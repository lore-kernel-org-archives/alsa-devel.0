From: jayakumar.alsa@gmail.com
Subject: [PATCH 2.6.17-rc5 1/1] ALSA: AD1888 mixer controls for
	DC mode v2
Date: Fri, 23 Jun 2006 14:09:57 +0800
Message-ID: <200606230609.k5N69v33023740@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Takashi, Jaroslav,

This patch adds two mixer controls. The V_REFOUT enable is a 
documented register that couples the microphone input lines 
to the V_REFOUT DC source. The High Pass Filter enable in the
AC97_AD_TEST2 (0x5c) is an undocumented register provided by 
Miller Puckette via Analog Devices that enables the AD codec 
to apply a high pass filter to the input. 

Thanks,
Jaya Kumar

Signed-off-by: Jaya Kumar <jayakumar.alsa@gmail.com>

---
 
 include/sound/ac97_codec.h  |    1 +
 sound/pci/ac97/ac97_patch.c |    2 ++
 2 files changed, 3 insertions(+)
diff -X cs5535audio.dontdiff -X linux-2.6.17-rc5/Documentation/dontdiff -uprN linux-2.6.17-rc5-ad1888pm/include/sound/ac97_codec.h linux-2.6.17-rc5-ad1888vref/include/sound/ac97_codec.h
--- linux-2.6.17-rc5-ad1888pm/include/sound/ac97_codec.h	2006-06-18 15:50:59.000000000 +0800
+++ linux-2.6.17-rc5-ad1888vref/include/sound/ac97_codec.h	2006-06-22 04:06:35.000000000 +0800
@@ -265,6 +265,7 @@
 
 /* specific - Analog Devices */
 #define AC97_AD_TEST		0x5a	/* test register */
+#define AC97_AD_TEST2		0x5c	/* undocumented test register 2 */
 #define AC97_AD_CODEC_CFG	0x70	/* codec configuration */
 #define AC97_AD_JACK_SPDIF	0x72	/* Jack Sense & S/PDIF */
 #define AC97_AD_SERIAL_CFG	0x74	/* Serial Configuration */
diff -X cs5535audio.dontdiff -X linux-2.6.17-rc5/Documentation/dontdiff -uprN linux-2.6.17-rc5-ad1888pm/sound/pci/ac97/ac97_patch.c linux-2.6.17-rc5-ad1888vref/sound/pci/ac97/ac97_patch.c
--- linux-2.6.17-rc5-ad1888pm/sound/pci/ac97/ac97_patch.c	2006-06-18 15:40:03.000000000 +0800
+++ linux-2.6.17-rc5-ad1888vref/sound/pci/ac97/ac97_patch.c	2006-06-22 22:57:22.000000000 +0800
@@ -1873,6 +1873,8 @@ static const struct snd_kcontrol_new snd
 		.get = snd_ac97_ad1888_lohpsel_get,
 		.put = snd_ac97_ad1888_lohpsel_put
 	},
+	AC97_SINGLE("V_REFOUT Enable", AC97_AD_MISC, 2, 1, 1),
+	AC97_SINGLE("High Pass Filter Enable", AC97_AD_TEST2, 12, 1, 1),
 	AC97_SINGLE("Spread Front to Surround and Center/LFE", AC97_AD_MISC, 7, 1, 0),
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
