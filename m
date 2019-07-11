From: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Subject: [PATCH] sound: pci: au88x0: Remove unneeded variable: "changed"
Date: Thu, 11 Jul 2019 22:43:02 +0530
Message-ID: <20190711171302.GA3445@hari-Inspiron-1545>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Armijn Hemel <armijn@tjaldur.nl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hariprasad Kelam <hariprasad.kelam@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Fix below issues reported by coccicheck

sound/pci/au88x0/au88x0_a3d.c:821:8-15: Unneeded variable: "changed".
Return "1" on line 834
sound/pci/au88x0/au88x0_a3d.c:768:5-12: Unneeded variable: "changed".
Return "1" on line 777
sound/pci/au88x0/au88x0_a3d.c:804:5-12: Unneeded variable: "changed".
Return "1" on line 813
sound/pci/au88x0/au88x0_a3d.c:786:8-15: Unneeded variable: "changed".
Return "1" on line 796

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 sound/pci/au88x0/au88x0_a3d.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/sound/pci/au88x0/au88x0_a3d.c b/sound/pci/au88x0/au88x0_a3d.c
index 7347103..2db183f 100644
--- a/sound/pci/au88x0/au88x0_a3d.c
+++ b/sound/pci/au88x0/au88x0_a3d.c
@@ -765,7 +765,7 @@ snd_vortex_a3d_hrtf_put(struct snd_kcontrol *kcontrol,
 			struct snd_ctl_elem_value *ucontrol)
 {
 	a3dsrc_t *a = kcontrol->private_data;
-	int changed = 1, i;
+	int i;
 	int coord[6];
 	for (i = 0; i < 6; i++)
 		coord[i] = ucontrol->value.integer.value[i];
@@ -774,7 +774,7 @@ snd_vortex_a3d_hrtf_put(struct snd_kcontrol *kcontrol,
 	vortex_a3d_coord2hrtf(a->hrtf[1], coord);
 	a3dsrc_SetHrtfTarget(a, a->hrtf[0], a->hrtf[1]);
 	a3dsrc_SetHrtfCurrent(a, a->hrtf[0], a->hrtf[1]);
-	return changed;
+	return 1;
 }
 
 static int
@@ -783,7 +783,7 @@ snd_vortex_a3d_itd_put(struct snd_kcontrol *kcontrol,
 {
 	a3dsrc_t *a = kcontrol->private_data;
 	int coord[6];
-	int i, changed = 1;
+	int i;
 	for (i = 0; i < 6; i++)
 		coord[i] = ucontrol->value.integer.value[i];
 	/* Translate orientation coordinates to a3d params. */
@@ -793,7 +793,7 @@ snd_vortex_a3d_itd_put(struct snd_kcontrol *kcontrol,
 	a3dsrc_SetItdTarget(a, a->itd[0], a->itd[1]);
 	a3dsrc_SetItdCurrent(a, a->itd[0], a->itd[1]);
 	a3dsrc_SetItdDline(a, a->dline);
-	return changed;
+	return 1;
 }
 
 static int
@@ -801,7 +801,6 @@ snd_vortex_a3d_ild_put(struct snd_kcontrol *kcontrol,
 		       struct snd_ctl_elem_value *ucontrol)
 {
 	a3dsrc_t *a = kcontrol->private_data;
-	int changed = 1;
 	int l, r;
 	/* There may be some scale tranlation needed here. */
 	l = ucontrol->value.integer.value[0];
@@ -810,7 +809,7 @@ snd_vortex_a3d_ild_put(struct snd_kcontrol *kcontrol,
 	/* Left Right panning. */
 	a3dsrc_SetGainTarget(a, l, r);
 	a3dsrc_SetGainCurrent(a, l, r);
-	return changed;
+	return 1;
 }
 
 static int
@@ -818,7 +817,7 @@ snd_vortex_a3d_filter_put(struct snd_kcontrol *kcontrol,
 			  struct snd_ctl_elem_value *ucontrol)
 {
 	a3dsrc_t *a = kcontrol->private_data;
-	int i, changed = 1;
+	int i;
 	int params[6];
 	for (i = 0; i < 6; i++)
 		params[i] = ucontrol->value.integer.value[i];
@@ -831,7 +830,7 @@ snd_vortex_a3d_filter_put(struct snd_kcontrol *kcontrol,
 	a3dsrc_SetAtmosCurrent(a, a->filter[0],
 			       a->filter[1], a->filter[2],
 			       a->filter[3], a->filter[4]);
-	return changed;
+	return 1;
 }
 
 static const struct snd_kcontrol_new vortex_a3d_kcontrol = {
-- 
2.7.4
