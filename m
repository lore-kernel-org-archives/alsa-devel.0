Return-Path: <SRS0=sxeJ=4J=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6372CC35640
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Feb 2020 10:08:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E224220722
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Feb 2020 10:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="KkODfBZX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="MNIUzmf2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E224220722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3734716AE;
	Fri, 21 Feb 2020 11:08:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3734716AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582279730;
	bh=7iv85r/E6IKQiugwycyCXOqnGFwdFq7etKvQyvCf8NM=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KkODfBZXKkNfLDVYHJApaIrsDMC21f/P0ADrChAB5KUWYwWGCeM9bkEZaf0kHKOZ1
	 VW8B5aFjzGvpBFVQ2Kad6Ww9Ptg6q8KzODc9Vn7/yeRvroefJ0XJNeZnGc0erhbZ2b
	 c8SFFbKu9xJFa1ty18vqq7DaAwRHejcH7kwwwas0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9767FF80240;
	Fri, 21 Feb 2020 11:07:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E2482F8025F; Fri, 21 Feb 2020 11:07:56 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6DCA4F800C5
 for <alsa-devel@alsa-project.org>; Fri, 21 Feb 2020 11:07:53 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id A27FDA003F;
 Fri, 21 Feb 2020 11:07:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz A27FDA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1582279672; bh=TH4JGpiyxD0qWDgfr66r7GV7RqB6a7jzO3/wgLcwVfQ=;
 h=From:To:Cc:Subject:Date:From;
 b=MNIUzmf2vlKATWsd8rJG/7S2aSFs3OKUau3/KieIL6/kbewV2agJFaLKVsFIRE4IG
 7GCZasutYtNYRj77y+l2ovAkI41ZtwPA2S2rhoBPH7m1m2b3pO6Hcc+ZoNddsSwX39
 Otlx/GvAQHKfaUTVIFaL7TsrsFYqYyvP+shM0JT8=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Fri, 21 Feb 2020 11:07:47 +0100 (CET)
From: Jaroslav Kysela <perex@perex.cz>
To: ALSA development <alsa-devel@alsa-project.org>
Subject: [PATCH] ASoC: SOF - topology - do not change the link trigger order
 for pre-1.4 firmware
Date: Fri, 21 Feb 2020 11:07:39 +0100
Message-Id: <20200221100739.3883842-1-perex@perex.cz>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

This patch is for SOF v1.3 firmware. The DSP firmware will crash (DSP oops)
without this patch. The 1.4.1 firmare has this issue fixed.

The ABI version is used for the comparison, because the firmware version
for the firmware files before 1.4.2 was not set properly (git hash was
used).

BugLink: https://github.com/thesofproject/sof/issues/2102
Signed-off-by: Jaroslav Kysela <perex@perex.cz>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/topology.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index 9f4f8868b386..58ff4766b47b 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -3111,6 +3111,7 @@ static int sof_link_load(struct snd_soc_component *scomp, int index,
 	struct snd_soc_tplg_private *private = &cfg->priv;
 	struct sof_ipc_dai_config config;
 	struct snd_soc_tplg_hw_config *hw_config;
+	struct sof_ipc_fw_version *v = &sdev->fw_ready.version;
 	int num_hw_configs;
 	int ret;
 	int i = 0;
@@ -3128,9 +3129,12 @@ static int sof_link_load(struct snd_soc_component *scomp, int index,
 	if (!link->no_pcm) {
 		link->nonatomic = true;
 
-		/* set trigger order */
-		link->trigger[0] = SND_SOC_DPCM_TRIGGER_POST;
-		link->trigger[1] = SND_SOC_DPCM_TRIGGER_POST;
+		/* this causes DSP panic on firmware v1.3 */
+		if (v->abi_version > SOF_ABI_VER(3, 7, 0)) {
+			/* set trigger order */
+			link->trigger[0] = SND_SOC_DPCM_TRIGGER_POST;
+			link->trigger[1] = SND_SOC_DPCM_TRIGGER_POST;
+		}
 
 		/* nothing more to do for FE dai links */
 		return 0;
-- 
2.24.1
