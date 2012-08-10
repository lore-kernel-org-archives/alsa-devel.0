From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - Fix panned "Beep Playback Switch"
Date: Fri, 10 Aug 2012 13:29:32 +0200
Message-ID: <1344598172-6050-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 089B82664FE
 for <alsa-devel@alsa-project.org>; Fri, 10 Aug 2012 12:59:48 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

When "Beep Playback Switch" had a different value on left and right
channels (such as muting left but not right, or vice versa), this
could result in the right channel being ignored.

This patch enables beep to be sounding from right channel only, and
also give correct result back to userspace (e g amixer).

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_beep.c |   20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/hda_beep.c b/sound/pci/hda/hda_beep.c
index 0bc2315..d26ae65 100644
--- a/sound/pci/hda/hda_beep.c
+++ b/sound/pci/hda/hda_beep.c
@@ -237,10 +237,9 @@ int snd_hda_mixer_amp_switch_get_beep(struct snd_kcontrol *kcontrol,
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct hda_beep *beep = codec->beep;
-	if (beep) {
+	if (beep && !beep->enabled) {
 		ucontrol->value.integer.value[0] =
-			ucontrol->value.integer.value[1] =
-			beep->enabled;
+			ucontrol->value.integer.value[1] = 0;
 		return 0;
 	}
 	return snd_hda_mixer_amp_switch_get(kcontrol, ucontrol);
@@ -252,9 +251,18 @@ int snd_hda_mixer_amp_switch_put_beep(struct snd_kcontrol *kcontrol,
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct hda_beep *beep = codec->beep;
-	if (beep)
-		snd_hda_enable_beep_device(codec,
-					   *ucontrol->value.integer.value);
+	if (beep) {
+		u8 chs = get_amp_channels(kcontrol);
+		int enable = 0;
+		long *valp = ucontrol->value.integer.value;
+		if (chs & 1) {
+			enable |= *valp;
+			valp++;
+		}
+		if (chs & 2)
+			enable |= *valp;
+		snd_hda_enable_beep_device(codec, enable);
+	}
 	return snd_hda_mixer_amp_switch_put(kcontrol, ucontrol);
 }
 EXPORT_SYMBOL_HDA(snd_hda_mixer_amp_switch_put_beep);
-- 
1.7.9.5
