From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Serialize codec registrations
Date: Fri,  1 Feb 2019 11:31:38 +0100
Message-ID: <20190201103138.14847-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A31D267463
 for <alsa-devel@alsa-project.org>; Fri,  1 Feb 2019 11:31:39 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id A3FD3ADC9
 for <alsa-devel@alsa-project.org>; Fri,  1 Feb 2019 10:31:39 +0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In the current code, the codec registration may happen both at the
codec bind time and the end of the controller probe time.  In a rare
occasion, they race with each other, leading to Oops due to the still
uninitialized card device.

This patch introduces a simple flag to prevent the codec registration
at the codec bind time as long as the controller probe is going on.
The controller probe invokes snd_card_register() that does the whole
registration task, and we don't need to register each piece
beforehand.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/hda_codec.h | 1 +
 sound/pci/hda/hda_bind.c  | 3 ++-
 sound/pci/hda/hda_intel.c | 2 ++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/sound/hda_codec.h b/include/sound/hda_codec.h
index 7fa48b100936..cc7c8d42d4fd 100644
--- a/include/sound/hda_codec.h
+++ b/include/sound/hda_codec.h
@@ -68,6 +68,7 @@ struct hda_bus {
 	unsigned int response_reset:1;	/* controller was reset */
 	unsigned int in_reset:1;	/* during reset operation */
 	unsigned int no_response_fallback:1; /* don't fallback at RIRB error */
+	unsigned int bus_probing :1;	/* during probing process */
 
 	int primary_dig_out_type;	/* primary digital out PCM type */
 	unsigned int mixer_assigned;	/* codec addr for mixer name */
diff --git a/sound/pci/hda/hda_bind.c b/sound/pci/hda/hda_bind.c
index 9174f1b3a987..1ec706ced75c 100644
--- a/sound/pci/hda/hda_bind.c
+++ b/sound/pci/hda/hda_bind.c
@@ -115,7 +115,8 @@ static int hda_codec_driver_probe(struct device *dev)
 	err = snd_hda_codec_build_controls(codec);
 	if (err < 0)
 		goto error_module;
-	if (codec->card->registered) {
+	/* only register after the bus probe finished; otherwise it's racy */
+	if (!codec->bus->bus_probing && codec->card->registered) {
 		err = snd_card_register(codec->card);
 		if (err < 0)
 			goto error_module;
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index e784130ea4e0..e5c49003e75f 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2185,6 +2185,7 @@ static int azx_probe_continue(struct azx *chip)
 	int dev = chip->dev_index;
 	int err;
 
+	to_hda_bus(bus)->bus_probing = 1;
 	hda->probe_continued = 1;
 
 	/* bind with i915 if needed */
@@ -2269,6 +2270,7 @@ static int azx_probe_continue(struct azx *chip)
 	if (err < 0)
 		hda->init_failed = 1;
 	complete_all(&hda->probe_wait);
+	to_hda_bus(bus)->bus_probing = 0;
 	return err;
 }
 
-- 
2.16.4
