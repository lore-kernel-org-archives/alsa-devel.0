Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A823C25B0E
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Aug 2022 11:09:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 42EC9163C;
	Tue, 16 Aug 2022 13:08:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 42EC9163C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1660648162;
	bh=iFUP08ctBX6R/jtCmi0FMOx4vKOam7bfTsTPOVKY/kc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tfFH0nKznXkVBwDP7qGgF/fqVqhgcyLOmPy9+jyezH5WNfDanxD6mrrRehc+sNQ2Q
	 l3rWYnugqNGicpldQhytObbed/eltZLqARojA2sQBBo9c9lk71ke3KLdT/GvFnwm3L
	 6/Ru2aJfA3NuXl7hxNJjXLU/1sv6ddkUYlprlEcc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CA8EAF80549;
	Tue, 16 Aug 2022 13:07:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2EB17F8051D; Tue, 16 Aug 2022 13:07:46 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B13FDF8032D
 for <alsa-devel@alsa-project.org>; Tue, 16 Aug 2022 13:07:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B13FDF8032D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="IGGUWXEC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1660648059; x=1692184059;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=iFUP08ctBX6R/jtCmi0FMOx4vKOam7bfTsTPOVKY/kc=;
 b=IGGUWXEC/GX6Zhm3YYbIPC2Zbb2HGTopvU04udpY3fjdXiSrq5p62i+r
 YoDF33FfL2fETxoESUe0dePFNJky64VMtRNSmE46tytJehFxZbFpgXSUp
 MASRZlDk4HOiREedu5Y/ZYQutUJ/t3kAiD1rU4zBMkzvPkncV1qUFnXPx
 iQSZjqoL9BDRuVsK2HBgfxNfTqtjAS55AJAUPOI0VDSlvcUhi6AR4fPKQ
 SBiQe/z4vD5OqjT/HHaXMzcidBoOg6foayH088f7y+/2l0lVrqhzrqRmB
 KNvolDC2Ok1YfVLgaxYIg0nN8bXM33ikGQeIvD2aPK6k21rtCQVdBwdj1 Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="271960447"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; d="scan'208";a="271960447"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2022 04:07:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; d="scan'208";a="782986155"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by orsmga005.jf.intel.com with ESMTP; 16 Aug 2022 04:07:33 -0700
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org,
	tiwai@suse.com
Subject: [RESEND PATCH v2 2/6] ASoC: SOF: Intel: Introduce HDA codec init and
 exit routines
Date: Tue, 16 Aug 2022 13:17:23 +0200
Message-Id: <20220816111727.3218543-3-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220816111727.3218543-1-cezary.rojewski@intel.com>
References: <20220816111727.3218543-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, kai.vehmanen@linux.intel.com,
 pierre-louis.bossart@linux.intel.com, hdegoede@redhat.com,
 amadeuszx.slawinski@linux.intel.com
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

Preliminary step in making snd_hda_codec_device_init() the only
constructor for struct hda_codec instances. To do that, existing usage
of hdac_ext equivalents has to be dropped.

Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/intel/hda-codec.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/sound/soc/sof/intel/hda-codec.c b/sound/soc/sof/intel/hda-codec.c
index 2f3f4a733d9e..4c128ba02340 100644
--- a/sound/soc/sof/intel/hda-codec.c
+++ b/sound/soc/sof/intel/hda-codec.c
@@ -109,6 +109,36 @@ EXPORT_SYMBOL_NS(hda_codec_jack_check, SND_SOC_SOF_HDA_AUDIO_CODEC);
 #define is_generic_config(x)	0
 #endif
 
+static void hda_codec_device_exit(struct device *dev)
+{
+	snd_hdac_device_exit(dev_to_hdac_dev(dev));
+}
+
+static __maybe_unused struct hda_codec *
+hda_codec_device_init(struct hdac_bus *bus, int addr, int type)
+{
+	struct hda_codec *codec;
+	int ret;
+
+	codec = snd_hda_codec_device_init(to_hda_bus(bus), addr, "ehdaudio%dD%d", bus->idx, addr);
+	if (IS_ERR(codec)) {
+		dev_err(bus->dev, "device init failed for hdac device\n");
+		return codec;
+	}
+
+	codec->core.type = type;
+	codec->core.dev.release = hda_codec_device_exit;
+
+	ret = snd_hdac_device_register(&codec->core);
+	if (ret) {
+		dev_err(bus->dev, "failed to register hdac device\n");
+		snd_hdac_device_exit(&codec->core);
+		return ERR_PTR(ret);
+	}
+
+	return codec;
+}
+
 /* probe individual codec */
 static int hda_codec_probe(struct snd_sof_dev *sdev, int address,
 			   bool hda_codec_use_common_hdmi)
-- 
2.25.1

