Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA9CC25B06
	for <alsa-devel@archiver.kernel.org>; Sun, 14 Aug 2022 16:24:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 726FD1631;
	Sun, 14 Aug 2022 18:23:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 726FD1631
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1660494273;
	bh=R02L0ZCJjmtfN54L9LyXEzxy81yp/EaA6NDAEoEHBw8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K7/LM9VCPg6ihdXRv21RlVsOfN+9Gf199akAcFpaCOnY2GWdCFQq/t96mBwLaUp8b
	 RZVuOGSvR9jF1zTvR+/wpjpPmsGGy5I5KdxbUMVb0kqa2Z0ZgDEAYI9XIBahGlcwa3
	 EAYL4BRMDnBxl9O13eHFIW4UctO/y68wC9mx37IA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6A4A7F8054A;
	Sun, 14 Aug 2022 18:22:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 813DBF80548; Sun, 14 Aug 2022 18:22:02 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 520D9F80564
 for <alsa-devel@alsa-project.org>; Sun, 14 Aug 2022 18:21:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 520D9F80564
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="VCvwlBGr"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 47A1E60F78;
 Sun, 14 Aug 2022 16:21:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE86BC433C1;
 Sun, 14 Aug 2022 16:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1660494114;
 bh=R02L0ZCJjmtfN54L9LyXEzxy81yp/EaA6NDAEoEHBw8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VCvwlBGrF/AqLGT0G/nOqtUootNTXhhGd7kwtzDReBU4r5JJk4QlnGVmnkla/Dk0u
 xxhaH6isvDRhySikagqkgCfzfsXXxVZU58i7WLBD5EateXvc8HAmHL69CA0X6AUaKQ
 qb1kX6RIGZLQzgkyJCKP3FTfGr2tdkewzDHhgCgGBZ68sg06Q0yh75xKBi7iXrEWqi
 oYfd8EXVmywaUEhBTqD5TNeibohlBsUqQ1OK1WEanvA6pJ83jdF2j9smkBUEhO5waA
 FqFEa4dYElUBRGnRMzBm7CkapgXAv0JDUkWwgddyV03tfmIfuBfIOW195Uj6Wqdjp4
 CO8hfudvI1D9w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.19 27/48] ASoC: Intel: sof_nau8825: Move quirk check
 to the front in late probe
Date: Sun, 14 Aug 2022 12:19:20 -0400
Message-Id: <20220814161943.2394452-27-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220814161943.2394452-1-sashal@kernel.org>
References: <20220814161943.2394452-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, cezary.rojewski@intel.com,
 kai.vehmanen@linux.intel.com, yung-chuan.liao@linux.intel.com, tiwai@suse.com,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org,
 mac.chiang@intel.com, Mark Brown <broonie@kernel.org>, CTLIN0@nuvoton.com,
 akihiko.odaki@gmail.com, peter.ujfalusi@linux.intel.com,
 Yong Zhi <yong.zhi@intel.com>
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

From: Yong Zhi <yong.zhi@intel.com>

[ Upstream commit 5b56db90bbaf9d8581e5e6268727d8ad706555e4 ]

The sof_rt5682_quirk check was placed in the middle of
hdmi handling code, move it to the front to be consistent
with sof_rt5682.c/sof_card_late_probe().

Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Yong Zhi <yong.zhi@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20220725194909.145418-11-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/sof_nau8825.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/boards/sof_nau8825.c b/sound/soc/intel/boards/sof_nau8825.c
index 97dcd204a246..9b3a2ff4d9cd 100644
--- a/sound/soc/intel/boards/sof_nau8825.c
+++ b/sound/soc/intel/boards/sof_nau8825.c
@@ -177,11 +177,6 @@ static int sof_card_late_probe(struct snd_soc_card *card)
 	struct sof_hdmi_pcm *pcm;
 	int err;
 
-	if (list_empty(&ctx->hdmi_pcm_list))
-		return -EINVAL;
-
-	pcm = list_first_entry(&ctx->hdmi_pcm_list, struct sof_hdmi_pcm, head);
-
 	if (sof_nau8825_quirk & SOF_MAX98373_SPEAKER_AMP_PRESENT) {
 		/* Disable Left and Right Spk pin after boot */
 		snd_soc_dapm_disable_pin(dapm, "Left Spk");
@@ -191,6 +186,11 @@ static int sof_card_late_probe(struct snd_soc_card *card)
 			return err;
 	}
 
+	if (list_empty(&ctx->hdmi_pcm_list))
+		return -EINVAL;
+
+	pcm = list_first_entry(&ctx->hdmi_pcm_list, struct sof_hdmi_pcm, head);
+
 	return hda_dsp_hdmi_build_controls(card, pcm->codec_dai->component);
 }
 
-- 
2.35.1

