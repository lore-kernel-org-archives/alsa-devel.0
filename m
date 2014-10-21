From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 19/43] ALSA: ac97: Constify more text arrays
Date: Tue, 21 Oct 2014 12:10:55 +0200
Message-ID: <1413886279-18704-20-git-send-email-tiwai@suse.de>
References: <1413886279-18704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E9513266642
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 12:11:24 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 101B6AD98
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 10:11:24 +0000 (UTC)
In-Reply-To: <1413886279-18704-1-git-send-email-tiwai@suse.de>
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

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/ac97/ac97_patch.c | 22 ++++++++++++++--------
 sound/pci/ac97/ac97_patch.h |  2 +-
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/sound/pci/ac97/ac97_patch.c b/sound/pci/ac97/ac97_patch.c
index 50f420d69a8a..ceaac1c41906 100644
--- a/sound/pci/ac97/ac97_patch.c
+++ b/sound/pci/ac97/ac97_patch.c
@@ -33,7 +33,8 @@
 static struct snd_kcontrol *snd_ac97_find_mixer_ctl(struct snd_ac97 *ac97,
 						    const char *name);
 static int snd_ac97_add_vmaster(struct snd_ac97 *ac97, char *name,
-				const unsigned int *tlv, const char **slaves);
+				const unsigned int *tlv,
+				const char * const *slaves);
 
 /*
  *  Chip specific initialization
@@ -3196,7 +3197,9 @@ static int cm9761_spdif_out_source_put(struct snd_kcontrol *kcontrol, struct snd
 				    ucontrol->value.enumerated.item[0] == 1 ? 0x2 : 0);
 }
 
-static const char *cm9761_dac_clock[] = { "AC-Link", "SPDIF-In", "Both" };
+static const char * const cm9761_dac_clock[] = {
+	"AC-Link", "SPDIF-In", "Both"
+};
 static const struct ac97_enum cm9761_dac_clock_enum =
 	AC97_ENUM_SINGLE(AC97_CM9761_SPDIF_CTRL, 9, 3, cm9761_dac_clock);
 
@@ -3310,7 +3313,9 @@ static int patch_cm9761(struct snd_ac97 *ac97)
 #define AC97_CM9780_MULTI_CHAN	0x66
 #define AC97_CM9780_SPDIF	0x6c
 
-static const char *cm9780_ch_select[] = { "Front", "Side", "Center/LFE", "Rear" };
+static const char * const cm9780_ch_select[] = {
+	"Front", "Side", "Center/LFE", "Rear"
+};
 static const struct ac97_enum cm9780_ch_select_enum =
 	AC97_ENUM_SINGLE(AC97_CM9780_MULTI_CHAN, 6, 4, cm9780_ch_select);
 static const struct snd_kcontrol_new cm9780_controls[] = {
@@ -3356,7 +3361,7 @@ AC97_SINGLE("Downmix LFE and Center to Front", 0x5a, 12, 1, 0),
 AC97_SINGLE("Downmix Surround to Front", 0x5a, 11, 1, 0),
 };
 
-static const char *slave_vols_vt1616[] = {
+static const char * const slave_vols_vt1616[] = {
 	"Front Playback Volume",
 	"Surround Playback Volume",
 	"Center Playback Volume",
@@ -3364,7 +3369,7 @@ static const char *slave_vols_vt1616[] = {
 	NULL
 };
 
-static const char *slave_sws_vt1616[] = {
+static const char * const slave_sws_vt1616[] = {
 	"Front Playback Switch",
 	"Surround Playback Switch",
 	"Center Playback Switch",
@@ -3385,10 +3390,11 @@ static struct snd_kcontrol *snd_ac97_find_mixer_ctl(struct snd_ac97 *ac97,
 
 /* create a virtual master control and add slaves */
 static int snd_ac97_add_vmaster(struct snd_ac97 *ac97, char *name,
-				const unsigned int *tlv, const char **slaves)
+				const unsigned int *tlv,
+				const char * const *slaves)
 {
 	struct snd_kcontrol *kctl;
-	const char **s;
+	const char * const *s;
 	int err;
 
 	kctl = snd_ctl_make_virtual_master(name, tlv);
@@ -3612,7 +3618,7 @@ static int patch_vt1617a(struct snd_ac97 * ac97)
 struct vt1618_uaj_item {
 	unsigned short mask;
 	unsigned short shift;
-	const char *items[4];
+	const char * const items[4];
 };
 
 /* This list reflects the vt1618 docs for Vendor Defined Register 0x60. */
diff --git a/sound/pci/ac97/ac97_patch.h b/sound/pci/ac97/ac97_patch.h
index 47bf8dfe8276..d1ce151fe722 100644
--- a/sound/pci/ac97/ac97_patch.h
+++ b/sound/pci/ac97/ac97_patch.h
@@ -49,7 +49,7 @@ struct ac97_enum {
 	unsigned char shift_l;
 	unsigned char shift_r;
 	unsigned short mask;
-	const char **texts;
+	const char * const *texts;
 };
 
 #define AC97_ENUM_DOUBLE(xreg, xshift_l, xshift_r, xmask, xtexts) \
-- 
2.1.2
