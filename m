Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 836AAC636D4
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Feb 2023 11:11:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 737ACF17;
	Fri, 17 Feb 2023 12:11:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 737ACF17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1676632316;
	bh=Lavf09jyhdS+ewCEWzduKnGfji+NNs/v8MNjkeD6LV8=;
	h=From:To:Subject:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Ii+nxfBO4VPCVWIsC4WaVpszj+W85Cqpe0Tc+8OnHOklxFg4Uo6GapdarBroxx3sh
	 4gf9tb0ES8Wpp6wRXk0nk+TImG6BMxXR6EdlUflJLIy+nfb3/I82wkN1eLvK2EqQWd
	 uVLYLtCjytlCD9MlMlVoLueQoix08ANEVX54yOqE=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EA499F80551;
	Fri, 17 Feb 2023 12:09:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C40B3F80527; Fri, 17 Feb 2023 12:09:52 +0100 (CET)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CA5CCF800E4
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2023 12:09:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CA5CCF800E4
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=GMyJPqhY
Received: from cryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net
 [82.11.51.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	(Authenticated sender: tanureal)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 42C80660212C;
	Fri, 17 Feb 2023 11:09:34 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1676632174;
	bh=Lavf09jyhdS+ewCEWzduKnGfji+NNs/v8MNjkeD6LV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GMyJPqhYCuxwVTGB2Mr1nfVnR8dNJyvk1wUJG5Db2PG4wXrf43ucbFDymO23abiHe
	 +RD9MhUAN3LcrrMfMPR1XaX6tBFtHwBumoRo9N0jKMz2IOeIh2D/kuVu7m0edqFCFz
	 +/HxvVPI342Rrj4uIhCCX9SZemzd/PK9ZEQOlCfgoxPw66dR3kY8IoDrCaJLQzCzWa
	 4m9uDo2tFuFZebzaRt+hJVDFKgL9ZyYDgDLIDexrYV5JoURpLqBaGKWaZWJbvZJQlJ
	 rBxG+suG1AwaRYqZXNskWmtxu0OoY3HWU4bu1/+j8UcQG8e07ZuTFti0tMImT+1sP8
	 aj46qY5YlFikQ==
From: Lucas Tanure <lucas.tanure@collabora.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH v2 1/9] ASoC: amd: vangogh: Remove unnecessary init function
Date: Fri, 17 Feb 2023 11:08:42 +0000
Message-Id: <20230217110850.1045250-2-lucas.tanure@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230217110850.1045250-1-lucas.tanure@collabora.com>
References: <20230217110850.1045250-1-lucas.tanure@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 4WJ4F65YR4QGO2T53TLLHQYACUUPXIXI
X-Message-ID-Hash: 4WJ4F65YR4QGO2T53TLLHQYACUUPXIXI
X-MailFrom: lucas.tanure@collabora.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Lucas Tanure <lucas.tanure@collabora.com>, kernel@collabora.com
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4WJ4F65YR4QGO2T53TLLHQYACUUPXIXI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Remove empty acp5x_cs35l41_init function

Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
---
 sound/soc/amd/vangogh/acp5x-mach.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/soc/amd/vangogh/acp5x-mach.c b/sound/soc/amd/vangogh/acp5x-mach.c
index eebf2650ad27..5bd9418919a0 100644
--- a/sound/soc/amd/vangogh/acp5x-mach.c
+++ b/sound/soc/amd/vangogh/acp5x-mach.c
@@ -73,11 +73,6 @@ static int acp5x_8821_init(struct snd_soc_pcm_runtime *rtd)
 	return ret;
 }
 
-static int acp5x_cs35l41_init(struct snd_soc_pcm_runtime *rtd)
-{
-	return 0;
-}
-
 static const unsigned int rates[] = {
 	48000,
 };
@@ -258,7 +253,6 @@ static struct snd_soc_dai_link acp5x_dai[] = {
 		.dpcm_playback = 1,
 		.playback_only = 1,
 		.ops = &acp5x_cs35l41_play_ops,
-		.init = acp5x_cs35l41_init,
 		SND_SOC_DAILINK_REG(acp5x_bt, cs35l41, platform),
 	},
 };
-- 
2.39.2

