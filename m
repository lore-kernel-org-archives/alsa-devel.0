From: Bard liao <yung-chuan.liao@linux.intel.com>
Subject: [PATCH 2/2] ASoC: hdac_hda: overwrite hdev type to
	HDA_DEV_ASOC
Date: Sun, 28 Apr 2019 04:53:40 +0800
Message-ID: <20190427205340.8830-2-yung-chuan.liao@linux.intel.com>
References: <20190427205340.8830-1-yung-chuan.liao@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A9CF2F8962C
 for <alsa-devel@alsa-project.org>; Sun, 28 Apr 2019 10:52:44 +0200 (CEST)
In-Reply-To: <20190427205340.8830-1-yung-chuan.liao@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org, tiwai@suse.de
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
List-Id: alsa-devel@alsa-project.org

In ASoC driver, snd_hdac_device_register() will be called by
snd_hdac_ext_bus_device_init() and snd_hdac_device_unregister()
will called by snd_hdac_ext_bus_device_remove(). However when
ASoC codec driver call snd_hda_codec_device_new() to create a
new hda codec, it will assign snd_hda_codec_dev_free() to the
dev_free ops and snd_hda_codec_dev_free() will call
snd_hdac_device_unregister(). As a result, snd_hdac_device_unregister()
will be called twice in ASoC driver. To prevent it, we use hdev
type to determine if the hda codec is registered by legacy HDA
driver or ASoC driver and unregister device in  snd_hda_codec_dev_free()
only if it is a legacy HDA device.
This patch will overwrite the hdev type so that we can know it is
a ASoC device.

Signed-off-by: Bard liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/codecs/hdac_hda.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/codecs/hdac_hda.c b/sound/soc/codecs/hdac_hda.c
index f889d94c8e3c..7d4940256914 100644
--- a/sound/soc/codecs/hdac_hda.c
+++ b/sound/soc/codecs/hdac_hda.c
@@ -328,6 +328,12 @@ static int hdac_hda_codec_probe(struct snd_soc_component *component)
 		dev_err(&hdev->dev, "failed to create hda codec %d\n", ret);
 		goto error_no_pm;
 	}
+	/*
+	 * Overwrite type to HDA_DEV_ASOC since it is a ASoC driver
+	 * hda_codec.c will check this flag to determine if unregister
+	 * device is needed.
+	 */
+	hdev->type = HDA_DEV_ASOC;
 
 	/*
 	 * snd_hda_codec_device_new decrements the usage count so call get pm
-- 
2.17.1
