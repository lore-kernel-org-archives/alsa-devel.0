Return-Path: <SRS0=LJxm=YT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7A4CA9EB9
	for <alsa-devel@archiver.kernel.org>; Sat, 26 Oct 2019 07:42:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB55321655
	for <alsa-devel@archiver.kernel.org>; Sat, 26 Oct 2019 07:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="DcqBeYJ7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="ncqwUc08"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB55321655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 10D931AB6;
	Sat, 26 Oct 2019 09:41:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 10D931AB6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572075739;
	bh=htUYTf2y+2ujeEulFTbF3iiI1HNjF02l8Il0vU2LWUU=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DcqBeYJ7tuzRTqHEWpz7/eVfo9/CZB31u001+FuPBjCwW4orRGD1V9r5+61AzKZYc
	 VzvRpFRGov86Wr9uninSiyOSVmDBTqcqo95yIwaljPOOUvBdC+1pJXZDv4z3XIQzeN
	 r+bcvjH/aJxEUorSGA+iE5O/Kl7mbE3B3lMF3Dt8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8EFD8F80367;
	Sat, 26 Oct 2019 09:41:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9DD79F8036B; Sat, 26 Oct 2019 09:41:26 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3EC99F80274
 for <alsa-devel@alsa-project.org>; Sat, 26 Oct 2019 09:41:23 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 6FB82A003F;
 Sat, 26 Oct 2019 09:41:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 6FB82A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1572075683; bh=lC5cHQWaAe98g5+BXI/0PyphkxF5hnG+jej3UMIsaZA=;
 h=From:To:Cc:Subject:Date:From;
 b=ncqwUc08/5Bd+uahhBuQ55to2LhHQCPfqaRN/VwJXYGLdyKz4Tk7/tpdyBmpBgD5c
 oiqsx4niMfZR+hIQ/nPZSb2JhOiu9uJNgsxawDmyFucEKYR6njjOoXqjSHIuIoCBpm
 FssZK6WP7qecUikIX3Vkxcach2kebDQoFTCoktNM=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Sat, 26 Oct 2019 09:41:18 +0200 (CEST)
From: Jaroslav Kysela <perex@perex.cz>
To: ALSA development <alsa-devel@alsa-project.org>
Date: Sat, 26 Oct 2019 09:41:10 +0200
Message-Id: <20191026074110.22196-1-perex@perex.cz>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] [PATCH] ASoC: intel - fix the card names
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Those strings are exposed to the user space as the
card name thus used in the GUIs. The common
standard is to avoid '_' here. The worst case
is 'sof-skl_hda_card' string.

Signed-off-by: Jaroslav Kysela <perex@perex.cz>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c | 2 +-
 sound/soc/intel/boards/skl_hda_dsp_generic.c        | 2 +-
 sound/soc/intel/boards/sof_rt5682.c                 | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
index 74dda8784f1a..d14ca327c684 100644
--- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
@@ -623,7 +623,7 @@ static int kabylake_card_late_probe(struct snd_soc_card *card)
  * kabylake audio machine driver for  MAX98927 + RT5514 + RT5663
  */
 static struct snd_soc_card kabylake_audio_card = {
-	.name = "kbl_r5514_5663_max",
+	.name = "kbl-r5514-5663-max",
 	.owner = THIS_MODULE,
 	.dai_link = kabylake_dais,
 	.num_links = ARRAY_SIZE(kabylake_dais),
diff --git a/sound/soc/intel/boards/skl_hda_dsp_generic.c b/sound/soc/intel/boards/skl_hda_dsp_generic.c
index 1778acdc367c..5261f7bf0b3b 100644
--- a/sound/soc/intel/boards/skl_hda_dsp_generic.c
+++ b/sound/soc/intel/boards/skl_hda_dsp_generic.c
@@ -90,7 +90,7 @@ skl_hda_add_dai_link(struct snd_soc_card *card, struct snd_soc_dai_link *link)
 }
 
 static struct snd_soc_card hda_soc_card = {
-	.name = "skl_hda_card",
+	.name = "skl-hda",
 	.owner = THIS_MODULE,
 	.dai_link = skl_hda_be_dai_links,
 	.dapm_widgets = skl_hda_widgets,
diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index 4f6e58c3954a..fc4638b8e03b 100644
--- a/sound/soc/intel/boards/sof_rt5682.c
+++ b/sound/soc/intel/boards/sof_rt5682.c
@@ -370,7 +370,7 @@ static int dmic_init(struct snd_soc_pcm_runtime *rtd)
 
 /* sof audio machine driver for rt5682 codec */
 static struct snd_soc_card sof_audio_card_rt5682 = {
-	.name = "sof_rt5682",
+	.name = "sof-rt5682",
 	.owner = THIS_MODULE,
 	.controls = sof_controls,
 	.num_controls = ARRAY_SIZE(sof_controls),
-- 
2.20.1
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
