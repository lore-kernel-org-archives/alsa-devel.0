From: Jeff Muizelaar <jeff@infidigm.net>
Subject: [PATCH] au88x0: replace spdif frequency control with iec958 control
Date: Mon, 28 Feb 2005 23:51:35 -0500
Message-ID: <20050301045135.GA3444@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sf.net
Cc: Raymond <rayau@netvigator.com>, openvortex-dev@nongnu.org
List-Id: alsa-devel@alsa-project.org

The appended patch replaces the manual spdif frequency control in the
mixer with code that use the standard iec958 interface. The patch is
nearly the same as the one Raymond submitted, except it gets rid of the
identical *_default_* versions of the functions, and has a tiny bit of
cleanup. 
I have only tested it a little bit because I don't currently
have the hardware to actually test it properly. However, it looks
harmless to me.

Patch-by: Raymond
Signed-off-by: Jeff Muizelaar <muizelaar@rogers.com>

Index: pci/au88x0/au88x0_pcm.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/au88x0/au88x0_pcm.c,v
retrieving revision 1.6
diff -u -r1.6 au88x0_pcm.c
--- pci/au88x0/au88x0_pcm.c	3 Jan 2005 12:08:24 -0000	1.6
+++ pci/au88x0/au88x0_pcm.c	1 Mar 2005 04:40:30 -0000
@@ -20,7 +20,7 @@
  * Supports ADB and WT DMA. Unfortunately, WT channels do not run yet.
  * It remains stuck,and DMA transfers do not happen. 
  */
-
+#include <sound/asoundef.h>
 #include <sound/driver.h>
 #include <linux/time.h>
 #include <sound/core.h>
@@ -431,61 +431,74 @@
 };
 
 /* SPDIF kcontrol */
-static int
-snd_vortex_spdif_info(snd_kcontrol_t * kcontrol, snd_ctl_elem_info_t * uinfo)
-{
-	static char *texts[] = { "32000", "44100", "48000" };
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+static int snd_vortex_spdif_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_IEC958;
 	uinfo->count = 1;
-	uinfo->value.enumerated.items = 3;
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item =
-		    uinfo->value.enumerated.items - 1;
-	strcpy(uinfo->value.enumerated.name,
-	       texts[uinfo->value.enumerated.item]);
 	return 0;
 }
-static int
-snd_vortex_spdif_get(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+
+static int snd_vortex_spdif_mask_get(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
 {
-	vortex_t *vortex = snd_kcontrol_chip(kcontrol);
+	ucontrol->value.iec958.status[0] = 0xff;
+	ucontrol->value.iec958.status[1] = 0xff;
+	ucontrol->value.iec958.status[2] = 0xff;
+	ucontrol->value.iec958.status[3] = IEC958_AES3_CON_FS;
+	return 0;
+}
 
-	if (vortex->spdif_sr == 32000)
-		ucontrol->value.enumerated.item[0] = 0;
-	if (vortex->spdif_sr == 44100)
-		ucontrol->value.enumerated.item[0] = 1;
-	if (vortex->spdif_sr == 48000)
-		ucontrol->value.enumerated.item[0] = 2;
+static int snd_vortex_spdif_get(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+{
+	vortex_t *vortex = snd_kcontrol_chip(kcontrol);
+	ucontrol->value.iec958.status[0] = 0x00;
+	ucontrol->value.iec958.status[1] = IEC958_AES1_CON_ORIGINAL|IEC958_AES1_CON_DIGDIGCONV_ID;
+	ucontrol->value.iec958.status[2] = 0x00;
+	switch(vortex->spdif_sr){
+	case 32000: ucontrol->value.iec958.status[3] = IEC958_AES3_CON_FS_32000; break;
+	case 44100: ucontrol->value.iec958.status[3] = IEC958_AES3_CON_FS_44100; break;
+	case 48000: ucontrol->value.iec958.status[3] = IEC958_AES3_CON_FS_48000; break;
+	};
 	return 0;
 }
-static int
-snd_vortex_spdif_put(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+
+static int snd_vortex_spdif_put(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
 {
 	vortex_t *vortex = snd_kcontrol_chip(kcontrol);
-	static unsigned int sr[3] = { 32000, 44100, 48000 };
+	switch(ucontrol->value.iec958.status[3] & IEC958_AES3_CON_FS){
+	case IEC958_AES3_CON_FS_32000: vortex->spdif_sr = 32000; break;
+	case IEC958_AES3_CON_FS_44100: vortex->spdif_sr = 44100; break;
+	case IEC958_AES3_CON_FS_48000: vortex->spdif_sr = 48000; break;
+	};
+	vortex_spdif_init(vortex, vortex->spdif_sr, 1);
+	return 0;
+}
 
-	//printk("vortex: spdif sr = %d\n", ucontrol->value.enumerated.item[0]);
-	vortex->spdif_sr = sr[ucontrol->value.enumerated.item[0] % 3];
-	vortex_spdif_init(vortex,
-			  sr[ucontrol->value.enumerated.item[0] % 3], 1);
-	return 1;
-}
-static snd_kcontrol_new_t vortex_spdif_kcontrol __devinitdata = {
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	.name = "SPDIF SR",
-	.index = 0,
-	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
-	.private_value = 0,
-	.info = snd_vortex_spdif_info,
-	.get = snd_vortex_spdif_get,
-	.put = snd_vortex_spdif_put
+/* spdif controls */
+static snd_kcontrol_new_t snd_vortex_mixer_spdif[] __devinitdata = {
+	{
+		.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
+		.name =		SNDRV_CTL_NAME_IEC958("",PLAYBACK,DEFAULT),
+		.info =		snd_vortex_spdif_info,
+		.get =		snd_vortex_spdif_get,
+		.put =		snd_vortex_spdif_put,
+	},
+	{
+		.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
+		.access =	SNDRV_CTL_ELEM_ACCESS_READ,
+		.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
+		.name =		SNDRV_CTL_NAME_IEC958("",PLAYBACK,CON_MASK),
+		.info =		snd_vortex_spdif_info,
+		.get =		snd_vortex_spdif_mask_get
+	},
 };
 
 /* create a pcm device */
 static int __devinit snd_vortex_new_pcm(vortex_t * chip, int idx, int nr)
 {
 	snd_pcm_t *pcm;
+	snd_kcontrol_t *kctl;
+	int i;
 	int err, nr_capt;
 
 	if ((chip == 0) || (idx < 0) || (idx > VORTEX_PCM_LAST))
@@ -520,13 +533,13 @@
 					      0x10000, 0x10000);
 
 	if (VORTEX_PCM_TYPE(pcm) == VORTEX_PCM_SPDIF) {
-		snd_kcontrol_t *kcontrol;
-
-		if ((kcontrol =
-		     snd_ctl_new1(&vortex_spdif_kcontrol, chip)) == NULL)
-			return -ENOMEM;
-		if ((err = snd_ctl_add(chip->card, kcontrol)) < 0)
-			return err;
+		for (i = 0; i < ARRAY_SIZE(snd_vortex_mixer_spdif); i++) {
+			kctl = snd_ctl_new1(&snd_vortex_mixer_spdif[i], chip);
+			if (!kctl)
+				return -ENOMEM;
+			if ((err = snd_ctl_add(chip->card, kctl)) < 0)
+				return err;
+		}
 	}
 	return 0;
 }


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
