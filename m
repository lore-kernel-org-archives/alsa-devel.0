Return-Path: <SRS0=BS+q=CQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C54C433E2
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Sep 2020 16:36:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DFA021D1A
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Sep 2020 16:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UkaJy865";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0yC4GiMh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DFA021D1A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7B9031785;
	Mon,  7 Sep 2020 18:35:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7B9031785
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599496572;
	bh=Mt/qNSE8Xsx0QgG4r8hq6ijjX6NFOS904FufdN1uPcI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UkaJy865wCX237eDib0tuv8s89VS+kWPUG8MtQcEVnnp5pWEn5pIFCSqajiwi2m2t
	 6YyG8/1nmsfKW9GXxt0YzbeqM3UL1L2Wu5MU0UYtAqII/C66Vun/qyz2BjISTukj2j
	 b+kfN7tRHreq++xxahFKJ/aOoQnvpR0S0K0Vaatg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C9F71F802E0;
	Mon,  7 Sep 2020 18:33:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 12A44F80240; Mon,  7 Sep 2020 18:33:33 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 42948F80240
 for <alsa-devel@alsa-project.org>; Mon,  7 Sep 2020 18:33:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 42948F80240
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="0yC4GiMh"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 10A2021789;
 Mon,  7 Sep 2020 16:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599496402;
 bh=Mt/qNSE8Xsx0QgG4r8hq6ijjX6NFOS904FufdN1uPcI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=0yC4GiMhQ4HmZJBxxhM/VAPpV3RshAqzk438Ll8kF4AijRtQQGge+sjyRQeRV5s3A
 Rf4fGI0lPUG1nBk0PRa+Mj34mLfRXHWI9ySmzfFygO5G+V7zhwaff6/AjJb5qJswz/
 gz5M0Z8NItd6+660JO/hsZAD9ZHOJS0d5JwQf15A=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.8 48/53] ALSA: hda: use consistent HDAudio spelling
 in comments/docs
Date: Mon,  7 Sep 2020 12:32:14 -0400
Message-Id: <20200907163220.1280412-48-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907163220.1280412-1-sashal@kernel.org>
References: <20200907163220.1280412-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>,
 Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 linux-doc@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>
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

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit b79de57b4378a93115307be6962d05b099eb0f37 ]

We use HDaudio and HDAudio, pick one to make searches easier.
No functionality change

Also fix timestamping typo in documentation.

Reported-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Link: https://lore.kernel.org/r/20200902154250.1440585-1-kai.vehmanen@linux.intel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/sound/designs/timestamping.rst |  2 +-
 sound/hda/intel-dsp-config.c                 | 10 +++++-----
 sound/x86/Kconfig                            |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/sound/designs/timestamping.rst b/Documentation/sound/designs/timestamping.rst
index 2b0fff5034151..7c7ecf5dbc4bd 100644
--- a/Documentation/sound/designs/timestamping.rst
+++ b/Documentation/sound/designs/timestamping.rst
@@ -143,7 +143,7 @@ timestamp shows when the information is put together by the driver
 before returning from the ``STATUS`` and ``STATUS_EXT`` ioctl. in most cases
 this driver_timestamp will be identical to the regular system tstamp.
 
-Examples of typestamping with HDaudio:
+Examples of timestamping with HDAudio:
 
 1. DMA timestamp, no compensation for DMA+analog delay
 ::
diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
index 99aec73491676..1c5114dedda92 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -54,7 +54,7 @@ static const struct config_entry config_table[] = {
 #endif
 /*
  * Apollolake (Broxton-P)
- * the legacy HDaudio driver is used except on Up Squared (SOF) and
+ * the legacy HDAudio driver is used except on Up Squared (SOF) and
  * Chromebooks (SST)
  */
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_APOLLOLAKE)
@@ -89,7 +89,7 @@ static const struct config_entry config_table[] = {
 	},
 #endif
 /*
- * Skylake and Kabylake use legacy HDaudio driver except for Google
+ * Skylake and Kabylake use legacy HDAudio driver except for Google
  * Chromebooks (SST)
  */
 
@@ -135,7 +135,7 @@ static const struct config_entry config_table[] = {
 #endif
 
 /*
- * Geminilake uses legacy HDaudio driver except for Google
+ * Geminilake uses legacy HDAudio driver except for Google
  * Chromebooks
  */
 /* Geminilake */
@@ -157,7 +157,7 @@ static const struct config_entry config_table[] = {
 
 /*
  * CoffeeLake, CannonLake, CometLake, IceLake, TigerLake use legacy
- * HDaudio driver except for Google Chromebooks and when DMICs are
+ * HDAudio driver except for Google Chromebooks and when DMICs are
  * present. Two cases are required since Coreboot does not expose NHLT
  * tables.
  *
@@ -391,7 +391,7 @@ int snd_intel_dsp_driver_probe(struct pci_dev *pci)
 	if (pci->class == 0x040300)
 		return SND_INTEL_DSP_DRIVER_LEGACY;
 	if (pci->class != 0x040100 && pci->class != 0x040380) {
-		dev_err(&pci->dev, "Unknown PCI class/subclass/prog-if information (0x%06x) found, selecting HDA legacy driver\n", pci->class);
+		dev_err(&pci->dev, "Unknown PCI class/subclass/prog-if information (0x%06x) found, selecting HDAudio legacy driver\n", pci->class);
 		return SND_INTEL_DSP_DRIVER_LEGACY;
 	}
 
diff --git a/sound/x86/Kconfig b/sound/x86/Kconfig
index 77777192f6508..4ffcc5e623c22 100644
--- a/sound/x86/Kconfig
+++ b/sound/x86/Kconfig
@@ -9,7 +9,7 @@ menuconfig SND_X86
 if SND_X86
 
 config HDMI_LPE_AUDIO
-	tristate "HDMI audio without HDaudio on Intel Atom platforms"
+	tristate "HDMI audio without HDAudio on Intel Atom platforms"
 	depends on DRM_I915
 	select SND_PCM
 	help
-- 
2.25.1

