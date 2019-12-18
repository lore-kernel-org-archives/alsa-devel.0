Return-Path: <SRS0=OYz8=2I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F534C2D0BF
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Dec 2019 20:21:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C66624689
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Dec 2019 20:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="VyhuWVSI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C66624689
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EF7BA84A;
	Wed, 18 Dec 2019 21:20:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EF7BA84A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576700463;
	bh=uoerMkbsKekb0vn7UKHZ3fnARgbMdPaBxHn4hcMVQ1E=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=VyhuWVSIKAi+0gd1T6Fc6OruFNzaP830msOdwVz7J6TI/63WlSM5PiM2t+i/XnoBN
	 ZLS/QBWIPXhEkMhFdFAQm4BDTbNckF0hlrYZi0DF5/3C7OVJM51nzRbtHJ0XEHtk+U
	 TxHe2jPv1OiHP8+Z0hr+n7316SxrGbw49yos7YGE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7EFD2F80377;
	Wed, 18 Dec 2019 21:06:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CCF8BF8037E; Wed, 18 Dec 2019 21:06:25 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 95003F8036C
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2019 21:06:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 95003F8036C
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8D4931B;
 Wed, 18 Dec 2019 12:06:20 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 250F13F67D;
 Wed, 18 Dec 2019 12:06:19 -0800 (PST)
Date: Wed, 18 Dec 2019 20:06:18 +0000
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20191217202231.18259-2-pierre-louis.bossart@linux.intel.com>
Message-Id: <applied-20191217202231.18259-2-pierre-louis.bossart@linux.intel.com>
X-Patchwork-Hint: ignore
Cc: tiwai@suse.de, gregkh@linuxfoundation.org, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>
Subject: [alsa-devel] Applied "ASoC: SOF: Intel: add module namespace for
	legacy IPC" to the asoc tree
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The patch

   ASoC: SOF: Intel: add module namespace for legacy IPC

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.6

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

From f4483a0fda1df3e5b4f25de647b8777d2481f08c Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Tue, 17 Dec 2019 14:22:24 -0600
Subject: [PATCH] ASoC: SOF: Intel: add module namespace for legacy IPC

The legacy IPC routines are only used by broadwell and baytrail
modules, import them as needed and make sure other modules cannot load
them.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20191217202231.18259-2-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/intel/bdw.c       | 1 +
 sound/soc/sof/intel/byt.c       | 1 +
 sound/soc/sof/intel/intel-ipc.c | 8 ++++----
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sof/intel/bdw.c b/sound/soc/sof/intel/bdw.c
index c09885c0eb7d..39d1c8c7cddf 100644
--- a/sound/soc/sof/intel/bdw.c
+++ b/sound/soc/sof/intel/bdw.c
@@ -642,3 +642,4 @@ const struct sof_intel_dsp_desc bdw_chip_info = {
 EXPORT_SYMBOL(bdw_chip_info);
 
 MODULE_LICENSE("Dual BSD/GPL");
+MODULE_IMPORT_NS(SND_SOC_SOF_INTEL_HIFI_EP_IPC);
diff --git a/sound/soc/sof/intel/byt.c b/sound/soc/sof/intel/byt.c
index d43098a962c0..b214b12fdcda 100644
--- a/sound/soc/sof/intel/byt.c
+++ b/sound/soc/sof/intel/byt.c
@@ -877,3 +877,4 @@ EXPORT_SYMBOL(cht_chip_info);
 #endif /* CONFIG_SND_SOC_SOF_BAYTRAIL */
 
 MODULE_LICENSE("Dual BSD/GPL");
+MODULE_IMPORT_NS(SND_SOC_SOF_INTEL_HIFI_EP_IPC);
diff --git a/sound/soc/sof/intel/intel-ipc.c b/sound/soc/sof/intel/intel-ipc.c
index 4edd92151fd5..e935f70d611b 100644
--- a/sound/soc/sof/intel/intel-ipc.c
+++ b/sound/soc/sof/intel/intel-ipc.c
@@ -39,7 +39,7 @@ void intel_ipc_msg_data(struct snd_sof_dev *sdev,
 			sof_mailbox_read(sdev, stream->posn_offset, p, sz);
 	}
 }
-EXPORT_SYMBOL(intel_ipc_msg_data);
+EXPORT_SYMBOL_NS(intel_ipc_msg_data, SND_SOC_SOF_INTEL_HIFI_EP_IPC);
 
 int intel_ipc_pcm_params(struct snd_sof_dev *sdev,
 			 struct snd_pcm_substream *substream,
@@ -60,7 +60,7 @@ int intel_ipc_pcm_params(struct snd_sof_dev *sdev,
 
 	return 0;
 }
-EXPORT_SYMBOL(intel_ipc_pcm_params);
+EXPORT_SYMBOL_NS(intel_ipc_pcm_params, SND_SOC_SOF_INTEL_HIFI_EP_IPC);
 
 int intel_pcm_open(struct snd_sof_dev *sdev,
 		   struct snd_pcm_substream *substream)
@@ -75,7 +75,7 @@ int intel_pcm_open(struct snd_sof_dev *sdev,
 
 	return 0;
 }
-EXPORT_SYMBOL(intel_pcm_open);
+EXPORT_SYMBOL_NS(intel_pcm_open, SND_SOC_SOF_INTEL_HIFI_EP_IPC);
 
 int intel_pcm_close(struct snd_sof_dev *sdev,
 		    struct snd_pcm_substream *substream)
@@ -87,6 +87,6 @@ int intel_pcm_close(struct snd_sof_dev *sdev,
 
 	return 0;
 }
-EXPORT_SYMBOL(intel_pcm_close);
+EXPORT_SYMBOL_NS(intel_pcm_close, SND_SOC_SOF_INTEL_HIFI_EP_IPC);
 
 MODULE_LICENSE("Dual BSD/GPL");
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
