From: Raymond <rayau@netvigator.com>
Subject: au88x0 - Replace spdif frequency control by IEC958 control
Date: Mon, 21 Feb 2005 15:40:33 +0800
Message-ID: <42199071.6090406@netvigator.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050001080703060904000903"
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: openvortex-dev@nongnu.org
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050001080703060904000903
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch only change the existing SPDIF Frequency(32000,44100,48000) 
control to the IEC958 control. It means that you will have to use 
"iecset rate" instead of alsamixer to change the SPDIF frequency.

1) What is the difference between Consumer mode and Professional mode ?

2) What change will be needed in order to support the SPDIF IN/OUT of 
Turtle Beach Montego II Quadzilla ?

3) Are there any status bit to detect the presence of the add-on SPDIF 
daugther card of MX300 and Montego II ?

aplay can be used to play 4-channels wave (e.g. out1lq.wav,out1rq.wav, 
out2lq.wav and out2rq.wav from the win9x driver) using the au8830 driver.
4) What change will be needed in /usr/share/cards/AU8830.conf to support 
Surround40 ?

The PCI SubSystem Device/Vendor ID of the sound card which can be used 
to identify specific sound card such as Dimaond MX300, Turtle Beach 
Montego II, SQ2500, ....can be obtained from the memory mapped I/O 
address 0x2a804 - au8810/30, 0x13004 - au8820.

5) Can any au8810/au8830 owner verify that EN_CODEC1 should/should not 
be used for those au8810/au8830 not using a quad codec ? (e.g Montego II 
using STAC9721 stereo codec, SQ1500, Vortex Advantage, ASUS L8400B 
notebook au8810 with modem)

#define VORTEX_CODEC_CTRL    0x29184
#define VORTEX_CODEC_EN        0x29190
#define        EN_CODEC0    0x00000300
#define     EN_AC98        0x00000c00 /* Modem AC98 slots. */
#define        EN_CODEC1    0x00003000
#define        EN_CODEC    (EN_CODEC0 | EN_CODEC1)

There is already a parser to parse the sound font au30gm.arl in the 
vortex control panel.
http://savannah.nongnu.org/support/?func=detailitem&item_id=103017

6) What else will be needed for the au88x0 driver to support wavetable 
synthesis ?


--------------050001080703060904000903
Content-Type: text/plain;
 name="au88x0_iec958.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="au88x0_iec958.patch"

diff -Naur alsa-driver-1.0.8/alsa-kernel/pci/au88x0_orig/au88x0_pcm.c alsa-driver-1.0.8/alsa-kernel/pci/au88x0/au88x0_pcm.c
--- alsa-driver-1.0.8/alsa-kernel/pci/au88x0_orig/au88x0_pcm.c	2005-01-03 20:08:24.000000000 +0800
+++ alsa-driver-1.0.8/alsa-kernel/pci/au88x0/au88x0_pcm.c	2005-02-19 12:02:11.000000000 +0800
@@ -20,7 +20,7 @@
  * Supports ADB and WT DMA. Unfortunately, WT channels do not run yet.
  * It remains stuck,and DMA transfers do not happen. 
  */
-
+#include <sound/asoundef.h>
 #include <sound/driver.h>
 #include <linux/time.h>
 #include <sound/core.h>
@@ -431,61 +431,100 @@
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
+static int snd_vortex_spdif_default_get(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
 {
 	vortex_t *vortex = snd_kcontrol_chip(kcontrol);
+	ucontrol->value.iec958.status[0] = 0x00;
+	ucontrol->value.iec958.status[1] = IEC958_AES1_CON_ORIGINAL|IEC958_AES1_CON_DIGDIGCONV_ID;
+	ucontrol->value.iec958.status[2] = 0x00;
+	switch(vortex->spdif_sr){
+	case 32000: ucontrol->value.iec958.status[3] = IEC958_AES3_CON_FS_32000; break;
+	case 44100: ucontrol->value.iec958.status[3] = IEC958_AES3_CON_FS_44100; break;
+	case 48000: ucontrol->value.iec958.status[3] = IEC958_AES3_CON_FS_48000; break;
+	};
+	return 0;
+}
 
-	if (vortex->spdif_sr == 32000)
-		ucontrol->value.enumerated.item[0] = 0;
-	if (vortex->spdif_sr == 44100)
-		ucontrol->value.enumerated.item[0] = 1;
-	if (vortex->spdif_sr == 48000)
-		ucontrol->value.enumerated.item[0] = 2;
+static int snd_vortex_spdif_default_put(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+{
+	vortex_t *vortex = snd_kcontrol_chip(kcontrol);
+	switch(ucontrol->value.iec958.status[3] & IEC958_AES3_CON_FS){
+	case IEC958_AES3_CON_FS_32000: vortex->spdif_sr = 32000; break;
+	case IEC958_AES3_CON_FS_44100: vortex->spdif_sr = 44100; break;
+	case IEC958_AES3_CON_FS_48000: vortex->spdif_sr = 48000; break;
+	};
+	vortex_spdif_init(vortex, vortex->spdif_sr, 1);
 	return 0;
 }
-static int
-snd_vortex_spdif_put(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+
+static int snd_vortex_spdif_mask_get(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+{
+	ucontrol->value.iec958.status[0] = 0xff;
+	ucontrol->value.iec958.status[1] = 0xff;
+	ucontrol->value.iec958.status[2] = 0xff;
+	ucontrol->value.iec958.status[3] = IEC958_AES3_CON_FS;
+	return 0;
+}
+
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
+	return 0;
+}
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
+		.get =		snd_vortex_spdif_default_get,
+		.put =		snd_vortex_spdif_default_put,
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
@@ -520,13 +559,14 @@
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
+			if (! kctl)
+				return -ENOMEM;
+//			kctl->id.index = index;
+			if ((err = snd_ctl_add(chip->card, kctl)) < 0)
+				return err;
+		}
 	}
 	return 0;
 }

--------------050001080703060904000903--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
