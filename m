From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: [PATCH] ASoC: hda: increment codec device refcount
	when it is added to the card
Date: Thu, 30 May 2019 13:18:28 -0700
Message-ID: <20190530201828.2648-1-ranjani.sridharan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D45ADF8065A
 for <alsa-devel@alsa-project.org>; Thu, 30 May 2019 22:18:31 +0200 (CEST)
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

Calling snd_device_new() makes the codec devices managed by the card.
So, when the card is removed, the refcount for the codec
device is decremented and results in the codec device's kobject
being cleaned up if the refcount is 0. But, this leads to a NULL
pointer exception while attempting to remove the symlinks when the
codec driver is released later on. Therefore, increment the codec
device's refcount before adding it to the card to prevent this.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/pci/hda/hda_codec.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index b20eb7fc83eb..0d5d95b07e19 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -985,6 +985,14 @@ int snd_hda_codec_device_new(struct hda_bus *bus, struct snd_card *card,
 		codec->core.subsystem_id, codec->core.revision_id);
 	snd_component_add(card, component);
 
+	/*
+	 * snd_device_new() makes the codec device managed by the card.
+	 * When the card is removed, the device reference count is
+	 * decremented. Therefore, increment it here to prevent removing
+	 * the codec device's kobject when the card is removed.
+	 */
+	get_device(hda_codec_dev(codec));
+
 	err = snd_device_new(card, SNDRV_DEV_CODEC, codec, &dev_ops);
 	if (err < 0)
 		goto error;
-- 
2.17.1
