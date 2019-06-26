From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: [PATCH 1/2] ASoC: SOF: Intel: hda: Make hdac_device
	device-managed
Date: Tue, 25 Jun 2019 23:29:34 -0700
Message-ID: <20190626062935.5549-2-ranjani.sridharan@linux.intel.com>
References: <20190626062935.5549-1-ranjani.sridharan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0728CF806F0
 for <alsa-devel@alsa-project.org>; Wed, 26 Jun 2019 08:29:40 +0200 (CEST)
In-Reply-To: <20190626062935.5549-1-ranjani.sridharan@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, libin.yang@intel.com, broonie@kernel.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

snd_hdac_ext_bus_device_exit() has been recently modified
to no longer free the hdac device. SOF allocates memory for
hdac_device and hda_hda_priv with kzalloc. Make them
device-managed instead so that they will be freed when the
SOF driver is unloaded.

Signed-off-by: Libin Yang <libin.yang@intel.com>
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/sof/intel/hda-codec.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sof/intel/hda-codec.c b/sound/soc/sof/intel/hda-codec.c
index b8b37f082309..0d8437b080bf 100644
--- a/sound/soc/sof/intel/hda-codec.c
+++ b/sound/soc/sof/intel/hda-codec.c
@@ -62,8 +62,7 @@ static int hda_codec_probe(struct snd_sof_dev *sdev, int address)
 		address, resp);
 
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC)
-	/* snd_hdac_ext_bus_device_exit will use kfree to free hdev */
-	hda_priv = kzalloc(sizeof(*hda_priv), GFP_KERNEL);
+	hda_priv = devm_kzalloc(sdev->dev, sizeof(*hda_priv), GFP_KERNEL);
 	if (!hda_priv)
 		return -ENOMEM;
 
@@ -82,8 +81,7 @@ static int hda_codec_probe(struct snd_sof_dev *sdev, int address)
 
 	return 0;
 #else
-	/* snd_hdac_ext_bus_device_exit will use kfree to free hdev */
-	hdev = kzalloc(sizeof(*hdev), GFP_KERNEL);
+	hdev = devm_kzalloc(sdev->dev, sizeof(*hdev), GFP_KERNEL);
 	if (!hdev)
 		return -ENOMEM;
 
-- 
2.17.1
