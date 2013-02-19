From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH v2 2/4] ALSA: hda - hdmi: Do not expose eld
	data when eld is invalid
Date: Tue, 19 Feb 2013 09:47:35 +0100
Message-ID: <1361263657-15888-3-git-send-email-david.henningsson@canonical.com>
References: <1361263657-15888-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 28BD82651B0
 for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2013 09:47:34 +0100 (CET)
In-Reply-To: <1361263657-15888-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: fengguang.wu@intel.com, pierre-louis.bossart@linux.intel.com, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Previously, it was possible to read the eld data of the previous
monitor connected. This should not be allowed.

Also refactor the function slightly.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_hdmi.c |   23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 32adaa6..7a73dfb 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -343,14 +343,16 @@ static int hdmi_eld_ctl_info(struct snd_kcontrol *kcontrol,
 			struct snd_ctl_elem_info *uinfo)
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct hdmi_spec *spec;
+	struct hdmi_spec *spec = codec->spec;
+	struct hdmi_eld *eld;
 	int pin_idx;
 
-	spec = codec->spec;
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_BYTES;
 
 	pin_idx = kcontrol->private_value;
-	uinfo->count = spec->pins[pin_idx].sink_eld.eld_size;
+	eld = &spec->pins[pin_idx].sink_eld;
+
+	uinfo->count = eld->eld_valid ? eld->eld_size : 0;
 
 	return 0;
 }
@@ -359,14 +361,21 @@ static int hdmi_eld_ctl_get(struct snd_kcontrol *kcontrol,
 			struct snd_ctl_elem_value *ucontrol)
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct hdmi_spec *spec;
+	struct hdmi_spec *spec = codec->spec;
+	struct hdmi_eld *eld;
 	int pin_idx;
 
-	spec = codec->spec;
 	pin_idx = kcontrol->private_value;
+	eld = &spec->pins[pin_idx].sink_eld;
+
+	if (eld->eld_size > ARRAY_SIZE(ucontrol->value.bytes.data)) {
+		snd_BUG();
+		return -EINVAL;
+	}
 
-	memcpy(ucontrol->value.bytes.data,
-		spec->pins[pin_idx].sink_eld.eld_buffer, ELD_MAX_SIZE);
+	if (eld->eld_valid)
+		memcpy(ucontrol->value.bytes.data, eld->eld_buffer,
+		       eld->eld_size);
 
 	return 0;
 }
-- 
1.7.9.5
