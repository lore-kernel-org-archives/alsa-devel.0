From: Rene Herman <rene.herman@gmail.com>
Subject: Re: isa_bus device/driver naming
Date: Mon, 19 Mar 2007 22:17:10 +0100
Message-ID: <45FEFDD6.9030200@gmail.com>
References: <45FDA92F.8080206@gmail.com> <s5hslc1jzlc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080000060905080407070907"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hslc1jzlc.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080000060905080407070907
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

On 03/19/2007 11:29 AM, Takashi Iwai wrote:

> The name without snd_ prefix is fine. It was added simply because 
> once some names conflicted with OSS drivers in pnp_driver 
> configuration. But in the case of isa_driver, no other drivers use it
> yet, thus no confliction can happen.

Wonderful, thanks.

> Could you give a sign-off?

Err, yes, I keep forgetting. On linux-kernel the author's own signed-off 
is usually taken as implied on small (and non copyrightable) stuff like 
this...

===
isa_bus: delete snd_ prefix from the (sysfs visible) device/driver names.

Signed-off-by: Rene Herman <rene.herman@gmail.com>
===

Rene

--------------080000060905080407070907
Content-Type: text/plain;
 name="dev_name.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dev_name.diff"

diff -r 530b211fffdb isa/cmi8330.c
--- a/isa/cmi8330.c	Fri Mar 16 15:01:36 2007 +0100
+++ b/isa/cmi8330.c	Sun Mar 18 20:17:51 2007 +0100
@@ -601,7 +601,7 @@ static int snd_cmi8330_isa_resume(struct
 }
 #endif
 
-#define CMI8330_DRIVER	"snd_cmi8330"
+#define DEV_NAME	"cmi8330"
 
 static struct isa_driver snd_cmi8330_driver = {
 	.match		= snd_cmi8330_isa_match,
@@ -612,7 +612,7 @@ static struct isa_driver snd_cmi8330_dri
 	.resume		= snd_cmi8330_isa_resume,
 #endif
 	.driver		= {
-		.name	= CMI8330_DRIVER
+		.name	= DEV_NAME
 	},
 };
 
diff -r 530b211fffdb isa/cs423x/cs4236.c
--- a/isa/cs423x/cs4236.c	Fri Mar 16 15:01:36 2007 +0100
+++ b/isa/cs423x/cs4236.c	Sun Mar 18 20:20:38 2007 +0100
@@ -75,10 +75,10 @@ MODULE_SUPPORTED_DEVICE("{{Crystal Semic
 
 #ifdef CS4232
 #define IDENT "CS4232"
-#define CS423X_DRIVER "snd_cs4232"
+#define DEV_NAME "cs4232"
 #else
 #define IDENT "CS4236+"
-#define CS423X_DRIVER "snd_cs4236"
+#define DEV_NAME "cs4236"
 #endif
 
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
@@ -630,7 +630,7 @@ static struct isa_driver cs423x_isa_driv
 	.resume		= snd_cs423x_isa_resume,
 #endif
 	.driver		= {
-		.name	= CS423X_DRIVER
+		.name	= DEV_NAME
 	},
 };
 
diff -r 530b211fffdb isa/es18xx.c
--- a/isa/es18xx.c	Fri Mar 16 15:01:36 2007 +0100
+++ b/isa/es18xx.c	Sun Mar 18 20:25:10 2007 +0100
@@ -2318,7 +2318,7 @@ static int snd_es18xx_isa_resume(struct 
 }
 #endif
 
-#define ES18XX_DRIVER	"snd_es18xx"
+#define DEV_NAME "es18xx"
 
 static struct isa_driver snd_es18xx_isa_driver = {
 	.match		= snd_es18xx_isa_match,
@@ -2329,7 +2329,7 @@ static struct isa_driver snd_es18xx_isa_
 	.resume		= snd_es18xx_isa_resume,
 #endif
 	.driver		= {
-		.name	= ES18XX_DRIVER
+		.name	= DEV_NAME
 	},
 };
 
diff -r 530b211fffdb isa/gus/gusmax.c
--- a/isa/gus/gusmax.c	Fri Mar 16 15:01:36 2007 +0100
+++ b/isa/gus/gusmax.c	Sun Mar 18 20:24:55 2007 +0100
@@ -358,7 +358,7 @@ static int __devexit snd_gusmax_remove(s
 	return 0;
 }
 
-#define GUSMAX_DRIVER	"snd_gusmax"
+#define DEV_NAME "gusmax"
 
 static struct isa_driver snd_gusmax_driver = {
 	.match		= snd_gusmax_match,
@@ -366,7 +366,7 @@ static struct isa_driver snd_gusmax_driv
 	.remove		= __devexit_p(snd_gusmax_remove),
 	/* FIXME: suspend/resume */
 	.driver		= {
-		.name	= GUSMAX_DRIVER
+		.name	= DEV_NAME
 	},
 };
 
diff -r 530b211fffdb isa/opl3sa2.c
--- a/isa/opl3sa2.c	Fri Mar 16 15:01:36 2007 +0100
+++ b/isa/opl3sa2.c	Sun Mar 18 20:24:39 2007 +0100
@@ -947,7 +947,7 @@ static int snd_opl3sa2_isa_resume(struct
 }
 #endif
 
-#define OPL3SA2_DRIVER	"snd_opl3sa2"
+#define DEV_NAME "opl3sa2"
 
 static struct isa_driver snd_opl3sa2_isa_driver = {
 	.match		= snd_opl3sa2_isa_match,
@@ -958,7 +958,7 @@ static struct isa_driver snd_opl3sa2_isa
 	.resume		= snd_opl3sa2_isa_resume,
 #endif
 	.driver		= {
-		.name	= OPL3SA2_DRIVER
+		.name	= DEV_NAME
 	},
 };
 
diff -r 530b211fffdb isa/opti9xx/miro.c
--- a/isa/opti9xx/miro.c	Fri Mar 16 15:01:36 2007 +0100
+++ b/isa/opti9xx/miro.c	Sun Mar 18 20:27:19 2007 +0100
@@ -137,8 +137,6 @@ struct snd_miro {
 
 static void snd_miro_proc_init(struct snd_miro * miro);
 
-#define DRIVER_NAME "snd-miro"
-
 static char * snd_opti9xx_names[] = {
 	"unkown",
 	"82C928", "82C929",
@@ -1423,13 +1421,15 @@ static int __devexit snd_miro_remove(str
 	return 0;
 }
 
+#define DEV_NAME "miro"
+
 static struct isa_driver snd_miro_driver = {
 	.match		= snd_miro_match,
 	.probe		= snd_miro_probe,
 	.remove		= __devexit_p(snd_miro_remove),
 	/* FIXME: suspend/resume */
 	.driver		= {
-		.name	= DRIVER_NAME
+		.name	= DEV_NAME
 	},
 };
 
diff -r 530b211fffdb isa/opti9xx/opti92x-ad1848.c
--- a/isa/opti9xx/opti92x-ad1848.c	Fri Mar 16 15:01:36 2007 +0100
+++ b/isa/opti9xx/opti92x-ad1848.c	Sun Mar 18 20:30:36 2007 +0100
@@ -280,10 +280,10 @@ MODULE_DEVICE_TABLE(pnp_card, snd_opti9x
 #endif	/* CONFIG_PNP */
 
 #ifdef OPTi93X
-#define DRIVER_NAME	"snd-card-opti93x"
+#define DEV_NAME "opti93x"
 #else
-#define DRIVER_NAME	"snd-card-opti92x"
-#endif	/* OPTi93X */
+#define DEV_NAME "opti92x"
+#endif
 
 static char * snd_opti9xx_names[] = {
 	"unkown",
@@ -1289,7 +1289,7 @@ static int snd_opti93x_create(struct snd
 	}
 	codec->dma2 = chip->dma2;
 
-	if (request_irq(chip->irq, snd_opti93x_interrupt, IRQF_DISABLED, DRIVER_NAME" - WSS", codec)) {
+	if (request_irq(chip->irq, snd_opti93x_interrupt, IRQF_DISABLED, DEV_NAME" - WSS", codec)) {
 		snd_printk(KERN_ERR "opti9xx: can't grab IRQ %d\n", chip->irq);
 		snd_opti93x_free(codec);
 		return -EBUSY;
@@ -2015,7 +2015,7 @@ static struct isa_driver snd_opti9xx_dri
 	.remove		= __devexit_p(snd_opti9xx_isa_remove),
 	/* FIXME: suspend/resume */
 	.driver		= {
-		.name	= DRIVER_NAME
+		.name	= DEV_NAME
 	},
 };
 
diff -r 530b211fffdb isa/sb/sb16.c
--- a/isa/sb/sb16.c	Fri Mar 16 15:01:36 2007 +0100
+++ b/isa/sb/sb16.c	Sun Mar 18 20:34:10 2007 +0100
@@ -615,9 +615,9 @@ static int snd_sb16_isa_resume(struct de
 #endif
 
 #ifdef SNDRV_SBAWE
-#define SND_SB16_DRIVER	"snd_sbawe"
+#define DEV_NAME "sbawe"
 #else
-#define SND_SB16_DRIVER	"snd_sb16"
+#define DEV_NAME "sb16"
 #endif
 
 static struct isa_driver snd_sb16_isa_driver = {
@@ -629,7 +629,7 @@ static struct isa_driver snd_sb16_isa_dr
 	.resume		= snd_sb16_isa_resume,
 #endif
 	.driver		= {
-		.name	= SND_SB16_DRIVER
+		.name	= DEV_NAME
 	},
 };
 
diff -r 530b211fffdb isa/sb/sb8.c
--- a/isa/sb/sb8.c	Fri Mar 16 15:01:36 2007 +0100
+++ b/isa/sb/sb8.c	Sun Mar 18 20:32:02 2007 +0100
@@ -239,7 +239,7 @@ static int snd_sb8_resume(struct device 
 }
 #endif
 
-#define SND_SB8_DRIVER	"snd_sb8"
+#define DEV_NAME "sb8"
 
 static struct isa_driver snd_sb8_driver = {
 	.match		= snd_sb8_match,
@@ -250,7 +250,7 @@ static struct isa_driver snd_sb8_driver 
 	.resume		= snd_sb8_resume,
 #endif
 	.driver		= {
-		.name	= SND_SB8_DRIVER
+		.name	= DEV_NAME 
 	},
 };
 
diff -r 530b211fffdb isa/sgalaxy.c
--- a/isa/sgalaxy.c	Fri Mar 16 15:01:36 2007 +0100
+++ b/isa/sgalaxy.c	Sun Mar 18 20:35:51 2007 +0100
@@ -334,7 +334,7 @@ static int snd_sgalaxy_resume(struct dev
 }
 #endif
 
-#define SND_SGALAXY_DRIVER	"snd_sgalaxy"
+#define DEV_NAME "sgalaxy"
 
 static struct isa_driver snd_sgalaxy_driver = {
 	.match		= snd_sgalaxy_match,
@@ -345,7 +345,7 @@ static struct isa_driver snd_sgalaxy_dri
 	.resume		= snd_sgalaxy_resume,
 #endif
 	.driver		= {
-		.name	= SND_SGALAXY_DRIVER
+		.name	= DEV_NAME
 	},
 };
 
diff -r 530b211fffdb isa/sscape.c
--- a/isa/sscape.c	Fri Mar 16 15:01:36 2007 +0100
+++ b/isa/sscape.c	Sun Mar 18 20:36:43 2007 +0100
@@ -1296,7 +1296,7 @@ static int __devexit snd_sscape_remove(s
 	return 0;
 }
 
-#define SSCAPE_DRIVER	"snd_sscape"
+#define DEV_NAME "sscape"
 
 static struct isa_driver snd_sscape_driver = {
 	.match		= snd_sscape_match,
@@ -1304,7 +1304,7 @@ static struct isa_driver snd_sscape_driv
 	.remove		= __devexit_p(snd_sscape_remove),
 	/* FIXME: suspend/resume */
 	.driver		= {
-		.name	= SSCAPE_DRIVER
+		.name	= DEV_NAME
 	},
 };
 
diff -r 530b211fffdb isa/wavefront/wavefront.c
--- a/isa/wavefront/wavefront.c	Fri Mar 16 15:01:36 2007 +0100
+++ b/isa/wavefront/wavefront.c	Sun Mar 18 20:38:45 2007 +0100
@@ -633,7 +633,7 @@ static int __devexit snd_wavefront_isa_r
 	return 0;
 }
 
-#define WAVEFRONT_DRIVER	"snd_wavefront"
+#define DEV_NAME "wavefront"
 
 static struct isa_driver snd_wavefront_driver = {
 	.match		= snd_wavefront_isa_match,
@@ -641,7 +641,7 @@ static struct isa_driver snd_wavefront_d
 	.remove		= __devexit_p(snd_wavefront_isa_remove),
 	/* FIXME: suspend, resume */
 	.driver		= {
-		.name	= WAVEFRONT_DRIVER
+		.name	= DEV_NAME
 	},
 };
 

--------------080000060905080407070907
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------080000060905080407070907
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--------------080000060905080407070907--
