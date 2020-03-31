Return-Path: <SRS0=BIX5=5Q=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0A6C43331
	for <alsa-devel@archiver.kernel.org>; Tue, 31 Mar 2020 05:43:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89578206EB
	for <alsa-devel@archiver.kernel.org>; Tue, 31 Mar 2020 05:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="QxpD8du3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="joSyFyMZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89578206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E212A886;
	Tue, 31 Mar 2020 07:42:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E212A886
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585633395;
	bh=AJcbZzzeX2GcSN6n09F+Hp0xNwhEEvMTKArNQM6cXX4=;
	h=From:To:In-Reply-To:Subject:Date:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QxpD8du3uc2Gd3E/TNXVYqfrYf6zo3g4HXy8ZEL3RhoG4Ptl2XQbmVDtxSWEMdh+9
	 4Y1s7uPxXzTM07F2stBj70PJlbo/62EGeg4rwyZrcTNuq1gWZ5gh9cjphiMz6GWjPw
	 X501+0+FLK0DVlgLBxN//pFa+HAoALR6PHKAAdvM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5A7D6F80140;
	Tue, 31 Mar 2020 07:42:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B2FF8F8014F; Tue, 31 Mar 2020 07:42:21 +0200 (CEST)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CFDAEF8010C
 for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2020 07:42:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CFDAEF8010C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com
 header.b="joSyFyMZ"
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20200331054211epoutp01c8ea82163ad23fc6bff08b287aa838ef~BTR0gYEae3204532045epoutp01a
 for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2020 05:42:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20200331054211epoutp01c8ea82163ad23fc6bff08b287aa838ef~BTR0gYEae3204532045epoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1585633331;
 bh=hFcpKVJj25+xe62AedFKEBhBKP4z/4LIODe/zAU4lxc=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=joSyFyMZNTnZixVjGZ7pgIcL+adtN+29piv6Zpjy/ltRgcpdII0WW6LxNtzscJ6bs
 m7rmkAwMoUaIsXhAwnWao5QHPZBxI1oZCzb0T3rsanMsUOYavT3bQroJfyhCiKC0n8
 /HOk0dqSlkwQUKrsoS4vNRWihmwP1coiY8XD+opI=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTP id
 20200331054210epcas2p11c5f88be613f13738abfb9ead24c5177~BTRz6rQbf2079520795epcas2p1a;
 Tue, 31 Mar 2020 05:42:10 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.40.184]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 48ryrc0B5szMqYkr; Tue, 31 Mar
 2020 05:42:08 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
 epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 CC.A5.04024.F28D28E5; Tue, 31 Mar 2020 14:42:07 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
 20200331054207epcas2p3818aae4ef5d73ae1d7cdf804bca3a63f~BTRw98b1A3244532445epcas2p3x;
 Tue, 31 Mar 2020 05:42:07 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200331054207epsmtrp23f3a1eca115d35a457be91e3c9263216~BTRw9MF6n0531905319epsmtrp2J;
 Tue, 31 Mar 2020 05:42:07 +0000 (GMT)
X-AuditID: b6c32a48-5c1ff70000000fb8-97-5e82d82f21a8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 97.AE.04024.F28D28E5; Tue, 31 Mar 2020 14:42:07 +0900 (KST)
Received: from KORDO025540 (unknown [12.36.182.130]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20200331054207epsmtip12d8087862b0b5509acb984cf25a71e08~BTRwwwOF30985909859epsmtip1T;
 Tue, 31 Mar 2020 05:42:07 +0000 (GMT)
From: =?ks_c_5601-1987?B?wMyw5sXD?= <gt82.lee@samsung.com>
To: <broonie@kernel.org>
In-Reply-To: <000d01d60665$be93a920$3bbafb60$@samsung.com>
Subject: [PATCH 0/3] fixes for topology
Date: Tue, 31 Mar 2020 14:42:07 +0900
Message-ID: <010801d6071f$1d716680$58543380$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ks_c_5601-1987"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQE8i8ZtjI711u7LMsI3xetGlRxONgKEfuIyqYD+kZA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHec85OzuzJqel9eCHXCeisrRttXk0DSmpUUJS36K0k745aTd2
 tkrpgymZN6JCy9aVFDNtZWpWVlBL0aKChaJmoVF2WzfKLkZJm2fBvv2e5/m/vP//+z4MqWqg
 Y5h8qxM7rIKZoyOojnuLEuOXDhZnab4PpPB9Pi/B17x4RfO1HZUU/6OvjOC7fXUE3/LTg/iu
 fdVEmtzY8q2YNt5wP5cbW5vKaePB9iZkvNzeT2XKNptTTFjIxQ41tubYcvOteanc+k3Zq7P1
 Bo02XpvEJ3Jqq2DBqVx6Rmb8mnxzwAen3iWYXYFWpiCK3NKVKQ6by4nVJpvoTOWwPdds12rt
 CaJgEV3WvIQcmyVZq9Ho9AHlNrOp019F2oeoPW/9f2RF6AlZgRQMsMvh8kgdUYEiGBV7HcHr
 rxeQVHxFUF/VKZOKH4HJzUni/5G/tY1yaXAbwae7v1FwoGLfIXB7EisQw9BsMlRVcsF2FAsw
 3tk7dQXJHkHQ/PbNlF4R0Ix7vPIgz2QXwIHaYTrIFDsfxjy9U/6UbBIUfzlGSDwD7h9/RQWZ
 ZHVQ33yGkDgWrn08GcqjhomxBpnUj4IT5aWkZCIZSg4ekkkaPw2j3QaJ06G2boKSeCa872mX
 SxwD3z7dpoOmgS0JhHz0JzSoRlBeqZJ4GbSfekAEAwM7D7qehrxFQtm9v3KprYSy0pCagysP
 JkNqgNMt8kOIc4cFc4cFc4cFc4eFOYuoJjQL20VLHhZ19uXhn92KpnY0zngd3Xmc4UUsg7jp
 ytH+fVkqmbBLLLB4ETAkF6WkNxRlqZS5QkEhdtiyHS4zFr1IH3j4w2RMdI4tsPFWZ7ZWrzMY
 NEl6Xm/Q8dxsZeu0oS0qNk9w4p0Y27Hj/zmCUcQUobmNJb3PorP2z9pRL7QplsxdOPxy4qPp
 Umzs71Vbi98suTF/+ucrO3B0oeUiCc+vorFNaZEji9kTPQN7Ew1PzhnXDg1mmP3jh33rbhk2
 7j52ye9J6FqRmeYrbCjznZo8Cu+oOaOxbTMKXmxsXvvrtUcxcL7ChU2PPgxtr3kYXxrX6+Mo
 0SRo40iHKPwDK+TmDrkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsWy7bCSnK7+jaY4g2M7JSyuXDzEZDH14RM2
 ixnbulksvl3pYLI4enExk8WG72sZLY40TmFyYPfY8LmJzWPnrLvsHptWdbJ59G1ZxeixfstV
 lgDWKC6blNSczLLUIn27BK6MXa97mAtuslS8eP2HtYHxEnMXIyeHhICJxN8ZK9hBbCGB3YwS
 S5syIOISEh/mn2GHsIUl7rccYe1i5AKqec4oMXnKHrYuRg4ONgEriZ5uJZAaEaD6L7tOMIHU
 MAvMYpR4NWc2VEM3o8T8bR/ZQKo4gRq+rD0ENlVYQF2ifcZtsDiLgKrE07UnwC7iFbCUaPow
 nQnCFpQ4OfMJC4jNDHRp4+FuKFteYvvbOVAfKEj8fLqMFSIuIjG7s40Z4iIriea+CawTGIVn
 IRk1C8moWUhGzULSvoCRZRWjZGpBcW56brFhgWFearlecWJucWleul5yfu4mRnBEaWnuYLy8
 JP4QowAHoxIP74OrjXFCrIllxZW5hxglOJiVRHjZ/BvihHhTEiurUovy44tKc1KLDzFKc7Ao
 ifM+zTsWKSSQnliSmp2aWpBaBJNl4uCUamAMmi+fvphh6cKnz96Eviirz6h1fFT94FbLfbbi
 JXNErHYaVZ6/dnOOLevLfmb7ZzZG8+TuzmeO40/yY+QX+PvsvVrvSqtVDZ0Xb+8/Lr/A5+tL
 3ZNfVmdkTpV7eE5yrjebt+Uq4zMyXSfOLb17+++jJ/7c18UEXj9a/PuG4IXshR/FV3UtyX+i
 oMRSnJFoqMVcVJwIAFdsRaakAgAA
X-CMS-MailID: 20200331054207epcas2p3818aae4ef5d73ae1d7cdf804bca3a63f
X-Msg-Generator: CA
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200330073511epcas2p2dd0a6e9dca67734192f0d55b86104cbb
References: <CGME20200330073511epcas2p2dd0a6e9dca67734192f0d55b86104cbb@epcas2p2.samsung.com>
 <000d01d60665$be93a920$3bbafb60$@samsung.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.com,
 hmseo@samsung.com, tkjung@samsung.com, pilsun.jang@samsung.com
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi, Mark

I resend these patches as you requested.

And, please ignore my previous email "RE: [PATCH 3/3] ASoC: fix regwmask".
I miss-clicked send button.
I'm sorry about that.

Thank you.
Lee

Gyeongtaek Lee (3):
  ASoC: dapm: connect virtual mux with default value
  ASoC: topology: use name_prefix for new kcontrol
  ASoC: fix regwmask

 sound/soc/soc-dapm.c     | 11 ++++++++++-
 sound/soc/soc-ops.c      |  4 ++--
 sound/soc/soc-topology.c |  2 +-
 3 files changed, 13 insertions(+), 4 deletions(-)


base-commit: 76ccd234269bd05debdbc12c96eafe62dd9a6180
--
2.21.0



