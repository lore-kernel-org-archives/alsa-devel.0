Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01650C001DB
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Aug 2023 12:05:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0F2D1829;
	Fri,  4 Aug 2023 14:04:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0F2D1829
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691150744;
	bh=PFDdr6pGLpRP0bNdzNvRpmXOlb+JqknuVeXAGZDLVrA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=uIX9lrNgeq0bP5qDurwczvk21bPBXNOzn2eM9XVABdoxfdXTYtCyiU82vbkA/vp49
	 jE9gXrQ4NCzYyrH+NgydW6UcnEXWqixBfavQ/iGi8Zn60+cSQ3uYjumOq60zULUAw5
	 fyMX/AUe14w3RZDxhHuRmkabyuJk8/xc1+MoSe4A=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 04352F8025A; Fri,  4 Aug 2023 14:04:37 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3C154F80552;
	Fri,  4 Aug 2023 14:04:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0926EF805A1; Fri,  4 Aug 2023 12:48:05 +0200 (CEST)
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C140EF8057B;
	Fri,  4 Aug 2023 12:47:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C140EF8057B
Message-ID: <2719a8fc-d2e5-f499-ac4d-cf322941526c@linux.intel.com>
Date: Fri, 4 Aug 2023 12:47:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: [PATCH] ASoC: SOF: Intel: Move binding to display driver outside of
 deferred probe
Content-Language: en-US
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, sound-open-firmware@alsa-project.org,
 linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Cezary Rojewski <cezary.rojewski@intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, Mark Brown
 <broonie@kernel.org>, Daniel Baluta <daniel.baluta@nxp.com>
References: <20230719164141.228073-1-maarten.lankhorst@linux.intel.com>
 <87r0oohyea.wl-tiwai@suse.de>
 <ec653abc-f2f8-8a9d-4b8a-ea9d985d32fe@linux.intel.com>
 <f6efb6f9-11ae-e901-f2a5-a4ef94590290@linux.intel.com>
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <f6efb6f9-11ae-e901-f2a5-a4ef94590290@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MailFrom: maarten.lankhorst@linux.intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: W3CZBOU7EMUQL3VB3VBV4NXYWS7A3JO4
X-Message-ID-Hash: W3CZBOU7EMUQL3VB3VBV4NXYWS7A3JO4
X-Mailman-Approved-At: Fri, 04 Aug 2023 12:04:33 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/W3CZBOU7EMUQL3VB3VBV4NXYWS7A3JO4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hey,

On 2023-08-01 18:32, Pierre-Louis Bossart wrote:
> 
>> I've been working on a small change to keep the workqueue in SOF and
>> only move the binding to the probe function to match what snd-hda-intel
>> is doing, but I don't know if that is needed?
>>
>> It was a bit unclear to me based on feedback if I should try to kill the
>> workqueue on all drivers (but with no way to test), or keep it around.
> 
> My understanding is that we only want to move the binding to the probe
> function and leave the workqueue removal for another day - possibly never.

Patch 8/9 removed the workqueue, but can be replaced by the patch below, 
that simply moves out snd_sof_probe().

I've attempted this before, but didn't have snd_sof_remove in 
snd_sof_device_remove, which is why I would get a OOPS when attempting 
to do a shutdown/reboot.

With that I hopefully addressed the last concern.

Cheers,
Maarten

This mail can be applied with git am -c.
------8<---------
Now that we can use -EPROBE_DEFER, it's no longer required to spin off
the snd_hdac_i915_init into a workqueue.

Use the -EPROBE_DEFER mechanism instead, which must be returned in the
probe function.

Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
---
  sound/soc/sof/core.c            | 19 +++++++------------
  sound/soc/sof/intel/hda-codec.c |  2 +-
  2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/sound/soc/sof/core.c b/sound/soc/sof/core.c
index 30db685cc5f4b..cd4d06d1800b1 100644
--- a/sound/soc/sof/core.c
+++ b/sound/soc/sof/core.c
@@ -188,13 +188,6 @@ static int sof_probe_continue(struct snd_sof_dev *sdev)
  	struct snd_sof_pdata *plat_data = sdev->pdata;
  	int ret;

-	/* probe the DSP hardware */
-	ret = snd_sof_probe(sdev);
-	if (ret < 0) {
-		dev_err(sdev->dev, "error: failed to probe DSP %d\n", ret);
-		goto probe_err;
-	}
-
  	sof_set_fw_state(sdev, SOF_FW_BOOT_PREPARE);

  	/* check machine info */
@@ -325,10 +318,6 @@ static int sof_probe_continue(struct snd_sof_dev *sdev)
  dbg_err:
  	snd_sof_free_debug(sdev);
  dsp_err:
-	snd_sof_remove(sdev);
-probe_err:
-	sof_ops_free(sdev);
-
  	/* all resources freed, update state to match */
  	sof_set_fw_state(sdev, SOF_FW_BOOT_NOT_STARTED);
  	sdev->first_boot = true;
@@ -436,6 +425,12 @@ int snd_sof_device_probe(struct device *dev, struct 
snd_sof_pdata *plat_data)

  	sof_set_fw_state(sdev, SOF_FW_BOOT_NOT_STARTED);

+	ret = snd_sof_probe(sdev);
+	if (ret) {
+		dev_err_probe(sdev->dev, ret, "failed to probe DSP\n");
+		return ret;
+	}
+
  	if (IS_ENABLED(CONFIG_SND_SOC_SOF_PROBE_WORK_QUEUE)) {
  		INIT_WORK(&sdev->probe_work, sof_probe_work);
  		schedule_work(&sdev->probe_work);
@@ -485,9 +480,9 @@ int snd_sof_device_remove(struct device *dev)

  		snd_sof_ipc_free(sdev);
  		snd_sof_free_debug(sdev);
-		snd_sof_remove(sdev);
  	}

+	snd_sof_remove(sdev);
  	sof_ops_free(sdev);

  	/* release firmware */
diff --git a/sound/soc/sof/intel/hda-codec.c 
b/sound/soc/sof/intel/hda-codec.c
index f1fd5b44aaac9..344b61576c0e3 100644
--- a/sound/soc/sof/intel/hda-codec.c
+++ b/sound/soc/sof/intel/hda-codec.c
@@ -415,7 +415,7 @@ int hda_codec_i915_init(struct snd_sof_dev *sdev)
  		return 0;

  	/* i915 exposes a HDA codec for HDMI audio */
-	ret = snd_hdac_i915_init(bus, true);
+	ret = snd_hdac_i915_init(bus, false);
  	if (ret < 0)
  		return ret;

-- 
2.39.2

