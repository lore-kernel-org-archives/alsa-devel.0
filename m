From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 12/12] ASoC: SOF: Intel: hda-codec: fix memory
	allocation
Date: Sat, 18 May 2019 15:27:04 -0500
Message-ID: <20190518202704.7772-13-pierre-louis.bossart@linux.intel.com>
References: <20190518202704.7772-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6013AF8972F
 for <alsa-devel@alsa-project.org>; Sat, 18 May 2019 22:27:32 +0200 (CEST)
In-Reply-To: <20190518202704.7772-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, Libin Yang <libin.yang@intel.com>, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@intel.com>

Align all users of the hdac library to use devm_kzalloc.

Note for backports/stable: the patch ("ALSA: hdac: fix memory release
for SST and SOF drivers") needs to be applied as well.

Fixes: 5507b8103e26 ("ASoC: SOF: Intel: Add support for HDAudio codecs")
Signed-off-by: Libin Yang <libin.yang@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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
2.20.1
