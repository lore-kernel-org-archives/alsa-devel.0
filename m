From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v2] ALSA: hda - Update chmap tlv to report
	sink's capability
Date: Fri,  1 Apr 2016 15:48:51 +0530
Message-ID: <1459505931-20012-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id DB9712651BE
 for <alsa-devel@alsa-project.org>; Fri,  1 Apr 2016 12:19:22 +0200 (CEST)
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

The existing TLV callback implementation copies all of the
cea_channel_speaker_allocation map table to the TLV container
irrespective of what is reported by sink. This is of little use
to the userspace application.

With this patch, it parses the spk_alloc block as queried from
the ELD, and copies only the corresponding channel map from the
cea channel speaker allocation table. Thus the user can parse the
TLV container to identify sink's capability and set the channel
map accordingly.

It shouldn't impact the behavior in AMD chipset, as this makes
use of already parsed spk alloc block to calculate the channel
map.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---

changes in v2:
	Updated the commit message to make it more understandable.

 include/sound/hda_chmap.h  |  2 ++
 sound/hda/hdmi_chmap.c     | 90 +++++++++++++++++++++++++++++-----------------
 sound/pci/hda/patch_hdmi.c | 13 +++++++
 3 files changed, 72 insertions(+), 33 deletions(-)

diff --git a/include/sound/hda_chmap.h b/include/sound/hda_chmap.h
index e20d219..babd445 100644
--- a/include/sound/hda_chmap.h
+++ b/include/sound/hda_chmap.h
@@ -36,6 +36,8 @@ struct hdac_chmap_ops {
 	int (*chmap_validate)(struct hdac_chmap *hchmap, int ca,
 			int channels, unsigned char *chmap);
 
+	int (*get_spk_alloc)(struct hdac_device *hdac, int pcm_idx);
+
 	void (*get_chmap)(struct hdac_device *hdac, int pcm_idx,
 					unsigned char *chmap);
 	void (*set_chmap)(struct hdac_device *hdac, int pcm_idx,
diff --git a/sound/hda/hdmi_chmap.c b/sound/hda/hdmi_chmap.c
index d7ec862..9406203 100644
--- a/sound/hda/hdmi_chmap.c
+++ b/sound/hda/hdmi_chmap.c
@@ -625,13 +625,40 @@ static void hdmi_cea_alloc_to_tlv_chmap(struct hdac_chmap *hchmap,
 	WARN_ON(count != channels);
 }
 
+static struct hdac_cea_channel_speaker_allocation *get_cap_from_spk_alloc(
+							int spk_alloc)
+{
+	int i, spk_mask = 0;
+
+	if (!spk_alloc)
+		return &channel_allocations[0];
+
+	for (i = 0; i < ARRAY_SIZE(eld_speaker_allocation_bits); i++) {
+		if (spk_alloc & (1 << i))
+			spk_mask |= eld_speaker_allocation_bits[i];
+	}
+
+	/* Get num channels using spk mask */
+	for (i = 0; i < ARRAY_SIZE(channel_allocations); i++) {
+		if ((spk_mask & channel_allocations[i].spk_mask) == spk_mask)
+			return &channel_allocations[i];
+	}
+
+	return &channel_allocations[0];
+}
+
 static int hdmi_chmap_ctl_tlv(struct snd_kcontrol *kcontrol, int op_flag,
 			      unsigned int size, unsigned int __user *tlv)
 {
 	struct snd_pcm_chmap *info = snd_kcontrol_chip(kcontrol);
 	struct hdac_chmap *chmap = info->private_data;
+	int pcm_idx = kcontrol->private_value;
 	unsigned int __user *dst;
-	int chs, count = 0;
+	int chs, count = 0, chs_bytes;
+	int type;
+	unsigned int tlv_chmap[8];
+	int spk_alloc;
+	struct hdac_cea_channel_speaker_allocation *cap;
 
 	if (size < 8)
 		return -ENOMEM;
@@ -639,40 +666,37 @@ static int hdmi_chmap_ctl_tlv(struct snd_kcontrol *kcontrol, int op_flag,
 		return -EFAULT;
 	size -= 8;
 	dst = tlv + 2;
-	for (chs = 2; chs <= chmap->channels_max; chs++) {
-		int i;
-		struct hdac_cea_channel_speaker_allocation *cap;
-
-		cap = channel_allocations;
-		for (i = 0; i < ARRAY_SIZE(channel_allocations); i++, cap++) {
-			int chs_bytes = chs * 4;
-			int type = chmap->ops.chmap_cea_alloc_validate_get_type(
-								chmap, cap, chs);
-			unsigned int tlv_chmap[8];
-
-			if (type < 0)
-				continue;
-			if (size < 8)
-				return -ENOMEM;
-			if (put_user(type, dst) ||
-			    put_user(chs_bytes, dst + 1))
-				return -EFAULT;
-			dst += 2;
-			size -= 8;
-			count += 8;
-			if (size < chs_bytes)
-				return -ENOMEM;
-			size -= chs_bytes;
-			count += chs_bytes;
-			chmap->ops.cea_alloc_to_tlv_chmap(chmap, cap,
-						tlv_chmap, chs);
-			if (copy_to_user(dst, tlv_chmap, chs_bytes))
-				return -EFAULT;
-			dst += chs;
-		}
-	}
+
+	if (size < 8)
+		return -ENOMEM;
+
+	spk_alloc = chmap->ops.get_spk_alloc(chmap->hdac, pcm_idx);
+	cap = get_cap_from_spk_alloc(spk_alloc);
+	chs = cap->channels;
+
+	chs_bytes = chs * 4;
+	type = chmap->ops.chmap_cea_alloc_validate_get_type(chmap, cap, chs);
+	if (type < 0)
+		return -ENODEV;
+
+	if (put_user(type, dst) ||
+	    put_user(chs_bytes, dst + 1))
+		return -EFAULT;
+
+	dst += 2;
+	size -= 8;
+	count += 8;
+	if (size < chs_bytes)
+		return -ENOMEM;
+
+	count += chs_bytes;
+	chmap->ops.cea_alloc_to_tlv_chmap(chmap, cap, tlv_chmap, chs);
+	if (copy_to_user(dst, tlv_chmap, chs_bytes))
+		return -EFAULT;
+
 	if (put_user(count, tlv + 1))
 		return -EFAULT;
+
 	return 0;
 }
 
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 5af372d..dd25f2c 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1838,6 +1838,18 @@ static const struct hda_pcm_ops generic_ops = {
 	.cleanup = generic_hdmi_playback_pcm_cleanup,
 };
 
+static int hdmi_get_spk_alloc(struct hdac_device *hdac, int pcm_idx)
+{
+	struct hda_codec *codec = container_of(hdac, struct hda_codec, core);
+	struct hdmi_spec *spec = codec->spec;
+	struct hdmi_spec_per_pin *per_pin = pcm_idx_to_pin(spec, pcm_idx);
+
+	if (!per_pin)
+		return 0;
+
+	return per_pin->sink_eld.info.spk_alloc;
+}
+
 static void hdmi_get_chmap(struct hdac_device *hdac, int pcm_idx,
 					unsigned char *chmap)
 {
@@ -2249,6 +2261,7 @@ static int patch_generic_hdmi(struct hda_codec *codec)
 	spec->chmap.ops.get_chmap = hdmi_get_chmap;
 	spec->chmap.ops.set_chmap = hdmi_set_chmap;
 	spec->chmap.ops.is_pcm_attached = is_hdmi_pcm_attached;
+	spec->chmap.ops.get_spk_alloc = hdmi_get_spk_alloc,
 
 	codec->spec = spec;
 	hdmi_array_init(spec, 4);
-- 
1.9.1
