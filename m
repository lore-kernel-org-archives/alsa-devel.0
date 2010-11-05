From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH] ASoC: Decouple DAPM from CODECs
Date: Fri,  5 Nov 2010 15:53:46 +0200
Message-ID: <1288965226-23692-1-git-send-email-jhnikula@gmail.com>
References: <20101105133817.GJ13709@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 56E0C103965
	for <alsa-devel@alsa-project.org>; Fri,  5 Nov 2010 14:53:39 +0100 (CET)
Received: by eyg24 with SMTP id 24so1674375eyg.38
	for <alsa-devel@alsa-project.org>; Fri, 05 Nov 2010 06:53:39 -0700 (PDT)
In-Reply-To: <20101105133817.GJ13709@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Cliff Cai <cliff.cai@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Eric Miao <eric.y.miao@gmail.com>, Wan ZongShun <mcuos.com@gmail.com>, Mike Frysinger <vapier.adi@gmail.com>, Kevin Hilman <khilman@deeprootsystems.com>, Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Ryan Mallon <ryan@bluewatersys.com>, Daniel Gloeckner <dg@emlix.com>, Kuninori Morimoto <morimoto.kuninori@renesas.com>, Manuel Lauss <manuel.lauss@googlemail.com>, Jassi Brar <jassi.brar@samsung.com>, Timur Tabi <timur@freescale.com>, "Arnaud Patard (Rtp)" <arnaud.patard@rtp-net.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

From: Liam Girdwood <lrg@slimlogic.co.uk>

Decoupling Dynamic Audio Power Management (DAPM) from codec devices is
required when developing ASoC further. Such as for other ASoC components to
have DAPM widgets or when extending DAPM to handle cross-device paths.

This patch decouples DAPM related variables from struct snd_soc_codec and
moves them to new struct snd_soc_dapm_context that is used to encapsulate
DAPM context of a device. ASoC core and API of DAPM functions are modified
to use DAPM context instead of codec.

This patch does not change current functionality and a large part of changes
come because of structure and internal API changes.

Core implementation is from Liam Girdwood <lrg@slimlogic.co.uk> with some
minor core changes, codecs and machine driver conversions from
Jarkko Nikula <jhnikula@gmail.com>.

Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Manuel Lauss <manuel.lauss@googlemail.com>
Cc: Mike Frysinger <vapier.adi@gmail.com>
Cc: Cliff Cai <cliff.cai@analog.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Ryan Mallon <ryan@bluewatersys.com>
Cc: Timur Tabi <timur@freescale.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Cc: Wan ZongShun <mcuos.com@gmail.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Jassi Brar <jassi.brar@samsung.com>
Cc: Daniel Gloeckner <dg@emlix.com>
Cc: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
- Machine driver developers/maintainers Cc'ed for getting more build coverage
  than OMAP boards and codecs
- Patch is for branch for-2.6.38 of
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git
- RFC_[i-iii]/iv squashed into one patch as the 1st version shows the
  authorship of each parts. 1st set here:
  http://mailman.alsa-project.org/pipermail/alsa-devel/2010-October/033195.html
- struct snd_soc_dapm_context embedded into struct snd_soc_codec instead
  of allocating it. Based on discussion there is no need for DAPM without
  device context and this saves a few code lines from allocation/deallocation.
  A few include statement soc-dapm.h => soc.h changes in drivers because of
  that
- API of snd_soc_dapm_ignore_suspend changed also to be pair with other DAPM
  functions
- variable dapm instead of &codec->dapm used in drivers to make code more
  readable and to cut long lines. max98088 is space indented and this patch
  doesn't change that
- Function argument comments (codec => dapm) updated in soc-dapm.c
- Long soc-dapm function headers that this patch is touching are cut
---
 include/sound/soc-dapm.h                       |   49 +++-
 include/sound/soc.h                            |    9 +-
 sound/soc/atmel/playpaq_wm8510.c               |   11 +-
 sound/soc/atmel/sam9g20_wm8731.c               |   17 +-
 sound/soc/atmel/snd-soc-afeb9260.c             |   13 +-
 sound/soc/codecs/88pm860x-codec.c              |    9 +-
 sound/soc/codecs/ad1836.c                      |    5 +-
 sound/soc/codecs/ad193x.c                      |    5 +-
 sound/soc/codecs/ak4535.c                      |    9 +-
 sound/soc/codecs/ak4642.c                      |    2 +-
 sound/soc/codecs/ak4671.c                      |    9 +-
 sound/soc/codecs/alc5623.c                     |   23 +-
 sound/soc/codecs/cq93vc.c                      |    2 +-
 sound/soc/codecs/cs42l51.c                     |    5 +-
 sound/soc/codecs/cx20442.c                     |   15 +-
 sound/soc/codecs/da7210.c                      |    2 +-
 sound/soc/codecs/jz4740.c                      |   10 +-
 sound/soc/codecs/max98088.c                    |   12 +-
 sound/soc/codecs/ssm2602.c                     |    9 +-
 sound/soc/codecs/stac9766.c                    |    3 +-
 sound/soc/codecs/tlv320aic23.c                 |    9 +-
 sound/soc/codecs/tlv320aic3x.c                 |   22 +-
 sound/soc/codecs/tlv320dac33.c                 |   15 +-
 sound/soc/codecs/tpa6130a2.c                   |    5 +-
 sound/soc/codecs/twl4030.c                     |   13 +-
 sound/soc/codecs/twl6040.c                     |   12 +-
 sound/soc/codecs/uda134x.c                     |    2 +-
 sound/soc/codecs/uda1380.c                     |   13 +-
 sound/soc/codecs/wm2000.c                      |    5 +-
 sound/soc/codecs/wm8350.c                      |   28 +-
 sound/soc/codecs/wm8400.c                      |   11 +-
 sound/soc/codecs/wm8510.c                      |   11 +-
 sound/soc/codecs/wm8523.c                      |   11 +-
 sound/soc/codecs/wm8580.c                      |   11 +-
 sound/soc/codecs/wm8711.c                      |    9 +-
 sound/soc/codecs/wm8728.c                      |   11 +-
 sound/soc/codecs/wm8731.c                      |   13 +-
 sound/soc/codecs/wm8741.c                      |    7 +-
 sound/soc/codecs/wm8750.c                      |   11 +-
 sound/soc/codecs/wm8753.c                      |   29 +-
 sound/soc/codecs/wm8776.c                      |    9 +-
 sound/soc/codecs/wm8804.c                      |    6 +-
 sound/soc/codecs/wm8900.c                      |   11 +-
 sound/soc/codecs/wm8903.c                      |   11 +-
 sound/soc/codecs/wm8904.c                      |   33 ++-
 sound/soc/codecs/wm8940.c                      |    5 +-
 sound/soc/codecs/wm8955.c                      |   11 +-
 sound/soc/codecs/wm8960.c                      |   25 +-
 sound/soc/codecs/wm8961.c                      |   11 +-
 sound/soc/codecs/wm8962.c                      |   30 +-
 sound/soc/codecs/wm8971.c                      |   29 +-
 sound/soc/codecs/wm8974.c                      |   11 +-
 sound/soc/codecs/wm8978.c                      |   11 +-
 sound/soc/codecs/wm8985.c                      |   11 +-
 sound/soc/codecs/wm8988.c                      |    9 +-
 sound/soc/codecs/wm8990.c                      |   11 +-
 sound/soc/codecs/wm8993.c                      |    9 +-
 sound/soc/codecs/wm8994.c                      |   13 +-
 sound/soc/codecs/wm9081.c                      |    9 +-
 sound/soc/codecs/wm9090.c                      |   17 +-
 sound/soc/codecs/wm9705.c                      |    6 +-
 sound/soc/codecs/wm9712.c                      |    9 +-
 sound/soc/codecs/wm9713.c                      |    8 +-
 sound/soc/codecs/wm_hubs.c                     |   18 +-
 sound/soc/davinci/davinci-evm.c                |   21 +-
 sound/soc/ep93xx/snappercl15.c                 |    5 +-
 sound/soc/imx/wm1133-ev1.c                     |    7 +-
 sound/soc/jz4740/qi_lb60.c                     |   13 +-
 sound/soc/kirkwood/kirkwood-t5325.c            |   13 +-
 sound/soc/omap/am3517evm.c                     |   13 +-
 sound/soc/omap/ams-delta.c                     |   82 +++---
 sound/soc/omap/n810.c                          |   42 ++--
 sound/soc/omap/omap3pandora.c                  |   44 ++--
 sound/soc/omap/osk5912.c                       |   13 +-
 sound/soc/omap/rx51.c                          |   25 +-
 sound/soc/omap/sdp3430.c                       |   43 ++--
 sound/soc/omap/sdp4430.c                       |   19 +-
 sound/soc/omap/zoom2.c                         |   35 ++--
 sound/soc/pxa/corgi.c                          |   51 ++--
 sound/soc/pxa/e740_wm9705.c                    |   29 +-
 sound/soc/pxa/e750_wm9705.c                    |   29 +-
 sound/soc/pxa/e800_wm9712.c                    |    7 +-
 sound/soc/pxa/magician.c                       |   35 ++-
 sound/soc/pxa/mioa701_wm9713.c                 |   17 +-
 sound/soc/pxa/palm27x.c                        |   33 ++-
 sound/soc/pxa/poodle.c                         |   25 +-
 sound/soc/pxa/saarb.c                          |   17 +-
 sound/soc/pxa/spitz.c                          |   69 +++---
 sound/soc/pxa/tavorevb3.c                      |   17 +-
 sound/soc/pxa/tosa.c                           |   37 ++--
 sound/soc/pxa/z2.c                             |   15 +-
 sound/soc/pxa/zylonite.c                       |   11 +-
 sound/soc/s3c24xx/aquila_wm8994.c              |   25 +-
 sound/soc/s3c24xx/goni_wm8994.c                |   21 +-
 sound/soc/s3c24xx/jive_wm8750.c                |   19 +-
 sound/soc/s3c24xx/neo1973_gta02_wm8753.c       |   41 ++--
 sound/soc/s3c24xx/neo1973_wm8753.c             |  123 +++++----
 sound/soc/s3c24xx/rx1950_uda1380.c             |   11 +-
 sound/soc/s3c24xx/s3c24xx_simtec_hermes.c      |   15 +-
 sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c |   15 +-
 sound/soc/s3c24xx/smartq_wm8987.c              |   21 +-
 sound/soc/s3c24xx/smdk64xx_wm8580.c            |   16 +-
 sound/soc/s6000/s6105-ipcam.c                  |   40 ++--
 sound/soc/sh/migor.c                           |    5 +-
 sound/soc/sh/sh7760-ac97.c                     |    2 +-
 sound/soc/soc-core.c                           |   29 +-
 sound/soc/soc-dapm.c                           |  355 +++++++++++++-----------
 sound/soc/soc-jack.c                           |    8 +-
 108 files changed, 1239 insertions(+), 1064 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 8fd3b41..5881876 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -297,6 +297,7 @@ enum snd_soc_dapm_type;
 struct snd_soc_dapm_path;
 struct snd_soc_dapm_pin;
 struct snd_soc_dapm_route;
+struct snd_soc_dapm_context;
 
 int dapm_reg_event(struct snd_soc_dapm_widget *w,
 		   struct snd_kcontrol *kcontrol, int event);
@@ -324,16 +325,16 @@ int snd_soc_dapm_get_pin_switch(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *uncontrol);
 int snd_soc_dapm_put_pin_switch(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *uncontrol);
-int snd_soc_dapm_new_control(struct snd_soc_codec *codec,
+int snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 	const struct snd_soc_dapm_widget *widget);
-int snd_soc_dapm_new_controls(struct snd_soc_codec *codec,
+int snd_soc_dapm_new_controls(struct snd_soc_dapm_context *dapm,
 	const struct snd_soc_dapm_widget *widget,
 	int num);
 
 /* dapm path setup */
-int snd_soc_dapm_new_widgets(struct snd_soc_codec *codec);
-void snd_soc_dapm_free(struct snd_soc_codec *codec);
-int snd_soc_dapm_add_routes(struct snd_soc_codec *codec,
+int snd_soc_dapm_new_widgets(struct snd_soc_dapm_context *dapm);
+void snd_soc_dapm_free(struct snd_soc_dapm_context *dapm);
+int snd_soc_dapm_add_routes(struct snd_soc_dapm_context *dapm,
 			    const struct snd_soc_dapm_route *route, int num);
 
 /* dapm events */
@@ -343,17 +344,21 @@ void snd_soc_dapm_shutdown(struct snd_soc_card *card);
 
 /* dapm sys fs - used by the core */
 int snd_soc_dapm_sys_add(struct device *dev);
-void snd_soc_dapm_debugfs_init(struct snd_soc_codec *codec);
+void snd_soc_dapm_debugfs_init(struct snd_soc_dapm_context *dapm);
 
 /* dapm audio pin control and status */
-int snd_soc_dapm_enable_pin(struct snd_soc_codec *codec, const char *pin);
-int snd_soc_dapm_disable_pin(struct snd_soc_codec *codec, const char *pin);
-int snd_soc_dapm_nc_pin(struct snd_soc_codec *codec, const char *pin);
-int snd_soc_dapm_get_pin_status(struct snd_soc_codec *codec, const char *pin);
-int snd_soc_dapm_sync(struct snd_soc_codec *codec);
-int snd_soc_dapm_force_enable_pin(struct snd_soc_codec *codec,
+int snd_soc_dapm_enable_pin(struct snd_soc_dapm_context *dapm,
+			    const char *pin);
+int snd_soc_dapm_disable_pin(struct snd_soc_dapm_context *dapm,
+			     const char *pin);
+int snd_soc_dapm_nc_pin(struct snd_soc_dapm_context *dapm, const char *pin);
+int snd_soc_dapm_get_pin_status(struct snd_soc_dapm_context *dapm,
+				const char *pin);
+int snd_soc_dapm_sync(struct snd_soc_dapm_context *dapm);
+int snd_soc_dapm_force_enable_pin(struct snd_soc_dapm_context *dapm,
 				  const char *pin);
-int snd_soc_dapm_ignore_suspend(struct snd_soc_codec *codec, const char *pin);
+int snd_soc_dapm_ignore_suspend(struct snd_soc_dapm_context *dapm,
+				const char *pin);
 
 /* dapm widget types */
 enum snd_soc_dapm_type {
@@ -425,6 +430,7 @@ struct snd_soc_dapm_widget {
 	char *sname;	/* stream name */
 	struct snd_soc_codec *codec;
 	struct list_head list;
+	struct snd_soc_dapm_context *dapm;
 
 	/* dapm control */
 	short reg;						/* negative reg = no direct dapm */
@@ -461,4 +467,21 @@ struct snd_soc_dapm_widget {
 	struct list_head power_list;
 };
 
+/* DAPM context */
+struct snd_soc_dapm_context {
+	u32 pop_time;
+	struct list_head widgets;
+	struct list_head paths;
+	enum snd_soc_bias_level bias_level;
+	enum snd_soc_bias_level suspend_bias_level;
+	struct delayed_work delayed_work;
+	unsigned int idle_bias_off:1; /* Use BIAS_OFF instead of STANDBY */
+
+	struct device *dev; /* from parent - for debug */
+	struct snd_soc_codec *codec; /* parent codec */
+#ifdef CONFIG_DEBUG_FS
+	struct dentry *debugfs_dapm;
+#endif
+};
+
 #endif
diff --git a/include/sound/soc.h b/include/sound/soc.h
index aaf34d7..b048e08 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -238,6 +238,7 @@ struct soc_enum;
 struct snd_soc_ac97_ops;
 struct snd_soc_jack;
 struct snd_soc_jack_pin;
+#include <sound/soc-dapm.h>
 
 #ifdef CONFIG_GPIOLIB
 struct snd_soc_jack_gpio;
@@ -436,7 +437,6 @@ struct snd_soc_codec {
 	/* runtime */
 	struct snd_ac97 *ac97;  /* for ad-hoc ac97 devices */
 	unsigned int active;
-	unsigned int idle_bias_off:1; /* Use BIAS_OFF instead of STANDBY */
 	unsigned int cache_only:1;  /* Suppress writes to hardware */
 	unsigned int cache_sync:1; /* Cache needs to be synced to hardware */
 	unsigned int suspended:1; /* Codec is in suspend PM state */
@@ -452,12 +452,7 @@ struct snd_soc_codec {
 	void *reg_cache;
 
 	/* dapm */
-	u32 pop_time;
-	struct list_head dapm_widgets;
-	struct list_head dapm_paths;
-	enum snd_soc_bias_level bias_level;
-	enum snd_soc_bias_level suspend_bias_level;
-	struct delayed_work delayed_work;
+	struct snd_soc_dapm_context dapm;
 
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_codec_root;
diff --git a/sound/soc/atmel/playpaq_wm8510.c b/sound/soc/atmel/playpaq_wm8510.c
index 5f4e59f..aede7e7 100644
--- a/sound/soc/atmel/playpaq_wm8510.c
+++ b/sound/soc/atmel/playpaq_wm8510.c
@@ -318,27 +318,28 @@ static const struct snd_soc_dapm_route intercon[] = {
 static int playpaq_wm8510_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int i;
 
 	/*
 	 * Add DAPM widgets
 	 */
 	for (i = 0; i < ARRAY_SIZE(playpaq_dapm_widgets); i++)
-		snd_soc_dapm_new_control(codec, &playpaq_dapm_widgets[i]);
+		snd_soc_dapm_new_control(dapm, &playpaq_dapm_widgets[i]);
 
 
 
 	/*
 	 * Setup audio path interconnects
 	 */
-	snd_soc_dapm_add_routes(codec, intercon, ARRAY_SIZE(intercon));
+	snd_soc_dapm_add_routes(dapm, intercon, ARRAY_SIZE(intercon));
 
 
 
 	/* always connected pins */
-	snd_soc_dapm_enable_pin(codec, "Int Mic");
-	snd_soc_dapm_enable_pin(codec, "Ext Spk");
-	snd_soc_dapm_sync(codec);
+	snd_soc_dapm_enable_pin(dapm, "Int Mic");
+	snd_soc_dapm_enable_pin(dapm, "Ext Spk");
+	snd_soc_dapm_sync(dapm);
 
 
 
diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
index 293569d..da9c303 100644
--- a/sound/soc/atmel/sam9g20_wm8731.c
+++ b/sound/soc/atmel/sam9g20_wm8731.c
@@ -140,6 +140,7 @@ static int at91sam9g20ek_wm8731_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int ret;
 
 	printk(KERN_DEBUG
@@ -154,25 +155,25 @@ static int at91sam9g20ek_wm8731_init(struct snd_soc_pcm_runtime *rtd)
 	}
 
 	/* Add specific widgets */
-	snd_soc_dapm_new_controls(codec, at91sam9g20ek_dapm_widgets,
+	snd_soc_dapm_new_controls(dapm, at91sam9g20ek_dapm_widgets,
 				  ARRAY_SIZE(at91sam9g20ek_dapm_widgets));
 	/* Set up specific audio path interconnects */
-	snd_soc_dapm_add_routes(codec, intercon, ARRAY_SIZE(intercon));
+	snd_soc_dapm_add_routes(dapm, intercon, ARRAY_SIZE(intercon));
 
 	/* not connected */
-	snd_soc_dapm_nc_pin(codec, "RLINEIN");
-	snd_soc_dapm_nc_pin(codec, "LLINEIN");
+	snd_soc_dapm_nc_pin(dapm, "RLINEIN");
+	snd_soc_dapm_nc_pin(dapm, "LLINEIN");
 
 #ifdef ENABLE_MIC_INPUT
-	snd_soc_dapm_enable_pin(codec, "Int Mic");
+	snd_soc_dapm_enable_pin(dapm, "Int Mic");
 #else
-	snd_soc_dapm_nc_pin(codec, "Int Mic");
+	snd_soc_dapm_nc_pin(dapm, "Int Mic");
 #endif
 
 	/* always connected */
-	snd_soc_dapm_enable_pin(codec, "Ext Spk");
+	snd_soc_dapm_enable_pin(dapm, "Ext Spk");
 
-	snd_soc_dapm_sync(codec);
+	snd_soc_dapm_sync(dapm);
 
 	return 0;
 }
diff --git a/sound/soc/atmel/snd-soc-afeb9260.c b/sound/soc/atmel/snd-soc-afeb9260.c
index e3d2835..92c709e 100644
--- a/sound/soc/atmel/snd-soc-afeb9260.c
+++ b/sound/soc/atmel/snd-soc-afeb9260.c
@@ -105,19 +105,20 @@ static const struct snd_soc_dapm_route audio_map[] = {
 static int afeb9260_tlv320aic23_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
 	/* Add afeb9260 specific widgets */
-	snd_soc_dapm_new_controls(codec, tlv320aic23_dapm_widgets,
+	snd_soc_dapm_new_controls(dapm, tlv320aic23_dapm_widgets,
 				  ARRAY_SIZE(tlv320aic23_dapm_widgets));
 
 	/* Set up afeb9260 specific audio path audio_map */
-	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
-	snd_soc_dapm_enable_pin(codec, "Headphone Jack");
-	snd_soc_dapm_enable_pin(codec, "Line In");
-	snd_soc_dapm_enable_pin(codec, "Mic Jack");
+	snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
+	snd_soc_dapm_enable_pin(dapm, "Line In");
+	snd_soc_dapm_enable_pin(dapm, "Mic Jack");
 
-	snd_soc_dapm_sync(codec);
+	snd_soc_dapm_sync(dapm);
 
 	return 0;
 }
diff --git a/sound/soc/codecs/88pm860x-codec.c b/sound/soc/codecs/88pm860x-codec.c
index 01d19e9..a15a3e9 100644
--- a/sound/soc/codecs/88pm860x-codec.c
+++ b/sound/soc/codecs/88pm860x-codec.c
@@ -1172,7 +1172,7 @@ static int pm860x_set_bias_level(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
-		if (codec->bias_level == SND_SOC_BIAS_OFF) {
+		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
 			/* Enable Audio PLL & Audio section */
 			data = AUDIO_PLL | AUDIO_SECTION_RESET
 				| AUDIO_SECTION_ON;
@@ -1185,7 +1185,7 @@ static int pm860x_set_bias_level(struct snd_soc_codec *codec,
 		pm860x_set_bits(codec->control_data, REG_MISC2, data, 0);
 		break;
 	}
-	codec->bias_level = level;
+	codec->dapm.bias_level = level;
 	return 0;
 }
 
@@ -1346,6 +1346,7 @@ EXPORT_SYMBOL_GPL(pm860x_mic_jack_detect);
 static int pm860x_probe(struct snd_soc_codec *codec)
 {
 	struct pm860x_priv *pm860x = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int i, ret;
 
 	pm860x->codec = codec;
@@ -1374,9 +1375,9 @@ static int pm860x_probe(struct snd_soc_codec *codec)
 
 	snd_soc_add_controls(codec, pm860x_snd_controls,
 			     ARRAY_SIZE(pm860x_snd_controls));
-	snd_soc_dapm_new_controls(codec, pm860x_dapm_widgets,
+	snd_soc_dapm_new_controls(dapm, pm860x_dapm_widgets,
 				  ARRAY_SIZE(pm860x_dapm_widgets));
-	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 	return 0;
 
 out_codec:
diff --git a/sound/soc/codecs/ad1836.c b/sound/soc/codecs/ad1836.c
index d272534..c71b05d 100644
--- a/sound/soc/codecs/ad1836.c
+++ b/sound/soc/codecs/ad1836.c
@@ -220,6 +220,7 @@ static struct snd_soc_dai_driver ad1836_dai = {
 static int ad1836_probe(struct snd_soc_codec *codec)
 {
 	struct ad1836_priv *ad1836 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int ret = 0;
 
 	codec->control_data = ad1836->control_data;
@@ -252,9 +253,9 @@ static int ad1836_probe(struct snd_soc_codec *codec)
 
 	snd_soc_add_controls(codec, ad1836_snd_controls,
 			     ARRAY_SIZE(ad1836_snd_controls));
-	snd_soc_dapm_new_controls(codec, ad1836_dapm_widgets,
+	snd_soc_dapm_new_controls(dapm, ad1836_dapm_widgets,
 				  ARRAY_SIZE(ad1836_dapm_widgets));
-	snd_soc_dapm_add_routes(codec, audio_paths, ARRAY_SIZE(audio_paths));
+	snd_soc_dapm_add_routes(dapm, audio_paths, ARRAY_SIZE(audio_paths));
 
 	return ret;
 }
diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index fa2834c..dc105d8 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -353,6 +353,7 @@ static struct snd_soc_dai_driver ad193x_dai = {
 static int ad193x_probe(struct snd_soc_codec *codec)
 {
 	struct ad193x_priv *ad193x = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int ret;
 
 	codec->control_data = ad193x->control_data;
@@ -385,9 +386,9 @@ static int ad193x_probe(struct snd_soc_codec *codec)
 
 	snd_soc_add_controls(codec, ad193x_snd_controls,
 			     ARRAY_SIZE(ad193x_snd_controls));
-	snd_soc_dapm_new_controls(codec, ad193x_dapm_widgets,
+	snd_soc_dapm_new_controls(dapm, ad193x_dapm_widgets,
 				  ARRAY_SIZE(ad193x_dapm_widgets));
-	snd_soc_dapm_add_routes(codec, audio_paths, ARRAY_SIZE(audio_paths));
+	snd_soc_dapm_add_routes(dapm, audio_paths, ARRAY_SIZE(audio_paths));
 
 	return ret;
 }
diff --git a/sound/soc/codecs/ak4535.c b/sound/soc/codecs/ak4535.c
index cd88c8f..52abb93 100644
--- a/sound/soc/codecs/ak4535.c
+++ b/sound/soc/codecs/ak4535.c
@@ -290,10 +290,11 @@ static const struct snd_soc_dapm_route audio_map[] = {
 
 static int ak4535_add_widgets(struct snd_soc_codec *codec)
 {
-	snd_soc_dapm_new_controls(codec, ak4535_dapm_widgets,
-				  ARRAY_SIZE(ak4535_dapm_widgets));
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
-	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	snd_soc_dapm_new_controls(dapm, ak4535_dapm_widgets,
+				  ARRAY_SIZE(ak4535_dapm_widgets));
+	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
 	return 0;
 }
@@ -399,7 +400,7 @@ static int ak4535_set_bias_level(struct snd_soc_codec *codec,
 		ak4535_write(codec, AK4535_PM1, i & (~0x80));
 		break;
 	}
-	codec->bias_level = level;
+	codec->dapm.bias_level = level;
 	return 0;
 }
 
diff --git a/sound/soc/codecs/ak4642.c b/sound/soc/codecs/ak4642.c
index 90c90b7..f00eba3 100644
--- a/sound/soc/codecs/ak4642.c
+++ b/sound/soc/codecs/ak4642.c
@@ -26,7 +26,7 @@
 #include <linux/i2c.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
-#include <sound/soc-dapm.h>
+#include <sound/soc.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
 
diff --git a/sound/soc/codecs/ak4671.c b/sound/soc/codecs/ak4671.c
index 24f5f49..1d6573c 100644
--- a/sound/soc/codecs/ak4671.c
+++ b/sound/soc/codecs/ak4671.c
@@ -437,10 +437,11 @@ static const struct snd_soc_dapm_route intercon[] = {
 
 static int ak4671_add_widgets(struct snd_soc_codec *codec)
 {
-	snd_soc_dapm_new_controls(codec, ak4671_dapm_widgets,
-				  ARRAY_SIZE(ak4671_dapm_widgets));
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
-	snd_soc_dapm_add_routes(codec, intercon, ARRAY_SIZE(intercon));
+	snd_soc_dapm_new_controls(dapm, ak4671_dapm_widgets,
+				  ARRAY_SIZE(ak4671_dapm_widgets));
+	snd_soc_dapm_add_routes(dapm, intercon, ARRAY_SIZE(intercon));
 
 	return 0;
 }
@@ -602,7 +603,7 @@ static int ak4671_set_bias_level(struct snd_soc_codec *codec,
 		snd_soc_write(codec, AK4671_AD_DA_POWER_MANAGEMENT, 0x00);
 		break;
 	}
-	codec->bias_level = level;
+	codec->dapm.bias_level = level;
 	return 0;
 }
 
diff --git a/sound/soc/codecs/alc5623.c b/sound/soc/codecs/alc5623.c
index fac6174..5a45067 100644
--- a/sound/soc/codecs/alc5623.c
+++ b/sound/soc/codecs/alc5623.c
@@ -832,7 +832,7 @@ static int alc5623_set_bias_level(struct snd_soc_codec *codec,
 		snd_soc_write(codec, ALC5623_PWR_MANAG_ADD1, 0);
 		break;
 	}
-	codec->bias_level = level;
+	codec->dapm.bias_level = level;
 	return 0;
 }
 
@@ -888,10 +888,10 @@ static int alc5623_resume(struct snd_soc_codec *codec)
 	alc5623_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	/* charge alc5623 caps */
-	if (codec->suspend_bias_level == SND_SOC_BIAS_ON) {
+	if (codec->dapm.suspend_bias_level == SND_SOC_BIAS_ON) {
 		alc5623_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-		codec->bias_level = SND_SOC_BIAS_ON;
-		alc5623_set_bias_level(codec, codec->bias_level);
+		codec->dapm.bias_level = SND_SOC_BIAS_ON;
+		alc5623_set_bias_level(codec, codec->dapm.bias_level);
 	}
 
 	return 0;
@@ -900,6 +900,7 @@ static int alc5623_resume(struct snd_soc_codec *codec)
 static int alc5623_probe(struct snd_soc_codec *codec)
 {
 	struct alc5623_priv *alc5623 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int ret;
 
 	ret = snd_soc_codec_set_cache_io(codec, 8, 16, alc5623->control_type);
@@ -943,24 +944,24 @@ static int alc5623_probe(struct snd_soc_codec *codec)
 	snd_soc_add_controls(codec, alc5623_snd_controls,
 			ARRAY_SIZE(alc5623_snd_controls));
 
-	snd_soc_dapm_new_controls(codec, alc5623_dapm_widgets,
+	snd_soc_dapm_new_controls(dapm, alc5623_dapm_widgets,
 					ARRAY_SIZE(alc5623_dapm_widgets));
 
 	/* set up audio path interconnects */
-	snd_soc_dapm_add_routes(codec, intercon, ARRAY_SIZE(intercon));
+	snd_soc_dapm_add_routes(dapm, intercon, ARRAY_SIZE(intercon));
 
 	switch (alc5623->id) {
 	default:
 	case 0x21:
 	case 0x22:
-		snd_soc_dapm_new_controls(codec, alc5623_dapm_amp_widgets,
+		snd_soc_dapm_new_controls(dapm, alc5623_dapm_amp_widgets,
 					ARRAY_SIZE(alc5623_dapm_amp_widgets));
-		snd_soc_dapm_add_routes(codec, intercon_amp_spk,
-						ARRAY_SIZE(intercon_amp_spk));
+		snd_soc_dapm_add_routes(dapm, intercon_amp_spk,
+					ARRAY_SIZE(intercon_amp_spk));
 		break;
 	case 0x23:
-		snd_soc_dapm_add_routes(codec, intercon_spk,
-						ARRAY_SIZE(intercon_spk));
+		snd_soc_dapm_add_routes(dapm, intercon_spk,
+					ARRAY_SIZE(intercon_spk));
 		break;
 	}
 
diff --git a/sound/soc/codecs/cq93vc.c b/sound/soc/codecs/cq93vc.c
index 8236439..98b9e52 100644
--- a/sound/soc/codecs/cq93vc.c
+++ b/sound/soc/codecs/cq93vc.c
@@ -116,7 +116,7 @@ static int cq93vc_set_bias_level(struct snd_soc_codec *codec,
 			     DAVINCI_VC_REG12_POWER_ALL_OFF);
 		break;
 	}
-	codec->bias_level = level;
+	codec->dapm.bias_level = level;
 
 	return 0;
 }
diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index cb086ea..a7fdca3 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -519,6 +519,7 @@ static struct snd_soc_dai_driver cs42l51_dai = {
 static int cs42l51_probe(struct snd_soc_codec *codec)
 {
 	struct cs42l51_private *cs42l51 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int ret, reg;
 
 	codec->control_data = cs42l51->control_data;
@@ -550,9 +551,9 @@ static int cs42l51_probe(struct snd_soc_codec *codec)
 
 	snd_soc_add_controls(codec, cs42l51_snd_controls,
 		ARRAY_SIZE(cs42l51_snd_controls));
-	snd_soc_dapm_new_controls(codec, cs42l51_dapm_widgets,
+	snd_soc_dapm_new_controls(dapm, cs42l51_dapm_widgets,
 		ARRAY_SIZE(cs42l51_dapm_widgets));
-	snd_soc_dapm_add_routes(codec, cs42l51_routes,
+	snd_soc_dapm_add_routes(dapm, cs42l51_routes,
 		ARRAY_SIZE(cs42l51_routes));
 
 	return 0;
diff --git a/sound/soc/codecs/cx20442.c b/sound/soc/codecs/cx20442.c
index e8d27c8..11beb1a 100644
--- a/sound/soc/codecs/cx20442.c
+++ b/sound/soc/codecs/cx20442.c
@@ -18,7 +18,7 @@
 
 #include <sound/core.h>
 #include <sound/initval.h>
-#include <sound/soc-dapm.h>
+#include <sound/soc.h>
 
 #include "cx20442.h"
 
@@ -89,10 +89,11 @@ static const struct snd_soc_dapm_route cx20442_audio_map[] = {
 
 static int cx20442_add_widgets(struct snd_soc_codec *codec)
 {
-	snd_soc_dapm_new_controls(codec, cx20442_dapm_widgets,
-				  ARRAY_SIZE(cx20442_dapm_widgets));
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
-	snd_soc_dapm_add_routes(codec, cx20442_audio_map,
+	snd_soc_dapm_new_controls(dapm, cx20442_dapm_widgets,
+				  ARRAY_SIZE(cx20442_dapm_widgets));
+	snd_soc_dapm_add_routes(dapm, cx20442_audio_map,
 				ARRAY_SIZE(cx20442_audio_map));
 
 	return 0;
@@ -263,7 +264,7 @@ static void v253_close(struct tty_struct *tty)
 	/* Prevent the codec driver from further accessing the modem */
 	codec->hw_write = NULL;
 	cx20442->control_data = NULL;
-	codec->pop_time = 0;
+	codec->dapm.pop_time = 0;
 }
 
 /* Line discipline .hangup() */
@@ -291,7 +292,7 @@ static void v253_receive(struct tty_struct *tty,
 		/* Set up codec driver access to modem controls */
 		cx20442->control_data = tty;
 		codec->hw_write = (hw_write_t)tty->ops->write;
-		codec->pop_time = 1;
+		codec->dapm.pop_time = 1;
 	}
 }
 
@@ -348,7 +349,7 @@ static int cx20442_codec_probe(struct snd_soc_codec *codec)
 
 	cx20442->control_data = NULL;
 	codec->hw_write = NULL;
-	codec->pop_time = 0;
+	codec->dapm.pop_time = 0;
 
 	return 0;
 }
diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index 58bb9b9..92fd9d7 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -21,7 +21,7 @@
 #include <linux/slab.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
-#include <sound/soc-dapm.h>
+#include <sound/soc.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
 
diff --git a/sound/soc/codecs/jz4740.c b/sound/soc/codecs/jz4740.c
index 16253ec..8a45562 100644
--- a/sound/soc/codecs/jz4740.c
+++ b/sound/soc/codecs/jz4740.c
@@ -266,7 +266,7 @@ static int jz4740_codec_set_bias_level(struct snd_soc_codec *codec,
 		break;
 	case SND_SOC_BIAS_STANDBY:
 		/* The only way to clear the suspend flag is to reset the codec */
-		if (codec->bias_level == SND_SOC_BIAS_OFF)
+		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF)
 			jz4740_codec_wakeup(codec);
 
 		mask = JZ4740_CODEC_1_VREF_DISABLE |
@@ -288,23 +288,25 @@ static int jz4740_codec_set_bias_level(struct snd_soc_codec *codec,
 		break;
 	}
 
-	codec->bias_level = level;
+	codec->dapm.bias_level = level;
 
 	return 0;
 }
 
 static int jz4740_codec_dev_probe(struct snd_soc_codec *codec)
 {
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
+
 	snd_soc_update_bits(codec, JZ4740_REG_CODEC_1,
 			JZ4740_CODEC_1_SW2_ENABLE, JZ4740_CODEC_1_SW2_ENABLE);
 
 	snd_soc_add_controls(codec, jz4740_codec_controls,
 		ARRAY_SIZE(jz4740_codec_controls));
 
-	snd_soc_dapm_new_controls(codec, jz4740_codec_dapm_widgets,
+	snd_soc_dapm_new_controls(dapm, jz4740_codec_dapm_widgets,
 		ARRAY_SIZE(jz4740_codec_dapm_widgets));
 
-	snd_soc_dapm_add_routes(codec, jz4740_codec_dapm_routes,
+	snd_soc_dapm_add_routes(dapm, jz4740_codec_dapm_routes,
 		ARRAY_SIZE(jz4740_codec_dapm_routes));
 
 	snd_soc_dapm_new_widgets(codec);
diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index bc22ee9..ef06007 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -1224,15 +1224,17 @@ static const struct snd_soc_dapm_route audio_map[] = {
 
 static int max98088_add_widgets(struct snd_soc_codec *codec)
 {
-       snd_soc_dapm_new_controls(codec, max98088_dapm_widgets,
+       struct snd_soc_dapm_context *dapm = &codec->dapm;
+
+       snd_soc_dapm_new_controls(dapm, max98088_dapm_widgets,
                                  ARRAY_SIZE(max98088_dapm_widgets));
 
-       snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+       snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
        snd_soc_add_controls(codec, max98088_snd_controls,
                             ARRAY_SIZE(max98088_snd_controls));
 
-       snd_soc_dapm_new_widgets(codec);
+       snd_soc_dapm_new_widgets(dapm);
        return 0;
 }
 
@@ -1617,7 +1619,7 @@ static int max98088_set_bias_level(struct snd_soc_codec *codec,
                break;
 
        case SND_SOC_BIAS_STANDBY:
-               if (codec->bias_level == SND_SOC_BIAS_OFF)
+               if (codec->dapm.bias_level == SND_SOC_BIAS_OFF)
                        max98088_sync_cache(codec);
 
                snd_soc_update_bits(codec, M98088_REG_4C_PWR_EN_IN,
@@ -1630,7 +1632,7 @@ static int max98088_set_bias_level(struct snd_soc_codec *codec,
                codec->cache_sync = 1;
                break;
        }
-       codec->bias_level = level;
+       codec->dapm.bias_level = level;
        return 0;
 }
 
diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index 6f38d61..adbc3e8 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -207,10 +207,11 @@ static const struct snd_soc_dapm_route audio_conn[] = {
 
 static int ssm2602_add_widgets(struct snd_soc_codec *codec)
 {
-	snd_soc_dapm_new_controls(codec, ssm2602_dapm_widgets,
-				  ARRAY_SIZE(ssm2602_dapm_widgets));
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
-	snd_soc_dapm_add_routes(codec, audio_conn, ARRAY_SIZE(audio_conn));
+	snd_soc_dapm_new_controls(dapm, ssm2602_dapm_widgets,
+				  ARRAY_SIZE(ssm2602_dapm_widgets));
+	snd_soc_dapm_add_routes(dapm, audio_conn, ARRAY_SIZE(audio_conn));
 
 	return 0;
 }
@@ -493,7 +494,7 @@ static int ssm2602_set_bias_level(struct snd_soc_codec *codec,
 		break;
 
 	}
-	codec->bias_level = level;
+	codec->dapm.bias_level = level;
 	return 0;
 }
 
diff --git a/sound/soc/codecs/stac9766.c b/sound/soc/codecs/stac9766.c
index 00d67cc..8aad3a2 100644
--- a/sound/soc/codecs/stac9766.c
+++ b/sound/soc/codecs/stac9766.c
@@ -24,6 +24,7 @@
 #include <sound/initval.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
+#include <sound/soc-dapm.h>
 #include <sound/tlv.h>
 
 #include "stac9766.h"
@@ -236,7 +237,7 @@ static int stac9766_set_bias_level(struct snd_soc_codec *codec,
 		stac9766_ac97_write(codec, AC97_POWERDOWN, 0xffff);
 		break;
 	}
-	codec->bias_level = level;
+	codec->dapm.bias_level = level;
 	return 0;
 }
 
diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index e8652b1..d9d8e84 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -391,11 +391,12 @@ static int set_sample_rate_control(struct snd_soc_codec *codec, int mclk,
 
 static int tlv320aic23_add_widgets(struct snd_soc_codec *codec)
 {
-	snd_soc_dapm_new_controls(codec, tlv320aic23_dapm_widgets,
-				  ARRAY_SIZE(tlv320aic23_dapm_widgets));
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
+	snd_soc_dapm_new_controls(dapm, tlv320aic23_dapm_widgets,
+				  ARRAY_SIZE(tlv320aic23_dapm_widgets));
 	/* set up audio path interconnects */
-	snd_soc_dapm_add_routes(codec, intercon, ARRAY_SIZE(intercon));
+	snd_soc_dapm_add_routes(dapm, intercon, ARRAY_SIZE(intercon));
 
 	return 0;
 }
@@ -574,7 +575,7 @@ static int tlv320aic23_set_bias_level(struct snd_soc_codec *codec,
 		tlv320aic23_write(codec, TLV320AIC23_PWR, 0xffff);
 		break;
 	}
-	codec->bias_level = level;
+	codec->dapm.bias_level = level;
 	return 0;
 }
 
diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index fc68779..6173c2b 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -183,7 +183,7 @@ static int snd_soc_dapm_put_volsw_aic3x(struct snd_kcontrol *kcontrol,
 
 	if (snd_soc_test_bits(widget->codec, reg, val_mask, val)) {
 		/* find dapm widget path assoc with kcontrol */
-		list_for_each_entry(path, &widget->codec->dapm_paths, list) {
+		list_for_each_entry(path, &widget->dapm->paths, list) {
 			if (path->kcontrol != kcontrol)
 				continue;
 
@@ -199,7 +199,7 @@ static int snd_soc_dapm_put_volsw_aic3x(struct snd_kcontrol *kcontrol,
 		}
 
 		if (found)
-			snd_soc_dapm_sync(widget->codec);
+			snd_soc_dapm_sync(widget->dapm);
 	}
 
 	ret = snd_soc_update_bits(widget->codec, reg, val_mask, val);
@@ -788,17 +788,19 @@ static const struct snd_soc_dapm_route intercon_3007[] = {
 static int aic3x_add_widgets(struct snd_soc_codec *codec)
 {
 	struct aic3x_priv *aic3x = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
-	snd_soc_dapm_new_controls(codec, aic3x_dapm_widgets,
+	snd_soc_dapm_new_controls(dapm, aic3x_dapm_widgets,
 				  ARRAY_SIZE(aic3x_dapm_widgets));
 
 	/* set up audio path interconnects */
-	snd_soc_dapm_add_routes(codec, intercon, ARRAY_SIZE(intercon));
+	snd_soc_dapm_add_routes(dapm, intercon, ARRAY_SIZE(intercon));
 
 	if (aic3x->model == AIC3X_MODEL_3007) {
-		snd_soc_dapm_new_controls(codec, aic3007_dapm_widgets,
+		snd_soc_dapm_new_controls(dapm, aic3007_dapm_widgets,
 			ARRAY_SIZE(aic3007_dapm_widgets));
-		snd_soc_dapm_add_routes(codec, intercon_3007, ARRAY_SIZE(intercon_3007));
+		snd_soc_dapm_add_routes(dapm, intercon_3007,
+					ARRAY_SIZE(intercon_3007));
 	}
 
 	return 0;
@@ -1135,7 +1137,7 @@ static int aic3x_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_ON:
 		break;
 	case SND_SOC_BIAS_PREPARE:
-		if (codec->bias_level == SND_SOC_BIAS_STANDBY &&
+		if (codec->dapm.bias_level == SND_SOC_BIAS_STANDBY &&
 		    aic3x->master) {
 			/* enable pll */
 			reg = snd_soc_read(codec, AIC3X_PLL_PROGA_REG);
@@ -1146,7 +1148,7 @@ static int aic3x_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_STANDBY:
 		if (!aic3x->power)
 			aic3x_set_power(codec, 1);
-		if (codec->bias_level == SND_SOC_BIAS_PREPARE &&
+		if (codec->dapm.bias_level == SND_SOC_BIAS_PREPARE &&
 		    aic3x->master) {
 			/* disable pll */
 			reg = snd_soc_read(codec, AIC3X_PLL_PROGA_REG);
@@ -1159,7 +1161,7 @@ static int aic3x_set_bias_level(struct snd_soc_codec *codec,
 			aic3x_set_power(codec, 0);
 		break;
 	}
-	codec->bias_level = level;
+	codec->dapm.bias_level = level;
 
 	return 0;
 }
@@ -1351,7 +1353,7 @@ static int aic3x_probe(struct snd_soc_codec *codec)
 
 	codec->control_data = aic3x->control_data;
 	aic3x->codec = codec;
-	codec->idle_bias_off = 1;
+	codec->dapm.idle_bias_off = 1;
 
 	ret = snd_soc_codec_set_cache_io(codec, 8, 8, aic3x->control_type);
 	if (ret != 0) {
diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index d251ff5..883f984 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -622,11 +622,12 @@ static const struct snd_soc_dapm_route audio_map[] = {
 
 static int dac33_add_widgets(struct snd_soc_codec *codec)
 {
-	snd_soc_dapm_new_controls(codec, dac33_dapm_widgets,
-				  ARRAY_SIZE(dac33_dapm_widgets));
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
+	snd_soc_dapm_new_controls(dapm, dac33_dapm_widgets,
+				  ARRAY_SIZE(dac33_dapm_widgets));
 	/* set up audio path interconnects */
-	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
 	return 0;
 }
@@ -643,7 +644,7 @@ static int dac33_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_PREPARE:
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		if (codec->bias_level == SND_SOC_BIAS_OFF) {
+		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
 			/* Coming from OFF, switch on the codec */
 			ret = dac33_hard_power(codec, 1);
 			if (ret != 0)
@@ -654,14 +655,14 @@ static int dac33_set_bias_level(struct snd_soc_codec *codec,
 		break;
 	case SND_SOC_BIAS_OFF:
 		/* Do not power off, when the codec is already off */
-		if (codec->bias_level == SND_SOC_BIAS_OFF)
+		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF)
 			return 0;
 		ret = dac33_hard_power(codec, 0);
 		if (ret != 0)
 			return ret;
 		break;
 	}
-	codec->bias_level = level;
+	codec->dapm.bias_level = level;
 
 	return 0;
 }
@@ -1405,7 +1406,7 @@ static int dac33_soc_probe(struct snd_soc_codec *codec)
 
 	codec->control_data = dac33->control_data;
 	codec->hw_write = (hw_write_t) i2c_master_send;
-	codec->idle_bias_off = 1;
+	codec->dapm.idle_bias_off = 1;
 	dac33->codec = codec;
 
 	/* Read the tlv320dac33 ID registers */
diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index 329acc1..ea0072c 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -388,16 +388,17 @@ static const struct snd_soc_dapm_route audio_map[] = {
 int tpa6130a2_add_controls(struct snd_soc_codec *codec)
 {
 	struct	tpa6130a2_data *data;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
 	if (tpa6130a2_client == NULL)
 		return -ENODEV;
 
 	data = i2c_get_clientdata(tpa6130a2_client);
 
-	snd_soc_dapm_new_controls(codec, tpa6130a2_dapm_widgets,
+	snd_soc_dapm_new_controls(dapm, tpa6130a2_dapm_widgets,
 				ARRAY_SIZE(tpa6130a2_dapm_widgets));
 
-	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
 	if (data->id == TPA6140A2)
 		return snd_soc_add_controls(codec, tpa6140a2_controls,
diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index cbebec6..f4602e8 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -1621,10 +1621,11 @@ static const struct snd_soc_dapm_route intercon[] = {
 
 static int twl4030_add_widgets(struct snd_soc_codec *codec)
 {
-	snd_soc_dapm_new_controls(codec, twl4030_dapm_widgets,
-				 ARRAY_SIZE(twl4030_dapm_widgets));
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
-	snd_soc_dapm_add_routes(codec, intercon, ARRAY_SIZE(intercon));
+	snd_soc_dapm_new_controls(dapm, twl4030_dapm_widgets,
+				 ARRAY_SIZE(twl4030_dapm_widgets));
+	snd_soc_dapm_add_routes(dapm, intercon, ARRAY_SIZE(intercon));
 
 	return 0;
 }
@@ -1638,14 +1639,14 @@ static int twl4030_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_PREPARE:
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		if (codec->bias_level == SND_SOC_BIAS_OFF)
+		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF)
 			twl4030_codec_enable(codec, 1);
 		break;
 	case SND_SOC_BIAS_OFF:
 		twl4030_codec_enable(codec, 0);
 		break;
 	}
-	codec->bias_level = level;
+	codec->dapm.bias_level = level;
 
 	return 0;
 }
@@ -2245,7 +2246,7 @@ static int twl4030_soc_probe(struct snd_soc_codec *codec)
 	snd_soc_codec_set_drvdata(codec, twl4030);
 	/* Set the defaults, and power up the codec */
 	twl4030->sysclk = twl4030_codec_get_mclk() / 1000;
-	codec->idle_bias_off = 1;
+	codec->dapm.idle_bias_off = 1;
 
 	twl4030_init_chip(codec);
 
diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 10f6e52..0dd2d53 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -641,12 +641,12 @@ static const struct snd_soc_dapm_route intercon[] = {
 
 static int twl6040_add_widgets(struct snd_soc_codec *codec)
 {
-	snd_soc_dapm_new_controls(codec, twl6040_dapm_widgets,
-				 ARRAY_SIZE(twl6040_dapm_widgets));
-
-	snd_soc_dapm_add_routes(codec, intercon, ARRAY_SIZE(intercon));
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
-	snd_soc_dapm_new_widgets(codec);
+	snd_soc_dapm_new_controls(dapm, twl6040_dapm_widgets,
+				 ARRAY_SIZE(twl6040_dapm_widgets));
+	snd_soc_dapm_add_routes(dapm, intercon, ARRAY_SIZE(intercon));
+	snd_soc_dapm_new_widgets(dapm);
 
 	return 0;
 }
@@ -739,7 +739,7 @@ static int twl6040_set_bias_level(struct snd_soc_codec *codec,
 		break;
 	}
 
-	codec->bias_level = level;
+	codec->dapm.bias_level = level;
 
 	return 0;
 }
diff --git a/sound/soc/codecs/uda134x.c b/sound/soc/codecs/uda134x.c
index 7540a50..8ea81d4 100644
--- a/sound/soc/codecs/uda134x.c
+++ b/sound/soc/codecs/uda134x.c
@@ -389,7 +389,7 @@ static int uda134x_set_bias_level(struct snd_soc_codec *codec,
 			pd->power(0);
 		break;
 	}
-	codec->bias_level = level;
+	codec->dapm.bias_level = level;
 	return 0;
 }
 
diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index 0c6c725..cd6dd19 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -414,10 +414,11 @@ static const struct snd_soc_dapm_route audio_map[] = {
 
 static int uda1380_add_widgets(struct snd_soc_codec *codec)
 {
-	snd_soc_dapm_new_controls(codec, uda1380_dapm_widgets,
-				  ARRAY_SIZE(uda1380_dapm_widgets));
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
-	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	snd_soc_dapm_new_controls(dapm, uda1380_dapm_widgets,
+				  ARRAY_SIZE(uda1380_dapm_widgets));
+	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
 	return 0;
 }
@@ -603,7 +604,7 @@ static int uda1380_set_bias_level(struct snd_soc_codec *codec,
 	int reg;
 	struct uda1380_platform_data *pdata = codec->dev->platform_data;
 
-	if (codec->bias_level == level)
+	if (codec->dapm.bias_level == level)
 		return 0;
 
 	switch (level) {
@@ -613,7 +614,7 @@ static int uda1380_set_bias_level(struct snd_soc_codec *codec,
 		uda1380_write(codec, UDA1380_PM, R02_PON_BIAS | pm);
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		if (codec->bias_level == SND_SOC_BIAS_OFF) {
+		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
 			if (gpio_is_valid(pdata->gpio_power)) {
 				gpio_set_value(pdata->gpio_power, 1);
 				mdelay(1);
@@ -636,7 +637,7 @@ static int uda1380_set_bias_level(struct snd_soc_codec *codec,
 		for (reg = UDA1380_MVOL; reg < UDA1380_CACHEREGNUM; reg++)
 			set_bit(reg - 0x10, &uda1380_cache_dirty);
 	}
-	codec->bias_level = level;
+	codec->dapm.bias_level = level;
 	return 0;
 }
 
diff --git a/sound/soc/codecs/wm2000.c b/sound/soc/codecs/wm2000.c
index 4bcd168..9277d8d 100644
--- a/sound/soc/codecs/wm2000.c
+++ b/sound/soc/codecs/wm2000.c
@@ -705,6 +705,7 @@ static const struct snd_soc_dapm_route audio_map[] = {
 /* Called from the machine driver */
 int wm2000_add_controls(struct snd_soc_codec *codec)
 {
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int ret;
 
 	if (!wm2000_i2c) {
@@ -712,12 +713,12 @@ int wm2000_add_controls(struct snd_soc_codec *codec)
 		return -ENODEV;
 	}
 
-	ret = snd_soc_dapm_new_controls(codec, wm2000_dapm_widgets,
+	ret = snd_soc_dapm_new_controls(dapm, wm2000_dapm_widgets,
 					ARRAY_SIZE(wm2000_dapm_widgets));
 	if (ret < 0)
 		return ret;
 
-	ret = snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	ret = snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 	if (ret < 0)
 		return ret;
 
diff --git a/sound/soc/codecs/wm8350.c b/sound/soc/codecs/wm8350.c
index f4f1fba..4c6c81e 100644
--- a/sound/soc/codecs/wm8350.c
+++ b/sound/soc/codecs/wm8350.c
@@ -230,8 +230,9 @@ static inline int wm8350_out2_ramp_step(struct snd_soc_codec *codec)
  */
 static void wm8350_pga_work(struct work_struct *work)
 {
-	struct snd_soc_codec *codec =
-	    container_of(work, struct snd_soc_codec, delayed_work.work);
+	struct snd_soc_dapm_context *dapm =
+	    container_of(work, struct snd_soc_dapm_context, delayed_work.work);
+	struct snd_soc_codec *codec = dapm->codec;
 	struct wm8350_data *wm8350_data = snd_soc_codec_get_drvdata(codec);
 	struct wm8350_output *out1 = &wm8350_data->out1,
 	    *out2 = &wm8350_data->out2;
@@ -302,8 +303,8 @@ static int pga_event(struct snd_soc_dapm_widget *w,
 		out->ramp = WM8350_RAMP_UP;
 		out->active = 1;
 
-		if (!delayed_work_pending(&codec->delayed_work))
-			schedule_delayed_work(&codec->delayed_work,
+		if (!delayed_work_pending(&codec->dapm.delayed_work))
+			schedule_delayed_work(&codec->dapm.delayed_work,
 					      msecs_to_jiffies(1));
 		break;
 
@@ -311,8 +312,8 @@ static int pga_event(struct snd_soc_dapm_widget *w,
 		out->ramp = WM8350_RAMP_DOWN;
 		out->active = 0;
 
-		if (!delayed_work_pending(&codec->delayed_work))
-			schedule_delayed_work(&codec->delayed_work,
+		if (!delayed_work_pending(&codec->dapm.delayed_work))
+			schedule_delayed_work(&codec->dapm.delayed_work,
 					      msecs_to_jiffies(1));
 		break;
 	}
@@ -786,9 +787,10 @@ static const struct snd_soc_dapm_route audio_map[] = {
 
 static int wm8350_add_widgets(struct snd_soc_codec *codec)
 {
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int ret;
 
-	ret = snd_soc_dapm_new_controls(codec,
+	ret = snd_soc_dapm_new_controls(dapm,
 					wm8350_dapm_widgets,
 					ARRAY_SIZE(wm8350_dapm_widgets));
 	if (ret != 0) {
@@ -797,7 +799,7 @@ static int wm8350_add_widgets(struct snd_soc_codec *codec)
 	}
 
 	/* set up audio paths */
-	ret = snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	ret = snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 	if (ret != 0) {
 		dev_err(codec->dev, "DAPM route register failed\n");
 		return ret;
@@ -1184,7 +1186,7 @@ static int wm8350_set_bias_level(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
-		if (codec->bias_level == SND_SOC_BIAS_OFF) {
+		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
 			ret = regulator_bulk_enable(ARRAY_SIZE(priv->supplies),
 						    priv->supplies);
 			if (ret != 0)
@@ -1317,7 +1319,7 @@ static int wm8350_set_bias_level(struct snd_soc_codec *codec,
 				       priv->supplies);
 		break;
 	}
-	codec->bias_level = level;
+	codec->dapm.bias_level = level;
 	return 0;
 }
 
@@ -1550,7 +1552,7 @@ static  int wm8350_codec_probe(struct snd_soc_codec *codec)
 	/* Put the codec into reset if it wasn't already */
 	wm8350_clear_bits(wm8350, WM8350_POWER_MGMT_5, WM8350_CODEC_ENA);
 
-	INIT_DELAYED_WORK(&codec->delayed_work, wm8350_pga_work);
+	INIT_DELAYED_WORK(&codec->dapm.delayed_work, wm8350_pga_work);
 
 	/* Enable the codec */
 	wm8350_set_bits(wm8350, WM8350_POWER_MGMT_5, WM8350_CODEC_ENA);
@@ -1635,12 +1637,12 @@ static int  wm8350_codec_remove(struct snd_soc_codec *codec)
 	priv->mic.jack = NULL;
 
 	/* cancel any work waiting to be queued. */
-	ret = cancel_delayed_work(&codec->delayed_work);
+	ret = cancel_delayed_work(&codec->dapm.delayed_work);
 
 	/* if there was any work waiting then we run it now and
 	 * wait for its completion */
 	if (ret) {
-		schedule_delayed_work(&codec->delayed_work, 0);
+		schedule_delayed_work(&codec->dapm.delayed_work, 0);
 		flush_scheduled_work();
 	}
 
diff --git a/sound/soc/codecs/wm8400.c b/sound/soc/codecs/wm8400.c
index 8502997..96927a4 100644
--- a/sound/soc/codecs/wm8400.c
+++ b/sound/soc/codecs/wm8400.c
@@ -911,10 +911,11 @@ static const struct snd_soc_dapm_route audio_map[] = {
 
 static int wm8400_add_widgets(struct snd_soc_codec *codec)
 {
-	snd_soc_dapm_new_controls(codec, wm8400_dapm_widgets,
-				  ARRAY_SIZE(wm8400_dapm_widgets));
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
-	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	snd_soc_dapm_new_controls(dapm, wm8400_dapm_widgets,
+				  ARRAY_SIZE(wm8400_dapm_widgets));
+	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
 	return 0;
 }
@@ -1219,7 +1220,7 @@ static int wm8400_set_bias_level(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
-		if (codec->bias_level == SND_SOC_BIAS_OFF) {
+		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
 			ret = regulator_bulk_enable(ARRAY_SIZE(power),
 						    &power[0]);
 			if (ret != 0) {
@@ -1306,7 +1307,7 @@ static int wm8400_set_bias_level(struct snd_soc_codec *codec,
 		break;
 	}
 
-	codec->bias_level = level;
+	codec->dapm.bias_level = level;
 	return 0;
 }
 
diff --git a/sound/soc/codecs/wm8510.c b/sound/soc/codecs/wm8510.c
index 8f10709..6b3833c 100644
--- a/sound/soc/codecs/wm8510.c
+++ b/sound/soc/codecs/wm8510.c
@@ -216,10 +216,11 @@ static const struct snd_soc_dapm_route audio_map[] = {
 
 static int wm8510_add_widgets(struct snd_soc_codec *codec)
 {
-	snd_soc_dapm_new_controls(codec, wm8510_dapm_widgets,
-				  ARRAY_SIZE(wm8510_dapm_widgets));
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
-	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	snd_soc_dapm_new_controls(dapm, wm8510_dapm_widgets,
+				  ARRAY_SIZE(wm8510_dapm_widgets));
+	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
 	return 0;
 }
@@ -478,7 +479,7 @@ static int wm8510_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_STANDBY:
 		power1 |= WM8510_POWER1_BIASEN | WM8510_POWER1_BUFIOEN;
 
-		if (codec->bias_level == SND_SOC_BIAS_OFF) {
+		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
 			/* Initial cap charge at VMID 5k */
 			snd_soc_write(codec, WM8510_POWER1, power1 | 0x3);
 			mdelay(100);
@@ -495,7 +496,7 @@ static int wm8510_set_bias_level(struct snd_soc_codec *codec,
 		break;
 	}
 
-	codec->bias_level = level;
+	codec->dapm.bias_level = level;
 	return 0;
 }
 
diff --git a/sound/soc/codecs/wm8523.c b/sound/soc/codecs/wm8523.c
index 712ef7c..d331888 100644
--- a/sound/soc/codecs/wm8523.c
+++ b/sound/soc/codecs/wm8523.c
@@ -110,10 +110,11 @@ static const struct snd_soc_dapm_route intercon[] = {
 
 static int wm8523_add_widgets(struct snd_soc_codec *codec)
 {
-	snd_soc_dapm_new_controls(codec, wm8523_dapm_widgets,
-				  ARRAY_SIZE(wm8523_dapm_widgets));
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
-	snd_soc_dapm_add_routes(codec, intercon, ARRAY_SIZE(intercon));
+	snd_soc_dapm_new_controls(dapm, wm8523_dapm_widgets,
+				  ARRAY_SIZE(wm8523_dapm_widgets));
+	snd_soc_dapm_add_routes(dapm, intercon, ARRAY_SIZE(intercon));
 
 	return 0;
 }
@@ -328,7 +329,7 @@ static int wm8523_set_bias_level(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
-		if (codec->bias_level == SND_SOC_BIAS_OFF) {
+		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
 			ret = regulator_bulk_enable(ARRAY_SIZE(wm8523->supplies),
 						    wm8523->supplies);
 			if (ret != 0) {
@@ -367,7 +368,7 @@ static int wm8523_set_bias_level(struct snd_soc_codec *codec,
 				       wm8523->supplies);
 		break;
 	}
-	codec->bias_level = level;
+	codec->dapm.bias_level = level;
 	return 0;
 }
 
diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index a2e0ed5..dfd1dbd 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -302,10 +302,11 @@ static const struct snd_soc_dapm_route audio_map[] = {
 
 static int wm8580_add_widgets(struct snd_soc_codec *codec)
 {
-	snd_soc_dapm_new_controls(codec, wm8580_dapm_widgets,
-				  ARRAY_SIZE(wm8580_dapm_widgets));
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
-	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	snd_soc_dapm_new_controls(dapm, wm8580_dapm_widgets,
+				  ARRAY_SIZE(wm8580_dapm_widgets));
+	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
 	return 0;
 }
@@ -767,7 +768,7 @@ static int wm8580_set_bias_level(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
-		if (codec->bias_level == SND_SOC_BIAS_OFF) {
+		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
 			/* Power up and get individual control of the DACs */
 			reg = snd_soc_read(codec, WM8580_PWRDN1);
 			reg &= ~(WM8580_PWRDN1_PWDN | WM8580_PWRDN1_ALLDACPD);
@@ -785,7 +786,7 @@ static int wm8580_set_bias_level(struct snd_soc_codec *codec,
 		snd_soc_write(codec, WM8580_PWRDN1, reg | WM8580_PWRDN1_PWDN);
 		break;
 	}
-	codec->bias_level = level;
+	codec->dapm.bias_level = level;
 	return 0;
 }
 
diff --git a/sound/soc/codecs/wm8711.c b/sound/soc/codecs/wm8711.c
index 54fbd76..ea2daf4 100644
--- a/sound/soc/codecs/wm8711.c
+++ b/sound/soc/codecs/wm8711.c
@@ -93,10 +93,11 @@ static const struct snd_soc_dapm_route intercon[] = {
 
 static int wm8711_add_widgets(struct snd_soc_codec *codec)
 {
-	snd_soc_dapm_new_controls(codec, wm8711_dapm_widgets,
-				  ARRAY_SIZE(wm8711_dapm_widgets));
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
-	snd_soc_dapm_add_routes(codec, intercon, ARRAY_SIZE(intercon));
+	snd_soc_dapm_new_controls(dapm, wm8711_dapm_widgets,
+				  ARRAY_SIZE(wm8711_dapm_widgets));
+	snd_soc_dapm_add_routes(dapm, intercon, ARRAY_SIZE(intercon));
 
 	return 0;
 }
@@ -318,7 +319,7 @@ static int wm8711_set_bias_level(struct snd_soc_codec *codec,
 		snd_soc_write(codec, WM8711_PWR, 0xffff);
 		break;
 	}
-	codec->bias_level = level;
+	codec->dapm.bias_level = level;
 	return 0;
 }
 
diff --git a/sound/soc/codecs/wm8728.c b/sound/soc/codecs/wm8728.c
index 075f35e..2393997 100644
--- a/sound/soc/codecs/wm8728.c
+++ b/sound/soc/codecs/wm8728.c
@@ -73,10 +73,11 @@ static const struct snd_soc_dapm_route intercon[] = {
 
 static int wm8728_add_widgets(struct snd_soc_codec *codec)
 {
-	snd_soc_dapm_new_controls(codec, wm8728_dapm_widgets,
-				  ARRAY_SIZE(wm8728_dapm_widgets));
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
-	snd_soc_dapm_add_routes(codec, intercon, ARRAY_SIZE(intercon));
+	snd_soc_dapm_new_controls(dapm, wm8728_dapm_widgets,
+				  ARRAY_SIZE(wm8728_dapm_widgets));
+	snd_soc_dapm_add_routes(dapm, intercon, ARRAY_SIZE(intercon));
 
 	return 0;
 }
@@ -180,7 +181,7 @@ static int wm8728_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_ON:
 	case SND_SOC_BIAS_PREPARE:
 	case SND_SOC_BIAS_STANDBY:
-		if (codec->bias_level == SND_SOC_BIAS_OFF) {
+		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
 			/* Power everything up... */
 			reg = snd_soc_read(codec, WM8728_DACCTL);
 			snd_soc_write(codec, WM8728_DACCTL, reg & ~0x4);
@@ -197,7 +198,7 @@ static int wm8728_set_bias_level(struct snd_soc_codec *codec,
 		snd_soc_write(codec, WM8728_DACCTL, reg | 0x4);
 		break;
 	}
-	codec->bias_level = level;
+	codec->dapm.bias_level = level;
 	return 0;
 }
 
diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 6313858..95ade32 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -165,10 +165,11 @@ static const struct snd_soc_dapm_route intercon[] = {
 
 static int wm8731_add_widgets(struct snd_soc_codec *codec)
 {
-	snd_soc_dapm_new_controls(codec, wm8731_dapm_widgets,
-				  ARRAY_SIZE(wm8731_dapm_widgets));
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
-	snd_soc_dapm_add_routes(codec, intercon, ARRAY_SIZE(intercon));
+	snd_soc_dapm_new_controls(dapm, wm8731_dapm_widgets,
+				  ARRAY_SIZE(wm8731_dapm_widgets));
+	snd_soc_dapm_add_routes(dapm, intercon, ARRAY_SIZE(intercon));
 
 	return 0;
 }
@@ -319,7 +320,7 @@ static int wm8731_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 		return -EINVAL;
 	}
 
-	snd_soc_dapm_sync(codec);
+	snd_soc_dapm_sync(&codec->dapm);
 
 	return 0;
 }
@@ -399,7 +400,7 @@ static int wm8731_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_PREPARE:
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		if (codec->bias_level == SND_SOC_BIAS_OFF) {
+		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
 			ret = regulator_bulk_enable(ARRAY_SIZE(wm8731->supplies),
 						    wm8731->supplies);
 			if (ret != 0)
@@ -428,7 +429,7 @@ static int wm8731_set_bias_level(struct snd_soc_codec *codec,
 				       wm8731->supplies);
 		break;
 	}
-	codec->bias_level = level;
+	codec->dapm.bias_level = level;
 	return 0;
 }
 
diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
index 90e31e9..43c49df 100644
--- a/sound/soc/codecs/wm8741.c
+++ b/sound/soc/codecs/wm8741.c
@@ -95,10 +95,11 @@ static const struct snd_soc_dapm_route intercon[] = {
 
 static int wm8741_add_widgets(struct snd_soc_codec *codec)
 {
-	snd_soc_dapm_new_controls(codec, wm8741_dapm_widgets,
-				  ARRAY_SIZE(wm8741_dapm_widgets));
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
-	snd_soc_dapm_add_routes(codec, intercon, ARRAY_SIZE(intercon));
+	snd_soc_dapm_new_controls(dapm, wm8741_dapm_widgets,
+				  ARRAY_SIZE(wm8741_dapm_widgets));
+	snd_soc_dapm_add_routes(dapm, intercon, ARRAY_SIZE(intercon));
 
 	return 0;
 }
diff --git a/sound/soc/codecs/wm8750.c b/sound/soc/codecs/wm8750.c
index 6c924cd..178b967 100644
--- a/sound/soc/codecs/wm8750.c
+++ b/sound/soc/codecs/wm8750.c
@@ -399,10 +399,11 @@ static const struct snd_soc_dapm_route audio_map[] = {
 
 static int wm8750_add_widgets(struct snd_soc_codec *codec)
 {
-	snd_soc_dapm_new_controls(codec, wm8750_dapm_widgets,
-				  ARRAY_SIZE(wm8750_dapm_widgets));
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
-	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	snd_soc_dapm_new_controls(dapm, wm8750_dapm_widgets,
+				  ARRAY_SIZE(wm8750_dapm_widgets));
+	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
 	return 0;
 }
@@ -615,7 +616,7 @@ static int wm8750_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_PREPARE:
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		if (codec->bias_level == SND_SOC_BIAS_OFF) {
+		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
 			/* Set VMID to 5k */
 			snd_soc_write(codec, WM8750_PWR1, pwr_reg | 0x01c1);
 
@@ -630,7 +631,7 @@ static int wm8750_set_bias_level(struct snd_soc_codec *codec,
 		snd_soc_write(codec, WM8750_PWR1, 0x0001);
 		break;
 	}
-	codec->bias_level = level;
+	codec->dapm.bias_level = level;
 	return 0;
 }
 
diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index 8f679a1..26096b4 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -670,10 +670,11 @@ static const struct snd_soc_dapm_route audio_map[] = {
 
 static int wm8753_add_widgets(struct snd_soc_codec *codec)
 {
-	snd_soc_dapm_new_controls(codec, wm8753_dapm_widgets,
-				  ARRAY_SIZE(wm8753_dapm_widgets));
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
-	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	snd_soc_dapm_new_controls(dapm, wm8753_dapm_widgets,
+				  ARRAY_SIZE(wm8753_dapm_widgets));
+	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
 	return 0;
 }
@@ -1292,7 +1293,7 @@ static int wm8753_set_bias_level(struct snd_soc_codec *codec,
 		wm8753_write(codec, WM8753_PWR1, 0x0001);
 		break;
 	}
-	codec->bias_level = level;
+	codec->dapm.bias_level = level;
 	return 0;
 }
 
@@ -1482,9 +1483,11 @@ static void wm8753_set_dai_mode(struct snd_soc_codec *codec,
 
 static void wm8753_work(struct work_struct *work)
 {
-	struct snd_soc_codec *codec =
-		container_of(work, struct snd_soc_codec, delayed_work.work);
-	wm8753_set_bias_level(codec, codec->bias_level);
+	struct snd_soc_dapm_context *dapm =
+		container_of(work, struct snd_soc_dapm_context,
+			     delayed_work.work);
+	struct snd_soc_codec *codec = dapm->codec;
+	wm8753_set_bias_level(codec, dapm->bias_level);
 }
 
 static int wm8753_suspend(struct snd_soc_codec *codec, pm_message_t state)
@@ -1516,10 +1519,10 @@ static int wm8753_resume(struct snd_soc_codec *codec)
 	wm8753_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	/* charge wm8753 caps */
-	if (codec->suspend_bias_level == SND_SOC_BIAS_ON) {
+	if (codec->dapm.suspend_bias_level == SND_SOC_BIAS_ON) {
 		wm8753_set_bias_level(codec, SND_SOC_BIAS_PREPARE);
-		codec->bias_level = SND_SOC_BIAS_ON;
-		schedule_delayed_work(&codec->delayed_work,
+		codec->dapm.bias_level = SND_SOC_BIAS_ON;
+		schedule_delayed_work(&codec->dapm.delayed_work,
 			msecs_to_jiffies(caps_charge));
 	}
 
@@ -1550,7 +1553,7 @@ static int wm8753_probe(struct snd_soc_codec *codec)
 	struct wm8753_priv *wm8753 = snd_soc_codec_get_drvdata(codec);
 	int ret = 0, reg;
 
-	INIT_DELAYED_WORK(&codec->delayed_work, wm8753_work);
+	INIT_DELAYED_WORK(&codec->dapm.delayed_work, wm8753_work);
 
 	ret = snd_soc_codec_set_cache_io(codec, 7, 9, wm8753->control_type);
 	if (ret < 0) {
@@ -1569,7 +1572,7 @@ static int wm8753_probe(struct snd_soc_codec *codec)
 
 	/* charge output caps */
 	wm8753_set_bias_level(codec, SND_SOC_BIAS_PREPARE);
-	schedule_delayed_work(&codec->delayed_work,
+	schedule_delayed_work(&codec->dapm.delayed_work,
 			      msecs_to_jiffies(caps_charge));
 
 	/* set the update bits */
@@ -1604,7 +1607,7 @@ static int wm8753_probe(struct snd_soc_codec *codec)
 /* power down chip */
 static int wm8753_remove(struct snd_soc_codec *codec)
 {
-	run_delayed_work(&codec->delayed_work);
+	run_delayed_work(&codec->dapm.delayed_work);
 	wm8753_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
 	return 0;
diff --git a/sound/soc/codecs/wm8776.c b/sound/soc/codecs/wm8776.c
index 04182c4..96474a4 100644
--- a/sound/soc/codecs/wm8776.c
+++ b/sound/soc/codecs/wm8776.c
@@ -307,7 +307,7 @@ static int wm8776_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_PREPARE:
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		if (codec->bias_level == SND_SOC_BIAS_OFF) {
+		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
 			/* Disable the global powerdown; DAPM does the rest */
 			snd_soc_update_bits(codec, WM8776_PWRDOWN, 1, 0);
 		}
@@ -318,7 +318,7 @@ static int wm8776_set_bias_level(struct snd_soc_codec *codec,
 		break;
 	}
 
-	codec->bias_level = level;
+	codec->dapm.bias_level = level;
 	return 0;
 }
 
@@ -405,6 +405,7 @@ static int wm8776_resume(struct snd_soc_codec *codec)
 static int wm8776_probe(struct snd_soc_codec *codec)
 {
 	struct wm8776_priv *wm8776 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int ret = 0;
 
 	ret = snd_soc_codec_set_cache_io(codec, 7, 9, wm8776->control_type);
@@ -428,9 +429,9 @@ static int wm8776_probe(struct snd_soc_codec *codec)
 
 	snd_soc_add_controls(codec, wm8776_snd_controls,
 			     ARRAY_SIZE(wm8776_snd_controls));
-	snd_soc_dapm_new_controls(codec, wm8776_dapm_widgets,
+	snd_soc_dapm_new_controls(dapm, wm8776_dapm_widgets,
 				  ARRAY_SIZE(wm8776_dapm_widgets));
-	snd_soc_dapm_add_routes(codec, routes, ARRAY_SIZE(routes));
+	snd_soc_dapm_add_routes(dapm, routes, ARRAY_SIZE(routes));
 
 	return ret;
 }
diff --git a/sound/soc/codecs/wm8804.c b/sound/soc/codecs/wm8804.c
index 4599e8e..031a0d4 100644
--- a/sound/soc/codecs/wm8804.c
+++ b/sound/soc/codecs/wm8804.c
@@ -515,7 +515,7 @@ static int wm8804_set_bias_level(struct snd_soc_codec *codec,
 		snd_soc_update_bits(codec, WM8804_PWRDN, 0x9, 0);
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		if (codec->bias_level == SND_SOC_BIAS_OFF) {
+		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
 			ret = regulator_bulk_enable(ARRAY_SIZE(wm8804->supplies),
 						    wm8804->supplies);
 			if (ret) {
@@ -537,7 +537,7 @@ static int wm8804_set_bias_level(struct snd_soc_codec *codec,
 		break;
 	}
 
-	codec->bias_level = level;
+	codec->dapm.bias_level = level;
 	return 0;
 }
 
@@ -581,7 +581,7 @@ static int wm8804_probe(struct snd_soc_codec *codec)
 	wm8804 = snd_soc_codec_get_drvdata(codec);
 	wm8804->codec = codec;
 
-	codec->idle_bias_off = 1;
+	codec->dapm.idle_bias_off = 1;
 
 	ret = snd_soc_codec_set_cache_io(codec, 8, 8, wm8804->control_type);
 	if (ret < 0) {
diff --git a/sound/soc/codecs/wm8900.c b/sound/soc/codecs/wm8900.c
index aca4b1e..06ea9c0 100644
--- a/sound/soc/codecs/wm8900.c
+++ b/sound/soc/codecs/wm8900.c
@@ -611,10 +611,11 @@ static const struct snd_soc_dapm_route audio_map[] = {
 
 static int wm8900_add_widgets(struct snd_soc_codec *codec)
 {
-	snd_soc_dapm_new_controls(codec, wm8900_dapm_widgets,
-				  ARRAY_SIZE(wm8900_dapm_widgets));
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
-	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	snd_soc_dapm_new_controls(dapm, wm8900_dapm_widgets,
+				  ARRAY_SIZE(wm8900_dapm_widgets));
+	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
 	return 0;
 }
@@ -1051,7 +1052,7 @@ static int wm8900_set_bias_level(struct snd_soc_codec *codec,
 
 	case SND_SOC_BIAS_STANDBY:
 		/* Charge capacitors if initial power up */
-		if (codec->bias_level == SND_SOC_BIAS_OFF) {
+		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
 			/* STARTUP_BIAS_ENA on */
 			snd_soc_write(codec, WM8900_REG_POWER1,
 				     WM8900_REG_POWER1_STARTUP_BIAS_ENA);
@@ -1119,7 +1120,7 @@ static int wm8900_set_bias_level(struct snd_soc_codec *codec,
 			     WM8900_REG_POWER2_SYSCLK_ENA);
 		break;
 	}
-	codec->bias_level = level;
+	codec->dapm.bias_level = level;
 	return 0;
 }
 
diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 622b602..4a6df4b 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -923,10 +923,11 @@ static const struct snd_soc_dapm_route intercon[] = {
 
 static int wm8903_add_widgets(struct snd_soc_codec *codec)
 {
-	snd_soc_dapm_new_controls(codec, wm8903_dapm_widgets,
-				  ARRAY_SIZE(wm8903_dapm_widgets));
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
-	snd_soc_dapm_add_routes(codec, intercon, ARRAY_SIZE(intercon));
+	snd_soc_dapm_new_controls(dapm, wm8903_dapm_widgets,
+				  ARRAY_SIZE(wm8903_dapm_widgets));
+	snd_soc_dapm_add_routes(dapm, intercon, ARRAY_SIZE(intercon));
 
 	return 0;
 }
@@ -946,7 +947,7 @@ static int wm8903_set_bias_level(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
-		if (codec->bias_level == SND_SOC_BIAS_OFF) {
+		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
 			snd_soc_write(codec, WM8903_CLOCK_RATES_2,
 				     WM8903_CLK_SYS_ENA);
 
@@ -991,7 +992,7 @@ static int wm8903_set_bias_level(struct snd_soc_codec *codec,
 		break;
 	}
 
-	codec->bias_level = level;
+	codec->dapm.bias_level = level;
 
 	return 0;
 }
diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index 33be84e..be90399 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -1428,10 +1428,11 @@ static const struct snd_soc_dapm_route wm8912_intercon[] = {
 static int wm8904_add_widgets(struct snd_soc_codec *codec)
 {
 	struct wm8904_priv *wm8904 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
-	snd_soc_dapm_new_controls(codec, wm8904_core_dapm_widgets,
+	snd_soc_dapm_new_controls(dapm, wm8904_core_dapm_widgets,
 				  ARRAY_SIZE(wm8904_core_dapm_widgets));
-	snd_soc_dapm_add_routes(codec, core_intercon,
+	snd_soc_dapm_add_routes(dapm, core_intercon,
 				ARRAY_SIZE(core_intercon));
 
 	switch (wm8904->devtype) {
@@ -1443,20 +1444,20 @@ static int wm8904_add_widgets(struct snd_soc_codec *codec)
 		snd_soc_add_controls(codec, wm8904_snd_controls,
 				     ARRAY_SIZE(wm8904_snd_controls));
 
-		snd_soc_dapm_new_controls(codec, wm8904_adc_dapm_widgets,
+		snd_soc_dapm_new_controls(dapm, wm8904_adc_dapm_widgets,
 					  ARRAY_SIZE(wm8904_adc_dapm_widgets));
-		snd_soc_dapm_new_controls(codec, wm8904_dac_dapm_widgets,
+		snd_soc_dapm_new_controls(dapm, wm8904_dac_dapm_widgets,
 					  ARRAY_SIZE(wm8904_dac_dapm_widgets));
-		snd_soc_dapm_new_controls(codec, wm8904_dapm_widgets,
+		snd_soc_dapm_new_controls(dapm, wm8904_dapm_widgets,
 					  ARRAY_SIZE(wm8904_dapm_widgets));
 
-		snd_soc_dapm_add_routes(codec, core_intercon,
+		snd_soc_dapm_add_routes(dapm, core_intercon,
 					ARRAY_SIZE(core_intercon));
-		snd_soc_dapm_add_routes(codec, adc_intercon,
+		snd_soc_dapm_add_routes(dapm, adc_intercon,
 					ARRAY_SIZE(adc_intercon));
-		snd_soc_dapm_add_routes(codec, dac_intercon,
+		snd_soc_dapm_add_routes(dapm, dac_intercon,
 					ARRAY_SIZE(dac_intercon));
-		snd_soc_dapm_add_routes(codec, wm8904_intercon,
+		snd_soc_dapm_add_routes(dapm, wm8904_intercon,
 					ARRAY_SIZE(wm8904_intercon));
 		break;
 
@@ -1464,17 +1465,17 @@ static int wm8904_add_widgets(struct snd_soc_codec *codec)
 		snd_soc_add_controls(codec, wm8904_dac_snd_controls,
 				     ARRAY_SIZE(wm8904_dac_snd_controls));
 
-		snd_soc_dapm_new_controls(codec, wm8904_dac_dapm_widgets,
+		snd_soc_dapm_new_controls(dapm, wm8904_dac_dapm_widgets,
 					  ARRAY_SIZE(wm8904_dac_dapm_widgets));
 
-		snd_soc_dapm_add_routes(codec, dac_intercon,
+		snd_soc_dapm_add_routes(dapm, dac_intercon,
 					ARRAY_SIZE(dac_intercon));
-		snd_soc_dapm_add_routes(codec, wm8912_intercon,
+		snd_soc_dapm_add_routes(dapm, wm8912_intercon,
 					ARRAY_SIZE(wm8912_intercon));
 		break;
 	}
 
-	snd_soc_dapm_new_widgets(codec);
+	snd_soc_dapm_new_widgets(dapm);
 	return 0;
 }
 
@@ -2139,7 +2140,7 @@ static int wm8904_set_bias_level(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
-		if (codec->bias_level == SND_SOC_BIAS_OFF) {
+		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
 			ret = regulator_bulk_enable(ARRAY_SIZE(wm8904->supplies),
 						    wm8904->supplies);
 			if (ret != 0) {
@@ -2198,7 +2199,7 @@ static int wm8904_set_bias_level(struct snd_soc_codec *codec,
 				       wm8904->supplies);
 		break;
 	}
-	codec->bias_level = level;
+	codec->dapm.bias_level = level;
 	return 0;
 }
 
@@ -2373,7 +2374,7 @@ static int wm8904_probe(struct snd_soc_codec *codec)
 	int ret, i;
 
 	codec->cache_sync = 1;
-	codec->idle_bias_off = 1;
+	codec->dapm.idle_bias_off = 1;
 
 	switch (wm8904->devtype) {
 	case WM8904:
diff --git a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
index 2cb16f8..c2def1b 100644
--- a/sound/soc/codecs/wm8940.c
+++ b/sound/soc/codecs/wm8940.c
@@ -291,13 +291,14 @@ static const struct snd_soc_dapm_route audio_map[] = {
 
 static int wm8940_add_widgets(struct snd_soc_codec *codec)
 {
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int ret;
 
-	ret = snd_soc_dapm_new_controls(codec, wm8940_dapm_widgets,
+	ret = snd_soc_dapm_new_controls(dapm, wm8940_dapm_widgets,
 					ARRAY_SIZE(wm8940_dapm_widgets));
 	if (ret)
 		goto error_ret;
-	ret = snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	ret = snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 	if (ret)
 		goto error_ret;
 
diff --git a/sound/soc/codecs/wm8955.c b/sound/soc/codecs/wm8955.c
index f89ad6c..df1940f 100644
--- a/sound/soc/codecs/wm8955.c
+++ b/sound/soc/codecs/wm8955.c
@@ -577,13 +577,14 @@ static const struct snd_soc_dapm_route wm8955_intercon[] = {
 
 static int wm8955_add_widgets(struct snd_soc_codec *codec)
 {
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
+
 	snd_soc_add_controls(codec, wm8955_snd_controls,
 			     ARRAY_SIZE(wm8955_snd_controls));
 
-	snd_soc_dapm_new_controls(codec, wm8955_dapm_widgets,
+	snd_soc_dapm_new_controls(dapm, wm8955_dapm_widgets,
 				  ARRAY_SIZE(wm8955_dapm_widgets));
-
-	snd_soc_dapm_add_routes(codec, wm8955_intercon,
+	snd_soc_dapm_add_routes(dapm, wm8955_intercon,
 				ARRAY_SIZE(wm8955_intercon));
 
 	return 0;
@@ -786,7 +787,7 @@ static int wm8955_set_bias_level(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
-		if (codec->bias_level == SND_SOC_BIAS_OFF) {
+		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
 			ret = regulator_bulk_enable(ARRAY_SIZE(wm8955->supplies),
 						    wm8955->supplies);
 			if (ret != 0) {
@@ -850,7 +851,7 @@ static int wm8955_set_bias_level(struct snd_soc_codec *codec,
 				       wm8955->supplies);
 		break;
 	}
-	codec->bias_level = level;
+	codec->dapm.bias_level = level;
 	return 0;
 }
 
diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 8d5efb3..0ea5788 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -388,27 +388,28 @@ static int wm8960_add_widgets(struct snd_soc_codec *codec)
 {
 	struct wm8960_data *pdata = codec->dev->platform_data;
 	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	struct snd_soc_dapm_widget *w;
 
-	snd_soc_dapm_new_controls(codec, wm8960_dapm_widgets,
+	snd_soc_dapm_new_controls(dapm, wm8960_dapm_widgets,
 				  ARRAY_SIZE(wm8960_dapm_widgets));
 
-	snd_soc_dapm_add_routes(codec, audio_paths, ARRAY_SIZE(audio_paths));
+	snd_soc_dapm_add_routes(dapm, audio_paths, ARRAY_SIZE(audio_paths));
 
 	/* In capless mode OUT3 is used to provide VMID for the
 	 * headphone outputs, otherwise it is used as a mono mixer.
 	 */
 	if (pdata && pdata->capless) {
-		snd_soc_dapm_new_controls(codec, wm8960_dapm_widgets_capless,
+		snd_soc_dapm_new_controls(dapm, wm8960_dapm_widgets_capless,
 					  ARRAY_SIZE(wm8960_dapm_widgets_capless));
 
-		snd_soc_dapm_add_routes(codec, audio_paths_capless,
+		snd_soc_dapm_add_routes(dapm, audio_paths_capless,
 					ARRAY_SIZE(audio_paths_capless));
 	} else {
-		snd_soc_dapm_new_controls(codec, wm8960_dapm_widgets_out3,
+		snd_soc_dapm_new_controls(dapm, wm8960_dapm_widgets_out3,
 					  ARRAY_SIZE(wm8960_dapm_widgets_out3));
 
-		snd_soc_dapm_add_routes(codec, audio_paths_out3,
+		snd_soc_dapm_add_routes(dapm, audio_paths_out3,
 					ARRAY_SIZE(audio_paths_out3));
 	}
 
@@ -417,7 +418,7 @@ static int wm8960_add_widgets(struct snd_soc_codec *codec)
 	 * list each time to find the desired power state do so now
 	 * and save the result.
 	 */
-	list_for_each_entry(w, &codec->dapm_widgets, list) {
+	list_for_each_entry(w, &codec->dapm.widgets, list) {
 		if (strcmp(w->name, "LOUT1 PGA") == 0)
 			wm8960->lout1 = w;
 		if (strcmp(w->name, "ROUT1 PGA") == 0)
@@ -572,7 +573,7 @@ static int wm8960_set_bias_level_out3(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
-		if (codec->bias_level == SND_SOC_BIAS_OFF) {
+		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
 			/* Enable anti-pop features */
 			snd_soc_write(codec, WM8960_APOP1,
 				      WM8960_POBCTRL | WM8960_SOFT_ST |
@@ -610,7 +611,7 @@ static int wm8960_set_bias_level_out3(struct snd_soc_codec *codec,
 		break;
 	}
 
-	codec->bias_level = level;
+	codec->dapm.bias_level = level;
 
 	return 0;
 }
@@ -626,7 +627,7 @@ static int wm8960_set_bias_level_capless(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_BIAS_PREPARE:
-		switch (codec->bias_level) {
+		switch (codec->dapm.bias_level) {
 		case SND_SOC_BIAS_STANDBY:
 			/* Enable anti pop mode */
 			snd_soc_update_bits(codec, WM8960_APOP1,
@@ -681,7 +682,7 @@ static int wm8960_set_bias_level_capless(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
-		switch (codec->bias_level) {
+		switch (codec->dapm.bias_level) {
 		case SND_SOC_BIAS_PREPARE:
 			/* Disable HP discharge */
 			snd_soc_update_bits(codec, WM8960_APOP2,
@@ -705,7 +706,7 @@ static int wm8960_set_bias_level_capless(struct snd_soc_codec *codec,
 		break;
 	}
 
-	codec->bias_level = level;
+	codec->dapm.bias_level = level;
 
 	return 0;
 }
diff --git a/sound/soc/codecs/wm8961.c b/sound/soc/codecs/wm8961.c
index 4f326f6..79b6509 100644
--- a/sound/soc/codecs/wm8961.c
+++ b/sound/soc/codecs/wm8961.c
@@ -882,7 +882,7 @@ static int wm8961_set_bias_level(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_BIAS_PREPARE:
-		if (codec->bias_level == SND_SOC_BIAS_STANDBY) {
+		if (codec->dapm.bias_level == SND_SOC_BIAS_STANDBY) {
 			/* Enable bias generation */
 			reg = snd_soc_read(codec, WM8961_ANTI_POP);
 			reg |= WM8961_BUFIOEN | WM8961_BUFDCOPEN;
@@ -897,7 +897,7 @@ static int wm8961_set_bias_level(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
-		if (codec->bias_level == SND_SOC_BIAS_PREPARE) {
+		if (codec->dapm.bias_level == SND_SOC_BIAS_PREPARE) {
 			/* VREF off */
 			reg = snd_soc_read(codec, WM8961_PWR_MGMT_1);
 			reg &= ~WM8961_VREF;
@@ -919,7 +919,7 @@ static int wm8961_set_bias_level(struct snd_soc_codec *codec,
 		break;
 	}
 
-	codec->bias_level = level;
+	codec->dapm.bias_level = level;
 
 	return 0;
 }
@@ -959,6 +959,7 @@ static struct snd_soc_dai_driver wm8961_dai = {
 
 static int wm8961_probe(struct snd_soc_codec *codec)
 {
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int ret = 0;
 	u16 reg;
 
@@ -1024,9 +1025,9 @@ static int wm8961_probe(struct snd_soc_codec *codec)
 
 	snd_soc_add_controls(codec, wm8961_snd_controls,
 				ARRAY_SIZE(wm8961_snd_controls));
-	snd_soc_dapm_new_controls(codec, wm8961_dapm_widgets,
+	snd_soc_dapm_new_controls(dapm, wm8961_dapm_widgets,
 				  ARRAY_SIZE(wm8961_dapm_widgets));
-	snd_soc_dapm_add_routes(codec, audio_paths, ARRAY_SIZE(audio_paths));
+	snd_soc_dapm_add_routes(dapm, audio_paths, ARRAY_SIZE(audio_paths));
 
 	return 0;
 }
diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 2eaf9bb..7a1cd5e 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2682,6 +2682,7 @@ static const struct snd_soc_dapm_route wm8962_spk_stereo_intercon[] = {
 static int wm8962_add_widgets(struct snd_soc_codec *codec)
 {
 	struct wm8962_pdata *pdata = dev_get_platdata(codec->dev);
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
 	snd_soc_add_controls(codec, wm8962_snd_controls,
 			     ARRAY_SIZE(wm8962_snd_controls));
@@ -2693,26 +2694,26 @@ static int wm8962_add_widgets(struct snd_soc_codec *codec)
 				     ARRAY_SIZE(wm8962_spk_stereo_controls));
 
 
-	snd_soc_dapm_new_controls(codec, wm8962_dapm_widgets,
+	snd_soc_dapm_new_controls(dapm, wm8962_dapm_widgets,
 				  ARRAY_SIZE(wm8962_dapm_widgets));
 	if (pdata && pdata->spk_mono)
-		snd_soc_dapm_new_controls(codec, wm8962_dapm_spk_mono_widgets,
+		snd_soc_dapm_new_controls(dapm, wm8962_dapm_spk_mono_widgets,
 					  ARRAY_SIZE(wm8962_dapm_spk_mono_widgets));
 	else
-		snd_soc_dapm_new_controls(codec, wm8962_dapm_spk_stereo_widgets,
+		snd_soc_dapm_new_controls(dapm, wm8962_dapm_spk_stereo_widgets,
 					  ARRAY_SIZE(wm8962_dapm_spk_stereo_widgets));
 
-	snd_soc_dapm_add_routes(codec, wm8962_intercon,
+	snd_soc_dapm_add_routes(dapm, wm8962_intercon,
 				ARRAY_SIZE(wm8962_intercon));
 	if (pdata && pdata->spk_mono)
-		snd_soc_dapm_add_routes(codec, wm8962_spk_mono_intercon,
+		snd_soc_dapm_add_routes(dapm, wm8962_spk_mono_intercon,
 					ARRAY_SIZE(wm8962_spk_mono_intercon));
 	else
-		snd_soc_dapm_add_routes(codec, wm8962_spk_stereo_intercon,
+		snd_soc_dapm_add_routes(dapm, wm8962_spk_stereo_intercon,
 					ARRAY_SIZE(wm8962_spk_stereo_intercon));
 
 
-	snd_soc_dapm_disable_pin(codec, "Beep");
+	snd_soc_dapm_disable_pin(dapm, "Beep");
 
 	return 0;
 }
@@ -2819,7 +2820,7 @@ static int wm8962_set_bias_level(struct snd_soc_codec *codec,
 	struct wm8962_priv *wm8962 = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
-	if (level == codec->bias_level)
+	if (level == codec->dapm.bias_level)
 		return 0;
 
 	switch (level) {
@@ -2833,7 +2834,7 @@ static int wm8962_set_bias_level(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
-		if (codec->bias_level == SND_SOC_BIAS_OFF) {
+		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
 			ret = regulator_bulk_enable(ARRAY_SIZE(wm8962->supplies),
 						    wm8962->supplies);
 			if (ret != 0) {
@@ -2883,7 +2884,7 @@ static int wm8962_set_bias_level(struct snd_soc_codec *codec,
 				       wm8962->supplies);
 		break;
 	}
-	codec->bias_level = level;
+	codec->dapm.bias_level = level;
 	return 0;
 }
 
@@ -3441,6 +3442,7 @@ static void wm8962_beep_work(struct work_struct *work)
 	struct wm8962_priv *wm8962 =
 		container_of(work, struct wm8962_priv, beep_work);
 	struct snd_soc_codec *codec = wm8962->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int i;
 	int reg = 0;
 	int best = 0;
@@ -3457,16 +3459,16 @@ static void wm8962_beep_work(struct work_struct *work)
 
 		reg = WM8962_BEEP_ENA | (best << WM8962_BEEP_RATE_SHIFT);
 
-		snd_soc_dapm_enable_pin(codec, "Beep");
+		snd_soc_dapm_enable_pin(dapm, "Beep");
 	} else {
 		dev_dbg(codec->dev, "Disabling beep\n");
-		snd_soc_dapm_disable_pin(codec, "Beep");
+		snd_soc_dapm_disable_pin(dapm, "Beep");
 	}
 
 	snd_soc_update_bits(codec, WM8962_BEEP_GENERATOR_1,
 			    WM8962_BEEP_ENA | WM8962_BEEP_RATE_MASK, reg);
 
-	snd_soc_dapm_sync(codec);
+	snd_soc_dapm_sync(dapm);
 }
 
 /* For usability define a way of injecting beep events for the device -
@@ -3710,7 +3712,7 @@ static int wm8962_probe(struct snd_soc_codec *codec)
 	INIT_DELAYED_WORK(&wm8962->mic_work, wm8962_mic_work);
 
 	codec->cache_sync = 1;
-	codec->idle_bias_off = 1;
+	codec->dapm.idle_bias_off = 1;
 
 	ret = snd_soc_codec_set_cache_io(codec, 16, 16, SND_SOC_I2C);
 	if (ret != 0) {
diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
index 63f6dbf..84b2dcb 100644
--- a/sound/soc/codecs/wm8971.c
+++ b/sound/soc/codecs/wm8971.c
@@ -333,10 +333,11 @@ static const struct snd_soc_dapm_route audio_map[] = {
 
 static int wm8971_add_widgets(struct snd_soc_codec *codec)
 {
-	snd_soc_dapm_new_controls(codec, wm8971_dapm_widgets,
-				  ARRAY_SIZE(wm8971_dapm_widgets));
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
-	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	snd_soc_dapm_new_controls(dapm, wm8971_dapm_widgets,
+				  ARRAY_SIZE(wm8971_dapm_widgets));
+	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
 	return 0;
 }
@@ -553,7 +554,7 @@ static int wm8971_set_bias_level(struct snd_soc_codec *codec,
 		snd_soc_write(codec, WM8971_PWR1, 0x0001);
 		break;
 	}
-	codec->bias_level = level;
+	codec->dapm.bias_level = level;
 	return 0;
 }
 
@@ -590,9 +591,11 @@ static struct snd_soc_dai_driver wm8971_dai = {
 
 static void wm8971_work(struct work_struct *work)
 {
-	struct snd_soc_codec *codec =
-		container_of(work, struct snd_soc_codec, delayed_work.work);
-	wm8971_set_bias_level(codec, codec->bias_level);
+	struct snd_soc_dapm_context *dapm =
+		container_of(work, struct snd_soc_dapm_context,
+			     delayed_work.work);
+	struct snd_soc_codec *codec = dapm->codec;
+	wm8971_set_bias_level(codec, codec->dapm.bias_level);
 }
 
 static int wm8971_suspend(struct snd_soc_codec *codec, pm_message_t state)
@@ -620,11 +623,11 @@ static int wm8971_resume(struct snd_soc_codec *codec)
 	wm8971_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	/* charge wm8971 caps */
-	if (codec->suspend_bias_level == SND_SOC_BIAS_ON) {
+	if (codec->dapm.suspend_bias_level == SND_SOC_BIAS_ON) {
 		reg = snd_soc_read(codec, WM8971_PWR1) & 0xfe3e;
 		snd_soc_write(codec, WM8971_PWR1, reg | 0x01c0);
-		codec->bias_level = SND_SOC_BIAS_ON;
-		queue_delayed_work(wm8971_workq, &codec->delayed_work,
+		codec->dapm.bias_level = SND_SOC_BIAS_ON;
+		queue_delayed_work(wm8971_workq, &codec->dapm.delayed_work,
 			msecs_to_jiffies(1000));
 	}
 
@@ -643,7 +646,7 @@ static int wm8971_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	INIT_DELAYED_WORK(&codec->delayed_work, wm8971_work);
+	INIT_DELAYED_WORK(&codec->dapm.delayed_work, wm8971_work);
 	wm8971_workq = create_workqueue("wm8971");
 	if (wm8971_workq == NULL)
 		return -ENOMEM;
@@ -653,8 +656,8 @@ static int wm8971_probe(struct snd_soc_codec *codec)
 	/* charge output caps - set vmid to 5k for quick power up */
 	reg = snd_soc_read(codec, WM8971_PWR1) & 0xfe3e;
 	snd_soc_write(codec, WM8971_PWR1, reg | 0x01c0);
-	codec->bias_level = SND_SOC_BIAS_STANDBY;
-	queue_delayed_work(wm8971_workq, &codec->delayed_work,
+	codec->dapm.bias_level = SND_SOC_BIAS_STANDBY;
+	queue_delayed_work(wm8971_workq, &codec->dapm.delayed_work,
 		msecs_to_jiffies(1000));
 
 	/* set the update bits */
diff --git a/sound/soc/codecs/wm8974.c b/sound/soc/codecs/wm8974.c
index b4363f6..d19bb14 100644
--- a/sound/soc/codecs/wm8974.c
+++ b/sound/soc/codecs/wm8974.c
@@ -274,10 +274,11 @@ static const struct snd_soc_dapm_route audio_map[] = {
 
 static int wm8974_add_widgets(struct snd_soc_codec *codec)
 {
-	snd_soc_dapm_new_controls(codec, wm8974_dapm_widgets,
-				  ARRAY_SIZE(wm8974_dapm_widgets));
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
-	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	snd_soc_dapm_new_controls(dapm, wm8974_dapm_widgets,
+				  ARRAY_SIZE(wm8974_dapm_widgets));
+	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
 	return 0;
 }
@@ -530,7 +531,7 @@ static int wm8974_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_STANDBY:
 		power1 |= WM8974_POWER1_BIASEN | WM8974_POWER1_BUFIOEN;
 
-		if (codec->bias_level == SND_SOC_BIAS_OFF) {
+		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
 			/* Initial cap charge at VMID 5k */
 			snd_soc_write(codec, WM8974_POWER1, power1 | 0x3);
 			mdelay(100);
@@ -547,7 +548,7 @@ static int wm8974_set_bias_level(struct snd_soc_codec *codec,
 		break;
 	}
 
-	codec->bias_level = level;
+	codec->dapm.bias_level = level;
 	return 0;
 }
 
diff --git a/sound/soc/codecs/wm8978.c b/sound/soc/codecs/wm8978.c
index 13b979a..ac43b60 100644
--- a/sound/soc/codecs/wm8978.c
+++ b/sound/soc/codecs/wm8978.c
@@ -355,11 +355,12 @@ static const struct snd_soc_dapm_route audio_map[] = {
 
 static int wm8978_add_widgets(struct snd_soc_codec *codec)
 {
-	snd_soc_dapm_new_controls(codec, wm8978_dapm_widgets,
-				  ARRAY_SIZE(wm8978_dapm_widgets));
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
+	snd_soc_dapm_new_controls(dapm, wm8978_dapm_widgets,
+				  ARRAY_SIZE(wm8978_dapm_widgets));
 	/* set up the WM8978 audio map */
-	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
 	return 0;
 }
@@ -837,7 +838,7 @@ static int wm8978_set_bias_level(struct snd_soc_codec *codec,
 		/* bit 3: enable bias, bit 2: enable I/O tie off buffer */
 		power1 |= 0xc;
 
-		if (codec->bias_level == SND_SOC_BIAS_OFF) {
+		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
 			/* Initial cap charge at VMID 5k */
 			snd_soc_write(codec, WM8978_POWER_MANAGEMENT_1,
 				      power1 | 0x3);
@@ -857,7 +858,7 @@ static int wm8978_set_bias_level(struct snd_soc_codec *codec,
 
 	dev_dbg(codec->dev, "%s: %d, %x\n", __func__, level, power1);
 
-	codec->bias_level = level;
+	codec->dapm.bias_level = level;
 	return 0;
 }
 
diff --git a/sound/soc/codecs/wm8985.c b/sound/soc/codecs/wm8985.c
index fd2e7cc..c3c8fd2 100644
--- a/sound/soc/codecs/wm8985.c
+++ b/sound/soc/codecs/wm8985.c
@@ -533,10 +533,11 @@ static int eqmode_put(struct snd_kcontrol *kcontrol,
 
 static int wm8985_add_widgets(struct snd_soc_codec *codec)
 {
-	snd_soc_dapm_new_controls(codec, wm8985_dapm_widgets,
-				  ARRAY_SIZE(wm8985_dapm_widgets));
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
-	snd_soc_dapm_add_routes(codec, audio_map,
+	snd_soc_dapm_new_controls(dapm, wm8985_dapm_widgets,
+				  ARRAY_SIZE(wm8985_dapm_widgets));
+	snd_soc_dapm_add_routes(dapm, audio_map,
 				ARRAY_SIZE(audio_map));
 	return 0;
 }
@@ -879,7 +880,7 @@ static int wm8985_set_bias_level(struct snd_soc_codec *codec,
 				    1 << WM8985_VMIDSEL_SHIFT);
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		if (codec->bias_level == SND_SOC_BIAS_OFF) {
+		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
 			ret = regulator_bulk_enable(ARRAY_SIZE(wm8985->supplies),
 						    wm8985->supplies);
 			if (ret) {
@@ -939,7 +940,7 @@ static int wm8985_set_bias_level(struct snd_soc_codec *codec,
 		break;
 	}
 
-	codec->bias_level = level;
+	codec->dapm.bias_level = level;
 	return 0;
 }
 
diff --git a/sound/soc/codecs/wm8988.c b/sound/soc/codecs/wm8988.c
index d7f2597..0bc2eb5 100644
--- a/sound/soc/codecs/wm8988.c
+++ b/sound/soc/codecs/wm8988.c
@@ -677,7 +677,7 @@ static int wm8988_set_bias_level(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
-		if (codec->bias_level == SND_SOC_BIAS_OFF) {
+		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
 			/* VREF, VMID=2x5k */
 			snd_soc_write(codec, WM8988_PWR1, pwr_reg | 0x1c1);
 
@@ -693,7 +693,7 @@ static int wm8988_set_bias_level(struct snd_soc_codec *codec,
 		snd_soc_write(codec, WM8988_PWR1, 0x0000);
 		break;
 	}
-	codec->bias_level = level;
+	codec->dapm.bias_level = level;
 	return 0;
 }
 
@@ -759,6 +759,7 @@ static int wm8988_resume(struct snd_soc_codec *codec)
 static int wm8988_probe(struct snd_soc_codec *codec)
 {
 	struct wm8988_priv *wm8988 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int ret = 0;
 	u16 reg;
 
@@ -790,9 +791,9 @@ static int wm8988_probe(struct snd_soc_codec *codec)
 
 	snd_soc_add_controls(codec, wm8988_snd_controls,
 				ARRAY_SIZE(wm8988_snd_controls));
-	snd_soc_dapm_new_controls(codec, wm8988_dapm_widgets,
+	snd_soc_dapm_new_controls(dapm, wm8988_dapm_widgets,
 				  ARRAY_SIZE(wm8988_dapm_widgets));
-	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
 	return 0;
 }
diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index 264828e..309664e 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -914,11 +914,12 @@ static const struct snd_soc_dapm_route audio_map[] = {
 
 static int wm8990_add_widgets(struct snd_soc_codec *codec)
 {
-	snd_soc_dapm_new_controls(codec, wm8990_dapm_widgets,
-				  ARRAY_SIZE(wm8990_dapm_widgets));
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
+	snd_soc_dapm_new_controls(dapm, wm8990_dapm_widgets,
+				  ARRAY_SIZE(wm8990_dapm_widgets));
 	/* set up the WM8990 audio map */
-	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
 	return 0;
 }
@@ -1170,7 +1171,7 @@ static int wm8990_set_bias_level(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
-		if (codec->bias_level == SND_SOC_BIAS_OFF) {
+		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
 			/* Enable all output discharge bits */
 			snd_soc_write(codec, WM8990_ANTIPOP1, WM8990_DIS_LLINE |
 				WM8990_DIS_RLINE | WM8990_DIS_OUT3 |
@@ -1266,7 +1267,7 @@ static int wm8990_set_bias_level(struct snd_soc_codec *codec,
 		break;
 	}
 
-	codec->bias_level = level;
+	codec->dapm.bias_level = level;
 	return 0;
 }
 
diff --git a/sound/soc/codecs/wm8993.c b/sound/soc/codecs/wm8993.c
index 67fe5cc..bcc54be 100644
--- a/sound/soc/codecs/wm8993.c
+++ b/sound/soc/codecs/wm8993.c
@@ -970,7 +970,7 @@ static int wm8993_set_bias_level(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
-		if (codec->bias_level == SND_SOC_BIAS_OFF) {
+		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
 			ret = regulator_bulk_enable(ARRAY_SIZE(wm8993->supplies),
 						    wm8993->supplies);
 			if (ret != 0)
@@ -1045,7 +1045,7 @@ static int wm8993_set_bias_level(struct snd_soc_codec *codec,
 		break;
 	}
 
-	codec->bias_level = level;
+	codec->dapm.bias_level = level;
 
 	return 0;
 }
@@ -1424,6 +1424,7 @@ static struct snd_soc_dai_driver wm8993_dai = {
 static int wm8993_probe(struct snd_soc_codec *codec)
 {
 	struct wm8993_priv *wm8993 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int ret, i, val;
 
 	wm8993->hubs_data.hp_startup_mode = 1;
@@ -1505,11 +1506,11 @@ static int wm8993_probe(struct snd_soc_codec *codec)
 				     ARRAY_SIZE(wm8993_eq_controls));
 	}
 
-	snd_soc_dapm_new_controls(codec, wm8993_dapm_widgets,
+	snd_soc_dapm_new_controls(dapm, wm8993_dapm_widgets,
 				  ARRAY_SIZE(wm8993_dapm_widgets));
 	wm_hubs_add_analogue_controls(codec);
 
-	snd_soc_dapm_add_routes(codec, routes, ARRAY_SIZE(routes));
+	snd_soc_dapm_add_routes(dapm, routes, ARRAY_SIZE(routes));
 	wm_hubs_add_analogue_routes(codec, wm8993->pdata.lineout1_diff,
 				    wm8993->pdata.lineout2_diff);
 
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index d81cac5..f7dea3d 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -1835,7 +1835,7 @@ static int configure_clock(struct snd_soc_codec *codec)
 
 	snd_soc_update_bits(codec, WM8994_CLOCKING_1, WM8994_SYSCLK_SRC, new);
 
-	snd_soc_dapm_sync(codec);
+	snd_soc_dapm_sync(&codec->dapm);
 
 	return 0;
 }
@@ -3108,7 +3108,7 @@ static int wm8994_set_bias_level(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
-		if (codec->bias_level == SND_SOC_BIAS_OFF) {
+		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
 			/* Tweak DC servo and DSP configuration for
 			 * improved performance. */
 			if (wm8994->revision < 4) {
@@ -3152,7 +3152,7 @@ static int wm8994_set_bias_level(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_BIAS_OFF:
-		if (codec->bias_level == SND_SOC_BIAS_STANDBY) {
+		if (codec->dapm.bias_level == SND_SOC_BIAS_STANDBY) {
 			/* Switch over to startup biases */
 			snd_soc_update_bits(codec, WM8994_ANTIPOP_2,
 					    WM8994_BIAS_SRC |
@@ -3187,7 +3187,7 @@ static int wm8994_set_bias_level(struct snd_soc_codec *codec,
 		}
 		break;
 	}
-	codec->bias_level = level;
+	codec->dapm.bias_level = level;
 	return 0;
 }
 
@@ -3895,6 +3895,7 @@ static irqreturn_t wm8994_mic_irq(int irq, void *data)
 static int wm8994_codec_probe(struct snd_soc_codec *codec)
 {
 	struct wm8994_priv *wm8994;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int ret, i;
 
 	codec->control_data = dev_get_drvdata(codec->dev->parent);
@@ -4033,10 +4034,10 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 	wm_hubs_add_analogue_controls(codec);
 	snd_soc_add_controls(codec, wm8994_snd_controls,
 			     ARRAY_SIZE(wm8994_snd_controls));
-	snd_soc_dapm_new_controls(codec, wm8994_dapm_widgets,
+	snd_soc_dapm_new_controls(dapm, wm8994_dapm_widgets,
 				  ARRAY_SIZE(wm8994_dapm_widgets));
 	wm_hubs_add_analogue_routes(codec, 0, 0);
-	snd_soc_dapm_add_routes(codec, intercon, ARRAY_SIZE(intercon));
+	snd_soc_dapm_add_routes(dapm, intercon, ARRAY_SIZE(intercon));
 
 	return 0;
 
diff --git a/sound/soc/codecs/wm9081.c b/sound/soc/codecs/wm9081.c
index ecc7c37..c03e2c3 100644
--- a/sound/soc/codecs/wm9081.c
+++ b/sound/soc/codecs/wm9081.c
@@ -805,7 +805,7 @@ static int wm9081_set_bias_level(struct snd_soc_codec *codec,
 
 	case SND_SOC_BIAS_STANDBY:
 		/* Initial cold start */
-		if (codec->bias_level == SND_SOC_BIAS_OFF) {
+		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
 			/* Disable LINEOUT discharge */
 			reg = snd_soc_read(codec, WM9081_ANTI_POP_CONTROL);
 			reg &= ~WM9081_LINEOUT_DISCH;
@@ -865,7 +865,7 @@ static int wm9081_set_bias_level(struct snd_soc_codec *codec,
 		break;
 	}
 
-	codec->bias_level = level;
+	codec->dapm.bias_level = level;
 
 	return 0;
 }
@@ -1228,6 +1228,7 @@ static struct snd_soc_dai_driver wm9081_dai = {
 static int wm9081_probe(struct snd_soc_codec *codec)
 {
 	struct wm9081_priv *wm9081 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int ret;
 	u16 reg;
 
@@ -1269,9 +1270,9 @@ static int wm9081_probe(struct snd_soc_codec *codec)
 				     ARRAY_SIZE(wm9081_eq_controls));
 	}
 
-	snd_soc_dapm_new_controls(codec, wm9081_dapm_widgets,
+	snd_soc_dapm_new_controls(dapm, wm9081_dapm_widgets,
 				  ARRAY_SIZE(wm9081_dapm_widgets));
-	snd_soc_dapm_add_routes(codec, audio_paths, ARRAY_SIZE(audio_paths));
+	snd_soc_dapm_add_routes(dapm, audio_paths, ARRAY_SIZE(audio_paths));
 
 	return ret;
 }
diff --git a/sound/soc/codecs/wm9090.c b/sound/soc/codecs/wm9090.c
index 99c046b..b5afa01 100644
--- a/sound/soc/codecs/wm9090.c
+++ b/sound/soc/codecs/wm9090.c
@@ -443,31 +443,32 @@ static const struct snd_soc_dapm_route audio_map_in2_diff[] = {
 static int wm9090_add_controls(struct snd_soc_codec *codec)
 {
 	struct wm9090_priv *wm9090 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int i;
 
-	snd_soc_dapm_new_controls(codec, wm9090_dapm_widgets,
+	snd_soc_dapm_new_controls(dapm, wm9090_dapm_widgets,
 				  ARRAY_SIZE(wm9090_dapm_widgets));
 
-	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
 	snd_soc_add_controls(codec, wm9090_controls,
 			     ARRAY_SIZE(wm9090_controls));
 
 	if (wm9090->pdata.lin1_diff) {
-		snd_soc_dapm_add_routes(codec, audio_map_in1_diff,
+		snd_soc_dapm_add_routes(dapm, audio_map_in1_diff,
 					ARRAY_SIZE(audio_map_in1_diff));
 	} else {
-		snd_soc_dapm_add_routes(codec, audio_map_in1_se,
+		snd_soc_dapm_add_routes(dapm, audio_map_in1_se,
 					ARRAY_SIZE(audio_map_in1_se));
 		snd_soc_add_controls(codec, wm9090_in1_se_controls,
 				     ARRAY_SIZE(wm9090_in1_se_controls));
 	}
 
 	if (wm9090->pdata.lin2_diff) {
-		snd_soc_dapm_add_routes(codec, audio_map_in2_diff,
+		snd_soc_dapm_add_routes(dapm, audio_map_in2_diff,
 					ARRAY_SIZE(audio_map_in2_diff));
 	} else {
-		snd_soc_dapm_add_routes(codec, audio_map_in2_se,
+		snd_soc_dapm_add_routes(dapm, audio_map_in2_se,
 					ARRAY_SIZE(audio_map_in2_se));
 		snd_soc_add_controls(codec, wm9090_in2_se_controls,
 				     ARRAY_SIZE(wm9090_in2_se_controls));
@@ -514,7 +515,7 @@ static int wm9090_set_bias_level(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
-		if (codec->bias_level == SND_SOC_BIAS_OFF) {
+		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
 			/* Restore the register cache */
 			for (i = 1; i < codec->driver->reg_cache_size; i++) {
 				if (reg_cache[i] == wm9090_reg_defaults[i])
@@ -544,7 +545,7 @@ static int wm9090_set_bias_level(struct snd_soc_codec *codec,
 		break;
 	}
 
-	codec->bias_level = level;
+	codec->dapm.bias_level = level;
 
 	return 0;
 }
diff --git a/sound/soc/codecs/wm9705.c b/sound/soc/codecs/wm9705.c
index a144acd..58d1208 100644
--- a/sound/soc/codecs/wm9705.c
+++ b/sound/soc/codecs/wm9705.c
@@ -203,9 +203,11 @@ static const struct snd_soc_dapm_route audio_map[] = {
 
 static int wm9705_add_widgets(struct snd_soc_codec *codec)
 {
-	snd_soc_dapm_new_controls(codec, wm9705_dapm_widgets,
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
+
+	snd_soc_dapm_new_controls(dapm, wm9705_dapm_widgets,
 					ARRAY_SIZE(wm9705_dapm_widgets));
-	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
 	return 0;
 }
diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index d2f224d..3ca42a3 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -432,10 +432,11 @@ static const struct snd_soc_dapm_route audio_map[] = {
 
 static int wm9712_add_widgets(struct snd_soc_codec *codec)
 {
-	snd_soc_dapm_new_controls(codec, wm9712_dapm_widgets,
-				  ARRAY_SIZE(wm9712_dapm_widgets));
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
-	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	snd_soc_dapm_new_controls(dapm, wm9712_dapm_widgets,
+				  ARRAY_SIZE(wm9712_dapm_widgets));
+	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
 	return 0;
 }
@@ -570,7 +571,7 @@ static int wm9712_set_bias_level(struct snd_soc_codec *codec,
 		ac97_write(codec, AC97_POWERDOWN, 0xffff);
 		break;
 	}
-	codec->bias_level = level;
+	codec->dapm.bias_level = level;
 	return 0;
 }
 
diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 7da13b0..87b236b 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -647,10 +647,12 @@ static const struct snd_soc_dapm_route audio_map[] = {
 
 static int wm9713_add_widgets(struct snd_soc_codec *codec)
 {
-	snd_soc_dapm_new_controls(codec, wm9713_dapm_widgets,
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
+
+	snd_soc_dapm_new_controls(dapm, wm9713_dapm_widgets,
 				  ARRAY_SIZE(wm9713_dapm_widgets));
 
-	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
 	return 0;
 }
@@ -1147,7 +1149,7 @@ static int wm9713_set_bias_level(struct snd_soc_codec *codec,
 		ac97_write(codec, AC97_POWERDOWN, 0xffff);
 		break;
 	}
-	codec->bias_level = level;
+	codec->dapm.bias_level = level;
 	return 0;
 }
 
diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
index 008b1f2..8aff0ef 100644
--- a/sound/soc/codecs/wm_hubs.c
+++ b/sound/soc/codecs/wm_hubs.c
@@ -814,6 +814,8 @@ static const struct snd_soc_dapm_route lineout2_se_routes[] = {
 
 int wm_hubs_add_analogue_controls(struct snd_soc_codec *codec)
 {
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
+
 	/* Latch volume update bits & default ZC on */
 	snd_soc_update_bits(codec, WM8993_LEFT_LINE_INPUT_1_2_VOLUME,
 			    WM8993_IN1_VU, WM8993_IN1_VU);
@@ -842,7 +844,7 @@ int wm_hubs_add_analogue_controls(struct snd_soc_codec *codec)
 	snd_soc_add_controls(codec, analogue_snd_controls,
 			     ARRAY_SIZE(analogue_snd_controls));
 
-	snd_soc_dapm_new_controls(codec, analogue_dapm_widgets,
+	snd_soc_dapm_new_controls(dapm, analogue_dapm_widgets,
 				  ARRAY_SIZE(analogue_dapm_widgets));
 	return 0;
 }
@@ -851,24 +853,26 @@ EXPORT_SYMBOL_GPL(wm_hubs_add_analogue_controls);
 int wm_hubs_add_analogue_routes(struct snd_soc_codec *codec,
 				int lineout1_diff, int lineout2_diff)
 {
-	snd_soc_dapm_add_routes(codec, analogue_routes,
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
+
+	snd_soc_dapm_add_routes(dapm, analogue_routes,
 				ARRAY_SIZE(analogue_routes));
 
 	if (lineout1_diff)
-		snd_soc_dapm_add_routes(codec,
+		snd_soc_dapm_add_routes(dapm,
 					lineout1_diff_routes,
 					ARRAY_SIZE(lineout1_diff_routes));
 	else
-		snd_soc_dapm_add_routes(codec,
+		snd_soc_dapm_add_routes(dapm,
 					lineout1_se_routes,
 					ARRAY_SIZE(lineout1_se_routes));
 
 	if (lineout2_diff)
-		snd_soc_dapm_add_routes(codec,
+		snd_soc_dapm_add_routes(dapm,
 					lineout2_diff_routes,
 					ARRAY_SIZE(lineout2_diff_routes));
 	else
-		snd_soc_dapm_add_routes(codec,
+		snd_soc_dapm_add_routes(dapm,
 					lineout2_se_routes,
 					ARRAY_SIZE(lineout2_se_routes));
 
@@ -895,7 +899,7 @@ int wm_hubs_handle_analogue_pdata(struct snd_soc_codec *codec,
 	 * VMID as an output and can disable it.
 	 */
 	if (lineout1_diff && lineout2_diff)
-		codec->idle_bias_off = 1;
+		codec->dapm.idle_bias_off = 1;
 
 	if (lineout1fb)
 		snd_soc_update_bits(codec, WM8993_ADDITIONAL_CONTROL,
diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index 2b07b17..a2cf64b 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -132,26 +132,27 @@ static const struct snd_soc_dapm_route audio_map[] = {
 static int evm_aic3x_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
 	/* Add davinci-evm specific widgets */
-	snd_soc_dapm_new_controls(codec, aic3x_dapm_widgets,
+	snd_soc_dapm_new_controls(dapm, aic3x_dapm_widgets,
 				  ARRAY_SIZE(aic3x_dapm_widgets));
 
 	/* Set up davinci-evm specific audio path audio_map */
-	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
 	/* not connected */
-	snd_soc_dapm_disable_pin(codec, "MONO_LOUT");
-	snd_soc_dapm_disable_pin(codec, "HPLCOM");
-	snd_soc_dapm_disable_pin(codec, "HPRCOM");
+	snd_soc_dapm_disable_pin(dapm, "MONO_LOUT");
+	snd_soc_dapm_disable_pin(dapm, "HPLCOM");
+	snd_soc_dapm_disable_pin(dapm, "HPRCOM");
 
 	/* always connected */
-	snd_soc_dapm_enable_pin(codec, "Headphone Jack");
-	snd_soc_dapm_enable_pin(codec, "Line Out");
-	snd_soc_dapm_enable_pin(codec, "Mic Jack");
-	snd_soc_dapm_enable_pin(codec, "Line In");
+	snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
+	snd_soc_dapm_enable_pin(dapm, "Line Out");
+	snd_soc_dapm_enable_pin(dapm, "Mic Jack");
+	snd_soc_dapm_enable_pin(dapm, "Line In");
 
-	snd_soc_dapm_sync(codec);
+	snd_soc_dapm_sync(dapm);
 
 	return 0;
 }
diff --git a/sound/soc/ep93xx/snappercl15.c b/sound/soc/ep93xx/snappercl15.c
index 28ab5ff..f1c7851 100644
--- a/sound/soc/ep93xx/snappercl15.c
+++ b/sound/soc/ep93xx/snappercl15.c
@@ -79,11 +79,12 @@ static const struct snd_soc_dapm_route audio_map[] = {
 static int snappercl15_tlv320aic23_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
-	snd_soc_dapm_new_controls(codec, tlv320aic23_dapm_widgets,
+	snd_soc_dapm_new_controls(dapm, tlv320aic23_dapm_widgets,
 				  ARRAY_SIZE(tlv320aic23_dapm_widgets));
 
-	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 	return 0;
 }
 
diff --git a/sound/soc/imx/wm1133-ev1.c b/sound/soc/imx/wm1133-ev1.c
index 30fdb15..46fadf4 100644
--- a/sound/soc/imx/wm1133-ev1.c
+++ b/sound/soc/imx/wm1133-ev1.c
@@ -213,11 +213,12 @@ static struct snd_soc_jack_pin mic_jack_pins[] = {
 static int wm1133_ev1_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
-	snd_soc_dapm_new_controls(codec, wm1133_ev1_widgets,
+	snd_soc_dapm_new_controls(dapm, wm1133_ev1_widgets,
 				  ARRAY_SIZE(wm1133_ev1_widgets));
 
-	snd_soc_dapm_add_routes(codec, wm1133_ev1_map,
+	snd_soc_dapm_add_routes(dapm, wm1133_ev1_map,
 				ARRAY_SIZE(wm1133_ev1_map));
 
 	/* Headphone jack detection */
@@ -234,7 +235,7 @@ static int wm1133_ev1_init(struct snd_soc_pcm_runtime *rtd)
 	wm8350_mic_jack_detect(codec, &mic_jack, SND_JACK_MICROPHONE,
 			       SND_JACK_BTN_0);
 
-	snd_soc_dapm_force_enable_pin(codec, "Mic Bias");
+	snd_soc_dapm_force_enable_pin(dapm, "Mic Bias");
 
 	return 0;
 }
diff --git a/sound/soc/jz4740/qi_lb60.c b/sound/soc/jz4740/qi_lb60.c
index ef1a99e..70afbfa 100644
--- a/sound/soc/jz4740/qi_lb60.c
+++ b/sound/soc/jz4740/qi_lb60.c
@@ -59,10 +59,11 @@ static int qi_lb60_codec_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int ret;
 
-	snd_soc_dapm_nc_pin(codec, "LIN");
-	snd_soc_dapm_nc_pin(codec, "RIN");
+	snd_soc_dapm_nc_pin(dapm, "LIN");
+	snd_soc_dapm_nc_pin(dapm, "RIN");
 
 	ret = snd_soc_dai_set_fmt(cpu_dai, QI_LB60_DAIFMT);
 	if (ret < 0) {
@@ -70,9 +71,11 @@ static int qi_lb60_codec_init(struct snd_soc_pcm_runtime *rtd)
 		return ret;
 	}
 
-	snd_soc_dapm_new_controls(codec, qi_lb60_widgets, ARRAY_SIZE(qi_lb60_widgets));
-	snd_soc_dapm_add_routes(codec, qi_lb60_routes, ARRAY_SIZE(qi_lb60_routes));
-	snd_soc_dapm_sync(codec);
+	snd_soc_dapm_new_controls(dapm, qi_lb60_widgets,
+				  ARRAY_SIZE(qi_lb60_widgets));
+	snd_soc_dapm_add_routes(dapm, qi_lb60_routes,
+				ARRAY_SIZE(qi_lb60_routes));
+	snd_soc_dapm_sync(dapm);
 
 	return 0;
 }
diff --git a/sound/soc/kirkwood/kirkwood-t5325.c b/sound/soc/kirkwood/kirkwood-t5325.c
index 51b52e3..07b6eca 100644
--- a/sound/soc/kirkwood/kirkwood-t5325.c
+++ b/sound/soc/kirkwood/kirkwood-t5325.c
@@ -69,17 +69,18 @@ static const struct snd_soc_dapm_route t5325_route[] = {
 static int t5325_dai_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
-	snd_soc_dapm_new_controls(codec, t5325_dapm_widgets,
+	snd_soc_dapm_new_controls(dapm, t5325_dapm_widgets,
 				ARRAY_SIZE(t5325_dapm_widgets));
 
-	snd_soc_dapm_add_routes(codec, t5325_route, ARRAY_SIZE(t5325_route));
+	snd_soc_dapm_add_routes(dapm, t5325_route, ARRAY_SIZE(t5325_route));
 
-	snd_soc_dapm_enable_pin(codec, "Mic Jack");
-	snd_soc_dapm_enable_pin(codec, "Headphone Jack");
-	snd_soc_dapm_enable_pin(codec, "Speaker");
+	snd_soc_dapm_enable_pin(dapm, "Mic Jack");
+	snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
+	snd_soc_dapm_enable_pin(dapm, "Speaker");
 
-	snd_soc_dapm_sync(codec);
+	snd_soc_dapm_sync(dapm);
 
 	return 0;
 }
diff --git a/sound/soc/omap/am3517evm.c b/sound/soc/omap/am3517evm.c
index 979dd50..668773d 100644
--- a/sound/soc/omap/am3517evm.c
+++ b/sound/soc/omap/am3517evm.c
@@ -114,20 +114,21 @@ static const struct snd_soc_dapm_route audio_map[] = {
 static int am3517evm_aic23_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
 	/* Add am3517-evm specific widgets */
-	snd_soc_dapm_new_controls(codec, tlv320aic23_dapm_widgets,
+	snd_soc_dapm_new_controls(dapm, tlv320aic23_dapm_widgets,
 				  ARRAY_SIZE(tlv320aic23_dapm_widgets));
 
 	/* Set up davinci-evm specific audio path audio_map */
-	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
 	/* always connected */
-	snd_soc_dapm_enable_pin(codec, "Line Out");
-	snd_soc_dapm_enable_pin(codec, "Line In");
-	snd_soc_dapm_enable_pin(codec, "Mic In");
+	snd_soc_dapm_enable_pin(dapm, "Line Out");
+	snd_soc_dapm_enable_pin(dapm, "Line In");
+	snd_soc_dapm_enable_pin(dapm, "Mic In");
 
-	snd_soc_dapm_sync(codec);
+	snd_soc_dapm_sync(dapm);
 
 	return 0;
 }
diff --git a/sound/soc/omap/ams-delta.c b/sound/soc/omap/ams-delta.c
index 438146a..2101bdc 100644
--- a/sound/soc/omap/ams-delta.c
+++ b/sound/soc/omap/ams-delta.c
@@ -26,7 +26,7 @@
 #include <linux/spinlock.h>
 #include <linux/tty.h>
 
-#include <sound/soc-dapm.h>
+#include <sound/soc.h>
 #include <sound/jack.h>
 
 #include <asm/mach-types.h>
@@ -94,6 +94,7 @@ static int ams_delta_set_audio_mode(struct snd_kcontrol *kcontrol,
 					struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	struct soc_enum *control = (struct soc_enum *)kcontrol->private_value;
 	unsigned short pins;
 	int pin, changed = 0;
@@ -112,48 +113,48 @@ static int ams_delta_set_audio_mode(struct snd_kcontrol *kcontrol,
 
 	/* Setup pins after corresponding bits if changed */
 	pin = !!(pins & (1 << AMS_DELTA_MOUTHPIECE));
-	if (pin != snd_soc_dapm_get_pin_status(codec, "Mouthpiece")) {
+	if (pin != snd_soc_dapm_get_pin_status(dapm, "Mouthpiece")) {
 		changed = 1;
 		if (pin)
-			snd_soc_dapm_enable_pin(codec, "Mouthpiece");
+			snd_soc_dapm_enable_pin(dapm, "Mouthpiece");
 		else
-			snd_soc_dapm_disable_pin(codec, "Mouthpiece");
+			snd_soc_dapm_disable_pin(dapm, "Mouthpiece");
 	}
 	pin = !!(pins & (1 << AMS_DELTA_EARPIECE));
-	if (pin != snd_soc_dapm_get_pin_status(codec, "Earpiece")) {
+	if (pin != snd_soc_dapm_get_pin_status(dapm, "Earpiece")) {
 		changed = 1;
 		if (pin)
-			snd_soc_dapm_enable_pin(codec, "Earpiece");
+			snd_soc_dapm_enable_pin(dapm, "Earpiece");
 		else
-			snd_soc_dapm_disable_pin(codec, "Earpiece");
+			snd_soc_dapm_disable_pin(dapm, "Earpiece");
 	}
 	pin = !!(pins & (1 << AMS_DELTA_MICROPHONE));
-	if (pin != snd_soc_dapm_get_pin_status(codec, "Microphone")) {
+	if (pin != snd_soc_dapm_get_pin_status(dapm, "Microphone")) {
 		changed = 1;
 		if (pin)
-			snd_soc_dapm_enable_pin(codec, "Microphone");
+			snd_soc_dapm_enable_pin(dapm, "Microphone");
 		else
-			snd_soc_dapm_disable_pin(codec, "Microphone");
+			snd_soc_dapm_disable_pin(dapm, "Microphone");
 	}
 	pin = !!(pins & (1 << AMS_DELTA_SPEAKER));
-	if (pin != snd_soc_dapm_get_pin_status(codec, "Speaker")) {
+	if (pin != snd_soc_dapm_get_pin_status(dapm, "Speaker")) {
 		changed = 1;
 		if (pin)
-			snd_soc_dapm_enable_pin(codec, "Speaker");
+			snd_soc_dapm_enable_pin(dapm, "Speaker");
 		else
-			snd_soc_dapm_disable_pin(codec, "Speaker");
+			snd_soc_dapm_disable_pin(dapm, "Speaker");
 	}
 	pin = !!(pins & (1 << AMS_DELTA_AGC));
 	if (pin != ams_delta_audio_agc) {
 		ams_delta_audio_agc = pin;
 		changed = 1;
 		if (pin)
-			snd_soc_dapm_enable_pin(codec, "AGCIN");
+			snd_soc_dapm_enable_pin(dapm, "AGCIN");
 		else
-			snd_soc_dapm_disable_pin(codec, "AGCIN");
+			snd_soc_dapm_disable_pin(dapm, "AGCIN");
 	}
 	if (changed)
-		snd_soc_dapm_sync(codec);
+		snd_soc_dapm_sync(dapm);
 
 	mutex_unlock(&codec->mutex);
 
@@ -164,19 +165,20 @@ static int ams_delta_get_audio_mode(struct snd_kcontrol *kcontrol,
 					struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	unsigned short pins, mode;
 
-	pins = ((snd_soc_dapm_get_pin_status(codec, "Mouthpiece") <<
+	pins = ((snd_soc_dapm_get_pin_status(dapm, "Mouthpiece") <<
 							AMS_DELTA_MOUTHPIECE) |
-			(snd_soc_dapm_get_pin_status(codec, "Earpiece") <<
+			(snd_soc_dapm_get_pin_status(dapm, "Earpiece") <<
 							AMS_DELTA_EARPIECE));
 	if (pins)
-		pins |= (snd_soc_dapm_get_pin_status(codec, "Microphone") <<
+		pins |= (snd_soc_dapm_get_pin_status(dapm, "Microphone") <<
 							AMS_DELTA_MICROPHONE);
 	else
-		pins = ((snd_soc_dapm_get_pin_status(codec, "Microphone") <<
+		pins = ((snd_soc_dapm_get_pin_status(dapm, "Microphone") <<
 							AMS_DELTA_MICROPHONE) |
-			(snd_soc_dapm_get_pin_status(codec, "Speaker") <<
+			(snd_soc_dapm_get_pin_status(dapm, "Speaker") <<
 							AMS_DELTA_SPEAKER) |
 			(ams_delta_audio_agc << AMS_DELTA_AGC));
 
@@ -300,6 +302,7 @@ static int cx81801_open(struct tty_struct *tty)
 static void cx81801_close(struct tty_struct *tty)
 {
 	struct snd_soc_codec *codec = tty->disc_data;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
 	del_timer_sync(&cx81801_timer);
 
@@ -312,12 +315,12 @@ static void cx81801_close(struct tty_struct *tty)
 	v253_ops.close(tty);
 
 	/* Revert back to default audio input/output constellation */
-	snd_soc_dapm_disable_pin(codec, "Mouthpiece");
-	snd_soc_dapm_enable_pin(codec, "Earpiece");
-	snd_soc_dapm_enable_pin(codec, "Microphone");
-	snd_soc_dapm_disable_pin(codec, "Speaker");
-	snd_soc_dapm_disable_pin(codec, "AGCIN");
-	snd_soc_dapm_sync(codec);
+	snd_soc_dapm_disable_pin(dapm, "Mouthpiece");
+	snd_soc_dapm_enable_pin(dapm, "Earpiece");
+	snd_soc_dapm_enable_pin(dapm, "Microphone");
+	snd_soc_dapm_disable_pin(dapm, "Speaker");
+	snd_soc_dapm_disable_pin(dapm, "AGCIN");
+	snd_soc_dapm_sync(dapm);
 }
 
 /* Line discipline .hangup() */
@@ -432,16 +435,16 @@ static int ams_delta_set_bias_level(struct snd_soc_card *card,
 	case SND_SOC_BIAS_ON:
 	case SND_SOC_BIAS_PREPARE:
 	case SND_SOC_BIAS_STANDBY:
-		if (codec->bias_level == SND_SOC_BIAS_OFF)
+		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF)
 			ams_delta_latch2_write(AMS_DELTA_LATCH2_MODEM_NRESET,
 						AMS_DELTA_LATCH2_MODEM_NRESET);
 		break;
 	case SND_SOC_BIAS_OFF:
-		if (codec->bias_level != SND_SOC_BIAS_OFF)
+		if (codec->dapm.bias_level != SND_SOC_BIAS_OFF)
 			ams_delta_latch2_write(AMS_DELTA_LATCH2_MODEM_NRESET,
 						0);
 	}
-	codec->bias_level = level;
+	codec->dapm.bias_level = level;
 
 	return 0;
 }
@@ -492,6 +495,7 @@ static void ams_delta_shutdown(struct snd_pcm_substream *substream)
 static int ams_delta_cx20442_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_card *card = rtd->card;
 	int ret;
@@ -541,7 +545,7 @@ static int ams_delta_cx20442_init(struct snd_soc_pcm_runtime *rtd)
 	}
 
 	/* Add board specific DAPM widgets and routes */
-	ret = snd_soc_dapm_new_controls(codec, ams_delta_dapm_widgets,
+	ret = snd_soc_dapm_new_controls(dapm, ams_delta_dapm_widgets,
 					ARRAY_SIZE(ams_delta_dapm_widgets));
 	if (ret) {
 		dev_warn(card->dev,
@@ -550,7 +554,7 @@ static int ams_delta_cx20442_init(struct snd_soc_pcm_runtime *rtd)
 		return 0;
 	}
 
-	ret = snd_soc_dapm_add_routes(codec, ams_delta_audio_map,
+	ret = snd_soc_dapm_add_routes(dapm, ams_delta_audio_map,
 					ARRAY_SIZE(ams_delta_audio_map));
 	if (ret) {
 		dev_warn(card->dev,
@@ -560,13 +564,13 @@ static int ams_delta_cx20442_init(struct snd_soc_pcm_runtime *rtd)
 	}
 
 	/* Set up initial pin constellation */
-	snd_soc_dapm_disable_pin(codec, "Mouthpiece");
-	snd_soc_dapm_enable_pin(codec, "Earpiece");
-	snd_soc_dapm_enable_pin(codec, "Microphone");
-	snd_soc_dapm_disable_pin(codec, "Speaker");
-	snd_soc_dapm_disable_pin(codec, "AGCIN");
-	snd_soc_dapm_disable_pin(codec, "AGCOUT");
-	snd_soc_dapm_sync(codec);
+	snd_soc_dapm_disable_pin(dapm, "Mouthpiece");
+	snd_soc_dapm_enable_pin(dapm, "Earpiece");
+	snd_soc_dapm_enable_pin(dapm, "Microphone");
+	snd_soc_dapm_disable_pin(dapm, "Speaker");
+	snd_soc_dapm_disable_pin(dapm, "AGCIN");
+	snd_soc_dapm_disable_pin(dapm, "AGCOUT");
+	snd_soc_dapm_sync(dapm);
 
 	/* Add virtual switch */
 	ret = snd_soc_add_controls(codec, ams_delta_audio_controls,
diff --git a/sound/soc/omap/n810.c b/sound/soc/omap/n810.c
index a3b6d89..296cd9b 100644
--- a/sound/soc/omap/n810.c
+++ b/sound/soc/omap/n810.c
@@ -58,6 +58,7 @@ static int n810_dmic_func;
 
 static void n810_ext_control(struct snd_soc_codec *codec)
 {
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int hp = 0, line1l = 0;
 
 	switch (n810_jack_func) {
@@ -72,25 +73,25 @@ static void n810_ext_control(struct snd_soc_codec *codec)
 	}
 
 	if (n810_spk_func)
-		snd_soc_dapm_enable_pin(codec, "Ext Spk");
+		snd_soc_dapm_enable_pin(dapm, "Ext Spk");
 	else
-		snd_soc_dapm_disable_pin(codec, "Ext Spk");
+		snd_soc_dapm_disable_pin(dapm, "Ext Spk");
 
 	if (hp)
-		snd_soc_dapm_enable_pin(codec, "Headphone Jack");
+		snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
 	else
-		snd_soc_dapm_disable_pin(codec, "Headphone Jack");
+		snd_soc_dapm_disable_pin(dapm, "Headphone Jack");
 	if (line1l)
-		snd_soc_dapm_enable_pin(codec, "LINE1L");
+		snd_soc_dapm_enable_pin(dapm, "LINE1L");
 	else
-		snd_soc_dapm_disable_pin(codec, "LINE1L");
+		snd_soc_dapm_disable_pin(dapm, "LINE1L");
 
 	if (n810_dmic_func)
-		snd_soc_dapm_enable_pin(codec, "DMic");
+		snd_soc_dapm_enable_pin(dapm, "DMic");
 	else
-		snd_soc_dapm_disable_pin(codec, "DMic");
+		snd_soc_dapm_disable_pin(dapm, "DMic");
 
-	snd_soc_dapm_sync(codec);
+	snd_soc_dapm_sync(dapm);
 }
 
 static int n810_startup(struct snd_pcm_substream *substream)
@@ -274,17 +275,18 @@ static const struct snd_kcontrol_new aic33_n810_controls[] = {
 static int n810_aic33_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int err;
 
 	/* Not connected */
-	snd_soc_dapm_nc_pin(codec, "MONO_LOUT");
-	snd_soc_dapm_nc_pin(codec, "HPLCOM");
-	snd_soc_dapm_nc_pin(codec, "HPRCOM");
-	snd_soc_dapm_nc_pin(codec, "MIC3L");
-	snd_soc_dapm_nc_pin(codec, "MIC3R");
-	snd_soc_dapm_nc_pin(codec, "LINE1R");
-	snd_soc_dapm_nc_pin(codec, "LINE2L");
-	snd_soc_dapm_nc_pin(codec, "LINE2R");
+	snd_soc_dapm_nc_pin(dapm, "MONO_LOUT");
+	snd_soc_dapm_nc_pin(dapm, "HPLCOM");
+	snd_soc_dapm_nc_pin(dapm, "HPRCOM");
+	snd_soc_dapm_nc_pin(dapm, "MIC3L");
+	snd_soc_dapm_nc_pin(dapm, "MIC3R");
+	snd_soc_dapm_nc_pin(dapm, "LINE1R");
+	snd_soc_dapm_nc_pin(dapm, "LINE2L");
+	snd_soc_dapm_nc_pin(dapm, "LINE2R");
 
 	/* Add N810 specific controls */
 	err = snd_soc_add_controls(codec, aic33_n810_controls,
@@ -293,13 +295,13 @@ static int n810_aic33_init(struct snd_soc_pcm_runtime *rtd)
 		return err;
 
 	/* Add N810 specific widgets */
-	snd_soc_dapm_new_controls(codec, aic33_dapm_widgets,
+	snd_soc_dapm_new_controls(dapm, aic33_dapm_widgets,
 				  ARRAY_SIZE(aic33_dapm_widgets));
 
 	/* Set up N810 specific audio path audio_map */
-	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
-	snd_soc_dapm_sync(codec);
+	snd_soc_dapm_sync(dapm);
 
 	return 0;
 }
diff --git a/sound/soc/omap/omap3pandora.c b/sound/soc/omap/omap3pandora.c
index dbd9d96..93e83c0 100644
--- a/sound/soc/omap/omap3pandora.c
+++ b/sound/soc/omap/omap3pandora.c
@@ -170,51 +170,53 @@ static const struct snd_soc_dapm_route omap3pandora_in_map[] = {
 static int omap3pandora_out_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int ret;
 
 	/* All TWL4030 output pins are floating */
-	snd_soc_dapm_nc_pin(codec, "EARPIECE");
-	snd_soc_dapm_nc_pin(codec, "PREDRIVEL");
-	snd_soc_dapm_nc_pin(codec, "PREDRIVER");
-	snd_soc_dapm_nc_pin(codec, "HSOL");
-	snd_soc_dapm_nc_pin(codec, "HSOR");
-	snd_soc_dapm_nc_pin(codec, "CARKITL");
-	snd_soc_dapm_nc_pin(codec, "CARKITR");
-	snd_soc_dapm_nc_pin(codec, "HFL");
-	snd_soc_dapm_nc_pin(codec, "HFR");
-	snd_soc_dapm_nc_pin(codec, "VIBRA");
-
-	ret = snd_soc_dapm_new_controls(codec, omap3pandora_out_dapm_widgets,
+	snd_soc_dapm_nc_pin(dapm, "EARPIECE");
+	snd_soc_dapm_nc_pin(dapm, "PREDRIVEL");
+	snd_soc_dapm_nc_pin(dapm, "PREDRIVER");
+	snd_soc_dapm_nc_pin(dapm, "HSOL");
+	snd_soc_dapm_nc_pin(dapm, "HSOR");
+	snd_soc_dapm_nc_pin(dapm, "CARKITL");
+	snd_soc_dapm_nc_pin(dapm, "CARKITR");
+	snd_soc_dapm_nc_pin(dapm, "HFL");
+	snd_soc_dapm_nc_pin(dapm, "HFR");
+	snd_soc_dapm_nc_pin(dapm, "VIBRA");
+
+	ret = snd_soc_dapm_new_controls(dapm, omap3pandora_out_dapm_widgets,
 				ARRAY_SIZE(omap3pandora_out_dapm_widgets));
 	if (ret < 0)
 		return ret;
 
-	snd_soc_dapm_add_routes(codec, omap3pandora_out_map,
+	snd_soc_dapm_add_routes(dapm, omap3pandora_out_map,
 		ARRAY_SIZE(omap3pandora_out_map));
 
-	return snd_soc_dapm_sync(codec);
+	return snd_soc_dapm_sync(dapm);
 }
 
 static int omap3pandora_in_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int ret;
 
 	/* Not comnnected */
-	snd_soc_dapm_nc_pin(codec, "HSMIC");
-	snd_soc_dapm_nc_pin(codec, "CARKITMIC");
-	snd_soc_dapm_nc_pin(codec, "DIGIMIC0");
-	snd_soc_dapm_nc_pin(codec, "DIGIMIC1");
+	snd_soc_dapm_nc_pin(dapm, "HSMIC");
+	snd_soc_dapm_nc_pin(dapm, "CARKITMIC");
+	snd_soc_dapm_nc_pin(dapm, "DIGIMIC0");
+	snd_soc_dapm_nc_pin(dapm, "DIGIMIC1");
 
-	ret = snd_soc_dapm_new_controls(codec, omap3pandora_in_dapm_widgets,
+	ret = snd_soc_dapm_new_controls(dapm, omap3pandora_in_dapm_widgets,
 				ARRAY_SIZE(omap3pandora_in_dapm_widgets));
 	if (ret < 0)
 		return ret;
 
-	snd_soc_dapm_add_routes(codec, omap3pandora_in_map,
+	snd_soc_dapm_add_routes(dapm, omap3pandora_in_map,
 		ARRAY_SIZE(omap3pandora_in_map));
 
-	return snd_soc_dapm_sync(codec);
+	return snd_soc_dapm_sync(dapm);
 }
 
 static struct snd_soc_ops omap3pandora_ops = {
diff --git a/sound/soc/omap/osk5912.c b/sound/soc/omap/osk5912.c
index f0e6625..c2a5420 100644
--- a/sound/soc/omap/osk5912.c
+++ b/sound/soc/omap/osk5912.c
@@ -116,19 +116,20 @@ static const struct snd_soc_dapm_route audio_map[] = {
 static int osk_tlv320aic23_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
 	/* Add osk5912 specific widgets */
-	snd_soc_dapm_new_controls(codec, tlv320aic23_dapm_widgets,
+	snd_soc_dapm_new_controls(dapm, tlv320aic23_dapm_widgets,
 				  ARRAY_SIZE(tlv320aic23_dapm_widgets));
 
 	/* Set up osk5912 specific audio path audio_map */
-	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
-	snd_soc_dapm_enable_pin(codec, "Headphone Jack");
-	snd_soc_dapm_enable_pin(codec, "Line In");
-	snd_soc_dapm_enable_pin(codec, "Mic Jack");
+	snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
+	snd_soc_dapm_enable_pin(dapm, "Line In");
+	snd_soc_dapm_enable_pin(dapm, "Mic Jack");
 
-	snd_soc_dapm_sync(codec);
+	snd_soc_dapm_sync(dapm);
 
 	return 0;
 }
diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
index 04b5723..62fc7a4 100644
--- a/sound/soc/omap/rx51.c
+++ b/sound/soc/omap/rx51.c
@@ -58,19 +58,21 @@ static int rx51_jack_func;
 
 static void rx51_ext_control(struct snd_soc_codec *codec)
 {
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
+
 	if (rx51_spk_func)
-		snd_soc_dapm_enable_pin(codec, "Ext Spk");
+		snd_soc_dapm_enable_pin(dapm, "Ext Spk");
 	else
-		snd_soc_dapm_disable_pin(codec, "Ext Spk");
+		snd_soc_dapm_disable_pin(dapm, "Ext Spk");
 	if (rx51_dmic_func)
-		snd_soc_dapm_enable_pin(codec, "DMic");
+		snd_soc_dapm_enable_pin(dapm, "DMic");
 	else
-		snd_soc_dapm_disable_pin(codec, "DMic");
+		snd_soc_dapm_disable_pin(dapm, "DMic");
 
 	gpio_set_value(RX51_TVOUT_SEL_GPIO,
 		       rx51_jack_func == RX51_JACK_TVOUT);
 
-	snd_soc_dapm_sync(codec);
+	snd_soc_dapm_sync(dapm);
 }
 
 static int rx51_startup(struct snd_pcm_substream *substream)
@@ -244,12 +246,13 @@ static const struct snd_kcontrol_new aic34_rx51_controls[] = {
 static int rx51_aic34_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int err;
 
 	/* Set up NC codec pins */
-	snd_soc_dapm_nc_pin(codec, "MIC3L");
-	snd_soc_dapm_nc_pin(codec, "MIC3R");
-	snd_soc_dapm_nc_pin(codec, "LINE1R");
+	snd_soc_dapm_nc_pin(dapm, "MIC3L");
+	snd_soc_dapm_nc_pin(dapm, "MIC3R");
+	snd_soc_dapm_nc_pin(dapm, "LINE1R");
 
 	/* Add RX-51 specific controls */
 	err = snd_soc_add_controls(codec, aic34_rx51_controls,
@@ -258,13 +261,13 @@ static int rx51_aic34_init(struct snd_soc_pcm_runtime *rtd)
 		return err;
 
 	/* Add RX-51 specific widgets */
-	snd_soc_dapm_new_controls(codec, aic34_dapm_widgets,
+	snd_soc_dapm_new_controls(dapm, aic34_dapm_widgets,
 				  ARRAY_SIZE(aic34_dapm_widgets));
 
 	/* Set up RX-51 specific audio path audio_map */
-	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
-	snd_soc_dapm_sync(codec);
+	snd_soc_dapm_sync(dapm);
 
 	/* AV jack detection */
 	err = snd_soc_jack_new(codec, "AV Jack",
diff --git a/sound/soc/omap/sdp3430.c b/sound/soc/omap/sdp3430.c
index 07fbcf7..a3dd07a 100644
--- a/sound/soc/omap/sdp3430.c
+++ b/sound/soc/omap/sdp3430.c
@@ -191,39 +191,40 @@ static const struct snd_soc_dapm_route audio_map[] = {
 static int sdp3430_twl4030_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int ret;
 
 	/* Add SDP3430 specific widgets */
-	ret = snd_soc_dapm_new_controls(codec, sdp3430_twl4030_dapm_widgets,
+	ret = snd_soc_dapm_new_controls(dapm, sdp3430_twl4030_dapm_widgets,
 				ARRAY_SIZE(sdp3430_twl4030_dapm_widgets));
 	if (ret)
 		return ret;
 
 	/* Set up SDP3430 specific audio path audio_map */
-	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
 	/* SDP3430 connected pins */
-	snd_soc_dapm_enable_pin(codec, "Ext Mic");
-	snd_soc_dapm_enable_pin(codec, "Ext Spk");
-	snd_soc_dapm_disable_pin(codec, "Headset Mic");
-	snd_soc_dapm_disable_pin(codec, "Headset Stereophone");
+	snd_soc_dapm_enable_pin(dapm, "Ext Mic");
+	snd_soc_dapm_enable_pin(dapm, "Ext Spk");
+	snd_soc_dapm_disable_pin(dapm, "Headset Mic");
+	snd_soc_dapm_disable_pin(dapm, "Headset Stereophone");
 
 	/* TWL4030 not connected pins */
-	snd_soc_dapm_nc_pin(codec, "AUXL");
-	snd_soc_dapm_nc_pin(codec, "AUXR");
-	snd_soc_dapm_nc_pin(codec, "CARKITMIC");
-	snd_soc_dapm_nc_pin(codec, "DIGIMIC0");
-	snd_soc_dapm_nc_pin(codec, "DIGIMIC1");
-
-	snd_soc_dapm_nc_pin(codec, "OUTL");
-	snd_soc_dapm_nc_pin(codec, "OUTR");
-	snd_soc_dapm_nc_pin(codec, "EARPIECE");
-	snd_soc_dapm_nc_pin(codec, "PREDRIVEL");
-	snd_soc_dapm_nc_pin(codec, "PREDRIVER");
-	snd_soc_dapm_nc_pin(codec, "CARKITL");
-	snd_soc_dapm_nc_pin(codec, "CARKITR");
-
-	ret = snd_soc_dapm_sync(codec);
+	snd_soc_dapm_nc_pin(dapm, "AUXL");
+	snd_soc_dapm_nc_pin(dapm, "AUXR");
+	snd_soc_dapm_nc_pin(dapm, "CARKITMIC");
+	snd_soc_dapm_nc_pin(dapm, "DIGIMIC0");
+	snd_soc_dapm_nc_pin(dapm, "DIGIMIC1");
+
+	snd_soc_dapm_nc_pin(dapm, "OUTL");
+	snd_soc_dapm_nc_pin(dapm, "OUTR");
+	snd_soc_dapm_nc_pin(dapm, "EARPIECE");
+	snd_soc_dapm_nc_pin(dapm, "PREDRIVEL");
+	snd_soc_dapm_nc_pin(dapm, "PREDRIVER");
+	snd_soc_dapm_nc_pin(dapm, "CARKITL");
+	snd_soc_dapm_nc_pin(dapm, "CARKITR");
+
+	ret = snd_soc_dapm_sync(dapm);
 	if (ret)
 		return ret;
 
diff --git a/sound/soc/omap/sdp4430.c b/sound/soc/omap/sdp4430.c
index 4b4463d..3ce1731 100644
--- a/sound/soc/omap/sdp4430.c
+++ b/sound/soc/omap/sdp4430.c
@@ -129,6 +129,7 @@ static const struct snd_soc_dapm_route audio_map[] = {
 static int sdp4430_twl6040_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int ret;
 
 	/* Add SDP4430 specific controls */
@@ -138,25 +139,25 @@ static int sdp4430_twl6040_init(struct snd_soc_pcm_runtime *rtd)
 		return ret;
 
 	/* Add SDP4430 specific widgets */
-	ret = snd_soc_dapm_new_controls(codec, sdp4430_twl6040_dapm_widgets,
+	ret = snd_soc_dapm_new_controls(dapm, sdp4430_twl6040_dapm_widgets,
 				ARRAY_SIZE(sdp4430_twl6040_dapm_widgets));
 	if (ret)
 		return ret;
 
 	/* Set up SDP4430 specific audio path audio_map */
-	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
 	/* SDP4430 connected pins */
-	snd_soc_dapm_enable_pin(codec, "Ext Mic");
-	snd_soc_dapm_enable_pin(codec, "Ext Spk");
-	snd_soc_dapm_enable_pin(codec, "Headset Mic");
-	snd_soc_dapm_enable_pin(codec, "Headset Stereophone");
+	snd_soc_dapm_enable_pin(dapm, "Ext Mic");
+	snd_soc_dapm_enable_pin(dapm, "Ext Spk");
+	snd_soc_dapm_enable_pin(dapm, "Headset Mic");
+	snd_soc_dapm_enable_pin(dapm, "Headset Stereophone");
 
 	/* TWL6040 not connected pins */
-	snd_soc_dapm_nc_pin(codec, "AFML");
-	snd_soc_dapm_nc_pin(codec, "AFMR");
+	snd_soc_dapm_nc_pin(dapm, "AFML");
+	snd_soc_dapm_nc_pin(dapm, "AFMR");
 
-	ret = snd_soc_dapm_sync(codec);
+	ret = snd_soc_dapm_sync(dapm);
 
 	return ret;
 }
diff --git a/sound/soc/omap/zoom2.c b/sound/soc/omap/zoom2.c
index 718031e..cc5bc52 100644
--- a/sound/soc/omap/zoom2.c
+++ b/sound/soc/omap/zoom2.c
@@ -162,35 +162,36 @@ static const struct snd_soc_dapm_route audio_map[] = {
 static int zoom2_twl4030_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int ret;
 
 	/* Add Zoom2 specific widgets */
-	ret = snd_soc_dapm_new_controls(codec, zoom2_twl4030_dapm_widgets,
+	ret = snd_soc_dapm_new_controls(dapm, zoom2_twl4030_dapm_widgets,
 				ARRAY_SIZE(zoom2_twl4030_dapm_widgets));
 	if (ret)
 		return ret;
 
 	/* Set up Zoom2 specific audio path audio_map */
-	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
 	/* Zoom2 connected pins */
-	snd_soc_dapm_enable_pin(codec, "Ext Mic");
-	snd_soc_dapm_enable_pin(codec, "Ext Spk");
-	snd_soc_dapm_enable_pin(codec, "Headset Mic");
-	snd_soc_dapm_enable_pin(codec, "Headset Stereophone");
-	snd_soc_dapm_enable_pin(codec, "Aux In");
+	snd_soc_dapm_enable_pin(dapm, "Ext Mic");
+	snd_soc_dapm_enable_pin(dapm, "Ext Spk");
+	snd_soc_dapm_enable_pin(dapm, "Headset Mic");
+	snd_soc_dapm_enable_pin(dapm, "Headset Stereophone");
+	snd_soc_dapm_enable_pin(dapm, "Aux In");
 
 	/* TWL4030 not connected pins */
-	snd_soc_dapm_nc_pin(codec, "CARKITMIC");
-	snd_soc_dapm_nc_pin(codec, "DIGIMIC0");
-	snd_soc_dapm_nc_pin(codec, "DIGIMIC1");
-	snd_soc_dapm_nc_pin(codec, "EARPIECE");
-	snd_soc_dapm_nc_pin(codec, "PREDRIVEL");
-	snd_soc_dapm_nc_pin(codec, "PREDRIVER");
-	snd_soc_dapm_nc_pin(codec, "CARKITL");
-	snd_soc_dapm_nc_pin(codec, "CARKITR");
-
-	ret = snd_soc_dapm_sync(codec);
+	snd_soc_dapm_nc_pin(dapm, "CARKITMIC");
+	snd_soc_dapm_nc_pin(dapm, "DIGIMIC0");
+	snd_soc_dapm_nc_pin(dapm, "DIGIMIC1");
+	snd_soc_dapm_nc_pin(dapm, "EARPIECE");
+	snd_soc_dapm_nc_pin(dapm, "PREDRIVEL");
+	snd_soc_dapm_nc_pin(dapm, "PREDRIVER");
+	snd_soc_dapm_nc_pin(dapm, "CARKITL");
+	snd_soc_dapm_nc_pin(dapm, "CARKITR");
+
+	ret = snd_soc_dapm_sync(dapm);
 
 	return ret;
 }
diff --git a/sound/soc/pxa/corgi.c b/sound/soc/pxa/corgi.c
index 97e9423..810633c 100644
--- a/sound/soc/pxa/corgi.c
+++ b/sound/soc/pxa/corgi.c
@@ -48,51 +48,53 @@ static int corgi_spk_func;
 
 static void corgi_ext_control(struct snd_soc_codec *codec)
 {
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
+
 	/* set up jack connection */
 	switch (corgi_jack_func) {
 	case CORGI_HP:
 		/* set = unmute headphone */
 		gpio_set_value(CORGI_GPIO_MUTE_L, 1);
 		gpio_set_value(CORGI_GPIO_MUTE_R, 1);
-		snd_soc_dapm_disable_pin(codec, "Mic Jack");
-		snd_soc_dapm_disable_pin(codec, "Line Jack");
-		snd_soc_dapm_enable_pin(codec, "Headphone Jack");
-		snd_soc_dapm_disable_pin(codec, "Headset Jack");
+		snd_soc_dapm_disable_pin(dapm, "Mic Jack");
+		snd_soc_dapm_disable_pin(dapm, "Line Jack");
+		snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
+		snd_soc_dapm_disable_pin(dapm, "Headset Jack");
 		break;
 	case CORGI_MIC:
 		/* reset = mute headphone */
 		gpio_set_value(CORGI_GPIO_MUTE_L, 0);
 		gpio_set_value(CORGI_GPIO_MUTE_R, 0);
-		snd_soc_dapm_enable_pin(codec, "Mic Jack");
-		snd_soc_dapm_disable_pin(codec, "Line Jack");
-		snd_soc_dapm_disable_pin(codec, "Headphone Jack");
-		snd_soc_dapm_disable_pin(codec, "Headset Jack");
+		snd_soc_dapm_enable_pin(dapm, "Mic Jack");
+		snd_soc_dapm_disable_pin(dapm, "Line Jack");
+		snd_soc_dapm_disable_pin(dapm, "Headphone Jack");
+		snd_soc_dapm_disable_pin(dapm, "Headset Jack");
 		break;
 	case CORGI_LINE:
 		gpio_set_value(CORGI_GPIO_MUTE_L, 0);
 		gpio_set_value(CORGI_GPIO_MUTE_R, 0);
-		snd_soc_dapm_disable_pin(codec, "Mic Jack");
-		snd_soc_dapm_enable_pin(codec, "Line Jack");
-		snd_soc_dapm_disable_pin(codec, "Headphone Jack");
-		snd_soc_dapm_disable_pin(codec, "Headset Jack");
+		snd_soc_dapm_disable_pin(dapm, "Mic Jack");
+		snd_soc_dapm_enable_pin(dapm, "Line Jack");
+		snd_soc_dapm_disable_pin(dapm, "Headphone Jack");
+		snd_soc_dapm_disable_pin(dapm, "Headset Jack");
 		break;
 	case CORGI_HEADSET:
 		gpio_set_value(CORGI_GPIO_MUTE_L, 0);
 		gpio_set_value(CORGI_GPIO_MUTE_R, 1);
-		snd_soc_dapm_enable_pin(codec, "Mic Jack");
-		snd_soc_dapm_disable_pin(codec, "Line Jack");
-		snd_soc_dapm_disable_pin(codec, "Headphone Jack");
-		snd_soc_dapm_enable_pin(codec, "Headset Jack");
+		snd_soc_dapm_enable_pin(dapm, "Mic Jack");
+		snd_soc_dapm_disable_pin(dapm, "Line Jack");
+		snd_soc_dapm_disable_pin(dapm, "Headphone Jack");
+		snd_soc_dapm_enable_pin(dapm, "Headset Jack");
 		break;
 	}
 
 	if (corgi_spk_func == CORGI_SPK_ON)
-		snd_soc_dapm_enable_pin(codec, "Ext Spk");
+		snd_soc_dapm_enable_pin(dapm, "Ext Spk");
 	else
-		snd_soc_dapm_disable_pin(codec, "Ext Spk");
+		snd_soc_dapm_disable_pin(dapm, "Ext Spk");
 
 	/* signal a DAPM event */
-	snd_soc_dapm_sync(codec);
+	snd_soc_dapm_sync(dapm);
 }
 
 static int corgi_startup(struct snd_pcm_substream *substream)
@@ -274,10 +276,11 @@ static const struct snd_kcontrol_new wm8731_corgi_controls[] = {
 static int corgi_wm8731_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int err;
 
-	snd_soc_dapm_nc_pin(codec, "LLINEIN");
-	snd_soc_dapm_nc_pin(codec, "RLINEIN");
+	snd_soc_dapm_nc_pin(dapm, "LLINEIN");
+	snd_soc_dapm_nc_pin(dapm, "RLINEIN");
 
 	/* Add corgi specific controls */
 	err = snd_soc_add_controls(codec, wm8731_corgi_controls,
@@ -286,13 +289,13 @@ static int corgi_wm8731_init(struct snd_soc_pcm_runtime *rtd)
 		return err;
 
 	/* Add corgi specific widgets */
-	snd_soc_dapm_new_controls(codec, wm8731_dapm_widgets,
+	snd_soc_dapm_new_controls(dapm, wm8731_dapm_widgets,
 				  ARRAY_SIZE(wm8731_dapm_widgets));
 
 	/* Set up corgi specific audio path audio_map */
-	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
-	snd_soc_dapm_sync(codec);
+	snd_soc_dapm_sync(dapm);
 	return 0;
 }
 
diff --git a/sound/soc/pxa/e740_wm9705.c b/sound/soc/pxa/e740_wm9705.c
index c82cedb..38a84b8 100644
--- a/sound/soc/pxa/e740_wm9705.c
+++ b/sound/soc/pxa/e740_wm9705.c
@@ -92,23 +92,24 @@ static const struct snd_soc_dapm_route audio_map[] = {
 static int e740_ac97_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
-
-	snd_soc_dapm_nc_pin(codec, "HPOUTL");
-	snd_soc_dapm_nc_pin(codec, "HPOUTR");
-	snd_soc_dapm_nc_pin(codec, "PHONE");
-	snd_soc_dapm_nc_pin(codec, "LINEINL");
-	snd_soc_dapm_nc_pin(codec, "LINEINR");
-	snd_soc_dapm_nc_pin(codec, "CDINL");
-	snd_soc_dapm_nc_pin(codec, "CDINR");
-	snd_soc_dapm_nc_pin(codec, "PCBEEP");
-	snd_soc_dapm_nc_pin(codec, "MIC2");
-
-	snd_soc_dapm_new_controls(codec, e740_dapm_widgets,
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
+
+	snd_soc_dapm_nc_pin(dapm, "HPOUTL");
+	snd_soc_dapm_nc_pin(dapm, "HPOUTR");
+	snd_soc_dapm_nc_pin(dapm, "PHONE");
+	snd_soc_dapm_nc_pin(dapm, "LINEINL");
+	snd_soc_dapm_nc_pin(dapm, "LINEINR");
+	snd_soc_dapm_nc_pin(dapm, "CDINL");
+	snd_soc_dapm_nc_pin(dapm, "CDINR");
+	snd_soc_dapm_nc_pin(dapm, "PCBEEP");
+	snd_soc_dapm_nc_pin(dapm, "MIC2");
+
+	snd_soc_dapm_new_controls(dapm, e740_dapm_widgets,
 					ARRAY_SIZE(e740_dapm_widgets));
 
-	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
-	snd_soc_dapm_sync(codec);
+	snd_soc_dapm_sync(dapm);
 
 	return 0;
 }
diff --git a/sound/soc/pxa/e750_wm9705.c b/sound/soc/pxa/e750_wm9705.c
index 4c14380..2bc97e9 100644
--- a/sound/soc/pxa/e750_wm9705.c
+++ b/sound/soc/pxa/e750_wm9705.c
@@ -74,23 +74,24 @@ static const struct snd_soc_dapm_route audio_map[] = {
 static int e750_ac97_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
-
-	snd_soc_dapm_nc_pin(codec, "LOUT");
-	snd_soc_dapm_nc_pin(codec, "ROUT");
-	snd_soc_dapm_nc_pin(codec, "PHONE");
-	snd_soc_dapm_nc_pin(codec, "LINEINL");
-	snd_soc_dapm_nc_pin(codec, "LINEINR");
-	snd_soc_dapm_nc_pin(codec, "CDINL");
-	snd_soc_dapm_nc_pin(codec, "CDINR");
-	snd_soc_dapm_nc_pin(codec, "PCBEEP");
-	snd_soc_dapm_nc_pin(codec, "MIC2");
-
-	snd_soc_dapm_new_controls(codec, e750_dapm_widgets,
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
+
+	snd_soc_dapm_nc_pin(dapm, "LOUT");
+	snd_soc_dapm_nc_pin(dapm, "ROUT");
+	snd_soc_dapm_nc_pin(dapm, "PHONE");
+	snd_soc_dapm_nc_pin(dapm, "LINEINL");
+	snd_soc_dapm_nc_pin(dapm, "LINEINR");
+	snd_soc_dapm_nc_pin(dapm, "CDINL");
+	snd_soc_dapm_nc_pin(dapm, "CDINR");
+	snd_soc_dapm_nc_pin(dapm, "PCBEEP");
+	snd_soc_dapm_nc_pin(dapm, "MIC2");
+
+	snd_soc_dapm_new_controls(dapm, e750_dapm_widgets,
 					ARRAY_SIZE(e750_dapm_widgets));
 
-	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
-	snd_soc_dapm_sync(codec);
+	snd_soc_dapm_sync(dapm);
 
 	return 0;
 }
diff --git a/sound/soc/pxa/e800_wm9712.c b/sound/soc/pxa/e800_wm9712.c
index d42e5fe..eac846c 100644
--- a/sound/soc/pxa/e800_wm9712.c
+++ b/sound/soc/pxa/e800_wm9712.c
@@ -75,12 +75,13 @@ static const struct snd_soc_dapm_route audio_map[] = {
 static int e800_ac97_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
-	snd_soc_dapm_new_controls(codec, e800_dapm_widgets,
+	snd_soc_dapm_new_controls(dapm, e800_dapm_widgets,
 					ARRAY_SIZE(e800_dapm_widgets));
 
-	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
-	snd_soc_dapm_sync(codec);
+	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
+	snd_soc_dapm_sync(dapm);
 
 	return 0;
 }
diff --git a/sound/soc/pxa/magician.c b/sound/soc/pxa/magician.c
index b8207ce..f1acdc5 100644
--- a/sound/soc/pxa/magician.c
+++ b/sound/soc/pxa/magician.c
@@ -44,27 +44,29 @@ static int magician_in_sel = MAGICIAN_MIC;
 
 static void magician_ext_control(struct snd_soc_codec *codec)
 {
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
+
 	if (magician_spk_switch)
-		snd_soc_dapm_enable_pin(codec, "Speaker");
+		snd_soc_dapm_enable_pin(dapm, "Speaker");
 	else
-		snd_soc_dapm_disable_pin(codec, "Speaker");
+		snd_soc_dapm_disable_pin(dapm, "Speaker");
 	if (magician_hp_switch)
-		snd_soc_dapm_enable_pin(codec, "Headphone Jack");
+		snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
 	else
-		snd_soc_dapm_disable_pin(codec, "Headphone Jack");
+		snd_soc_dapm_disable_pin(dapm, "Headphone Jack");
 
 	switch (magician_in_sel) {
 	case MAGICIAN_MIC:
-		snd_soc_dapm_disable_pin(codec, "Headset Mic");
-		snd_soc_dapm_enable_pin(codec, "Call Mic");
+		snd_soc_dapm_disable_pin(dapm, "Headset Mic");
+		snd_soc_dapm_enable_pin(dapm, "Call Mic");
 		break;
 	case MAGICIAN_MIC_EXT:
-		snd_soc_dapm_disable_pin(codec, "Call Mic");
-		snd_soc_dapm_enable_pin(codec, "Headset Mic");
+		snd_soc_dapm_disable_pin(dapm, "Call Mic");
+		snd_soc_dapm_enable_pin(dapm, "Headset Mic");
 		break;
 	}
 
-	snd_soc_dapm_sync(codec);
+	snd_soc_dapm_sync(dapm);
 }
 
 static int magician_startup(struct snd_pcm_substream *substream)
@@ -395,15 +397,16 @@ static const struct snd_kcontrol_new uda1380_magician_controls[] = {
 static int magician_uda1380_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int err;
 
 	/* NC codec pins */
-	snd_soc_dapm_nc_pin(codec, "VOUTLHP");
-	snd_soc_dapm_nc_pin(codec, "VOUTRHP");
+	snd_soc_dapm_nc_pin(dapm, "VOUTLHP");
+	snd_soc_dapm_nc_pin(dapm, "VOUTRHP");
 
 	/* FIXME: is anything connected here? */
-	snd_soc_dapm_nc_pin(codec, "VINL");
-	snd_soc_dapm_nc_pin(codec, "VINR");
+	snd_soc_dapm_nc_pin(dapm, "VINL");
+	snd_soc_dapm_nc_pin(dapm, "VINR");
 
 	/* Add magician specific controls */
 	err = snd_soc_add_controls(codec, uda1380_magician_controls,
@@ -412,13 +415,13 @@ static int magician_uda1380_init(struct snd_soc_pcm_runtime *rtd)
 		return err;
 
 	/* Add magician specific widgets */
-	snd_soc_dapm_new_controls(codec, uda1380_dapm_widgets,
+	snd_soc_dapm_new_controls(dapm, uda1380_dapm_widgets,
 				  ARRAY_SIZE(uda1380_dapm_widgets));
 
 	/* Set up magician specific audio path interconnects */
-	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
-	snd_soc_dapm_sync(codec);
+	snd_soc_dapm_sync(dapm);
 	return 0;
 }
 
diff --git a/sound/soc/pxa/mioa701_wm9713.c b/sound/soc/pxa/mioa701_wm9713.c
index f284cc5..f7a1e8f 100644
--- a/sound/soc/pxa/mioa701_wm9713.c
+++ b/sound/soc/pxa/mioa701_wm9713.c
@@ -130,13 +130,14 @@ static const struct snd_soc_dapm_route audio_map[] = {
 static int mioa701_wm9713_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	unsigned short reg;
 
 	/* Add mioa701 specific widgets */
-	snd_soc_dapm_new_controls(codec, ARRAY_AND_SIZE(mioa701_dapm_widgets));
+	snd_soc_dapm_new_controls(dapm, ARRAY_AND_SIZE(mioa701_dapm_widgets));
 
 	/* Set up mioa701 specific audio path audio_mapnects */
-	snd_soc_dapm_add_routes(codec, ARRAY_AND_SIZE(audio_map));
+	snd_soc_dapm_add_routes(dapm, ARRAY_AND_SIZE(audio_map));
 
 	/* Prepare GPIO8 for rear speaker amplifier */
 	reg = codec->driver->read(codec, AC97_GPIO_CFG);
@@ -146,12 +147,12 @@ static int mioa701_wm9713_init(struct snd_soc_pcm_runtime *rtd)
 	reg = codec->driver->read(codec, AC97_3D_CONTROL);
 	codec->driver->write(codec, AC97_3D_CONTROL, reg | 0xc000);
 
-	snd_soc_dapm_enable_pin(codec, "Front Speaker");
-	snd_soc_dapm_enable_pin(codec, "Rear Speaker");
-	snd_soc_dapm_enable_pin(codec, "Front Mic");
-	snd_soc_dapm_enable_pin(codec, "GSM Line In");
-	snd_soc_dapm_enable_pin(codec, "GSM Line Out");
-	snd_soc_dapm_sync(codec);
+	snd_soc_dapm_enable_pin(dapm, "Front Speaker");
+	snd_soc_dapm_enable_pin(dapm, "Rear Speaker");
+	snd_soc_dapm_enable_pin(dapm, "Front Mic");
+	snd_soc_dapm_enable_pin(dapm, "GSM Line In");
+	snd_soc_dapm_enable_pin(dapm, "GSM Line Out");
+	snd_soc_dapm_sync(dapm);
 
 	return 0;
 }
diff --git a/sound/soc/pxa/palm27x.c b/sound/soc/pxa/palm27x.c
index 13f6d48..530064d 100644
--- a/sound/soc/pxa/palm27x.c
+++ b/sound/soc/pxa/palm27x.c
@@ -77,37 +77,38 @@ static struct snd_soc_card palm27x_asoc;
 static int palm27x_ac97_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int err;
 
 	/* add palm27x specific widgets */
-	err = snd_soc_dapm_new_controls(codec, palm27x_dapm_widgets,
+	err = snd_soc_dapm_new_controls(dapm, palm27x_dapm_widgets,
 				ARRAY_SIZE(palm27x_dapm_widgets));
 	if (err)
 		return err;
 
 	/* set up palm27x specific audio path audio_map */
-	err = snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	err = snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 	if (err)
 		return err;
 
 	/* connected pins */
 	if (machine_is_palmld())
-		snd_soc_dapm_enable_pin(codec, "MIC1");
-	snd_soc_dapm_enable_pin(codec, "HPOUTL");
-	snd_soc_dapm_enable_pin(codec, "HPOUTR");
-	snd_soc_dapm_enable_pin(codec, "LOUT2");
-	snd_soc_dapm_enable_pin(codec, "ROUT2");
+		snd_soc_dapm_enable_pin(dapm, "MIC1");
+	snd_soc_dapm_enable_pin(dapm, "HPOUTL");
+	snd_soc_dapm_enable_pin(dapm, "HPOUTR");
+	snd_soc_dapm_enable_pin(dapm, "LOUT2");
+	snd_soc_dapm_enable_pin(dapm, "ROUT2");
 
 	/* not connected pins */
-	snd_soc_dapm_nc_pin(codec, "OUT3");
-	snd_soc_dapm_nc_pin(codec, "MONOOUT");
-	snd_soc_dapm_nc_pin(codec, "LINEINL");
-	snd_soc_dapm_nc_pin(codec, "LINEINR");
-	snd_soc_dapm_nc_pin(codec, "PCBEEP");
-	snd_soc_dapm_nc_pin(codec, "PHONE");
-	snd_soc_dapm_nc_pin(codec, "MIC2");
-
-	err = snd_soc_dapm_sync(codec);
+	snd_soc_dapm_nc_pin(dapm, "OUT3");
+	snd_soc_dapm_nc_pin(dapm, "MONOOUT");
+	snd_soc_dapm_nc_pin(dapm, "LINEINL");
+	snd_soc_dapm_nc_pin(dapm, "LINEINR");
+	snd_soc_dapm_nc_pin(dapm, "PCBEEP");
+	snd_soc_dapm_nc_pin(dapm, "PHONE");
+	snd_soc_dapm_nc_pin(dapm, "MIC2");
+
+	err = snd_soc_dapm_sync(dapm);
 	if (err)
 		return err;
 
diff --git a/sound/soc/pxa/poodle.c b/sound/soc/pxa/poodle.c
index af84ee9..7353ee5 100644
--- a/sound/soc/pxa/poodle.c
+++ b/sound/soc/pxa/poodle.c
@@ -46,6 +46,8 @@ static int poodle_spk_func;
 
 static void poodle_ext_control(struct snd_soc_codec *codec)
 {
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
+
 	/* set up jack connection */
 	if (poodle_jack_func == POODLE_HP) {
 		/* set = unmute headphone */
@@ -53,23 +55,23 @@ static void poodle_ext_control(struct snd_soc_codec *codec)
 			POODLE_LOCOMO_GPIO_MUTE_L, 1);
 		locomo_gpio_write(&poodle_locomo_device.dev,
 			POODLE_LOCOMO_GPIO_MUTE_R, 1);
-		snd_soc_dapm_enable_pin(codec, "Headphone Jack");
+		snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
 	} else {
 		locomo_gpio_write(&poodle_locomo_device.dev,
 			POODLE_LOCOMO_GPIO_MUTE_L, 0);
 		locomo_gpio_write(&poodle_locomo_device.dev,
 			POODLE_LOCOMO_GPIO_MUTE_R, 0);
-		snd_soc_dapm_disable_pin(codec, "Headphone Jack");
+		snd_soc_dapm_disable_pin(dapm, "Headphone Jack");
 	}
 
 	/* set the enpoints to their new connetion states */
 	if (poodle_spk_func == POODLE_SPK_ON)
-		snd_soc_dapm_enable_pin(codec, "Ext Spk");
+		snd_soc_dapm_enable_pin(dapm, "Ext Spk");
 	else
-		snd_soc_dapm_disable_pin(codec, "Ext Spk");
+		snd_soc_dapm_disable_pin(dapm, "Ext Spk");
 
 	/* signal a DAPM event */
-	snd_soc_dapm_sync(codec);
+	snd_soc_dapm_sync(dapm);
 }
 
 static int poodle_startup(struct snd_pcm_substream *substream)
@@ -239,11 +241,12 @@ static const struct snd_kcontrol_new wm8731_poodle_controls[] = {
 static int poodle_wm8731_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int err;
 
-	snd_soc_dapm_nc_pin(codec, "LLINEIN");
-	snd_soc_dapm_nc_pin(codec, "RLINEIN");
-	snd_soc_dapm_enable_pin(codec, "MICIN");
+	snd_soc_dapm_nc_pin(dapm, "LLINEIN");
+	snd_soc_dapm_nc_pin(dapm, "RLINEIN");
+	snd_soc_dapm_enable_pin(dapm, "MICIN");
 
 	/* Add poodle specific controls */
 	err = snd_soc_add_controls(codec, wm8731_poodle_controls,
@@ -252,13 +255,13 @@ static int poodle_wm8731_init(struct snd_soc_pcm_runtime *rtd)
 		return err;
 
 	/* Add poodle specific widgets */
-	snd_soc_dapm_new_controls(codec, wm8731_dapm_widgets,
+	snd_soc_dapm_new_controls(dapm, wm8731_dapm_widgets,
 				  ARRAY_SIZE(wm8731_dapm_widgets));
 
 	/* Set up poodle specific audio path audio_map */
-	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
-	snd_soc_dapm_sync(codec);
+	snd_soc_dapm_sync(dapm);
 	return 0;
 }
 
diff --git a/sound/soc/pxa/saarb.c b/sound/soc/pxa/saarb.c
index d63cb47..ee06f99 100644
--- a/sound/soc/pxa/saarb.c
+++ b/sound/soc/pxa/saarb.c
@@ -133,20 +133,21 @@ static struct snd_soc_card snd_soc_card_saarb = {
 static int saarb_pm860x_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int ret;
 
-	snd_soc_dapm_new_controls(codec, saarb_dapm_widgets,
+	snd_soc_dapm_new_controls(dapm, saarb_dapm_widgets,
 				  ARRAY_SIZE(saarb_dapm_widgets));
-	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
 	/* connected pins */
-	snd_soc_dapm_enable_pin(codec, "Ext Speaker");
-	snd_soc_dapm_enable_pin(codec, "Ext Mic 1");
-	snd_soc_dapm_enable_pin(codec, "Ext Mic 3");
-	snd_soc_dapm_disable_pin(codec, "Headset Mic 2");
-	snd_soc_dapm_disable_pin(codec, "Headset Stereophone");
+	snd_soc_dapm_enable_pin(dapm, "Ext Speaker");
+	snd_soc_dapm_enable_pin(dapm, "Ext Mic 1");
+	snd_soc_dapm_enable_pin(dapm, "Ext Mic 3");
+	snd_soc_dapm_disable_pin(dapm, "Headset Mic 2");
+	snd_soc_dapm_disable_pin(dapm, "Headset Stereophone");
 
-	ret = snd_soc_dapm_sync(codec);
+	ret = snd_soc_dapm_sync(dapm);
 	if (ret)
 		return ret;
 
diff --git a/sound/soc/pxa/spitz.c b/sound/soc/pxa/spitz.c
index f470f36..0680b11 100644
--- a/sound/soc/pxa/spitz.c
+++ b/sound/soc/pxa/spitz.c
@@ -46,61 +46,63 @@ static int spitz_spk_func;
 
 static void spitz_ext_control(struct snd_soc_codec *codec)
 {
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
+
 	if (spitz_spk_func == SPITZ_SPK_ON)
-		snd_soc_dapm_enable_pin(codec, "Ext Spk");
+		snd_soc_dapm_enable_pin(dapm, "Ext Spk");
 	else
-		snd_soc_dapm_disable_pin(codec, "Ext Spk");
+		snd_soc_dapm_disable_pin(dapm, "Ext Spk");
 
 	/* set up jack connection */
 	switch (spitz_jack_func) {
 	case SPITZ_HP:
 		/* enable and unmute hp jack, disable mic bias */
-		snd_soc_dapm_disable_pin(codec, "Headset Jack");
-		snd_soc_dapm_disable_pin(codec, "Mic Jack");
-		snd_soc_dapm_disable_pin(codec, "Line Jack");
-		snd_soc_dapm_enable_pin(codec, "Headphone Jack");
+		snd_soc_dapm_disable_pin(dapm, "Headset Jack");
+		snd_soc_dapm_disable_pin(dapm, "Mic Jack");
+		snd_soc_dapm_disable_pin(dapm, "Line Jack");
+		snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
 		gpio_set_value(SPITZ_GPIO_MUTE_L, 1);
 		gpio_set_value(SPITZ_GPIO_MUTE_R, 1);
 		break;
 	case SPITZ_MIC:
 		/* enable mic jack and bias, mute hp */
-		snd_soc_dapm_disable_pin(codec, "Headphone Jack");
-		snd_soc_dapm_disable_pin(codec, "Headset Jack");
-		snd_soc_dapm_disable_pin(codec, "Line Jack");
-		snd_soc_dapm_enable_pin(codec, "Mic Jack");
+		snd_soc_dapm_disable_pin(dapm, "Headphone Jack");
+		snd_soc_dapm_disable_pin(dapm, "Headset Jack");
+		snd_soc_dapm_disable_pin(dapm, "Line Jack");
+		snd_soc_dapm_enable_pin(dapm, "Mic Jack");
 		gpio_set_value(SPITZ_GPIO_MUTE_L, 0);
 		gpio_set_value(SPITZ_GPIO_MUTE_R, 0);
 		break;
 	case SPITZ_LINE:
 		/* enable line jack, disable mic bias and mute hp */
-		snd_soc_dapm_disable_pin(codec, "Headphone Jack");
-		snd_soc_dapm_disable_pin(codec, "Headset Jack");
-		snd_soc_dapm_disable_pin(codec, "Mic Jack");
-		snd_soc_dapm_enable_pin(codec, "Line Jack");
+		snd_soc_dapm_disable_pin(dapm, "Headphone Jack");
+		snd_soc_dapm_disable_pin(dapm, "Headset Jack");
+		snd_soc_dapm_disable_pin(dapm, "Mic Jack");
+		snd_soc_dapm_enable_pin(dapm, "Line Jack");
 		gpio_set_value(SPITZ_GPIO_MUTE_L, 0);
 		gpio_set_value(SPITZ_GPIO_MUTE_R, 0);
 		break;
 	case SPITZ_HEADSET:
 		/* enable and unmute headset jack enable mic bias, mute L hp */
-		snd_soc_dapm_disable_pin(codec, "Headphone Jack");
-		snd_soc_dapm_enable_pin(codec, "Mic Jack");
-		snd_soc_dapm_disable_pin(codec, "Line Jack");
-		snd_soc_dapm_enable_pin(codec, "Headset Jack");
+		snd_soc_dapm_disable_pin(dapm, "Headphone Jack");
+		snd_soc_dapm_enable_pin(dapm, "Mic Jack");
+		snd_soc_dapm_disable_pin(dapm, "Line Jack");
+		snd_soc_dapm_enable_pin(dapm, "Headset Jack");
 		gpio_set_value(SPITZ_GPIO_MUTE_L, 0);
 		gpio_set_value(SPITZ_GPIO_MUTE_R, 1);
 		break;
 	case SPITZ_HP_OFF:
 
 		/* jack removed, everything off */
-		snd_soc_dapm_disable_pin(codec, "Headphone Jack");
-		snd_soc_dapm_disable_pin(codec, "Headset Jack");
-		snd_soc_dapm_disable_pin(codec, "Mic Jack");
-		snd_soc_dapm_disable_pin(codec, "Line Jack");
+		snd_soc_dapm_disable_pin(dapm, "Headphone Jack");
+		snd_soc_dapm_disable_pin(dapm, "Headset Jack");
+		snd_soc_dapm_disable_pin(dapm, "Mic Jack");
+		snd_soc_dapm_disable_pin(dapm, "Line Jack");
 		gpio_set_value(SPITZ_GPIO_MUTE_L, 0);
 		gpio_set_value(SPITZ_GPIO_MUTE_R, 0);
 		break;
 	}
-	snd_soc_dapm_sync(codec);
+	snd_soc_dapm_sync(dapm);
 }
 
 static int spitz_startup(struct snd_pcm_substream *substream)
@@ -276,16 +278,17 @@ static const struct snd_kcontrol_new wm8750_spitz_controls[] = {
 static int spitz_wm8750_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int err;
 
 	/* NC codec pins */
-	snd_soc_dapm_nc_pin(codec, "RINPUT1");
-	snd_soc_dapm_nc_pin(codec, "LINPUT2");
-	snd_soc_dapm_nc_pin(codec, "RINPUT2");
-	snd_soc_dapm_nc_pin(codec, "LINPUT3");
-	snd_soc_dapm_nc_pin(codec, "RINPUT3");
-	snd_soc_dapm_nc_pin(codec, "OUT3");
-	snd_soc_dapm_nc_pin(codec, "MONO1");
+	snd_soc_dapm_nc_pin(dapm, "RINPUT1");
+	snd_soc_dapm_nc_pin(dapm, "LINPUT2");
+	snd_soc_dapm_nc_pin(dapm, "RINPUT2");
+	snd_soc_dapm_nc_pin(dapm, "LINPUT3");
+	snd_soc_dapm_nc_pin(dapm, "RINPUT3");
+	snd_soc_dapm_nc_pin(dapm, "OUT3");
+	snd_soc_dapm_nc_pin(dapm, "MONO1");
 
 	/* Add spitz specific controls */
 	err = snd_soc_add_controls(codec, wm8750_spitz_controls,
@@ -294,13 +297,13 @@ static int spitz_wm8750_init(struct snd_soc_pcm_runtime *rtd)
 		return err;
 
 	/* Add spitz specific widgets */
-	snd_soc_dapm_new_controls(codec, wm8750_dapm_widgets,
+	snd_soc_dapm_new_controls(dapm, wm8750_dapm_widgets,
 				  ARRAY_SIZE(wm8750_dapm_widgets));
 
 	/* Set up spitz specific audio paths */
-	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
-	snd_soc_dapm_sync(codec);
+	snd_soc_dapm_sync(dapm);
 	return 0;
 }
 
diff --git a/sound/soc/pxa/tavorevb3.c b/sound/soc/pxa/tavorevb3.c
index 248c283..18cbe0e 100644
--- a/sound/soc/pxa/tavorevb3.c
+++ b/sound/soc/pxa/tavorevb3.c
@@ -133,20 +133,21 @@ static struct snd_soc_card snd_soc_card_evb3 = {
 static int evb3_pm860x_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int ret;
 
-	snd_soc_dapm_new_controls(codec, evb3_dapm_widgets,
+	snd_soc_dapm_new_controls(dapm, evb3_dapm_widgets,
 				  ARRAY_SIZE(evb3_dapm_widgets));
-	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
 	/* connected pins */
-	snd_soc_dapm_enable_pin(codec, "Ext Speaker");
-	snd_soc_dapm_enable_pin(codec, "Ext Mic 1");
-	snd_soc_dapm_enable_pin(codec, "Ext Mic 3");
-	snd_soc_dapm_disable_pin(codec, "Headset Mic 2");
-	snd_soc_dapm_disable_pin(codec, "Headset Stereophone");
+	snd_soc_dapm_enable_pin(dapm, "Ext Speaker");
+	snd_soc_dapm_enable_pin(dapm, "Ext Mic 1");
+	snd_soc_dapm_enable_pin(dapm, "Ext Mic 3");
+	snd_soc_dapm_disable_pin(dapm, "Headset Mic 2");
+	snd_soc_dapm_disable_pin(dapm, "Headset Stereophone");
 
-	ret = snd_soc_dapm_sync(codec);
+	ret = snd_soc_dapm_sync(dapm);
 	if (ret)
 		return ret;
 
diff --git a/sound/soc/pxa/tosa.c b/sound/soc/pxa/tosa.c
index 73d0edd..0a9bd68 100644
--- a/sound/soc/pxa/tosa.c
+++ b/sound/soc/pxa/tosa.c
@@ -49,31 +49,33 @@ static int tosa_spk_func;
 
 static void tosa_ext_control(struct snd_soc_codec *codec)
 {
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
+
 	/* set up jack connection */
 	switch (tosa_jack_func) {
 	case TOSA_HP:
-		snd_soc_dapm_disable_pin(codec, "Mic (Internal)");
-		snd_soc_dapm_enable_pin(codec, "Headphone Jack");
-		snd_soc_dapm_disable_pin(codec, "Headset Jack");
+		snd_soc_dapm_disable_pin(dapm, "Mic (Internal)");
+		snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
+		snd_soc_dapm_disable_pin(dapm, "Headset Jack");
 		break;
 	case TOSA_MIC_INT:
-		snd_soc_dapm_enable_pin(codec, "Mic (Internal)");
-		snd_soc_dapm_disable_pin(codec, "Headphone Jack");
-		snd_soc_dapm_disable_pin(codec, "Headset Jack");
+		snd_soc_dapm_enable_pin(dapm, "Mic (Internal)");
+		snd_soc_dapm_disable_pin(dapm, "Headphone Jack");
+		snd_soc_dapm_disable_pin(dapm, "Headset Jack");
 		break;
 	case TOSA_HEADSET:
-		snd_soc_dapm_disable_pin(codec, "Mic (Internal)");
-		snd_soc_dapm_disable_pin(codec, "Headphone Jack");
-		snd_soc_dapm_enable_pin(codec, "Headset Jack");
+		snd_soc_dapm_disable_pin(dapm, "Mic (Internal)");
+		snd_soc_dapm_disable_pin(dapm, "Headphone Jack");
+		snd_soc_dapm_enable_pin(dapm, "Headset Jack");
 		break;
 	}
 
 	if (tosa_spk_func == TOSA_SPK_ON)
-		snd_soc_dapm_enable_pin(codec, "Speaker");
+		snd_soc_dapm_enable_pin(dapm, "Speaker");
 	else
-		snd_soc_dapm_disable_pin(codec, "Speaker");
+		snd_soc_dapm_disable_pin(dapm, "Speaker");
 
-	snd_soc_dapm_sync(codec);
+	snd_soc_dapm_sync(dapm);
 }
 
 static int tosa_startup(struct snd_pcm_substream *substream)
@@ -186,10 +188,11 @@ static const struct snd_kcontrol_new tosa_controls[] = {
 static int tosa_ac97_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int err;
 
-	snd_soc_dapm_nc_pin(codec, "OUT3");
-	snd_soc_dapm_nc_pin(codec, "MONOOUT");
+	snd_soc_dapm_nc_pin(dapm, "OUT3");
+	snd_soc_dapm_nc_pin(dapm, "MONOOUT");
 
 	/* add tosa specific controls */
 	err = snd_soc_add_controls(codec, tosa_controls,
@@ -198,13 +201,13 @@ static int tosa_ac97_init(struct snd_soc_pcm_runtime *rtd)
 		return err;
 
 	/* add tosa specific widgets */
-	snd_soc_dapm_new_controls(codec, tosa_dapm_widgets,
+	snd_soc_dapm_new_controls(dapm, tosa_dapm_widgets,
 				  ARRAY_SIZE(tosa_dapm_widgets));
 
 	/* set up tosa specific audio path audio_map */
-	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
-	snd_soc_dapm_sync(codec);
+	snd_soc_dapm_sync(dapm);
 	return 0;
 }
 
diff --git a/sound/soc/pxa/z2.c b/sound/soc/pxa/z2.c
index 4cc841b..cacbcd4 100644
--- a/sound/soc/pxa/z2.c
+++ b/sound/soc/pxa/z2.c
@@ -140,22 +140,23 @@ static const struct snd_soc_dapm_route audio_map[] = {
 static int z2_wm8750_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int ret;
 
 	/* NC codec pins */
-	snd_soc_dapm_disable_pin(codec, "LINPUT3");
-	snd_soc_dapm_disable_pin(codec, "RINPUT3");
-	snd_soc_dapm_disable_pin(codec, "OUT3");
-	snd_soc_dapm_disable_pin(codec, "MONO");
+	snd_soc_dapm_disable_pin(dapm, "LINPUT3");
+	snd_soc_dapm_disable_pin(dapm, "RINPUT3");
+	snd_soc_dapm_disable_pin(dapm, "OUT3");
+	snd_soc_dapm_disable_pin(dapm, "MONO");
 
 	/* Add z2 specific widgets */
-	snd_soc_dapm_new_controls(codec, wm8750_dapm_widgets,
+	snd_soc_dapm_new_controls(dapm, wm8750_dapm_widgets,
 				 ARRAY_SIZE(wm8750_dapm_widgets));
 
 	/* Set up z2 specific audio paths */
-	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
-	ret = snd_soc_dapm_sync(codec);
+	ret = snd_soc_dapm_sync(dapm);
 	if (ret)
 		goto err;
 
diff --git a/sound/soc/pxa/zylonite.c b/sound/soc/pxa/zylonite.c
index d27e05a..c74eac3 100644
--- a/sound/soc/pxa/zylonite.c
+++ b/sound/soc/pxa/zylonite.c
@@ -73,21 +73,22 @@ static const struct snd_soc_dapm_route audio_map[] = {
 static int zylonite_wm9713_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
 	if (clk_pout)
 		snd_soc_dai_set_pll(rtd->codec_dai, 0, 0,
 				    clk_get_rate(pout), 0);
 
-	snd_soc_dapm_new_controls(codec, zylonite_dapm_widgets,
+	snd_soc_dapm_new_controls(dapm, zylonite_dapm_widgets,
 				  ARRAY_SIZE(zylonite_dapm_widgets));
 
-	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
 	/* Static setup for now */
-	snd_soc_dapm_enable_pin(codec, "Headphone");
-	snd_soc_dapm_enable_pin(codec, "Headset Earpiece");
+	snd_soc_dapm_enable_pin(dapm, "Headphone");
+	snd_soc_dapm_enable_pin(dapm, "Headset Earpiece");
 
-	snd_soc_dapm_sync(codec);
+	snd_soc_dapm_sync(dapm);
 	return 0;
 }
 
diff --git a/sound/soc/s3c24xx/aquila_wm8994.c b/sound/soc/s3c24xx/aquila_wm8994.c
index 235d197..33bebda 100644
--- a/sound/soc/s3c24xx/aquila_wm8994.c
+++ b/sound/soc/s3c24xx/aquila_wm8994.c
@@ -93,27 +93,28 @@ static const struct snd_soc_dapm_route aquila_dapm_routes[] = {
 static int aquila_wm8994_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int ret;
 
 	/* add aquila specific widgets */
-	snd_soc_dapm_new_controls(codec, aquila_dapm_widgets,
+	snd_soc_dapm_new_controls(dapm, aquila_dapm_widgets,
 			ARRAY_SIZE(aquila_dapm_widgets));
 
 	/* set up aquila specific audio routes */
-	snd_soc_dapm_add_routes(codec, aquila_dapm_routes,
+	snd_soc_dapm_add_routes(dapm, aquila_dapm_routes,
 			ARRAY_SIZE(aquila_dapm_routes));
 
 	/* set endpoints to not connected */
-	snd_soc_dapm_nc_pin(codec, "IN2LP:VXRN");
-	snd_soc_dapm_nc_pin(codec, "IN2RP:VXRP");
-	snd_soc_dapm_nc_pin(codec, "LINEOUT1N");
-	snd_soc_dapm_nc_pin(codec, "LINEOUT1P");
-	snd_soc_dapm_nc_pin(codec, "LINEOUT2N");
-	snd_soc_dapm_nc_pin(codec, "LINEOUT2P");
-	snd_soc_dapm_nc_pin(codec, "SPKOUTRN");
-	snd_soc_dapm_nc_pin(codec, "SPKOUTRP");
-
-	snd_soc_dapm_sync(codec);
+	snd_soc_dapm_nc_pin(dapm, "IN2LP:VXRN");
+	snd_soc_dapm_nc_pin(dapm, "IN2RP:VXRP");
+	snd_soc_dapm_nc_pin(dapm, "LINEOUT1N");
+	snd_soc_dapm_nc_pin(dapm, "LINEOUT1P");
+	snd_soc_dapm_nc_pin(dapm, "LINEOUT2N");
+	snd_soc_dapm_nc_pin(dapm, "LINEOUT2P");
+	snd_soc_dapm_nc_pin(dapm, "SPKOUTRN");
+	snd_soc_dapm_nc_pin(dapm, "SPKOUTRP");
+
+	snd_soc_dapm_sync(dapm);
 
 	/* Headset jack detection */
 	ret = snd_soc_jack_new(&aquila, "Headset Jack",
diff --git a/sound/soc/s3c24xx/goni_wm8994.c b/sound/soc/s3c24xx/goni_wm8994.c
index 694f702..052729c 100644
--- a/sound/soc/s3c24xx/goni_wm8994.c
+++ b/sound/soc/s3c24xx/goni_wm8994.c
@@ -97,25 +97,26 @@ static const struct snd_soc_dapm_route goni_dapm_routes[] = {
 static int goni_wm8994_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int ret;
 
 	/* add goni specific widgets */
-	snd_soc_dapm_new_controls(codec, goni_dapm_widgets,
+	snd_soc_dapm_new_controls(dapm, goni_dapm_widgets,
 			ARRAY_SIZE(goni_dapm_widgets));
 
 	/* set up goni specific audio routes */
-	snd_soc_dapm_add_routes(codec, goni_dapm_routes,
+	snd_soc_dapm_add_routes(dapm, goni_dapm_routes,
 			ARRAY_SIZE(goni_dapm_routes));
 
 	/* set endpoints to not connected */
-	snd_soc_dapm_nc_pin(codec, "IN2LP:VXRN");
-	snd_soc_dapm_nc_pin(codec, "IN2RP:VXRP");
-	snd_soc_dapm_nc_pin(codec, "LINEOUT1N");
-	snd_soc_dapm_nc_pin(codec, "LINEOUT1P");
-	snd_soc_dapm_nc_pin(codec, "LINEOUT2N");
-	snd_soc_dapm_nc_pin(codec, "LINEOUT2P");
-
-	snd_soc_dapm_sync(codec);
+	snd_soc_dapm_nc_pin(dapm, "IN2LP:VXRN");
+	snd_soc_dapm_nc_pin(dapm, "IN2RP:VXRP");
+	snd_soc_dapm_nc_pin(dapm, "LINEOUT1N");
+	snd_soc_dapm_nc_pin(dapm, "LINEOUT1P");
+	snd_soc_dapm_nc_pin(dapm, "LINEOUT2N");
+	snd_soc_dapm_nc_pin(dapm, "LINEOUT2P");
+
+	snd_soc_dapm_sync(dapm);
 
 	/* Headset jack detection */
 	ret = snd_soc_jack_new(&goni, "Headset Jack",
diff --git a/sound/soc/s3c24xx/jive_wm8750.c b/sound/soc/s3c24xx/jive_wm8750.c
index 49605cd..e3599e2 100644
--- a/sound/soc/s3c24xx/jive_wm8750.c
+++ b/sound/soc/s3c24xx/jive_wm8750.c
@@ -111,18 +111,19 @@ static struct snd_soc_ops jive_ops = {
 static int jive_wm8750_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int err;
 
 	/* These endpoints are not being used. */
-	snd_soc_dapm_nc_pin(codec, "LINPUT2");
-	snd_soc_dapm_nc_pin(codec, "RINPUT2");
-	snd_soc_dapm_nc_pin(codec, "LINPUT3");
-	snd_soc_dapm_nc_pin(codec, "RINPUT3");
-	snd_soc_dapm_nc_pin(codec, "OUT3");
-	snd_soc_dapm_nc_pin(codec, "MONO");
+	snd_soc_dapm_nc_pin(dapm, "LINPUT2");
+	snd_soc_dapm_nc_pin(dapm, "RINPUT2");
+	snd_soc_dapm_nc_pin(dapm, "LINPUT3");
+	snd_soc_dapm_nc_pin(dapm, "RINPUT3");
+	snd_soc_dapm_nc_pin(dapm, "OUT3");
+	snd_soc_dapm_nc_pin(dapm, "MONO");
 
 	/* Add jive specific widgets */
-	err = snd_soc_dapm_new_controls(codec, wm8750_dapm_widgets,
+	err = snd_soc_dapm_new_controls(dapm, wm8750_dapm_widgets,
 					ARRAY_SIZE(wm8750_dapm_widgets));
 	if (err) {
 		printk(KERN_ERR "%s: failed to add widgets (%d)\n",
@@ -130,8 +131,8 @@ static int jive_wm8750_init(struct snd_soc_pcm_runtime *rtd)
 		return err;
 	}
 
-	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
-	snd_soc_dapm_sync(codec);
+	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
+	snd_soc_dapm_sync(dapm);
 
 	return 0;
 }
diff --git a/sound/soc/s3c24xx/neo1973_gta02_wm8753.c b/sound/soc/s3c24xx/neo1973_gta02_wm8753.c
index e97bdf1..c3f63ef 100644
--- a/sound/soc/s3c24xx/neo1973_gta02_wm8753.c
+++ b/sound/soc/s3c24xx/neo1973_gta02_wm8753.c
@@ -333,16 +333,17 @@ static const struct snd_kcontrol_new wm8753_neo1973_gta02_controls[] = {
 static int neo1973_gta02_wm8753_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int err;
 
 	/* set up NC codec pins */
-	snd_soc_dapm_nc_pin(codec, "OUT3");
-	snd_soc_dapm_nc_pin(codec, "OUT4");
-	snd_soc_dapm_nc_pin(codec, "LINE1");
-	snd_soc_dapm_nc_pin(codec, "LINE2");
+	snd_soc_dapm_nc_pin(dapm, "OUT3");
+	snd_soc_dapm_nc_pin(dapm, "OUT4");
+	snd_soc_dapm_nc_pin(dapm, "LINE1");
+	snd_soc_dapm_nc_pin(dapm, "LINE2");
 
 	/* Add neo1973 gta02 specific widgets */
-	snd_soc_dapm_new_controls(codec, wm8753_dapm_widgets,
+	snd_soc_dapm_new_controls(dapm, wm8753_dapm_widgets,
 				  ARRAY_SIZE(wm8753_dapm_widgets));
 
 	/* add neo1973 gta02 specific controls */
@@ -353,25 +354,25 @@ static int neo1973_gta02_wm8753_init(struct snd_soc_pcm_runtime *rtd)
 		return err;
 
 	/* set up neo1973 gta02 specific audio path audio_map */
-	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
 	/* set endpoints to default off mode */
-	snd_soc_dapm_disable_pin(codec, "Stereo Out");
-	snd_soc_dapm_disable_pin(codec, "GSM Line Out");
-	snd_soc_dapm_disable_pin(codec, "GSM Line In");
-	snd_soc_dapm_disable_pin(codec, "Headset Mic");
-	snd_soc_dapm_disable_pin(codec, "Handset Mic");
-	snd_soc_dapm_disable_pin(codec, "Handset Spk");
+	snd_soc_dapm_disable_pin(dapm, "Stereo Out");
+	snd_soc_dapm_disable_pin(dapm, "GSM Line Out");
+	snd_soc_dapm_disable_pin(dapm, "GSM Line In");
+	snd_soc_dapm_disable_pin(dapm, "Headset Mic");
+	snd_soc_dapm_disable_pin(dapm, "Handset Mic");
+	snd_soc_dapm_disable_pin(dapm, "Handset Spk");
 
 	/* allow audio paths from the GSM modem to run during suspend */
-	snd_soc_dapm_ignore_suspend(codec, "Stereo Out");
-	snd_soc_dapm_ignore_suspend(codec, "GSM Line Out");
-	snd_soc_dapm_ignore_suspend(codec, "GSM Line In");
-	snd_soc_dapm_ignore_suspend(codec, "Headset Mic");
-	snd_soc_dapm_ignore_suspend(codec, "Handset Mic");
-	snd_soc_dapm_ignore_suspend(codec, "Handset Spk");
-
-	snd_soc_dapm_sync(codec);
+	snd_soc_dapm_ignore_suspend(dapm, "Stereo Out");
+	snd_soc_dapm_ignore_suspend(dapm, "GSM Line Out");
+	snd_soc_dapm_ignore_suspend(dapm, "GSM Line In");
+	snd_soc_dapm_ignore_suspend(dapm, "Headset Mic");
+	snd_soc_dapm_ignore_suspend(dapm, "Handset Mic");
+	snd_soc_dapm_ignore_suspend(dapm, "Handset Spk");
+
+	snd_soc_dapm_sync(dapm);
 
 	return 0;
 }
diff --git a/sound/soc/s3c24xx/neo1973_wm8753.c b/sound/soc/s3c24xx/neo1973_wm8753.c
index f4f2ee7..e94ffe0 100644
--- a/sound/soc/s3c24xx/neo1973_wm8753.c
+++ b/sound/soc/s3c24xx/neo1973_wm8753.c
@@ -237,81 +237,83 @@ static int neo1973_get_scenario(struct snd_kcontrol *kcontrol,
 
 static int set_scenario_endpoints(struct snd_soc_codec *codec, int scenario)
 {
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
+
 	pr_debug("Entered %s\n", __func__);
 
 	switch (neo1973_scenario) {
 	case NEO_AUDIO_OFF:
-		snd_soc_dapm_disable_pin(codec, "Audio Out");
-		snd_soc_dapm_disable_pin(codec, "GSM Line Out");
-		snd_soc_dapm_disable_pin(codec, "GSM Line In");
-		snd_soc_dapm_disable_pin(codec, "Headset Mic");
-		snd_soc_dapm_disable_pin(codec, "Call Mic");
+		snd_soc_dapm_disable_pin(dapm, "Audio Out");
+		snd_soc_dapm_disable_pin(dapm, "GSM Line Out");
+		snd_soc_dapm_disable_pin(dapm, "GSM Line In");
+		snd_soc_dapm_disable_pin(dapm, "Headset Mic");
+		snd_soc_dapm_disable_pin(dapm, "Call Mic");
 		break;
 	case NEO_GSM_CALL_AUDIO_HANDSET:
-		snd_soc_dapm_enable_pin(codec, "Audio Out");
-		snd_soc_dapm_enable_pin(codec, "GSM Line Out");
-		snd_soc_dapm_enable_pin(codec, "GSM Line In");
-		snd_soc_dapm_disable_pin(codec, "Headset Mic");
-		snd_soc_dapm_enable_pin(codec, "Call Mic");
+		snd_soc_dapm_enable_pin(dapm, "Audio Out");
+		snd_soc_dapm_enable_pin(dapm, "GSM Line Out");
+		snd_soc_dapm_enable_pin(dapm, "GSM Line In");
+		snd_soc_dapm_disable_pin(dapm, "Headset Mic");
+		snd_soc_dapm_enable_pin(dapm, "Call Mic");
 		break;
 	case NEO_GSM_CALL_AUDIO_HEADSET:
-		snd_soc_dapm_enable_pin(codec, "Audio Out");
-		snd_soc_dapm_enable_pin(codec, "GSM Line Out");
-		snd_soc_dapm_enable_pin(codec, "GSM Line In");
-		snd_soc_dapm_enable_pin(codec, "Headset Mic");
-		snd_soc_dapm_disable_pin(codec, "Call Mic");
+		snd_soc_dapm_enable_pin(dapm, "Audio Out");
+		snd_soc_dapm_enable_pin(dapm, "GSM Line Out");
+		snd_soc_dapm_enable_pin(dapm, "GSM Line In");
+		snd_soc_dapm_enable_pin(dapm, "Headset Mic");
+		snd_soc_dapm_disable_pin(dapm, "Call Mic");
 		break;
 	case NEO_GSM_CALL_AUDIO_BLUETOOTH:
-		snd_soc_dapm_disable_pin(codec, "Audio Out");
-		snd_soc_dapm_enable_pin(codec, "GSM Line Out");
-		snd_soc_dapm_enable_pin(codec, "GSM Line In");
-		snd_soc_dapm_disable_pin(codec, "Headset Mic");
-		snd_soc_dapm_disable_pin(codec, "Call Mic");
+		snd_soc_dapm_disable_pin(dapm, "Audio Out");
+		snd_soc_dapm_enable_pin(dapm, "GSM Line Out");
+		snd_soc_dapm_enable_pin(dapm, "GSM Line In");
+		snd_soc_dapm_disable_pin(dapm, "Headset Mic");
+		snd_soc_dapm_disable_pin(dapm, "Call Mic");
 		break;
 	case NEO_STEREO_TO_SPEAKERS:
-		snd_soc_dapm_enable_pin(codec, "Audio Out");
-		snd_soc_dapm_disable_pin(codec, "GSM Line Out");
-		snd_soc_dapm_disable_pin(codec, "GSM Line In");
-		snd_soc_dapm_disable_pin(codec, "Headset Mic");
-		snd_soc_dapm_disable_pin(codec, "Call Mic");
+		snd_soc_dapm_enable_pin(dapm, "Audio Out");
+		snd_soc_dapm_disable_pin(dapm, "GSM Line Out");
+		snd_soc_dapm_disable_pin(dapm, "GSM Line In");
+		snd_soc_dapm_disable_pin(dapm, "Headset Mic");
+		snd_soc_dapm_disable_pin(dapm, "Call Mic");
 		break;
 	case NEO_STEREO_TO_HEADPHONES:
-		snd_soc_dapm_enable_pin(codec, "Audio Out");
-		snd_soc_dapm_disable_pin(codec, "GSM Line Out");
-		snd_soc_dapm_disable_pin(codec, "GSM Line In");
-		snd_soc_dapm_disable_pin(codec, "Headset Mic");
-		snd_soc_dapm_disable_pin(codec, "Call Mic");
+		snd_soc_dapm_enable_pin(dapm, "Audio Out");
+		snd_soc_dapm_disable_pin(dapm, "GSM Line Out");
+		snd_soc_dapm_disable_pin(dapm, "GSM Line In");
+		snd_soc_dapm_disable_pin(dapm, "Headset Mic");
+		snd_soc_dapm_disable_pin(dapm, "Call Mic");
 		break;
 	case NEO_CAPTURE_HANDSET:
-		snd_soc_dapm_disable_pin(codec, "Audio Out");
-		snd_soc_dapm_disable_pin(codec, "GSM Line Out");
-		snd_soc_dapm_disable_pin(codec, "GSM Line In");
-		snd_soc_dapm_disable_pin(codec, "Headset Mic");
-		snd_soc_dapm_enable_pin(codec, "Call Mic");
+		snd_soc_dapm_disable_pin(dapm, "Audio Out");
+		snd_soc_dapm_disable_pin(dapm, "GSM Line Out");
+		snd_soc_dapm_disable_pin(dapm, "GSM Line In");
+		snd_soc_dapm_disable_pin(dapm, "Headset Mic");
+		snd_soc_dapm_enable_pin(dapm, "Call Mic");
 		break;
 	case NEO_CAPTURE_HEADSET:
-		snd_soc_dapm_disable_pin(codec, "Audio Out");
-		snd_soc_dapm_disable_pin(codec, "GSM Line Out");
-		snd_soc_dapm_disable_pin(codec, "GSM Line In");
-		snd_soc_dapm_enable_pin(codec, "Headset Mic");
-		snd_soc_dapm_disable_pin(codec, "Call Mic");
+		snd_soc_dapm_disable_pin(dapm, "Audio Out");
+		snd_soc_dapm_disable_pin(dapm, "GSM Line Out");
+		snd_soc_dapm_disable_pin(dapm, "GSM Line In");
+		snd_soc_dapm_enable_pin(dapm, "Headset Mic");
+		snd_soc_dapm_disable_pin(dapm, "Call Mic");
 		break;
 	case NEO_CAPTURE_BLUETOOTH:
-		snd_soc_dapm_disable_pin(codec, "Audio Out");
-		snd_soc_dapm_disable_pin(codec, "GSM Line Out");
-		snd_soc_dapm_disable_pin(codec, "GSM Line In");
-		snd_soc_dapm_disable_pin(codec, "Headset Mic");
-		snd_soc_dapm_disable_pin(codec, "Call Mic");
+		snd_soc_dapm_disable_pin(dapm, "Audio Out");
+		snd_soc_dapm_disable_pin(dapm, "GSM Line Out");
+		snd_soc_dapm_disable_pin(dapm, "GSM Line In");
+		snd_soc_dapm_disable_pin(dapm, "Headset Mic");
+		snd_soc_dapm_disable_pin(dapm, "Call Mic");
 		break;
 	default:
-		snd_soc_dapm_disable_pin(codec, "Audio Out");
-		snd_soc_dapm_disable_pin(codec, "GSM Line Out");
-		snd_soc_dapm_disable_pin(codec, "GSM Line In");
-		snd_soc_dapm_disable_pin(codec, "Headset Mic");
-		snd_soc_dapm_disable_pin(codec, "Call Mic");
+		snd_soc_dapm_disable_pin(dapm, "Audio Out");
+		snd_soc_dapm_disable_pin(dapm, "GSM Line Out");
+		snd_soc_dapm_disable_pin(dapm, "GSM Line In");
+		snd_soc_dapm_disable_pin(dapm, "Headset Mic");
+		snd_soc_dapm_disable_pin(dapm, "Call Mic");
 	}
 
-	snd_soc_dapm_sync(codec);
+	snd_soc_dapm_sync(dapm);
 
 	return 0;
 }
@@ -502,20 +504,21 @@ static const struct snd_kcontrol_new wm8753_neo1973_controls[] = {
 static int neo1973_wm8753_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int err;
 
 	pr_debug("Entered %s\n", __func__);
 
 	/* set up NC codec pins */
-	snd_soc_dapm_nc_pin(codec, "LOUT2");
-	snd_soc_dapm_nc_pin(codec, "ROUT2");
-	snd_soc_dapm_nc_pin(codec, "OUT3");
-	snd_soc_dapm_nc_pin(codec, "OUT4");
-	snd_soc_dapm_nc_pin(codec, "LINE1");
-	snd_soc_dapm_nc_pin(codec, "LINE2");
+	snd_soc_dapm_nc_pin(dapm, "LOUT2");
+	snd_soc_dapm_nc_pin(dapm, "ROUT2");
+	snd_soc_dapm_nc_pin(dapm, "OUT3");
+	snd_soc_dapm_nc_pin(dapm, "OUT4");
+	snd_soc_dapm_nc_pin(dapm, "LINE1");
+	snd_soc_dapm_nc_pin(dapm, "LINE2");
 
 	/* Add neo1973 specific widgets */
-	snd_soc_dapm_new_controls(codec, wm8753_dapm_widgets,
+	snd_soc_dapm_new_controls(dapm, wm8753_dapm_widgets,
 				  ARRAY_SIZE(wm8753_dapm_widgets));
 
 	/* set endpoints to default mode */
@@ -528,10 +531,10 @@ static int neo1973_wm8753_init(struct snd_soc_pcm_runtime *rtd)
 		return err;
 
 	/* set up neo1973 specific audio routes */
-	err = snd_soc_dapm_add_routes(codec, dapm_routes,
+	err = snd_soc_dapm_add_routes(dapm, dapm_routes,
 				      ARRAY_SIZE(dapm_routes));
 
-	snd_soc_dapm_sync(codec);
+	snd_soc_dapm_sync(dapm);
 	return 0;
 }
 
diff --git a/sound/soc/s3c24xx/rx1950_uda1380.c b/sound/soc/s3c24xx/rx1950_uda1380.c
index ffd5cf2..105d177 100644
--- a/sound/soc/s3c24xx/rx1950_uda1380.c
+++ b/sound/soc/s3c24xx/rx1950_uda1380.c
@@ -232,26 +232,27 @@ static int rx1950_hw_params(struct snd_pcm_substream *substream,
 static int rx1950_uda1380_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int err;
 
 	/* Add rx1950 specific widgets */
-	err = snd_soc_dapm_new_controls(codec, uda1380_dapm_widgets,
+	err = snd_soc_dapm_new_controls(dapm, uda1380_dapm_widgets,
 				  ARRAY_SIZE(uda1380_dapm_widgets));
 
 	if (err)
 		return err;
 
 	/* Set up rx1950 specific audio path audio_mapnects */
-	err = snd_soc_dapm_add_routes(codec, audio_map,
+	err = snd_soc_dapm_add_routes(dapm, audio_map,
 				      ARRAY_SIZE(audio_map));
 
 	if (err)
 		return err;
 
-	snd_soc_dapm_enable_pin(codec, "Headphone Jack");
-	snd_soc_dapm_enable_pin(codec, "Speaker");
+	snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
+	snd_soc_dapm_enable_pin(dapm, "Speaker");
 
-	snd_soc_dapm_sync(codec);
+	snd_soc_dapm_sync(dapm);
 
 	snd_soc_jack_new(codec, "Headphone Jack", SND_JACK_HEADPHONE,
 		&hp_jack);
diff --git a/sound/soc/s3c24xx/s3c24xx_simtec_hermes.c b/sound/soc/s3c24xx/s3c24xx_simtec_hermes.c
index f884537..05c7937 100644
--- a/sound/soc/s3c24xx/s3c24xx_simtec_hermes.c
+++ b/sound/soc/s3c24xx/s3c24xx_simtec_hermes.c
@@ -76,19 +76,20 @@ static const struct snd_soc_dapm_route base_map[] = {
 static int simtec_hermes_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
-	snd_soc_dapm_new_controls(codec, dapm_widgets,
+	snd_soc_dapm_new_controls(dapm, dapm_widgets,
 				  ARRAY_SIZE(dapm_widgets));
 
-	snd_soc_dapm_add_routes(codec, base_map, ARRAY_SIZE(base_map));
+	snd_soc_dapm_add_routes(dapm, base_map, ARRAY_SIZE(base_map));
 
-	snd_soc_dapm_enable_pin(codec, "Headphone Jack");
-	snd_soc_dapm_enable_pin(codec, "Line In");
-	snd_soc_dapm_enable_pin(codec, "Line Out");
-	snd_soc_dapm_enable_pin(codec, "Mic Jack");
+	snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
+	snd_soc_dapm_enable_pin(dapm, "Line In");
+	snd_soc_dapm_enable_pin(dapm, "Line Out");
+	snd_soc_dapm_enable_pin(dapm, "Mic Jack");
 
 	simtec_audio_init(rtd);
-	snd_soc_dapm_sync(codec);
+	snd_soc_dapm_sync(dapm);
 
 	return 0;
 }
diff --git a/sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c b/sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c
index c096759..653dc75 100644
--- a/sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c
+++ b/sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c
@@ -65,19 +65,20 @@ static const struct snd_soc_dapm_route base_map[] = {
 static int simtec_tlv320aic23_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
-	snd_soc_dapm_new_controls(codec, dapm_widgets,
+	snd_soc_dapm_new_controls(dapm, dapm_widgets,
 				  ARRAY_SIZE(dapm_widgets));
 
-	snd_soc_dapm_add_routes(codec, base_map, ARRAY_SIZE(base_map));
+	snd_soc_dapm_add_routes(dapm, base_map, ARRAY_SIZE(base_map));
 
-	snd_soc_dapm_enable_pin(codec, "Headphone Jack");
-	snd_soc_dapm_enable_pin(codec, "Line In");
-	snd_soc_dapm_enable_pin(codec, "Line Out");
-	snd_soc_dapm_enable_pin(codec, "Mic Jack");
+	snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
+	snd_soc_dapm_enable_pin(dapm, "Line In");
+	snd_soc_dapm_enable_pin(dapm, "Line Out");
+	snd_soc_dapm_enable_pin(dapm, "Mic Jack");
 
 	simtec_audio_init(rtd);
-	snd_soc_dapm_sync(codec);
+	snd_soc_dapm_sync(dapm);
 
 	return 0;
 }
diff --git a/sound/soc/s3c24xx/smartq_wm8987.c b/sound/soc/s3c24xx/smartq_wm8987.c
index dd20ca7..1f6da1e 100644
--- a/sound/soc/s3c24xx/smartq_wm8987.c
+++ b/sound/soc/s3c24xx/smartq_wm8987.c
@@ -158,10 +158,11 @@ static const struct snd_soc_dapm_route audio_map[] = {
 
 static int smartq_wm8987_init(struct snd_soc_codec *codec)
 {
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int err = 0;
 
 	/* Add SmartQ specific widgets */
-	snd_soc_dapm_new_controls(codec, wm8987_dapm_widgets,
+	snd_soc_dapm_new_controls(dapm, wm8987_dapm_widgets,
 				  ARRAY_SIZE(wm8987_dapm_widgets));
 
 	/* add SmartQ specific controls */
@@ -172,20 +173,20 @@ static int smartq_wm8987_init(struct snd_soc_codec *codec)
 		return err;
 
 	/* setup SmartQ specific audio path */
-	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
 	/* set endpoints to not connected */
-	snd_soc_dapm_nc_pin(codec, "LINPUT1");
-	snd_soc_dapm_nc_pin(codec, "RINPUT1");
-	snd_soc_dapm_nc_pin(codec, "OUT3");
-	snd_soc_dapm_nc_pin(codec, "ROUT1");
+	snd_soc_dapm_nc_pin(dapm, "LINPUT1");
+	snd_soc_dapm_nc_pin(dapm, "RINPUT1");
+	snd_soc_dapm_nc_pin(dapm, "OUT3");
+	snd_soc_dapm_nc_pin(dapm, "ROUT1");
 
 	/* set endpoints to default off mode */
-	snd_soc_dapm_enable_pin(codec, "Internal Speaker");
-	snd_soc_dapm_enable_pin(codec, "Internal Mic");
-	snd_soc_dapm_disable_pin(codec, "Headphone Jack");
+	snd_soc_dapm_enable_pin(dapm, "Internal Speaker");
+	snd_soc_dapm_enable_pin(dapm, "Internal Mic");
+	snd_soc_dapm_disable_pin(dapm, "Headphone Jack");
 
-	err = snd_soc_dapm_sync(codec);
+	err = snd_soc_dapm_sync(dapm);
 	if (err)
 		return err;
 
diff --git a/sound/soc/s3c24xx/smdk64xx_wm8580.c b/sound/soc/s3c24xx/smdk64xx_wm8580.c
index 052e499..291939c 100644
--- a/sound/soc/s3c24xx/smdk64xx_wm8580.c
+++ b/sound/soc/s3c24xx/smdk64xx_wm8580.c
@@ -182,21 +182,22 @@ static const struct snd_soc_dapm_route audio_map_rx[] = {
 static int smdk64xx_wm8580_init_paiftx(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
 	/* Add smdk64xx specific Capture widgets */
-	snd_soc_dapm_new_controls(codec, wm8580_dapm_widgets_cpt,
+	snd_soc_dapm_new_controls(dapm, wm8580_dapm_widgets_cpt,
 				  ARRAY_SIZE(wm8580_dapm_widgets_cpt));
 
 	/* Set up PAIFTX audio path */
-	snd_soc_dapm_add_routes(codec, audio_map_tx, ARRAY_SIZE(audio_map_tx));
+	snd_soc_dapm_add_routes(dapm, audio_map_tx, ARRAY_SIZE(audio_map_tx));
 
 	/* Enabling the microphone requires the fitting of a 0R
 	 * resistor to connect the line from the microphone jack.
 	 */
-	snd_soc_dapm_disable_pin(codec, "MicIn");
+	snd_soc_dapm_disable_pin(dapm, "MicIn");
 
 	/* signal a DAPM event */
-	snd_soc_dapm_sync(codec);
+	snd_soc_dapm_sync(dapm);
 
 	return 0;
 }
@@ -204,16 +205,17 @@ static int smdk64xx_wm8580_init_paiftx(struct snd_soc_pcm_runtime *rtd)
 static int smdk64xx_wm8580_init_paifrx(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
 	/* Add smdk64xx specific Playback widgets */
-	snd_soc_dapm_new_controls(codec, wm8580_dapm_widgets_pbk,
+	snd_soc_dapm_new_controls(dapm, wm8580_dapm_widgets_pbk,
 				  ARRAY_SIZE(wm8580_dapm_widgets_pbk));
 
 	/* Set up PAIFRX audio path */
-	snd_soc_dapm_add_routes(codec, audio_map_rx, ARRAY_SIZE(audio_map_rx));
+	snd_soc_dapm_add_routes(dapm, audio_map_rx, ARRAY_SIZE(audio_map_rx));
 
 	/* signal a DAPM event */
-	snd_soc_dapm_sync(codec);
+	snd_soc_dapm_sync(dapm);
 
 	return 0;
 }
diff --git a/sound/soc/s6000/s6105-ipcam.c b/sound/soc/s6000/s6105-ipcam.c
index 96c05e1..db1803d 100644
--- a/sound/soc/s6000/s6105-ipcam.c
+++ b/sound/soc/s6000/s6105-ipcam.c
@@ -107,6 +107,7 @@ static int output_type_put(struct snd_kcontrol *kcontrol,
 			   struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_codec *codec = kcontrol->private_data;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	unsigned int val = (ucontrol->value.enumerated.item[0] != 0);
 	char *differential = "Audio Out Differential";
 	char *stereo = "Audio Out Stereo";
@@ -114,10 +115,10 @@ static int output_type_put(struct snd_kcontrol *kcontrol,
 	if (kcontrol->private_value == val)
 		return 0;
 	kcontrol->private_value = val;
-	snd_soc_dapm_disable_pin(codec, val ? differential : stereo);
-	snd_soc_dapm_sync(codec);
-	snd_soc_dapm_enable_pin(codec, val ? stereo : differential);
-	snd_soc_dapm_sync(codec);
+	snd_soc_dapm_disable_pin(dapm, val ? differential : stereo);
+	snd_soc_dapm_sync(dapm);
+	snd_soc_dapm_enable_pin(dapm, val ? stereo : differential);
+	snd_soc_dapm_sync(dapm);
 
 	return 1;
 }
@@ -137,35 +138,36 @@ static const struct snd_kcontrol_new audio_out_mux = {
 static int s6105_aic3x_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
 	/* Add s6105 specific widgets */
-	snd_soc_dapm_new_controls(codec, aic3x_dapm_widgets,
+	snd_soc_dapm_new_controls(dapm, aic3x_dapm_widgets,
 				  ARRAY_SIZE(aic3x_dapm_widgets));
 
 	/* Set up s6105 specific audio path audio_map */
-	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
 	/* not present */
-	snd_soc_dapm_nc_pin(codec, "MONO_LOUT");
-	snd_soc_dapm_nc_pin(codec, "LINE2L");
-	snd_soc_dapm_nc_pin(codec, "LINE2R");
+	snd_soc_dapm_nc_pin(dapm, "MONO_LOUT");
+	snd_soc_dapm_nc_pin(dapm, "LINE2L");
+	snd_soc_dapm_nc_pin(dapm, "LINE2R");
 
 	/* not connected */
-	snd_soc_dapm_nc_pin(codec, "MIC3L"); /* LINE2L on this chip */
-	snd_soc_dapm_nc_pin(codec, "MIC3R"); /* LINE2R on this chip */
-	snd_soc_dapm_nc_pin(codec, "LLOUT");
-	snd_soc_dapm_nc_pin(codec, "RLOUT");
-	snd_soc_dapm_nc_pin(codec, "HPRCOM");
+	snd_soc_dapm_nc_pin(dapm, "MIC3L"); /* LINE2L on this chip */
+	snd_soc_dapm_nc_pin(dapm, "MIC3R"); /* LINE2R on this chip */
+	snd_soc_dapm_nc_pin(dapm, "LLOUT");
+	snd_soc_dapm_nc_pin(dapm, "RLOUT");
+	snd_soc_dapm_nc_pin(dapm, "HPRCOM");
 
 	/* always connected */
-	snd_soc_dapm_enable_pin(codec, "Audio In");
+	snd_soc_dapm_enable_pin(dapm, "Audio In");
 
 	/* must correspond to audio_out_mux.private_value initializer */
-	snd_soc_dapm_disable_pin(codec, "Audio Out Differential");
-	snd_soc_dapm_sync(codec);
-	snd_soc_dapm_enable_pin(codec, "Audio Out Stereo");
+	snd_soc_dapm_disable_pin(dapm, "Audio Out Differential");
+	snd_soc_dapm_sync(dapm);
+	snd_soc_dapm_enable_pin(dapm, "Audio Out Stereo");
 
-	snd_soc_dapm_sync(codec);
+	snd_soc_dapm_sync(dapm);
 
 	snd_ctl_add(codec->snd_card, snd_ctl_new1(&audio_out_mux, codec));
 
diff --git a/sound/soc/sh/migor.c b/sound/soc/sh/migor.c
index ac6c49c..c61fc18 100644
--- a/sound/soc/sh/migor.c
+++ b/sound/soc/sh/migor.c
@@ -140,11 +140,12 @@ static const struct snd_soc_dapm_route audio_map[] = {
 static int migor_dai_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
-	snd_soc_dapm_new_controls(codec, migor_dapm_widgets,
+	snd_soc_dapm_new_controls(dapm, migor_dapm_widgets,
 				  ARRAY_SIZE(migor_dapm_widgets));
 
-	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
 	return 0;
 }
diff --git a/sound/soc/sh/sh7760-ac97.c b/sound/soc/sh/sh7760-ac97.c
index f8e0ab8..105d411 100644
--- a/sound/soc/sh/sh7760-ac97.c
+++ b/sound/soc/sh/sh7760-ac97.c
@@ -23,7 +23,7 @@ extern struct snd_soc_platform_driver sh7760_soc_platform;
 
 static int machine_init(struct snd_soc_pcm_runtime *rtd)
 {
-	snd_soc_dapm_sync(rtd->codec);
+	snd_soc_dapm_sync(&rtd->codec->dapm);
 	return 0;
 }
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 4360436..abbeadf 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -255,18 +255,18 @@ static void soc_init_codec_debugfs(struct snd_soc_codec *codec)
 
 	codec->debugfs_pop_time = debugfs_create_u32("dapm_pop_time", 0644,
 						     codec->debugfs_codec_root,
-						     &codec->pop_time);
+						     &codec->dapm.pop_time);
 	if (!codec->debugfs_pop_time)
 		printk(KERN_WARNING
 		       "Failed to create pop time debugfs file\n");
 
-	codec->debugfs_dapm = debugfs_create_dir("dapm",
+	codec->dapm.debugfs_dapm = debugfs_create_dir("dapm",
 						 codec->debugfs_codec_root);
-	if (!codec->debugfs_dapm)
+	if (!codec->dapm.debugfs_dapm)
 		printk(KERN_WARNING
 		       "Failed to create DAPM debugfs directory\n");
 
-	snd_soc_dapm_debugfs_init(codec);
+	snd_soc_dapm_debugfs_init(&codec->dapm);
 }
 
 static void soc_cleanup_codec_debugfs(struct snd_soc_codec *codec)
@@ -1017,7 +1017,7 @@ static int soc_suspend(struct device *dev)
 	/* close any waiting streams and save state */
 	for (i = 0; i < card->num_rtd; i++) {
 		run_delayed_work(&card->rtd[i].delayed_work);
-		card->rtd[i].codec->suspend_bias_level = card->rtd[i].codec->bias_level;
+		card->rtd[i].codec->dapm.suspend_bias_level = card->rtd[i].codec->dapm.bias_level;
 	}
 
 	for (i = 0; i < card->num_rtd; i++) {
@@ -1041,7 +1041,7 @@ static int soc_suspend(struct device *dev)
 		/* If there are paths active then the CODEC will be held with
 		 * bias _ON and should not be suspended. */
 		if (!codec->suspended && codec->driver->suspend) {
-			switch (codec->bias_level) {
+			switch (codec->dapm.bias_level) {
 			case SND_SOC_BIAS_STANDBY:
 			case SND_SOC_BIAS_OFF:
 				codec->driver->suspend(codec, PMSG_SUSPEND);
@@ -1110,7 +1110,7 @@ static void soc_resume_deferred(struct work_struct *work)
 		 * resume.  Otherwise the suspend was suppressed.
 		 */
 		if (codec->driver->resume && codec->suspended) {
-			switch (codec->bias_level) {
+			switch (codec->dapm.bias_level) {
 			case SND_SOC_BIAS_STANDBY:
 			case SND_SOC_BIAS_OFF:
 				codec->driver->resume(codec);
@@ -1346,7 +1346,7 @@ static void soc_remove_dai_link(struct snd_soc_card *card, int num)
 		}
 
 		/* Make sure all DAPM widgets are freed */
-		snd_soc_dapm_free(codec);
+		snd_soc_dapm_free(&codec->dapm);
 
 		soc_cleanup_codec_debugfs(codec);
 		device_remove_file(&rtd->dev, &dev_attr_codec_reg);
@@ -1470,8 +1470,8 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num)
 	}
 
 	/* Make sure all DAPM widgets are instantiated */
-	snd_soc_dapm_new_widgets(codec);
-	snd_soc_dapm_sync(codec);
+	snd_soc_dapm_new_widgets(&codec->dapm);
+	snd_soc_dapm_sync(&codec->dapm);
 
 	/* register the rtd device */
 	rtd->dev.release = rtd_release;
@@ -3236,6 +3236,12 @@ int snd_soc_register_codec(struct device *dev,
 		return -ENOMEM;
 	}
 
+	INIT_LIST_HEAD(&codec->dapm.widgets);
+	INIT_LIST_HEAD(&codec->dapm.paths);
+	codec->dapm.bias_level = SND_SOC_BIAS_OFF;
+	codec->dapm.dev = dev;
+	codec->dapm.codec = codec;
+
 	/* allocate CODEC register cache */
 	if (codec_drv->reg_cache_size && codec_drv->reg_word_size) {
 
@@ -3255,11 +3261,8 @@ int snd_soc_register_codec(struct device *dev,
 
 	codec->dev = dev;
 	codec->driver = codec_drv;
-	codec->bias_level = SND_SOC_BIAS_OFF;
 	codec->num_dai = num_dai;
 	mutex_init(&codec->mutex);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
 
 	for (i = 0; i < num_dai; i++) {
 		fixup_codec_formats(&dai_drv[i].playback);
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 7d85c64..b8f653e 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -42,6 +42,7 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
+#include <sound/soc.h>
 #include <sound/soc-dapm.h>
 #include <sound/initval.h>
 
@@ -120,35 +121,36 @@ static inline struct snd_soc_dapm_widget *dapm_cnew_widget(
  * Returns 0 for success else error.
  */
 static int snd_soc_dapm_set_bias_level(struct snd_soc_card *card,
-		struct snd_soc_codec *codec, enum snd_soc_bias_level level)
+				       struct snd_soc_dapm_context *dapm,
+				       enum snd_soc_bias_level level)
 {
 	int ret = 0;
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
-		dev_dbg(codec->dev, "Setting full bias\n");
+		dev_dbg(dapm->dev, "Setting full bias\n");
 		break;
 	case SND_SOC_BIAS_PREPARE:
-		dev_dbg(codec->dev, "Setting bias prepare\n");
+		dev_dbg(dapm->dev, "Setting bias prepare\n");
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		dev_dbg(codec->dev, "Setting standby bias\n");
+		dev_dbg(dapm->dev, "Setting standby bias\n");
 		break;
 	case SND_SOC_BIAS_OFF:
-		dev_dbg(codec->dev, "Setting bias off\n");
+		dev_dbg(dapm->dev, "Setting bias off\n");
 		break;
 	default:
-		dev_err(codec->dev, "Setting invalid bias %d\n", level);
+		dev_err(dapm->dev, "Setting invalid bias %d\n", level);
 		return -EINVAL;
 	}
 
 	if (card && card->set_bias_level)
 		ret = card->set_bias_level(card, level);
 	if (ret == 0) {
-		if (codec->driver->set_bias_level)
-			ret = codec->driver->set_bias_level(codec, level);
+		if (dapm->codec && dapm->codec->driver->set_bias_level)
+			ret = dapm->codec->driver->set_bias_level(dapm->codec, level);
 		else
-			codec->bias_level = level;
+			dapm->bias_level = level;
 	}
 
 	return ret;
@@ -241,7 +243,7 @@ static void dapm_set_path_status(struct snd_soc_dapm_widget *w,
 }
 
 /* connect mux widget to its interconnecting audio paths */
-static int dapm_connect_mux(struct snd_soc_codec *codec,
+static int dapm_connect_mux(struct snd_soc_dapm_context *dapm,
 	struct snd_soc_dapm_widget *src, struct snd_soc_dapm_widget *dest,
 	struct snd_soc_dapm_path *path, const char *control_name,
 	const struct snd_kcontrol_new *kcontrol)
@@ -251,7 +253,7 @@ static int dapm_connect_mux(struct snd_soc_codec *codec,
 
 	for (i = 0; i < e->max; i++) {
 		if (!(strcmp(control_name, e->texts[i]))) {
-			list_add(&path->list, &codec->dapm_paths);
+			list_add(&path->list, &dapm->paths);
 			list_add(&path->list_sink, &dest->sources);
 			list_add(&path->list_source, &src->sinks);
 			path->name = (char*)e->texts[i];
@@ -264,7 +266,7 @@ static int dapm_connect_mux(struct snd_soc_codec *codec,
 }
 
 /* connect mixer widget to its interconnecting audio paths */
-static int dapm_connect_mixer(struct snd_soc_codec *codec,
+static int dapm_connect_mixer(struct snd_soc_dapm_context *dapm,
 	struct snd_soc_dapm_widget *src, struct snd_soc_dapm_widget *dest,
 	struct snd_soc_dapm_path *path, const char *control_name)
 {
@@ -273,7 +275,7 @@ static int dapm_connect_mixer(struct snd_soc_codec *codec,
 	/* search for mixer kcontrol */
 	for (i = 0; i < dest->num_kcontrols; i++) {
 		if (!strcmp(control_name, dest->kcontrols[i].name)) {
-			list_add(&path->list, &codec->dapm_paths);
+			list_add(&path->list, &dapm->paths);
 			list_add(&path->list_sink, &dest->sources);
 			list_add(&path->list_source, &src->sinks);
 			path->name = dest->kcontrols[i].name;
@@ -290,6 +292,7 @@ static int dapm_update_bits(struct snd_soc_dapm_widget *widget)
 	int change, power;
 	unsigned int old, new;
 	struct snd_soc_codec *codec = widget->codec;
+	struct snd_soc_dapm_context *dapm = widget->dapm;
 
 	/* check for valid widgets */
 	if (widget->reg < 0 || widget->id == snd_soc_dapm_input ||
@@ -309,10 +312,10 @@ static int dapm_update_bits(struct snd_soc_dapm_widget *widget)
 
 	change = old != new;
 	if (change) {
-		pop_dbg(codec->pop_time, "pop test %s : %s in %d ms\n",
+		pop_dbg(dapm->pop_time, "pop test %s : %s in %d ms\n",
 			widget->name, widget->power ? "on" : "off",
-			codec->pop_time);
-		pop_wait(codec->pop_time);
+			dapm->pop_time);
+		pop_wait(dapm->pop_time);
 		snd_soc_write(codec, widget->reg, new);
 	}
 	pr_debug("reg %x old %x new %x change %d\n", widget->reg,
@@ -321,12 +324,13 @@ static int dapm_update_bits(struct snd_soc_dapm_widget *widget)
 }
 
 /* create new dapm mixer control */
-static int dapm_new_mixer(struct snd_soc_codec *codec,
+static int dapm_new_mixer(struct snd_soc_dapm_context *dapm,
 	struct snd_soc_dapm_widget *w)
 {
 	int i, ret = 0;
 	size_t name_len;
 	struct snd_soc_dapm_path *path;
+	struct snd_card *card = dapm->codec->card->snd_card;
 
 	/* add kcontrol */
 	for (i = 0; i < w->num_kcontrols; i++) {
@@ -368,7 +372,7 @@ static int dapm_new_mixer(struct snd_soc_codec *codec,
 
 			path->kcontrol = snd_soc_cnew(&w->kcontrols[i], w,
 				path->long_name);
-			ret = snd_ctl_add(codec->card->snd_card, path->kcontrol);
+			ret = snd_ctl_add(card, path->kcontrol);
 			if (ret < 0) {
 				printk(KERN_ERR "asoc: failed to add dapm kcontrol %s: %d\n",
 				       path->long_name,
@@ -383,11 +387,12 @@ static int dapm_new_mixer(struct snd_soc_codec *codec,
 }
 
 /* create new dapm mux control */
-static int dapm_new_mux(struct snd_soc_codec *codec,
+static int dapm_new_mux(struct snd_soc_dapm_context *dapm,
 	struct snd_soc_dapm_widget *w)
 {
 	struct snd_soc_dapm_path *path = NULL;
 	struct snd_kcontrol *kcontrol;
+	struct snd_card *card = dapm->codec->card->snd_card;
 	int ret = 0;
 
 	if (!w->num_kcontrols) {
@@ -396,7 +401,8 @@ static int dapm_new_mux(struct snd_soc_codec *codec,
 	}
 
 	kcontrol = snd_soc_cnew(&w->kcontrols[0], w, w->name);
-	ret = snd_ctl_add(codec->card->snd_card, kcontrol);
+	ret = snd_ctl_add(card, kcontrol);
+
 	if (ret < 0)
 		goto err;
 
@@ -411,7 +417,7 @@ err:
 }
 
 /* create new dapm volume control */
-static int dapm_new_pga(struct snd_soc_codec *codec,
+static int dapm_new_pga(struct snd_soc_dapm_context *dapm,
 	struct snd_soc_dapm_widget *w)
 {
 	if (w->num_kcontrols)
@@ -421,11 +427,11 @@ static int dapm_new_pga(struct snd_soc_codec *codec,
 }
 
 /* reset 'walked' bit for each dapm path */
-static inline void dapm_clear_walk(struct snd_soc_codec *codec)
+static inline void dapm_clear_walk(struct snd_soc_dapm_context *dapm)
 {
 	struct snd_soc_dapm_path *p;
 
-	list_for_each_entry(p, &codec->dapm_paths, list)
+	list_for_each_entry(p, &dapm->paths, list)
 		p->walked = 0;
 }
 
@@ -435,7 +441,7 @@ static inline void dapm_clear_walk(struct snd_soc_codec *codec)
  */
 static int snd_soc_dapm_suspend_check(struct snd_soc_dapm_widget *widget)
 {
-	int level = snd_power_get_state(widget->codec->card->snd_card);
+	int level = snd_power_get_state(widget->dapm->codec->card->snd_card);
 
 	switch (level) {
 	case SNDRV_CTL_POWER_D3hot:
@@ -621,9 +627,9 @@ static int dapm_generic_check_power(struct snd_soc_dapm_widget *w)
 	int in, out;
 
 	in = is_connected_input_ep(w);
-	dapm_clear_walk(w->codec);
+	dapm_clear_walk(w->dapm);
 	out = is_connected_output_ep(w);
-	dapm_clear_walk(w->codec);
+	dapm_clear_walk(w->dapm);
 	return out != 0 && in != 0;
 }
 
@@ -634,7 +640,7 @@ static int dapm_adc_check_power(struct snd_soc_dapm_widget *w)
 
 	if (w->active) {
 		in = is_connected_input_ep(w);
-		dapm_clear_walk(w->codec);
+		dapm_clear_walk(w->dapm);
 		return in != 0;
 	} else {
 		return dapm_generic_check_power(w);
@@ -648,7 +654,7 @@ static int dapm_dac_check_power(struct snd_soc_dapm_widget *w)
 
 	if (w->active) {
 		out = is_connected_output_ep(w);
-		dapm_clear_walk(w->codec);
+		dapm_clear_walk(w->dapm);
 		return out != 0;
 	} else {
 		return dapm_generic_check_power(w);
@@ -674,7 +680,7 @@ static int dapm_supply_check_power(struct snd_soc_dapm_widget *w)
 		}
 	}
 
-	dapm_clear_walk(w->codec);
+	dapm_clear_walk(w->dapm);
 
 	return power;
 }
@@ -710,7 +716,7 @@ static void dapm_seq_insert(struct snd_soc_dapm_widget *new_widget,
 }
 
 /* Apply the coalesced changes from a DAPM sequence */
-static void dapm_seq_run_coalesced(struct snd_soc_codec *codec,
+static void dapm_seq_run_coalesced(struct snd_soc_dapm_context *dapm,
 				   struct list_head *pending)
 {
 	struct snd_soc_dapm_widget *w;
@@ -735,14 +741,14 @@ static void dapm_seq_run_coalesced(struct snd_soc_codec *codec,
 		if (power)
 			value |= cur_mask;
 
-		pop_dbg(codec->pop_time,
+		pop_dbg(dapm->pop_time,
 			"pop test : Queue %s: reg=0x%x, 0x%x/0x%x\n",
 			w->name, reg, value, mask);
 
 		/* power up pre event */
 		if (w->power && w->event &&
 		    (w->event_flags & SND_SOC_DAPM_PRE_PMU)) {
-			pop_dbg(codec->pop_time, "pop test : %s PRE_PMU\n",
+			pop_dbg(dapm->pop_time, "pop test : %s PRE_PMU\n",
 				w->name);
 			ret = w->event(w, NULL, SND_SOC_DAPM_PRE_PMU);
 			if (ret < 0)
@@ -753,7 +759,7 @@ static void dapm_seq_run_coalesced(struct snd_soc_codec *codec,
 		/* power down pre event */
 		if (!w->power && w->event &&
 		    (w->event_flags & SND_SOC_DAPM_PRE_PMD)) {
-			pop_dbg(codec->pop_time, "pop test : %s PRE_PMD\n",
+			pop_dbg(dapm->pop_time, "pop test : %s PRE_PMD\n",
 				w->name);
 			ret = w->event(w, NULL, SND_SOC_DAPM_PRE_PMD);
 			if (ret < 0)
@@ -763,18 +769,18 @@ static void dapm_seq_run_coalesced(struct snd_soc_codec *codec,
 	}
 
 	if (reg >= 0) {
-		pop_dbg(codec->pop_time,
+		pop_dbg(dapm->pop_time,
 			"pop test : Applying 0x%x/0x%x to %x in %dms\n",
-			value, mask, reg, codec->pop_time);
-		pop_wait(codec->pop_time);
-		snd_soc_update_bits(codec, reg, mask, value);
+			value, mask, reg, dapm->pop_time);
+		pop_wait(dapm->pop_time);
+		snd_soc_update_bits(dapm->codec, reg, mask, value);
 	}
 
 	list_for_each_entry(w, pending, power_list) {
 		/* power up post event */
 		if (w->power && w->event &&
 		    (w->event_flags & SND_SOC_DAPM_POST_PMU)) {
-			pop_dbg(codec->pop_time, "pop test : %s POST_PMU\n",
+			pop_dbg(dapm->pop_time, "pop test : %s POST_PMU\n",
 				w->name);
 			ret = w->event(w,
 				       NULL, SND_SOC_DAPM_POST_PMU);
@@ -786,7 +792,7 @@ static void dapm_seq_run_coalesced(struct snd_soc_codec *codec,
 		/* power down post event */
 		if (!w->power && w->event &&
 		    (w->event_flags & SND_SOC_DAPM_POST_PMD)) {
-			pop_dbg(codec->pop_time, "pop test : %s POST_PMD\n",
+			pop_dbg(dapm->pop_time, "pop test : %s POST_PMD\n",
 				w->name);
 			ret = w->event(w, NULL, SND_SOC_DAPM_POST_PMD);
 			if (ret < 0)
@@ -804,8 +810,8 @@ static void dapm_seq_run_coalesced(struct snd_soc_codec *codec,
  * Currently anything that requires more than a single write is not
  * handled.
  */
-static void dapm_seq_run(struct snd_soc_codec *codec, struct list_head *list,
-			 int event, int sort[])
+static void dapm_seq_run(struct snd_soc_dapm_context *dapm,
+			 struct list_head *list, int event, int sort[])
 {
 	struct snd_soc_dapm_widget *w, *n;
 	LIST_HEAD(pending);
@@ -819,7 +825,7 @@ static void dapm_seq_run(struct snd_soc_codec *codec, struct list_head *list,
 		/* Do we need to apply any queued changes? */
 		if (sort[w->id] != cur_sort || w->reg != cur_reg) {
 			if (!list_empty(&pending))
-				dapm_seq_run_coalesced(codec, &pending);
+				dapm_seq_run_coalesced(dapm, &pending);
 
 			INIT_LIST_HEAD(&pending);
 			cur_sort = -1;
@@ -877,7 +883,7 @@ static void dapm_seq_run(struct snd_soc_codec *codec, struct list_head *list,
 	}
 
 	if (!list_empty(&pending))
-		dapm_seq_run_coalesced(codec, &pending);
+		dapm_seq_run_coalesced(dapm, &pending);
 }
 
 /*
@@ -889,9 +895,9 @@ static void dapm_seq_run(struct snd_soc_codec *codec, struct list_head *list,
  *  o Input pin to Output pin (bypass, sidetone)
  *  o DAC to ADC (loopback).
  */
-static int dapm_power_widgets(struct snd_soc_codec *codec, int event)
+static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 {
-	struct snd_soc_card *card = codec->card;
+	struct snd_soc_card *card = dapm->codec->card;
 	struct snd_soc_dapm_widget *w;
 	LIST_HEAD(up_list);
 	LIST_HEAD(down_list);
@@ -902,7 +908,7 @@ static int dapm_power_widgets(struct snd_soc_codec *codec, int event)
 	/* Check which widgets we need to power and store them in
 	 * lists indicating if they should be powered up or down.
 	 */
-	list_for_each_entry(w, &codec->dapm_widgets, list) {
+	list_for_each_entry(w, &dapm->widgets, list) {
 		switch (w->id) {
 		case snd_soc_dapm_pre:
 			dapm_seq_insert(w, &down_list, dapm_down_seq);
@@ -938,7 +944,7 @@ static int dapm_power_widgets(struct snd_soc_codec *codec, int event)
 	/* If there are no DAPM widgets then try to figure out power from the
 	 * event type.
 	 */
-	if (list_empty(&codec->dapm_widgets)) {
+	if (list_empty(&dapm->widgets)) {
 		switch (event) {
 		case SND_SOC_DAPM_STREAM_START:
 		case SND_SOC_DAPM_STREAM_RESUME:
@@ -948,7 +954,7 @@ static int dapm_power_widgets(struct snd_soc_codec *codec, int event)
 			sys_power = 0;
 			break;
 		case SND_SOC_DAPM_STREAM_NOP:
-			switch (codec->bias_level) {
+			switch (dapm->bias_level) {
 				case SND_SOC_BIAS_STANDBY:
 				case SND_SOC_BIAS_OFF:
 					sys_power = 0;
@@ -963,52 +969,52 @@ static int dapm_power_widgets(struct snd_soc_codec *codec, int event)
 		}
 	}
 
-	if (sys_power && codec->bias_level == SND_SOC_BIAS_OFF) {
-		ret = snd_soc_dapm_set_bias_level(card, codec,
+	if (sys_power && dapm->bias_level == SND_SOC_BIAS_OFF) {
+		ret = snd_soc_dapm_set_bias_level(card, dapm,
 						  SND_SOC_BIAS_STANDBY);
 		if (ret != 0)
 			pr_err("Failed to turn on bias: %d\n", ret);
 	}
 
 	/* If we're changing to all on or all off then prepare */
-	if ((sys_power && codec->bias_level == SND_SOC_BIAS_STANDBY) ||
-	    (!sys_power && codec->bias_level == SND_SOC_BIAS_ON)) {
-		ret = snd_soc_dapm_set_bias_level(card, codec, SND_SOC_BIAS_PREPARE);
+	if ((sys_power && dapm->bias_level == SND_SOC_BIAS_STANDBY) ||
+	    (!sys_power && dapm->bias_level == SND_SOC_BIAS_ON)) {
+		ret = snd_soc_dapm_set_bias_level(card, dapm, SND_SOC_BIAS_PREPARE);
 		if (ret != 0)
 			pr_err("Failed to prepare bias: %d\n", ret);
 	}
 
 	/* Power down widgets first; try to avoid amplifying pops. */
-	dapm_seq_run(codec, &down_list, event, dapm_down_seq);
+	dapm_seq_run(dapm, &down_list, event, dapm_down_seq);
 
 	/* Now power up. */
-	dapm_seq_run(codec, &up_list, event, dapm_up_seq);
+	dapm_seq_run(dapm, &up_list, event, dapm_up_seq);
 
 	/* If we just powered the last thing off drop to standby bias */
-	if (codec->bias_level == SND_SOC_BIAS_PREPARE && !sys_power) {
-		ret = snd_soc_dapm_set_bias_level(card, codec, SND_SOC_BIAS_STANDBY);
+	if (dapm->bias_level == SND_SOC_BIAS_PREPARE && !sys_power) {
+		ret = snd_soc_dapm_set_bias_level(card, dapm, SND_SOC_BIAS_STANDBY);
 		if (ret != 0)
 			pr_err("Failed to apply standby bias: %d\n", ret);
 	}
 
 	/* If we're in standby and can support bias off then do that */
-	if (codec->bias_level == SND_SOC_BIAS_STANDBY &&
-	    codec->idle_bias_off) {
-		ret = snd_soc_dapm_set_bias_level(card, codec, SND_SOC_BIAS_OFF);
+	if (dapm->bias_level == SND_SOC_BIAS_STANDBY &&
+	    dapm->idle_bias_off) {
+		ret = snd_soc_dapm_set_bias_level(card, dapm, SND_SOC_BIAS_OFF);
 		if (ret != 0)
 			pr_err("Failed to turn off bias: %d\n", ret);
 	}
 
 	/* If we just powered up then move to active bias */
-	if (codec->bias_level == SND_SOC_BIAS_PREPARE && sys_power) {
-		ret = snd_soc_dapm_set_bias_level(card, codec, SND_SOC_BIAS_ON);
+	if (dapm->bias_level == SND_SOC_BIAS_PREPARE && sys_power) {
+		ret = snd_soc_dapm_set_bias_level(card, dapm, SND_SOC_BIAS_ON);
 		if (ret != 0)
 			pr_err("Failed to apply active bias: %d\n", ret);
 	}
 
-	pop_dbg(codec->pop_time, "DAPM sequencing finished, waiting %dms\n",
-		codec->pop_time);
-	pop_wait(codec->pop_time);
+	pop_dbg(dapm->pop_time, "DAPM sequencing finished, waiting %dms\n",
+		dapm->pop_time);
+	pop_wait(dapm->pop_time);
 
 	return 0;
 }
@@ -1035,9 +1041,9 @@ static ssize_t dapm_widget_power_read_file(struct file *file,
 		return -ENOMEM;
 
 	in = is_connected_input_ep(w);
-	dapm_clear_walk(w->codec);
+	dapm_clear_walk(w->dapm);
 	out = is_connected_output_ep(w);
-	dapm_clear_walk(w->codec);
+	dapm_clear_walk(w->dapm);
 
 	ret = snprintf(buf, PAGE_SIZE, "%s: %s  in %d out %d",
 		       w->name, w->power ? "On" : "Off", in, out);
@@ -1087,20 +1093,20 @@ static const struct file_operations dapm_widget_power_fops = {
 	.llseek = default_llseek,
 };
 
-void snd_soc_dapm_debugfs_init(struct snd_soc_codec *codec)
+void snd_soc_dapm_debugfs_init(struct snd_soc_dapm_context *dapm)
 {
 	struct snd_soc_dapm_widget *w;
 	struct dentry *d;
 
-	if (!codec->debugfs_dapm)
+	if (!dapm->debugfs_dapm)
 		return;
 
-	list_for_each_entry(w, &codec->dapm_widgets, list) {
+	list_for_each_entry(w, &dapm->widgets, list) {
 		if (!w->name)
 			continue;
 
 		d = debugfs_create_file(w->name, 0444,
-					codec->debugfs_dapm, w,
+					dapm->debugfs_dapm, w,
 					&dapm_widget_power_fops);
 		if (!d)
 			printk(KERN_WARNING
@@ -1109,7 +1115,7 @@ void snd_soc_dapm_debugfs_init(struct snd_soc_codec *codec)
 	}
 }
 #else
-void snd_soc_dapm_debugfs_init(struct snd_soc_codec *codec)
+void snd_soc_dapm_debugfs_init(struct snd_soc_dapm_context *dapm)
 {
 }
 #endif
@@ -1130,7 +1136,7 @@ static int dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
 		return 0;
 
 	/* find dapm widget path assoc with kcontrol */
-	list_for_each_entry(path, &widget->codec->dapm_paths, list) {
+	list_for_each_entry(path, &widget->dapm->paths, list) {
 		if (path->kcontrol != kcontrol)
 			continue;
 
@@ -1146,7 +1152,7 @@ static int dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
 	}
 
 	if (found)
-		dapm_power_widgets(widget->codec, SND_SOC_DAPM_STREAM_NOP);
+		dapm_power_widgets(widget->dapm, SND_SOC_DAPM_STREAM_NOP);
 
 	return 0;
 }
@@ -1164,7 +1170,7 @@ static int dapm_mixer_update_power(struct snd_soc_dapm_widget *widget,
 		return -ENODEV;
 
 	/* find dapm widget path assoc with kcontrol */
-	list_for_each_entry(path, &widget->codec->dapm_paths, list) {
+	list_for_each_entry(path, &widget->dapm->paths, list) {
 		if (path->kcontrol != kcontrol)
 			continue;
 
@@ -1175,7 +1181,7 @@ static int dapm_mixer_update_power(struct snd_soc_dapm_widget *widget,
 	}
 
 	if (found)
-		dapm_power_widgets(widget->codec, SND_SOC_DAPM_STREAM_NOP);
+		dapm_power_widgets(widget->dapm, SND_SOC_DAPM_STREAM_NOP);
 
 	return 0;
 }
@@ -1191,7 +1197,7 @@ static ssize_t dapm_widget_show(struct device *dev,
 	int count = 0;
 	char *state = "not set";
 
-	list_for_each_entry(w, &codec->dapm_widgets, list) {
+	list_for_each_entry(w, &codec->dapm.widgets, list) {
 
 		/* only display widgets that burnm power */
 		switch (w->id) {
@@ -1215,7 +1221,7 @@ static ssize_t dapm_widget_show(struct device *dev,
 		}
 	}
 
-	switch (codec->bias_level) {
+	switch (codec->dapm.bias_level) {
 	case SND_SOC_BIAS_ON:
 		state = "On";
 		break;
@@ -1247,31 +1253,31 @@ static void snd_soc_dapm_sys_remove(struct device *dev)
 }
 
 /* free all dapm widgets and resources */
-static void dapm_free_widgets(struct snd_soc_codec *codec)
+static void dapm_free_widgets(struct snd_soc_dapm_context *dapm)
 {
 	struct snd_soc_dapm_widget *w, *next_w;
 	struct snd_soc_dapm_path *p, *next_p;
 
-	list_for_each_entry_safe(w, next_w, &codec->dapm_widgets, list) {
+	list_for_each_entry_safe(w, next_w, &dapm->widgets, list) {
 		list_del(&w->list);
 		kfree(w);
 	}
 
-	list_for_each_entry_safe(p, next_p, &codec->dapm_paths, list) {
+	list_for_each_entry_safe(p, next_p, &dapm->paths, list) {
 		list_del(&p->list);
 		kfree(p->long_name);
 		kfree(p);
 	}
 }
 
-static int snd_soc_dapm_set_pin(struct snd_soc_codec *codec,
+static int snd_soc_dapm_set_pin(struct snd_soc_dapm_context *dapm,
 				const char *pin, int status)
 {
 	struct snd_soc_dapm_widget *w;
 
-	list_for_each_entry(w, &codec->dapm_widgets, list) {
+	list_for_each_entry(w, &dapm->widgets, list) {
 		if (!strcmp(w->name, pin)) {
-			pr_debug("dapm: %s: pin %s\n", codec->name, pin);
+			pr_debug("dapm: %s: pin %s\n", dapm->codec->name, pin);
 			w->connected = status;
 			/* Allow disabling of forced pins */
 			if (status == 0)
@@ -1280,26 +1286,27 @@ static int snd_soc_dapm_set_pin(struct snd_soc_codec *codec,
 		}
 	}
 
-	pr_err("dapm: %s: configuring unknown pin %s\n", codec->name, pin);
+	pr_err("dapm: %s: configuring unknown pin %s\n",
+	       dapm->codec->name, pin);
 	return -EINVAL;
 }
 
 /**
  * snd_soc_dapm_sync - scan and power dapm paths
- * @codec: audio codec
+ * @dapm: DAPM context
  *
  * Walks all dapm audio paths and powers widgets according to their
  * stream or path usage.
  *
  * Returns 0 for success.
  */
-int snd_soc_dapm_sync(struct snd_soc_codec *codec)
+int snd_soc_dapm_sync(struct snd_soc_dapm_context *dapm)
 {
-	return dapm_power_widgets(codec, SND_SOC_DAPM_STREAM_NOP);
+	return dapm_power_widgets(dapm, SND_SOC_DAPM_STREAM_NOP);
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_sync);
 
-static int snd_soc_dapm_add_route(struct snd_soc_codec *codec,
+static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
 				  const struct snd_soc_dapm_route *route)
 {
 	struct snd_soc_dapm_path *path;
@@ -1310,7 +1317,7 @@ static int snd_soc_dapm_add_route(struct snd_soc_codec *codec,
 	int ret = 0;
 
 	/* find src and dest widgets */
-	list_for_each_entry(w, &codec->dapm_widgets, list) {
+	list_for_each_entry(w, &dapm->widgets, list) {
 
 		if (!wsink && !(strcmp(w->name, sink))) {
 			wsink = w;
@@ -1353,7 +1360,7 @@ static int snd_soc_dapm_add_route(struct snd_soc_codec *codec,
 
 	/* connect static paths */
 	if (control == NULL) {
-		list_add(&path->list, &codec->dapm_paths);
+		list_add(&path->list, &dapm->paths);
 		list_add(&path->list_sink, &wsink->sources);
 		list_add(&path->list_source, &wsource->sinks);
 		path->connect = 1;
@@ -1374,14 +1381,14 @@ static int snd_soc_dapm_add_route(struct snd_soc_codec *codec,
 	case snd_soc_dapm_supply:
 	case snd_soc_dapm_aif_in:
 	case snd_soc_dapm_aif_out:
-		list_add(&path->list, &codec->dapm_paths);
+		list_add(&path->list, &dapm->paths);
 		list_add(&path->list_sink, &wsink->sources);
 		list_add(&path->list_source, &wsource->sinks);
 		path->connect = 1;
 		return 0;
 	case snd_soc_dapm_mux:
 	case snd_soc_dapm_value_mux:
-		ret = dapm_connect_mux(codec, wsource, wsink, path, control,
+		ret = dapm_connect_mux(dapm, wsource, wsink, path, control,
 			&wsink->kcontrols[0]);
 		if (ret != 0)
 			goto err;
@@ -1389,7 +1396,7 @@ static int snd_soc_dapm_add_route(struct snd_soc_codec *codec,
 	case snd_soc_dapm_switch:
 	case snd_soc_dapm_mixer:
 	case snd_soc_dapm_mixer_named_ctl:
-		ret = dapm_connect_mixer(codec, wsource, wsink, path, control);
+		ret = dapm_connect_mixer(dapm, wsource, wsink, path, control);
 		if (ret != 0)
 			goto err;
 		break;
@@ -1397,7 +1404,7 @@ static int snd_soc_dapm_add_route(struct snd_soc_codec *codec,
 	case snd_soc_dapm_mic:
 	case snd_soc_dapm_line:
 	case snd_soc_dapm_spk:
-		list_add(&path->list, &codec->dapm_paths);
+		list_add(&path->list, &dapm->paths);
 		list_add(&path->list_sink, &wsink->sources);
 		list_add(&path->list_source, &wsource->sinks);
 		path->connect = 0;
@@ -1414,7 +1421,7 @@ err:
 
 /**
  * snd_soc_dapm_add_routes - Add routes between DAPM widgets
- * @codec: codec
+ * @dapm: DAPM context
  * @route: audio routes
  * @num: number of routes
  *
@@ -1425,13 +1432,13 @@ err:
  * Returns 0 for success else error. On error all resources can be freed
  * with a call to snd_soc_card_free().
  */
-int snd_soc_dapm_add_routes(struct snd_soc_codec *codec,
+int snd_soc_dapm_add_routes(struct snd_soc_dapm_context *dapm,
 			    const struct snd_soc_dapm_route *route, int num)
 {
 	int i, ret;
 
 	for (i = 0; i < num; i++) {
-		ret = snd_soc_dapm_add_route(codec, route);
+		ret = snd_soc_dapm_add_route(dapm, route);
 		if (ret < 0) {
 			printk(KERN_ERR "Failed to add route %s->%s\n",
 			       route->source,
@@ -1447,17 +1454,17 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_add_routes);
 
 /**
  * snd_soc_dapm_new_widgets - add new dapm widgets
- * @codec: audio codec
+ * @dapm: DAPM context
  *
  * Checks the codec for any new dapm widgets and creates them if found.
  *
  * Returns 0 for success.
  */
-int snd_soc_dapm_new_widgets(struct snd_soc_codec *codec)
+int snd_soc_dapm_new_widgets(struct snd_soc_dapm_context *dapm)
 {
 	struct snd_soc_dapm_widget *w;
 
-	list_for_each_entry(w, &codec->dapm_widgets, list)
+	list_for_each_entry(w, &dapm->widgets, list)
 	{
 		if (w->new)
 			continue;
@@ -1467,12 +1474,12 @@ int snd_soc_dapm_new_widgets(struct snd_soc_codec *codec)
 		case snd_soc_dapm_mixer:
 		case snd_soc_dapm_mixer_named_ctl:
 			w->power_check = dapm_generic_check_power;
-			dapm_new_mixer(codec, w);
+			dapm_new_mixer(dapm, w);
 			break;
 		case snd_soc_dapm_mux:
 		case snd_soc_dapm_value_mux:
 			w->power_check = dapm_generic_check_power;
-			dapm_new_mux(codec, w);
+			dapm_new_mux(dapm, w);
 			break;
 		case snd_soc_dapm_adc:
 		case snd_soc_dapm_aif_out:
@@ -1484,7 +1491,7 @@ int snd_soc_dapm_new_widgets(struct snd_soc_codec *codec)
 			break;
 		case snd_soc_dapm_pga:
 			w->power_check = dapm_generic_check_power;
-			dapm_new_pga(codec, w);
+			dapm_new_pga(dapm, w);
 			break;
 		case snd_soc_dapm_input:
 		case snd_soc_dapm_output:
@@ -1505,7 +1512,7 @@ int snd_soc_dapm_new_widgets(struct snd_soc_codec *codec)
 		w->new = 1;
 	}
 
-	dapm_power_widgets(codec, SND_SOC_DAPM_STREAM_NOP);
+	dapm_power_widgets(dapm, SND_SOC_DAPM_STREAM_NOP);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_new_widgets);
@@ -1889,7 +1896,7 @@ int snd_soc_dapm_get_pin_switch(struct snd_kcontrol *kcontrol,
 	mutex_lock(&codec->mutex);
 
 	ucontrol->value.integer.value[0] =
-		snd_soc_dapm_get_pin_status(codec, pin);
+		snd_soc_dapm_get_pin_status(&codec->dapm, pin);
 
 	mutex_unlock(&codec->mutex);
 
@@ -1912,11 +1919,11 @@ int snd_soc_dapm_put_pin_switch(struct snd_kcontrol *kcontrol,
 	mutex_lock(&codec->mutex);
 
 	if (ucontrol->value.integer.value[0])
-		snd_soc_dapm_enable_pin(codec, pin);
+		snd_soc_dapm_enable_pin(&codec->dapm, pin);
 	else
-		snd_soc_dapm_disable_pin(codec, pin);
+		snd_soc_dapm_disable_pin(&codec->dapm, pin);
 
-	snd_soc_dapm_sync(codec);
+	snd_soc_dapm_sync(&codec->dapm);
 
 	mutex_unlock(&codec->mutex);
 
@@ -1926,14 +1933,14 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_put_pin_switch);
 
 /**
  * snd_soc_dapm_new_control - create new dapm control
- * @codec: audio codec
+ * @dapm: DAPM context
  * @widget: widget template
  *
  * Creates a new dapm control based upon the template.
  *
  * Returns 0 for success else error.
  */
-int snd_soc_dapm_new_control(struct snd_soc_codec *codec,
+int snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 	const struct snd_soc_dapm_widget *widget)
 {
 	struct snd_soc_dapm_widget *w;
@@ -1941,11 +1948,12 @@ int snd_soc_dapm_new_control(struct snd_soc_codec *codec,
 	if ((w = dapm_cnew_widget(widget)) == NULL)
 		return -ENOMEM;
 
-	w->codec = codec;
+	w->dapm = dapm;
+	w->codec = dapm->codec;
 	INIT_LIST_HEAD(&w->sources);
 	INIT_LIST_HEAD(&w->sinks);
 	INIT_LIST_HEAD(&w->list);
-	list_add(&w->list, &codec->dapm_widgets);
+	list_add(&w->list, &dapm->widgets);
 
 	/* machine layer set ups unconnected pins and insertions */
 	w->connected = 1;
@@ -1955,7 +1963,7 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_new_control);
 
 /**
  * snd_soc_dapm_new_controls - create new dapm controls
- * @codec: audio codec
+ * @dapm: DAPM context
  * @widget: widget array
  * @num: number of widgets
  *
@@ -1963,14 +1971,14 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_new_control);
  *
  * Returns 0 for success else error.
  */
-int snd_soc_dapm_new_controls(struct snd_soc_codec *codec,
+int snd_soc_dapm_new_controls(struct snd_soc_dapm_context *dapm,
 	const struct snd_soc_dapm_widget *widget,
 	int num)
 {
 	int i, ret;
 
 	for (i = 0; i < num; i++) {
-		ret = snd_soc_dapm_new_control(codec, widget);
+		ret = snd_soc_dapm_new_control(dapm, widget);
 		if (ret < 0) {
 			printk(KERN_ERR
 			       "ASoC: Failed to create DAPM control %s: %d\n",
@@ -1983,29 +1991,12 @@ int snd_soc_dapm_new_controls(struct snd_soc_codec *codec,
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_new_controls);
 
-
-/**
- * snd_soc_dapm_stream_event - send a stream event to the dapm core
- * @codec: audio codec
- * @stream: stream name
- * @event: stream event
- *
- * Sends a stream event to the dapm core. The core then makes any
- * necessary widget power changes.
- *
- * Returns 0 for success else error.
- */
-int snd_soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd,
+static void soc_dapm_stream_event(struct snd_soc_dapm_context *dapm,
 	const char *stream, int event)
 {
-	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_dapm_widget *w;
 
-	if (stream == NULL)
-		return 0;
-
-	mutex_lock(&codec->mutex);
-	list_for_each_entry(w, &codec->dapm_widgets, list)
+	list_for_each_entry(w, &dapm->widgets, list)
 	{
 		if (!w->sname)
 			continue;
@@ -2028,7 +2019,30 @@ int snd_soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd,
 		}
 	}
 
-	dapm_power_widgets(codec, event);
+	dapm_power_widgets(dapm, event);
+}
+
+/**
+ * snd_soc_dapm_stream_event - send a stream event to the dapm core
+ * @rtd: PCM runtime data
+ * @stream: stream name
+ * @event: stream event
+ *
+ * Sends a stream event to the dapm core. The core then makes any
+ * necessary widget power changes.
+ *
+ * Returns 0 for success else error.
+ */
+int snd_soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd,
+	const char *stream, int event)
+{
+	struct snd_soc_codec *codec = rtd->codec;
+
+	if (stream == NULL)
+		return 0;
+
+	mutex_lock(&codec->mutex);
+	soc_dapm_stream_event(&codec->dapm, stream, event);
 	mutex_unlock(&codec->mutex);
 	return 0;
 }
@@ -2036,7 +2050,7 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_stream_event);
 
 /**
  * snd_soc_dapm_enable_pin - enable pin.
- * @codec: SoC codec
+ * @dapm: DAPM context
  * @pin: pin name
  *
  * Enables input/output pin and its parents or children widgets iff there is
@@ -2044,15 +2058,15 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_stream_event);
  * NOTE: snd_soc_dapm_sync() needs to be called after this for DAPM to
  * do any widget power switching.
  */
-int snd_soc_dapm_enable_pin(struct snd_soc_codec *codec, const char *pin)
+int snd_soc_dapm_enable_pin(struct snd_soc_dapm_context *dapm, const char *pin)
 {
-	return snd_soc_dapm_set_pin(codec, pin, 1);
+	return snd_soc_dapm_set_pin(dapm, pin, 1);
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_enable_pin);
 
 /**
  * snd_soc_dapm_force_enable_pin - force a pin to be enabled
- * @codec: SoC codec
+ * @dapm: DAPM context
  * @pin: pin name
  *
  * Enables input/output pin regardless of any other state.  This is
@@ -2062,42 +2076,45 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_enable_pin);
  * NOTE: snd_soc_dapm_sync() needs to be called after this for DAPM to
  * do any widget power switching.
  */
-int snd_soc_dapm_force_enable_pin(struct snd_soc_codec *codec, const char *pin)
+int snd_soc_dapm_force_enable_pin(struct snd_soc_dapm_context *dapm,
+				  const char *pin)
 {
 	struct snd_soc_dapm_widget *w;
 
-	list_for_each_entry(w, &codec->dapm_widgets, list) {
+	list_for_each_entry(w, &dapm->widgets, list) {
 		if (!strcmp(w->name, pin)) {
-			pr_debug("dapm: %s: pin %s\n", codec->name, pin);
+			pr_debug("dapm: %s: pin %s\n", dapm->codec->name, pin);
 			w->connected = 1;
 			w->force = 1;
 			return 0;
 		}
 	}
 
-	pr_err("dapm: %s: configuring unknown pin %s\n", codec->name, pin);
+	pr_err("dapm: %s: configuring unknown pin %s\n",
+	       dapm->codec->name, pin);
 	return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_force_enable_pin);
 
 /**
  * snd_soc_dapm_disable_pin - disable pin.
- * @codec: SoC codec
+ * @dapm: DAPM context
  * @pin: pin name
  *
  * Disables input/output pin and its parents or children widgets.
  * NOTE: snd_soc_dapm_sync() needs to be called after this for DAPM to
  * do any widget power switching.
  */
-int snd_soc_dapm_disable_pin(struct snd_soc_codec *codec, const char *pin)
+int snd_soc_dapm_disable_pin(struct snd_soc_dapm_context *dapm,
+			     const char *pin)
 {
-	return snd_soc_dapm_set_pin(codec, pin, 0);
+	return snd_soc_dapm_set_pin(dapm, pin, 0);
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_disable_pin);
 
 /**
  * snd_soc_dapm_nc_pin - permanently disable pin.
- * @codec: SoC codec
+ * @dapm: DAPM context
  * @pin: pin name
  *
  * Marks the specified pin as being not connected, disabling it along
@@ -2109,26 +2126,27 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_disable_pin);
  * NOTE: snd_soc_dapm_sync() needs to be called after this for DAPM to
  * do any widget power switching.
  */
-int snd_soc_dapm_nc_pin(struct snd_soc_codec *codec, const char *pin)
+int snd_soc_dapm_nc_pin(struct snd_soc_dapm_context *dapm, const char *pin)
 {
-	return snd_soc_dapm_set_pin(codec, pin, 0);
+	return snd_soc_dapm_set_pin(dapm, pin, 0);
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_nc_pin);
 
 /**
  * snd_soc_dapm_get_pin_status - get audio pin status
- * @codec: audio codec
+ * @dapm: DAPM context
  * @pin: audio signal pin endpoint (or start point)
  *
  * Get audio pin status - connected or disconnected.
  *
  * Returns 1 for connected otherwise 0.
  */
-int snd_soc_dapm_get_pin_status(struct snd_soc_codec *codec, const char *pin)
+int snd_soc_dapm_get_pin_status(struct snd_soc_dapm_context *dapm,
+				const char *pin)
 {
 	struct snd_soc_dapm_widget *w;
 
-	list_for_each_entry(w, &codec->dapm_widgets, list) {
+	list_for_each_entry(w, &dapm->widgets, list) {
 		if (!strcmp(w->name, pin))
 			return w->connected;
 	}
@@ -2139,7 +2157,7 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_get_pin_status);
 
 /**
  * snd_soc_dapm_ignore_suspend - ignore suspend status for DAPM endpoint
- * @codec: audio codec
+ * @dapm: DAPM context
  * @pin: audio signal pin endpoint (or start point)
  *
  * Mark the given endpoint or pin as ignoring suspend.  When the
@@ -2148,11 +2166,12 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_get_pin_status);
  * normal means at suspend time, it will not be turned on if it was not
  * already enabled.
  */
-int snd_soc_dapm_ignore_suspend(struct snd_soc_codec *codec, const char *pin)
+int snd_soc_dapm_ignore_suspend(struct snd_soc_dapm_context *dapm,
+				const char *pin)
 {
 	struct snd_soc_dapm_widget *w;
 
-	list_for_each_entry(w, &codec->dapm_widgets, list) {
+	list_for_each_entry(w, &dapm->widgets, list) {
 		if (!strcmp(w->name, pin)) {
 			w->ignore_suspend = 1;
 			return 0;
@@ -2170,20 +2189,20 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_ignore_suspend);
  *
  * Free all dapm widgets and resources.
  */
-void snd_soc_dapm_free(struct snd_soc_codec *codec)
+void snd_soc_dapm_free(struct snd_soc_dapm_context *dapm)
 {
-	snd_soc_dapm_sys_remove(codec->dev);
-	dapm_free_widgets(codec);
+	snd_soc_dapm_sys_remove(dapm->dev);
+	dapm_free_widgets(dapm);
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_free);
 
-static void soc_dapm_shutdown_codec(struct snd_soc_codec *codec)
+static void soc_dapm_shutdown_codec(struct snd_soc_dapm_context *dapm)
 {
 	struct snd_soc_dapm_widget *w;
 	LIST_HEAD(down_list);
 	int powerdown = 0;
 
-	list_for_each_entry(w, &codec->dapm_widgets, list) {
+	list_for_each_entry(w, &dapm->widgets, list) {
 		if (w->power) {
 			dapm_seq_insert(w, &down_list, dapm_down_seq);
 			w->power = 0;
@@ -2195,9 +2214,9 @@ static void soc_dapm_shutdown_codec(struct snd_soc_codec *codec)
 	 * standby.
 	 */
 	if (powerdown) {
-		snd_soc_dapm_set_bias_level(NULL, codec, SND_SOC_BIAS_PREPARE);
-		dapm_seq_run(codec, &down_list, 0, dapm_down_seq);
-		snd_soc_dapm_set_bias_level(NULL, codec, SND_SOC_BIAS_STANDBY);
+		snd_soc_dapm_set_bias_level(NULL, dapm, SND_SOC_BIAS_PREPARE);
+		dapm_seq_run(dapm, &down_list, 0, dapm_down_seq);
+		snd_soc_dapm_set_bias_level(NULL, dapm, SND_SOC_BIAS_STANDBY);
 	}
 }
 
@@ -2208,10 +2227,10 @@ void snd_soc_dapm_shutdown(struct snd_soc_card *card)
 {
 	struct snd_soc_codec *codec;
 
-	list_for_each_entry(codec, &card->codec_dev_list, list)
-		soc_dapm_shutdown_codec(codec);
-
-	snd_soc_dapm_set_bias_level(card, codec, SND_SOC_BIAS_OFF);
+	list_for_each_entry(codec, &card->codec_dev_list, list) {
+		soc_dapm_shutdown_codec(&codec->dapm);
+		snd_soc_dapm_set_bias_level(card, &codec->dapm, SND_SOC_BIAS_OFF);
+	}
 }
 
 /* Module information */
diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index 9f07551..4d95abb 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -60,6 +60,7 @@ EXPORT_SYMBOL_GPL(snd_soc_jack_new);
 void snd_soc_jack_report(struct snd_soc_jack *jack, int status, int mask)
 {
 	struct snd_soc_codec *codec;
+	struct snd_soc_dapm_context *dapm;
 	struct snd_soc_jack_pin *pin;
 	int enable;
 	int oldstatus;
@@ -68,6 +69,7 @@ void snd_soc_jack_report(struct snd_soc_jack *jack, int status, int mask)
 		return;
 
 	codec = jack->codec;
+	dapm =  &codec->dapm;
 
 	mutex_lock(&codec->mutex);
 
@@ -88,15 +90,15 @@ void snd_soc_jack_report(struct snd_soc_jack *jack, int status, int mask)
 			enable = !enable;
 
 		if (enable)
-			snd_soc_dapm_enable_pin(codec, pin->pin);
+			snd_soc_dapm_enable_pin(dapm, pin->pin);
 		else
-			snd_soc_dapm_disable_pin(codec, pin->pin);
+			snd_soc_dapm_disable_pin(dapm, pin->pin);
 	}
 
 	/* Report before the DAPM sync to help users updating micbias status */
 	blocking_notifier_call_chain(&jack->notifier, status, NULL);
 
-	snd_soc_dapm_sync(codec);
+	snd_soc_dapm_sync(dapm);
 
 	snd_jack_report(jack->jack, status);
 
-- 
1.7.2.3
