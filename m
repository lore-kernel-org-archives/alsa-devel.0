From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH v2 2/2] ALSA: hda - Remove jack kctls
Date: Fri, 20 Mar 2015 16:55:19 +0800
Message-ID: <1426841719-14576-4-git-send-email-yang.jie@intel.com>
References: <1426841719-14576-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 9326E2606E9
 for <alsa-devel@alsa-project.org>; Fri, 20 Mar 2015 09:52:36 +0100 (CET)
In-Reply-To: <1426841719-14576-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

We move kctls creating to core jack part, which means that
the kctls belonging to the jack will be created at jack
new stage. Then we can remove hda jack kctls here.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/core/Kconfig       |  3 ---
 sound/core/Makefile      |  3 +--
 sound/pci/hda/Kconfig    | 10 +---------
 sound/pci/hda/hda_jack.c | 45 +++------------------------------------------
 sound/pci/hda/hda_jack.h |  3 ---
 5 files changed, 5 insertions(+), 59 deletions(-)

diff --git a/sound/core/Kconfig b/sound/core/Kconfig
index 313f22e..63cc2e9 100644
--- a/sound/core/Kconfig
+++ b/sound/core/Kconfig
@@ -221,9 +221,6 @@ config SND_PCM_XRUN_DEBUG
 config SND_VMASTER
 	bool
 
-config SND_KCTL_JACK
-	bool
-
 config SND_DMA_SGBUF
 	def_bool y
 	depends on X86
diff --git a/sound/core/Makefile b/sound/core/Makefile
index 4daf2f5..e041dc2 100644
--- a/sound/core/Makefile
+++ b/sound/core/Makefile
@@ -7,8 +7,7 @@ snd-y     := sound.o init.o memory.o info.o control.o misc.o device.o
 snd-$(CONFIG_ISA_DMA_API) += isadma.o
 snd-$(CONFIG_SND_OSSEMUL) += sound_oss.o info_oss.o
 snd-$(CONFIG_SND_VMASTER) += vmaster.o
-snd-$(CONFIG_SND_KCTL_JACK) += ctljack.o
-snd-$(CONFIG_SND_JACK)	  += jack.o
+snd-$(CONFIG_SND_JACK)	  += ctljack.o jack.o
 
 snd-pcm-y := pcm.o pcm_native.o pcm_lib.o pcm_timer.o pcm_misc.o \
 		pcm_memory.o memalloc.o
diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index 7f0f2c5..7fe4a30 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -4,7 +4,7 @@ config SND_HDA
 	tristate
 	select SND_PCM
 	select SND_VMASTER
-	select SND_KCTL_JACK
+	select SND_JACK
 
 config SND_HDA_INTEL
 	tristate "HD Audio PCI"
@@ -86,14 +86,6 @@ config SND_HDA_INPUT_BEEP_MODE
 	  Set 1 to always enable the digital beep interface for HD-audio by
 	  default.
 
-config SND_HDA_INPUT_JACK
-	bool "Support jack plugging notification via input layer"
-	depends on INPUT=y || INPUT=SND
-	select SND_JACK
-	help
-	  Say Y here to enable the jack plugging notification via
-	  input layer.
-
 config SND_HDA_PATCH_LOADER
 	bool "Support initialization patch loading for HD-audio"
 	select FW_LOADER
diff --git a/sound/pci/hda/hda_jack.c b/sound/pci/hda/hda_jack.c
index e664307..5cbd1a7 100644
--- a/sound/pci/hda/hda_jack.c
+++ b/sound/pci/hda/hda_jack.c
@@ -132,11 +132,9 @@ void snd_hda_jack_tbl_clear(struct hda_codec *codec)
 
 	for (i = 0; i < codec->jacktbl.used; i++, jack++) {
 		struct hda_jack_callback *cb, *next;
-#ifdef CONFIG_SND_HDA_INPUT_JACK
 		/* free jack instances manually when clearing/reconfiguring */
 		if (!codec->bus->shutdown && jack->jack)
 			snd_device_free(codec->bus->card, jack->jack);
-#endif
 		for (cb = jack->callback; cb; cb = next) {
 			next = cb->next;
 			kfree(cb);
@@ -337,20 +335,16 @@ void snd_hda_jack_report_sync(struct hda_codec *codec)
 	jack = codec->jacktbl.list;
 	for (i = 0; i < codec->jacktbl.used; i++, jack++)
 		if (jack->nid) {
-			if (!jack->kctl || jack->block_report)
+			if (!jack->jack || jack->block_report)
 				continue;
 			state = get_jack_plug_state(jack->pin_sense);
-			snd_kctl_jack_report(codec->bus->card, jack->kctl, state);
-#ifdef CONFIG_SND_HDA_INPUT_JACK
 			if (jack->jack)
 				snd_jack_report(jack->jack,
 						state ? jack->type : 0);
-#endif
 		}
 }
 EXPORT_SYMBOL_GPL(snd_hda_jack_report_sync);
 
-#ifdef CONFIG_SND_HDA_INPUT_JACK
 /* guess the jack type from the pin-config */
 static int get_input_jack_type(struct hda_codec *codec, hda_nid_t nid)
 {
@@ -377,7 +371,6 @@ static void hda_free_jack_priv(struct snd_jack *jack)
 	jacks->nid = 0;
 	jacks->jack = NULL;
 }
-#endif
 
 /**
  * snd_hda_jack_add_kctl - Add a kctl for the given pin
@@ -394,26 +387,15 @@ static int __snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
 			  const char *name, int idx, bool phantom_jack)
 {
 	struct hda_jack_tbl *jack;
-	struct snd_kcontrol *kctl;
 	int err, state;
 
 	jack = snd_hda_jack_tbl_new(codec, nid);
 	if (!jack)
 		return 0;
-	if (jack->kctl)
+	if (jack->jack)
 		return 0; /* already created */
-	kctl = snd_kctl_jack_new(name, idx, codec);
-	if (!kctl)
-		return -ENOMEM;
-	err = snd_hda_ctl_add(codec, nid, kctl);
-	if (err < 0)
-		return err;
-	jack->kctl = kctl;
 	jack->phantom_jack = !!phantom_jack;
 
-	state = snd_hda_jack_detect(codec, nid);
-	snd_kctl_jack_report(codec->bus->card, kctl, state);
-#ifdef CONFIG_SND_HDA_INPUT_JACK
 	if (!phantom_jack) {
 		jack->type = get_input_jack_type(codec, nid);
 		err = snd_jack_new(codec->bus->card, name, jack->type,
@@ -422,9 +404,9 @@ static int __snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
 			return err;
 		jack->jack->private_data = jack;
 		jack->jack->private_free = hda_free_jack_priv;
+		state = snd_hda_jack_detect(codec, nid);
 		snd_jack_report(jack->jack, state ? jack->type : 0);
 	}
-#endif
 	return 0;
 }
 
@@ -444,26 +426,6 @@ int snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
 }
 EXPORT_SYMBOL_GPL(snd_hda_jack_add_kctl);
 
-/* get the unique index number for the given kctl name */
-static int get_unique_index(struct hda_codec *codec, const char *name, int idx)
-{
-	struct hda_jack_tbl *jack;
-	int i, len = strlen(name);
- again:
-	jack = codec->jacktbl.list;
-	for (i = 0; i < codec->jacktbl.used; i++, jack++) {
-		/* jack->kctl.id contains "XXX Jack" name string with index */
-		if (jack->kctl &&
-		    !strncmp(name, jack->kctl->id.name, len) &&
-		    !strcmp(" Jack", jack->kctl->id.name + len) &&
-		    jack->kctl->id.index == idx) {
-			idx++;
-			goto again;
-		}
-	}
-	return idx;
-}
-
 static int add_jack_kctl(struct hda_codec *codec, hda_nid_t nid,
 			 const struct auto_pin_cfg *cfg,
 			 const char *base_name)
@@ -490,7 +452,6 @@ static int add_jack_kctl(struct hda_codec *codec, hda_nid_t nid,
 	if (phantom_jack)
 		/* Example final name: "Internal Mic Phantom Jack" */
 		strncat(name, " Phantom", sizeof(name) - strlen(name) - 1);
-	idx = get_unique_index(codec, name, idx);
 	err = __snd_hda_jack_add_kctl(codec, nid, name, idx, phantom_jack);
 	if (err < 0)
 		return err;
diff --git a/sound/pci/hda/hda_jack.h b/sound/pci/hda/hda_jack.h
index b279e32..6530faf 100644
--- a/sound/pci/hda/hda_jack.h
+++ b/sound/pci/hda/hda_jack.h
@@ -39,11 +39,8 @@ struct hda_jack_tbl {
 	unsigned int block_report:1;    /* in a transitional state - do not report to userspace */
 	hda_nid_t gating_jack;		/* valid when gating jack plugged */
 	hda_nid_t gated_jack;		/* gated is dependent on this jack */
-	struct snd_kcontrol *kctl;	/* assigned kctl for jack-detection */
-#ifdef CONFIG_SND_HDA_INPUT_JACK
 	int type;
 	struct snd_jack *jack;
-#endif
 };
 
 struct hda_jack_tbl *
-- 
1.9.1
