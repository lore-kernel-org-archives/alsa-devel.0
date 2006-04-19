From: Andreas Mohr <andim2@users.sourceforge.net>
Subject: [PATCH 2/3] azt3328.c: add 3D sound mixer switch/rename controls
Date: Wed, 19 Apr 2006 21:22:39 +0200
Message-ID: <20060419192239.GB5800@rhlx01.fht-esslingen.de>
Reply-To: andi@lisas.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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
To: alsa-devel@lists.sourceforge.net
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi,

[patch 2 of 3, to be applied in correct order]

- add 3D sound pre-3D/post-3D switch, as seen in standard AC-97 
- rename controls to shorter and more accurate strings

Patch done and hardware-tested on 2.6.16-ck3, rediffed to ALSA CVS.

Signed-off-by: Andreas Mohr <andi@lisas.de>

Thanks!


--- alsa-kernel/pci/azt3328.c	2006-04-19 20:47:14.000000000 +0200
+++ alsa-kernel/pci/azt3328.c	2006-04-19 20:49:05.000000000 +0200
@@ -39,8 +39,15 @@
  *  for compatibility reasons) has the following features:
  *
  *  - builtin AC97 conformant codec (SNR over 80dB)
- *    (really AC97 compliant?? I really doubt it when looking
- *    at the mixer register layout)
+ *    Note that "conformant" != "compliant"!! this chip's mixer register layout
+ *    *differs* from the standard AC97 layout:
+ *    they chose to not implement the headphone register (which is not a
+ *    problem since it's merely optional), yet when doing this, they committed
+ *    the grave sin of letting other registers follow immediately instead of
+ *    keeping a headphone dummy register, thereby shifting the mixer register
+ *    addresses illegally. So far unfortunately it looks like the very flexible
+ *    ALSA AC97 support is still not enough to easily compensate for such a
+ *    grave layout violation despite all tweaks and quirks mechanisms it offers.
  *  - builtin genuine OPL3
  *  - full duplex 16bit playback/record at independent sampling rate
  *  - MPU401 (+ legacy address support) FIXME: how to enable legacy addr??
@@ -96,6 +103,9 @@
  *    The standard suspend/resume functionality could probably make use of
  *    some improvement, too...
  *  - figure out what all unknown port bits are responsible for
+ *  - figure out some cleverly evil scheme to possibly make ALSA AC97 code
+ *    fully accept our quite incompatible ""AC97"" mixer and thus save some
+ *    code (but I'm not too optimistic that doing this is possible at all)
  */
 
 #include <sound/driver.h>
@@ -525,15 +535,18 @@
 			    struct snd_ctl_elem_info *uinfo)
 {
 	static const char * const texts1[] = {
-		"ModemOut1", "ModemOut2"
+		"Mic1", "Mic2"
 	};
 	static const char * const texts2[] = {
-		"MonoSelectSource1", "MonoSelectSource2"
+		"Mix", "Mic"
 	};
 	static const char * const texts3[] = {
                 "Mic", "CD", "Video", "Aux",
 		"Line", "Mix", "Mix Mono", "Phone"
         };
+	static const char * const texts4[] = {
+		"pre 3D", "post 3D"
+        };
 	struct azf3328_mixer_reg reg;
 
 	snd_azf3328_mixer_reg_decode(&reg, kcontrol->private_value);
@@ -544,10 +557,17 @@
                 uinfo->value.enumerated.item = reg.enum_c - 1U;
 	if (reg.reg == IDX_MIXER_ADVCTL2)
 	{
-		if (reg.lchan_shift == 8) /* modem out sel */
+		switch(reg.lchan_shift) {
+		case 8: /* modem out sel */
 			strcpy(uinfo->value.enumerated.name, texts1[uinfo->value.enumerated.item]);
-		else /* mono sel source */
+			break;
+		case 9: /* mono sel source */
 			strcpy(uinfo->value.enumerated.name, texts2[uinfo->value.enumerated.item]);
+			break;
+		case 15: /* PCM Out Path */
+			strcpy(uinfo->value.enumerated.name, texts4[uinfo->value.enumerated.item]);
+			break;
+		}
 	}
 	else
         	strcpy(uinfo->value.enumerated.name, texts3[uinfo->value.enumerated.item]
@@ -640,13 +660,14 @@
 	AZF3328_MIXER_VOL_MONO("Modem Playback Volume", IDX_MIXER_MODEMOUT, 0x1f, 1),
 	AZF3328_MIXER_SWITCH("Modem Capture Switch", IDX_MIXER_MODEMIN, 15, 1),
 	AZF3328_MIXER_VOL_MONO("Modem Capture Volume", IDX_MIXER_MODEMIN, 0x1f, 1),
-	AZF3328_MIXER_ENUM("Modem Out Select", IDX_MIXER_ADVCTL2, 2, 8),
-	AZF3328_MIXER_ENUM("Mono Select Source", IDX_MIXER_ADVCTL2, 2, 9),
+	AZF3328_MIXER_ENUM("Mic Select", IDX_MIXER_ADVCTL2, 2, 8),
+	AZF3328_MIXER_ENUM("Mono Output Select", IDX_MIXER_ADVCTL2, 2, 9),
+	AZF3328_MIXER_ENUM("PCM", IDX_MIXER_ADVCTL2, 2, 15), /* PCM Out Path, place in front since it controls *both* 3D and Bass/Treble! */
 	AZF3328_MIXER_VOL_SPECIAL("Tone Control - Treble", IDX_MIXER_BASSTREBLE, 0x07, 1, 0),
 	AZF3328_MIXER_VOL_SPECIAL("Tone Control - Bass", IDX_MIXER_BASSTREBLE, 0x07, 9, 0),
 	AZF3328_MIXER_SWITCH("3D Control - Switch", IDX_MIXER_ADVCTL2, 13, 0),
-	AZF3328_MIXER_VOL_SPECIAL("3D Control - Wide", IDX_MIXER_ADVCTL1, 0x07, 1, 0), /* "3D Width" */
-	AZF3328_MIXER_VOL_SPECIAL("3D Control - Space", IDX_MIXER_ADVCTL1, 0x03, 8, 0), /* "Hifi 3D" */
+	AZF3328_MIXER_VOL_SPECIAL("3D Control - Width", IDX_MIXER_ADVCTL1, 0x07, 1, 0), /* "3D Width" */
+	AZF3328_MIXER_VOL_SPECIAL("3D Control - Depth", IDX_MIXER_ADVCTL1, 0x03, 8, 0), /* "Hifi 3D" */
 #if MIXER_TESTING
 	AZF3328_MIXER_SWITCH("0", IDX_MIXER_ADVCTL2, 0, 0),
 	AZF3328_MIXER_SWITCH("1", IDX_MIXER_ADVCTL2, 1, 0),
--- alsa-kernel/pci/azt3328.h	2006-04-19 20:41:06.000000000 +0200
+++ alsa-kernel/pci/azt3328.h	2006-04-19 20:45:08.000000000 +0200
@@ -90,7 +90,7 @@
 #define IDX_IO_REC_DMA_CURROFS  0x34 /* PU:0x00000000 */
 #define IDX_IO_REC_SOUNDFORMAT  0x36 /* PU:0x0000 */
 
-/** hmm, what is this I/O area for? MPU401?? (after playback, recording, ???, timer) **/
+/** hmm, what is this I/O area for? MPU401?? or external DAC via I2S?? (after playback, recording, ???, timer) **/
 #define IDX_IO_SOMETHING_FLAGS	0x40 /* gets set to 0x34 just like port 0x0 and 0x20 on card init, PU:0x0000 */
 /* general */
 #define IDX_IO_42H		0x42 /* PU:0x0001 */
@@ -170,14 +170,14 @@
 #define IDX_MIXER_ADVCTL1       0x1e
   /* unlisted bits are unmodifiable */
   #define MIXER_ADVCTL1_3DWIDTH_MASK	0x000e
-  #define MIXER_ADVCTL1_HIFI3D_MASK	0x0300
-#define IDX_MIXER_ADVCTL2       0x20 /* resembles AC97_GENERAL_PURPOSE reg! */
+  #define MIXER_ADVCTL1_HIFI3D_MASK	0x0300 /* yup, this is missing the high bit that official AC97 contains, plus it doesn't have linear bit value range behaviour but instead acts weirdly (possibly we're dealing with two *different* 3D settings here??) */
+#define IDX_MIXER_ADVCTL2       0x20 /* subset of AC97_GENERAL_PURPOSE reg! */
   /* unlisted bits are unmodifiable */
-  #define MIXER_ADVCTL2_BIT7		0x0080 /* WaveOut 3D Bypass? mutes WaveOut at LineOut */
-  #define MIXER_ADVCTL2_BIT8		0x0100 /* is this Modem Out Select? */
-  #define MIXER_ADVCTL2_BIT9		0x0200 /* Mono Select Source? */
-  #define MIXER_ADVCTL2_BIT13		0x2000 /* 3D enable? */
-  #define MIXER_ADVCTL2_BIT15		0x8000 /* unknown */
+  #define MIXER_ADVCTL2_LPBK		0x0080 /* Loopback mode -- Win driver: "WaveOut3DBypass"? mutes WaveOut at LineOut */
+  #define MIXER_ADVCTL2_MS		0x0100 /* Mic Select 0=Mic1, 1=Mic2 -- Win driver: "ModemOutSelect"?? */
+  #define MIXER_ADVCTL2_MIX		0x0200 /* Mono output select 0=Mix, 1=Mic; Win driver: "MonoSelectSource"?? */
+  #define MIXER_ADVCTL2_3D		0x2000 /* 3D Enhancement 1=on */
+  #define MIXER_ADVCTL2_POP		0x8000 /* Pcm Out Path, 0=pre 3D, 1=post 3D */
   
 #define IDX_MIXER_SOMETHING30H	0x30 /* used, but unknown??? */
 


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
