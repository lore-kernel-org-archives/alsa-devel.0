Return-Path: <SRS0=4JIF=JE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DC5C433ED
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Apr 2021 05:16:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00811613C6
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Apr 2021 05:16:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00811613C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8825C1661;
	Wed,  7 Apr 2021 07:15:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8825C1661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617772570;
	bh=+qMMU7mdQQp3wtgS09aHjDIGSCimf2zjJNhF8nOYCZA=;
	h=From:To:Subject:Date:References:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=taPmAo331juNAghVY7jQXu5wC4bcVuUiHEDzR2josIDNqCkAq+k6rTt4zYF3prUYg
	 AigCms0BfENfZQa49Vz1iSR/eSl7vllukFcc9FfT0IGCI5SwoLea4U7XuZqYHtOm/7
	 SQ8OpdxQgEZ1PIYkKxloey5/oPMJWe0P3lXpICWE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 04B61F80168;
	Wed,  7 Apr 2021 07:15:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2BFA9F8016A; Wed,  7 Apr 2021 07:15:18 +0200 (CEST)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 889FCF800BD
 for <alsa-devel@alsa-project.org>; Wed,  7 Apr 2021 07:15:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 889FCF800BD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com
 header.b="M2uzPuXh"
Received: from epcas3p4.samsung.com (unknown [182.195.41.22])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20210407051502epoutp04e1d61fa73822dc4da6e857c7ba41bed4~ze4UhMtC73144931449epoutp04K
 for <alsa-devel@alsa-project.org>; Wed,  7 Apr 2021 05:15:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20210407051502epoutp04e1d61fa73822dc4da6e857c7ba41bed4~ze4UhMtC73144931449epoutp04K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1617772502;
 bh=giEHecojzibPlMX48BTIkzdhmVwfXCQ4GbsK0oDZZIM=;
 h=From:To:Cc:Subject:Date:References:From;
 b=M2uzPuXhCiolRzWUqeqI+bRVEgtrEjY1qM/i9LEyTBNGfBranpDadTr2rfbWfiZcn
 wDMU9l7XDWY4HBucF4phCzbUAewcLZtGfVrUy413IaMmiT7t8DTeb11RXHUVdHGxQ7
 v83b7EHK3JnozLmOe18wKW00W+hhEgNmAtvbC+84=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas3p1.samsung.com (KnoxPortal) with ESMTP id
 20210407051502epcas3p13bd257cf3147c1deb7e1aeae9924278a~ze4UAoz8y2864328643epcas3p1s;
 Wed,  7 Apr 2021 05:15:02 +0000 (GMT)
Received: from epcpadp3 (unknown [182.195.40.17]) by epsnrtp1.localdomain
 (Postfix) with ESMTP id 4FFXdf24Pnz4x9QK; Wed,  7 Apr 2021 05:15:02 +0000
 (GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
 20210407041405epcas2p10649545662a5441230a3066481755cd0~zeDGKDPhE2264022640epcas2p1t;
 Wed,  7 Apr 2021 04:14:05 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20210407041405epsmtrp15c9d7ba512cbee0c2519fa5eefbbfe02~zeDGJMEA51672416724epsmtrp1u;
 Wed,  7 Apr 2021 04:14:05 +0000 (GMT)
X-AuditID: b6c32a2a-755ff70000002229-1f-606d318daf2a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 DC.8E.08745.D813D606; Wed,  7 Apr 2021 13:14:05 +0900 (KST)
Received: from KORDO025540 (unknown [12.36.182.130]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20210407041405epsmtip2199dd5fe87353f70cf14e864065c97c4~zeDF6JmSq1007010070epsmtip2P;
 Wed,  7 Apr 2021 04:14:05 +0000 (GMT)
From: "Gyeongtaek Lee" <gt82.lee@samsung.com>
To: "'Kuninori Morimoto'" <kuninori.morimoto.gx@renesas.com>,
 <cpgs@samsung.com>
Subject: [PATCH] ASoC: soc-compress: lock pcm_mutex to resolve lockdep error
Date: Wed, 7 Apr 2021 13:14:04 +0900
Message-ID: <1891546521.01617772502282.JavaMail.epsvc@epcpadp3>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AdcrZEoVXUmCQ/cCR/GzgsfcSW1Slg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsWy7bCSvG6vYW6CwbcL3BZXLh5ispj68Amb
 xctDmhZ3f5hbzNjWzWLReG8Cm8Xqq1uYLF4d3sVo8e1KB5PFr//PmCyOXlzMZNFwt5nd4uXm
 N0wWRxqnMDnweWz43MTmsXPWXXaPTas62TzmnQz0+HZmIotH35ZVjB6bT1cHsEdx2aSk5mSW
 pRbp2yVwZfxctoSpoIGv4uj5TsYGxg6eLkZODgkBE4k3t9cydzFycQgJ7GCUWPVgBxtEQkLi
 w/wz7BC2sMT9liOsEEXPGSX6DrazgiTYBHQlvty7wwxiiwgESSxY+hesiFmgjVni841usCJh
 AR+JDx+3ANkcHCwCKhI3LwWAhHkFLCWWtf5mh7AFJU7OfMICYjMLaEv0PmxlhLDlJba/ncMM
 cYSCxM+ny1gh4iISszvboPbqSXyaeJ9xAqPgLCSjZiEZNQvJqFlI2hcwsqxilEwtKM5Nzy02
 LDDKSy3XK07MLS7NS9dLzs/dxAiOOS2tHYx7Vn3QO8TIxMF4iFGCg1lJhHdHb3aCEG9KYmVV
 alF+fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tSs1NTC1KLYLJMHJxSDUzmiUcqa/ZL8jPtPp4Z
 6CRo+WxShHxC/bSPS1yadnuLnQyefbJMpvQpBxNTWCXTUeNNhyQypB3FeXQdrLbm/Uh7mM2b
 LNOspdyQudVt++1k34XLvvhI3X159OB6mdUBMxqPXJuz4pQLh4SYanZOPsMqk5p97cYv7n97
 W9rKzzehYX9EXfpj9dueX/hiVXRMdbz9eJfnlmgv6X7wymXi/radZksl1d9/c3Wbv6D9kaKT
 9MuvHLd3vg9ZEW3zx0G49Jt83SaHdfe8i7llnvoXePlI5Vq66ITa5qyxm/m/omLucoashF8/
 dN3T3t5aIF8R2XwwLVmgR+2ZY67xHkf5JJ2DZXk985etUX22/cBeJZbijERDLeai4kQAjDkr
 QCgDAAA=
X-CMS-MailID: 20210407041405epcas2p10649545662a5441230a3066481755cd0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20210407041405epcas2p10649545662a5441230a3066481755cd0
References: <CGME20210407041405epcas2p10649545662a5441230a3066481755cd0@epcas2p1.samsung.com>
Cc: alsa-devel@alsa-project.org, khw0178.kim@samsung.com, 'Takashi
 Iwai' <tiwai@suse.de>, broonie@kernel.org,
 'Pierre-Louis Bossart' <pierre-louis.bossart@linux.intel.com>,
 lgirdwood@gmail.com, kimty@samsung.com, donggyun.ko@samsung.com,
 hmseo@samsung.com, cpgs@samsung.com, s47.kang@samsung.com,
 pilsun.jang@samsung.com, tkjung@samsung.com
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

If panic_on_warn=1 is added in bootargs and compress offload playback with
DPCM is started, kernel panic would be occurred because rtd->card->pcm_mutex
isn't held in soc_compr_open_fe() and soc_compr_free_fe() and it generates
lockdep warning in the following code.

void snd_soc_runtime_action(struct snd_soc_pcm_runtime *rtd,
			    int stream, int action)
{
	struct snd_soc_dai *dai;
	int i;

	lockdep_assert_held(&rtd->card->pcm_mutex);

To prevent lockdep warning but minimize side effect by adding mutex,
pcm_mutex is held just before snd_soc_runtime_activate() and
snd_soc_runtime_deactivate() and is released right after them.

Signed-off-by: Gyeongtaek Lee <gt82.lee@samsung.com>
---
 sound/soc/soc-compress.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index 246a5e32e22a..b4810266f5e5 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -153,7 +153,9 @@ static int soc_compr_open_fe(struct snd_compr_stream *cstream)
 	fe->dpcm[stream].state = SND_SOC_DPCM_STATE_OPEN;
 	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_NO;
 
+	mutex_lock_nested(&fe->card->pcm_mutex, fe->card->pcm_subclass);
 	snd_soc_runtime_activate(fe, stream);
+	mutex_unlock(&fe->card->pcm_mutex);
 
 	mutex_unlock(&fe->card->mutex);
 
@@ -181,7 +183,9 @@ static int soc_compr_free_fe(struct snd_compr_stream *cstream)
 
 	mutex_lock_nested(&fe->card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
 
+	mutex_lock_nested(&fe->card->pcm_mutex, fe->card->pcm_subclass);
 	snd_soc_runtime_deactivate(fe, stream);
+	mutex_unlock(&fe->card->pcm_mutex);
 
 	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_FE;
 

base-commit: e49d033bddf5b565044e2abe4241353959bc9120
-- 
2.21.0


