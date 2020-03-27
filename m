Return-Path: <SRS0=JTem=5M=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C631DC43331
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Mar 2020 15:37:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52E9920658
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Mar 2020 15:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OgDOVTid"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52E9920658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A902E1664;
	Fri, 27 Mar 2020 16:36:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A902E1664
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585323429;
	bh=3irMTOSIk2jtx5TQgF/E9CuMUjkWdP2oqk8jGYQ3+hw=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=OgDOVTidSDO7pc1mmrK7kjtIG65ieFxNdAyaA7B38An/8EbFml518Yd3jeqpbcqUi
	 aKljsa/hqFD0mFE2U50zkDid1PgrdHqtOYvcFUXjOOpJ5TfzxwPZAIsF/vmTHG/QQH
	 CjH+kXAhHJqNiRJMXRbcsXV5vC70DlYVYhWViER4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C183FF802A2;
	Fri, 27 Mar 2020 16:33:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A62C0F802A7; Fri, 27 Mar 2020 16:33:49 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 9E60AF802A0
 for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2020 16:33:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9E60AF802A0
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3743A1FB;
 Fri, 27 Mar 2020 08:33:45 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AFD3F3F71F;
 Fri, 27 Mar 2020 08:33:44 -0700 (PDT)
Date: Fri, 27 Mar 2020 15:33:43 +0000
From: Mark Brown <broonie@kernel.org>
To: Rander Wang <rander.wang@intel.com>
Subject: Applied "ASoC: SOF: Intel: hda: add WAKEEN interrupt support for
 SoundWire" to the asoc tree
In-Reply-To: 
Message-Id: 
X-Patchwork-Hint: ignore
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
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
Message-ID: <20200327153343.IK8KCWHGMbeIpfwzup_HaSbO_lZ4LP692HZnMf3lYWw@z>

The patch

   ASoC: SOF: Intel: hda: add WAKEEN interrupt support for SoundWire

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From bbd19cdca8279cf244a301c6a13ae5ec9e4ef976 Mon Sep 17 00:00:00 2001
From: Rander Wang <rander.wang@intel.com>
Date: Wed, 25 Mar 2020 16:50:25 -0500
Subject: [PATCH] ASoC: SOF: Intel: hda: add WAKEEN interrupt support for
 SoundWire

When a SoundWire link is in clock stop state, a Slave device may wake
up the Master for some events such as jack detection. The WAKEEN
interrupt will be triggered and processed by the audio pci device.

If audio device is in D3, the interrupt will be routed to PME, or
aggregated at cAVS level as interrupt when audio device is in D0. This
patch only supports D3 case, where the audio pci device will be
resumed by a PME event and the WAKEEN interrupt will be processed
after audio pci device is powered up and ROM is initialized
successfully.

The WAKEEN handling is only enabled after the first boot due to
dependencies on a shim_lock mutex being initialized.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Rander Wang <rander.wang@intel.com>
Link: https://lore.kernel.org/r/20200325215027.28716-10-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/intel/hda-loader.c | 18 ++++++++++++++++++
 sound/soc/sof/intel/hda.c        | 11 +++++++++++
 sound/soc/sof/intel/hda.h        |  5 +++++
 3 files changed, 34 insertions(+)

diff --git a/sound/soc/sof/intel/hda-loader.c b/sound/soc/sof/intel/hda-loader.c
index 2ae94ea53122..e1550ccd0a49 100644
--- a/sound/soc/sof/intel/hda-loader.c
+++ b/sound/soc/sof/intel/hda-loader.c
@@ -346,6 +346,24 @@ int hda_dsp_cl_boot_firmware(struct snd_sof_dev *sdev)
 		goto cleanup;
 	}
 
+	/*
+	 * When a SoundWire link is in clock stop state, a Slave
+	 * device may trigger in-band wakes for events such as jack
+	 * insertion or acoustic event detection. This event will lead
+	 * to a WAKEEN interrupt, handled by the PCI device and routed
+	 * to PME if the PCI device is in D3. The resume function in
+	 * audio PCI driver will be invoked by ACPI for PME event and
+	 * initialize the device and process WAKEEN interrupt.
+	 *
+	 * The WAKEEN interrupt should be processed ASAP to prevent an
+	 * interrupt flood, otherwise other interrupts, such IPC,
+	 * cannot work normally.  The WAKEEN is handled after the ROM
+	 * is initialized successfully, which ensures power rails are
+	 * enabled before accessing the SoundWire SHIM registers
+	 */
+	if (!sdev->first_boot)
+		hda_sdw_process_wakeen(sdev);
+
 	/*
 	 * at this point DSP ROM has been initialized and
 	 * should be ready for code loading and firmware boot
diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 1e69cfcee8e0..7d1aa4c7d82c 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -241,6 +241,17 @@ static irqreturn_t hda_dsp_sdw_thread(int irq, void *context)
 	return sdw_intel_thread(irq, context);
 }
 
+void hda_sdw_process_wakeen(struct snd_sof_dev *sdev)
+{
+	struct sof_intel_hda_dev *hdev;
+
+	hdev = sdev->pdata->hw_pdata;
+	if (!hdev->sdw)
+		return;
+
+	sdw_intel_process_wakeen_event(hdev->sdw);
+}
+
 #endif
 
 /*
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index fc104c5ba006..6f1765b1ed1d 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -671,6 +671,7 @@ int hda_dsp_trace_trigger(struct snd_sof_dev *sdev, int cmd);
 
 int hda_sdw_startup(struct snd_sof_dev *sdev);
 void hda_sdw_int_enable(struct snd_sof_dev *sdev, bool enable);
+void hda_sdw_process_wakeen(struct snd_sof_dev *sdev);
 
 #else
 
@@ -707,6 +708,10 @@ static inline irqreturn_t hda_dsp_sdw_thread(int irq, void *context)
 {
 	return IRQ_HANDLED;
 }
+
+static inline void hda_sdw_process_wakeen(struct snd_sof_dev *sdev)
+{
+}
 #endif
 
 /* common dai driver */
-- 
2.20.1

