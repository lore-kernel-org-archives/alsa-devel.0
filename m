From: "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>
Subject: Re: [RFC v2 00/11] Enable HDA Codec support on Intel
 Platforms (Series2)
Date: Tue, 12 Dec 2017 16:37:56 +0000
Message-ID: <85DFEED57DC57344B2483EF7BF8CB60579AD52D3@BGSMSX104.gar.corp.intel.com>
References: <1512989583-10877-1-git-send-email-rakesh.a.ughreja@intel.com>
 <s5hbmj5mrts.wl-tiwai@suse.de>
 <85DFEED57DC57344B2483EF7BF8CB60579AD2978@BGSMSX104.gar.corp.intel.com>
 <s5hinddl28l.wl-tiwai@suse.de>
 <85DFEED57DC57344B2483EF7BF8CB60579AD2F48@BGSMSX104.gar.corp.intel.com>
 <s5hefo1aymr.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 2174C266DF0
 for <alsa-devel@alsa-project.org>; Tue, 12 Dec 2017 17:38:02 +0100 (CET)
In-Reply-To: <s5hefo1aymr.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Koul,
 Vinod" <vinod.koul@intel.com>, "pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org



>-----Original Message-----
>From: Takashi Iwai [mailto:tiwai@suse.de]
>Sent: Tuesday, December 12, 2017 12:19 AM
>To: Ughreja, Rakesh A <rakesh.a.ughreja@intel.com>
>Cc: alsa-devel@alsa-project.org; broonie@kernel.org;
>liam.r.girdwood@linux.intel.com; pierre-louis.bossart@linux.intel.com; Koul,
>Vinod <vinod.koul@intel.com>; Patches Audio <patches.audio@intel.com>
>Subject: Re: [RFC v2 00/11] Enable HDA Codec support on Intel Platforms
>(Series2)

>
>The registration should be triggered from the top-level, i.e. the
>controller driver, once after all codecs get probed.  Otherwise, it
>becomes racy.  The user-space will start poking the device before all
>the stuff becomes ready.

Thank you very much, I understand now.

>
>That said, at the point when the codec is probed, the card shouldn't
>be registered yet.  The card gets registered after the all components
>are bound and become ready -- which is done a single
>snd_card_register() call.  At this point, the access points to
>user-space are provided.

So based on your suggestion when I relooked at the code, I could
remove the new function that I added. I could completely reuse the 
existing function with little change.

Does it look okay ?

Following is the patch, which I tested and it works for me.
I will include this in next series but for now it's only for quick reference.

I am calling this API from the hdac_hda codec driver with argument
HDA_DEV_ASOC to make sure that it does not register with the bus
again. I am not able to call this API from ASoC Platform driver because
I don't have snd_card pointer at the time of machine driver probe.

Following is the patch. 
---------------------------
Modify snd_hda_codec_new API so that it can work for legacy as well as
ASoC codec drivers. The API takes an additional argument dev_type as
HDA_DEV_LEGACY or HDA_DEV_ASOC to distinguish the caller.

Signed-off-by: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
---
 sound/pci/hda/hda_codec.c      | 30 +++++++++++++++++++-----------
 sound/pci/hda/hda_codec.h      |  3 ++-
 sound/pci/hda/hda_controller.c |  2 +-
 3 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 085fd9e..252779c 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -865,7 +865,8 @@ static void snd_hda_codec_dev_release(struct device *dev)
  * Returns 0 if successful, or a negative error code.
  */
 int snd_hda_codec_new(struct hda_bus *bus, struct snd_card *card,
-		      unsigned int codec_addr, struct hda_codec **codecp)
+		      unsigned int codec_addr, struct hda_codec **codecp,
+			unsigned int dev_type)
 {
 	struct hda_codec *codec;
 	char component[31];
@@ -882,20 +883,27 @@ int snd_hda_codec_new(struct hda_bus *bus, struct snd_card *card,
 	if (snd_BUG_ON(codec_addr > HDA_MAX_CODEC_ADDRESS))
 		return -EINVAL;
 
-	codec = kzalloc(sizeof(*codec), GFP_KERNEL);
-	if (!codec)
-		return -ENOMEM;
+	if (dev_type == HDA_DEV_LEGACY) {
 
-	sprintf(component, "hdaudioC%dD%d", card->number, codec_addr);
-	err = snd_hdac_device_init(&codec->core, &bus->core, component,
-				   codec_addr);
-	if (err < 0) {
-		kfree(codec);
-		return err;
+		codec = kzalloc(sizeof(*codec), GFP_KERNEL);
+		if (!codec)
+			return -ENOMEM;
+
+		sprintf(component, "hdaudioC%dD%d", card->number, codec_addr);
+		err = snd_hdac_device_init(&codec->core, &bus->core, component,
+						codec_addr);
+		if (err < 0) {
+			kfree(codec);
+			return err;
+		}
+
+		codec->core.type = HDA_DEV_LEGACY;
+
+	} else {
+		codec = *codecp;
 	}
 
 	codec->core.dev.release = snd_hda_codec_dev_release;
-	codec->core.type = HDA_DEV_LEGACY;
 	codec->core.exec_verb = codec_exec_verb;
 
 	codec->bus = bus;
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index d3099db..92815b7 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -306,7 +306,8 @@ struct hda_codec {
  * constructors
  */
 int snd_hda_codec_new(struct hda_bus *bus, struct snd_card *card,
-		      unsigned int codec_addr, struct hda_codec **codecp);
+			unsigned int codec_addr, struct hda_codec **codecp,
+			unsigned int dev_type);
 int snd_hda_codec_configure(struct hda_codec *codec);
 int snd_hda_codec_update_widgets(struct hda_codec *codec);
 
diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index d1eb148..ec887d7 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -1318,7 +1318,7 @@ int azx_probe_codecs(struct azx *chip, unsigned int max_slots)
 	for (c = 0; c < max_slots; c++) {
 		if ((bus->codec_mask & (1 << c)) & chip->codec_probe_mask) {
 			struct hda_codec *codec;
-			err = snd_hda_codec_new(&chip->bus, chip->card, c, &codec);
+			err = snd_hda_codec_new(&chip->bus, chip->card, c, &codec, HDA_DEV_LEGACY);
 			if (err < 0)
 				continue;
 			codec->jackpoll_interval = get_jackpoll_interval(chip);
-- 
2.7.4
