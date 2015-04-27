From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH v10 2/7] ALSA: Jack: handle jack embedded
	kcontrol creating within ctljack
Date: Mon, 27 Apr 2015 21:20:57 +0800
Message-ID: <1430140862-17207-3-git-send-email-yang.jie@intel.com>
References: <1430140862-17207-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F3EA264F07
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2015 15:17:41 +0200 (CEST)
In-Reply-To: <1430140862-17207-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, tanu.kaskinen@linux.intel.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

This patch adds a static method get_available_index() to
allocate the index of new jack kcontrols and also adds
jack_kctl_name_gen() which is used to ensure compatibility
with jack naming by removing " Jack" from some incorrectly
passed names.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 include/sound/control.h  |  2 +-
 sound/core/ctljack.c     | 37 ++++++++++++++++++++++++++++++++++---
 sound/core/jack.c        |  2 +-
 sound/pci/hda/hda_jack.c |  2 +-
 4 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/include/sound/control.h b/include/sound/control.h
index 95aad6d..f50e2e9 100644
--- a/include/sound/control.h
+++ b/include/sound/control.h
@@ -252,7 +252,7 @@ void snd_ctl_sync_vmaster(struct snd_kcontrol *kctl, bool hook_only);
  * Helper functions for jack-detection controls
  */
 struct snd_kcontrol *
-snd_kctl_jack_new(const char *name, int idx, void *private_data);
+snd_kctl_jack_new(const char *name, void *private_data, struct snd_card *card);
 void snd_kctl_jack_report(struct snd_card *card,
 			  struct snd_kcontrol *kctl, bool status);
 
diff --git a/sound/core/ctljack.c b/sound/core/ctljack.c
index e4b38fb..df7c6cd 100644
--- a/sound/core/ctljack.c
+++ b/sound/core/ctljack.c
@@ -31,15 +31,46 @@ static struct snd_kcontrol_new jack_detect_kctl = {
 	.get = jack_detect_kctl_get,
 };
 
+static int get_available_index(struct snd_card *card, const char *name)
+{
+	struct snd_ctl_elem_id sid;
+
+	memset(&sid, 0, sizeof(sid));
+
+	sid.index = 0;
+	sid.iface = SNDRV_CTL_ELEM_IFACE_CARD;
+	strlcpy(sid.name, name, sizeof(sid.name));
+
+	while (snd_ctl_find_id(card, &sid))
+		sid.index++;
+
+	return sid.index;
+}
+
+static void jack_kctl_name_gen(char *name, const char *src_name, int size)
+{
+	size_t count = strlen(src_name);
+	bool need_cat = true;
+
+	/* remove redundant " Jack" from src_name */
+	if (count >= 5)
+		need_cat = strncmp(&src_name[count - 5], " Jack", 5) ? true : false;
+
+	snprintf(name, size, need_cat ? "%s Jack" : "%s", src_name);
+
+}
+
 struct snd_kcontrol *
-snd_kctl_jack_new(const char *name, int idx, void *private_data)
+snd_kctl_jack_new(const char *name, void *private_data, struct snd_card *card)
 {
 	struct snd_kcontrol *kctl;
+
 	kctl = snd_ctl_new1(&jack_detect_kctl, private_data);
 	if (!kctl)
 		return NULL;
-	snprintf(kctl->id.name, sizeof(kctl->id.name), "%s Jack", name);
-	kctl->id.index = idx;
+
+	jack_kctl_name_gen(kctl->id.name, name, sizeof(kctl->id.name));
+	kctl->id.index = get_available_index(card, name);
 	kctl->private_value = 0;
 	return kctl;
 }
diff --git a/sound/core/jack.c b/sound/core/jack.c
index db69ecc..067d37d 100644
--- a/sound/core/jack.c
+++ b/sound/core/jack.c
@@ -135,7 +135,7 @@ static struct snd_jack_kctl * snd_jack_kctl_new(struct snd_card *card, const cha
 	struct snd_jack_kctl *jack_kctl;
 	int err;
 
-	kctl = snd_kctl_jack_new(name, 0, card);
+	kctl = snd_kctl_jack_new(name, card, card);
 	if (!kctl)
 		return NULL;
 
diff --git a/sound/pci/hda/hda_jack.c b/sound/pci/hda/hda_jack.c
index d7cfe7b..05b49aa 100644
--- a/sound/pci/hda/hda_jack.c
+++ b/sound/pci/hda/hda_jack.c
@@ -402,7 +402,7 @@ static int __snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
 		return 0;
 	if (jack->kctl)
 		return 0; /* already created */
-	kctl = snd_kctl_jack_new(name, idx, codec);
+	kctl = snd_kctl_jack_new(name, codec, codec->card);
 	if (!kctl)
 		return -ENOMEM;
 	err = snd_hda_ctl_add(codec, nid, kctl);
-- 
1.9.1
