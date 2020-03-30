Return-Path: <SRS0=jBUr=5P=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301FDC43331
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Mar 2020 07:38:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC3342073B
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Mar 2020 07:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TKhhMSsO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="R3v4WylP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC3342073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0734F1612;
	Mon, 30 Mar 2020 09:37:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0734F1612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585553880;
	bh=Nr0I8EnIIwwVIoqTaCieEFqjOJwEgUBbKuJw3jeXw7I=;
	h=From:To:Subject:Date:References:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=TKhhMSsOApuX2dTkt5L2vipOmenXgpy+FCs7/OTLOkBD3YupaRwJkYIhcgUOZ6852
	 eGh2d40li+nqVXGfRud53CAjL1hekMCIFkyMw6F6s2Y8heCxzSGPUO8Dx3QUJArFcG
	 Ti11rn7bG0IRZmhk2K4xuPZh33djHNb0jUUIUxlg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 74F71F8028B;
	Mon, 30 Mar 2020 09:36:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 967A0F8028B; Mon, 30 Mar 2020 09:36:07 +0200 (CEST)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 83957F8015C
 for <alsa-devel@alsa-project.org>; Mon, 30 Mar 2020 09:36:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 83957F8015C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com
 header.b="R3v4WylP"
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20200330073558epoutp03d78c6daf37a867f9dfbdfe743d6f52eb~BBL4dJ5PT0381803818epoutp03G
 for <alsa-devel@alsa-project.org>; Mon, 30 Mar 2020 07:35:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20200330073558epoutp03d78c6daf37a867f9dfbdfe743d6f52eb~BBL4dJ5PT0381803818epoutp03G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1585553758;
 bh=PDofgcoC6wnDtbVC1Ce6dQ6p84gSjZunCDonfITFsBc=;
 h=From:To:Cc:Subject:Date:References:From;
 b=R3v4WylPgT7kcFCNPoas2PSw9l5ihjAuVu+xqisFgX0JCyo5+4nKBOM4HWkQJHveG
 kKQwEV0eVwYtMsMiXpW+DpvRAkZDcGA1cNzz149sTQRVWKZLMjHj3f6gmTGdnnvKeA
 T2dGLYHX87SgIZJjIkijV+D5jUXrpQ5aFE5RfUN4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTP id
 20200330073558epcas2p387cb01f77092a440b0b983658ab50409~BBL4Mg7El0115601156epcas2p3A;
 Mon, 30 Mar 2020 07:35:58 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.40.187]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 48rPQN5Z3fzMqYkV; Mon, 30 Mar
 2020 07:35:56 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
 epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 4B.0F.04105.B51A18E5; Mon, 30 Mar 2020 16:35:55 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
 20200330073555epcas2p47495e0e0435e6cf34e6a5d7e248a3e80~BBL13_OE-1825418254epcas2p4M;
 Mon, 30 Mar 2020 07:35:55 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200330073555epsmtrp14b3177662c2301340fd46a0e46f70209~BBL13PZZk1749117491epsmtrp16;
 Mon, 30 Mar 2020 07:35:55 +0000 (GMT)
X-AuditID: b6c32a47-173ff70000001009-0d-5e81a15b3fac
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 E4.DC.04024.B51A18E5; Mon, 30 Mar 2020 16:35:55 +0900 (KST)
Received: from KORDO025540 (unknown [12.36.182.130]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20200330073555epsmtip1f784364fc39e2b74cd03170722c33c3a~BBL1uBEHb2856828568epsmtip13;
 Mon, 30 Mar 2020 07:35:55 +0000 (GMT)
From: =?ks_c_5601-1987?B?wMyw5sXD?= <gt82.lee@samsung.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <tiwai@suse.com>
Subject: [PATCH 2/3] ASoC: topology: use name_prefix for new kcontrol
Date: Mon, 30 Mar 2020 16:35:55 +0900
Message-ID: <000f01d60665$d8e86220$8ab92660$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ks_c_5601-1987"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdYGZYCfYFCtfXt0RNS7DWpi3m0Xiw==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEJsWRmVeSWpSXmKPExsWy7bCmmW70wsY4gykfzS2uXDzEZDH14RM2
 i29XOpgsNnxfy+jA4rHhcxObx85Zd9k9Nq3qZPNYv+UqSwBLVI5NRmpiSmqRQmpecn5KZl66
 rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtBOJYWyxJxSoFBAYnGxkr6dTVF+aUmq
 QkZ+cYmtUmpBSk6BoWGBXnFibnFpXrpecn6ulaGBgZEpUGVCTsab/reMBQ9YK+atm8rewPiY
 pYuRk0NCwETizJWlbCC2kMAORomHzUpdjFxA9idGifN3f7NDON8YJRb3T2SF6ViyYgorRGIv
 o8TEExMZIZyXjBLNH78AzeLgYBOwkujpVgJpEBFwlPh6rAFsHbOAosTjP3PAbGEBV4lnkx+D
 DWURUJVYfug5WJxXwFLiysv3rBC2oMTJmU+geo0klqyezwRhy0tsfzuHGeIgBYmfT5exQuzS
 k2h918gGUSMiMbuzjRnkNgmBNWwSK47MYodocJGYM3My1P/CEq+Ob4GKS0m87G9jh2hoZpR4
 d/YPVGIKo0RntxCEbSyxZe4pJpAnJQSUJY7cgjqOT6Lj8F92iDCvREcbVLWSxMZT/6CqJSTm
 bYAa6CGx/ewnxgmMirOQfDkLyZezkHw5C8k3CxhZVjGKpRYU56anFhsVGCNH9iZGcHrUct/B
 uO2czyFGAQ5GJR7eD9sb4oRYE8uKK3MPMUpwMCuJ8LL5A4V4UxIrq1KL8uOLSnNSiw8xmgJj
 YSKzlGhyPjB155XEG5oamZkZWJpamJoZWSiJ827ivhkjJJCeWJKanZpakFoE08fEwSnVwLj4
 fULxj7UXXzMclL5oWjIpKlzm9eTAhVp/Ul8/n1HW5Hvro26zlPFzKe3vdfe1Ar+Vi2/askd9
 bnIRe0OZ+74H5s/eyXbNDT9900N653cptxzdjS+dvmha1Ep0cp9KdTu3a5Mx+9y/7dxip97p
 5fLvey//Iyx6mtrl2pUFu9/XH5y4RrLv6RIlluKMREMt5qLiRAAKafxWpQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsWy7bCSnG70wsY4gzWzlS2uXDzEZDH14RM2
 i29XOpgsNnxfy+jA4rHhcxObx85Zd9k9Nq3qZPNYv+UqSwBLFJdNSmpOZllqkb5dAlfGm/63
 jAUPWCvmrZvK3sD4mKWLkZNDQsBEYsmKKawgtpDAbkaJBbvKIeISEh/mn2GHsIUl7rccAarh
 Aqp5zigx8f8/xi5GDg42ASuJnm4lkBoRAVeJ+3sbwOqZBRQlHv+ZAzZfGCj+bPJjsPksAqoS
 yw89B4vzClhKXHn5nhXCFpQ4OfMJC0SviUTj4W4oW15i+9s5zBA3KEj8fLqMFWKXnkTru0Y2
 iBoRidmdbcwTGAVnIRk1C8moWUhGzULSsoCRZRWjZGpBcW56brFhgWFearlecWJucWleul5y
 fu4mRnDQa2nuYLy8JP4QowAHoxIP74ftDXFCrIllxZW5hxglOJiVRHjZ/IFCvCmJlVWpRfnx
 RaU5qcWHGKU5WJTEeZ/mHYsUEkhPLEnNTk0tSC2CyTJxcEo1MJq9NQ0ULpippvSlx1Fy9dXt
 sjMsFR9/mX7K5O9qMYvKvP8yeyS6n2zVmFNotklsRWei/M1tMrsDOYsCp7L+D85hKbjodqxl
 y6Oo83LH7vTNfnv5MkNPVHEFv+axdcfU9tY4ftqzwj/zSqvu9qefN8l1W1YtehL2V4Sn7Fzm
 6Q0ppo1ZbOl7JJVYijMSDbWYi4oTAVAIZtR2AgAA
X-CMS-MailID: 20200330073555epcas2p47495e0e0435e6cf34e6a5d7e248a3e80
X-Msg-Generator: CA
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200330073555epcas2p47495e0e0435e6cf34e6a5d7e248a3e80
References: <CGME20200330073555epcas2p47495e0e0435e6cf34e6a5d7e248a3e80@epcas2p4.samsung.com>
Cc: alsa-devel@alsa-project.org
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

Current topology doesn't add prefix of the component to newly created
kcontrol.

Signed-off-by: Gyeongtaek Lee <gt82.lee@samsung.com>
---
 sound/soc/soc-topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 575da6aba807..a152409e8746 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -362,7 +362,7 @@ static int soc_tplg_add_kcontrol(struct soc_tplg *tplg,
 	struct snd_soc_component *comp = tplg->comp;
 
 	return soc_tplg_add_dcontrol(comp->card->snd_card,
-				comp->dev, k, NULL, comp, kcontrol);
+				comp->dev, k, comp->name_prefix, comp,
kcontrol);
 }
 
 /* remove a mixer kcontrol */
-- 
2.21.0


