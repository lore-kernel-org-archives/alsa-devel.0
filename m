Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6819AC433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Mar 2022 07:11:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A28FA18D9;
	Mon, 14 Mar 2022 08:10:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A28FA18D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1647241862;
	bh=A1zcToTc75ICPJ7xXePmDwg8EpfGjoJHRWKbLk6MzRM=;
	h=From:To:Subject:Date:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D3qFq4JWUGmpry2POsE+4D1hUGg5hz7LqBXXq0RzzbVLl5HnJgHusnJb1T4IQa0j2
	 T5YV3D8SShs7Pg4Q56L4r61FFkBJXjxvqkuAIL5oFMj66azsf2ti2sEpq3OoXmkRVm
	 Spdwko0T+3XQ8ZNpXvCkh7H7K1R4jdjsSBZNRh4M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D6675F8060E;
	Mon, 14 Mar 2022 07:59:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3C417F80139; Mon, 14 Mar 2022 04:22:56 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B86D2F8011C
 for <alsa-devel@alsa-project.org>; Mon, 14 Mar 2022 04:22:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B86D2F8011C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NOcIuE5j"
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 22E3MleQ109974;
 Sun, 13 Mar 2022 22:22:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1647228167;
 bh=FuQi6PevB7w++5+4cGFXG8MpQk5cQNLMo3EQB1cv260=;
 h=From:To:CC:Subject:Date:References:In-Reply-To;
 b=NOcIuE5jaa6OtqtZfdXM5m4A/JGzm9JpBcqJUACIypbb0ibycFhrjkNT90zxROSfZ
 Xym76eSz1KHdQPRruZf3c4el2dfAJgRYThsDok2Mqcis6+/TiL9hLvd41efeuJwH0Y
 smrlG1NgJRL3lqiihYL9TxWyR9DzfjtZhmZq8fdU=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 22E3MlaS045243
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 13 Mar 2022 22:22:47 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Sun, 13
 Mar 2022 22:22:46 -0500
Received: from DFLE107.ent.ti.com ([fe80::86f:14f0:164b:4dbe]) by
 DFLE107.ent.ti.com ([fe80::86f:14f0:164b:4dbe%17]) with mapi id
 15.01.2308.014; Sun, 13 Mar 2022 22:22:46 -0500
From: "Xu, Yang" <raphael-xu@ti.com>
To: "tiwai@suse.com" <tiwai@suse.com>, "alsa-devel@alsa-project.org"
 <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: TAS27xx driver upstream to Kernel
Thread-Topic: TAS27xx driver upstream to Kernel
Thread-Index: Adg1HRBdnLa2xx5FSCKGm5piQQGdfwCNVOxg
Date: Mon, 14 Mar 2022 03:22:46 +0000
Message-ID: <db4ccb44a7434de3a40c92c0271d54bb@ti.com>
References: <bce2381b4b814f0f94409dad43def978@ti.com>
In-Reply-To: <bce2381b4b814f0f94409dad43def978@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.250.162.205]
x-exclaimer-md-config: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 14 Mar 2022 07:58:51 +0100
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: "Navada Kanyana, Mukund" <navada@ti.com>, "Ding,
 Shenghao" <shenghao-ding@ti.com>
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

Hi Takashi Iwai,

Any suggestion?Thanks.

Regards
Raphael

From: Xu, Yang
Sent: Friday, March 11, 2022 4:01 PM
To: 'tiwai@suse.com' <tiwai@suse.com>
Cc: Ding, Shenghao <shenghao-ding@ti.com>; Navada Kanyana, Mukund <navada@t=
i.com>
Subject: TAS27xx driver upstream to Kernel

Hi Takashi Iwai,

This is Raphael Xu who is from Low Power Audio team,Texas Instrument.
Could you help to review the attached patch and upstream them to the kernel=
?
Thanks and expect your response.

Change log:
Path: /sound/soc/codecs

  1.  This patch to support either TAS2764 or TAS2780 device from TI
  2.  Fixed "no audio" issue on some platforms.

Regards
Raphael
