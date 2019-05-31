From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: [PATCH v2] ASoC: hda: fix unbalanced codec dev
	refcount for HDA_DEV_ASOC
Date: Fri, 31 May 2019 09:01:37 -0700
Message-ID: <20190531160137.5603-1-ranjani.sridharan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F1FD1F8072E
 for <alsa-devel@alsa-project.org>; Fri, 31 May 2019 18:01:41 +0200 (CEST)
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
Cc: tiwai@suse.de, broonie@kernel.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

HDA_DEV_ASOC type codec device refcounts are managed differently
from HDA_DEV_LEGACY devices. The refcount is released explicitly
in snd_hdac_ext_bus_device_remove() for ASOC type devices.
So, remove the put_device() call in snd_hda_codec_dev_free()
for such devices to make the refcount balanced. This will prevent
the NULL pointer exception when the codec driver is released
after the card is freed.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/pci/hda/hda_codec.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index b20eb7fc83eb..fcdf2cd3783b 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -840,7 +840,14 @@ static int snd_hda_codec_dev_free(struct snd_device *device)
 	if (codec->core.type == HDA_DEV_LEGACY)
 		snd_hdac_device_unregister(&codec->core);
 	codec_display_power(codec, false);
-	put_device(hda_codec_dev(codec));
+
+	/*
+	 * In the case of ASoC HD-audio bus, the device refcount is released in
+	 * snd_hdac_ext_bus_device_remove() explicitly.
+	 */
+	if (codec->core.type == HDA_DEV_LEGACY)
+		put_device(hda_codec_dev(codec));
+
 	return 0;
 }
 
-- 
2.17.1
