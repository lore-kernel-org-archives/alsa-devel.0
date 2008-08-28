From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: Re: [PATCH] ASoC: Convert wm8731 to a new-style
	i2c	driver (testers wanted)
Date: Thu, 28 Aug 2008 20:42:52 +0200
Message-ID: <20080828184251.GA21868@roarinelk.homelinux.net>
References: <20080826182437.4c5e2f3e@hyperion.delvare>
	<20080826192043.GA3812@roarinelk.homelinux.net>
	<20080826193728.GD3461@sirena.org.uk>
	<20080828172540.GA21551@roarinelk.homelinux.net>
	<20080828193754.6f8f6594@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from roarinelk.homelinux.net (fnoeppeil48.netpark.at
	[217.175.205.176])
	by alsa0.perex.cz (Postfix) with ESMTP id D558124438
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Aug 2008 20:42:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080828193754.6f8f6594@hyperion.delvare>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jean Delvare <khali@linux-fr.org>
Cc: alsa-devel@alsa-project.org, Dmitry Baryshkov <dbaryshkov@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Eric Miao <eric.miao@marvell.com>, Andrew Victor <linux@maxim.org.za>, Liam Girdwood <lrg@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 28, 2008 at 07:37:54PM +0200, Jean Delvare wrote:
> Hi Manuel,
> 
> On Thu, 28 Aug 2008 19:25:40 +0200, Manuel Lauss wrote:
> > Hi Mark,
> > 
> > On Tue, Aug 26, 2008 at 08:37:28PM +0100, Mark Brown wrote:
> > > On Tue, Aug 26, 2008 at 09:20:43PM +0200, Manuel Lauss wrote:
> > > 
> > > > I don't know about other wm8731 users, but I'd prefer to let the board
> > > > code register the codec i2c device.  Then you could also get rid
> > > > of "struct wm8731_setup_data" altogether.
> > > 
> > > Yes, that would have been the ideal thing with the old I2C API too IIRC.
> > > Unfortunately ASoC v1 requires that all the devices comprising the ASoC
> > > system be registered in one fell swoop.  Once enough of v2 has been
> > > merged to allow the codec drivers to register their DAIs independantly
> > > of everything else the codecs can be instantiated from wherever the
> > > platform feels like doing it.
> > 
> > I modified Jean's newest patch a bit to just register the i2c driver and
> > leave the actual device registration to the board code.  It works as
> > intended!
> 
> Great, thanks for testing this. Could you please post an incremental
> patch going on top of mine? So that I see what it looks like and also
> so that both patches can be pushed upstream.

Attached below.  Although I'm no longer convinced it's a good idea after
all; I don't see how multiple asoc devices with this codec could be
realized (which afaik is planned with asoc2).

Thanks,
	Manuel Lauss
 
------ 8< -------------  8< ------------

From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH] wm8731: boards register i2c codec devices now!

Don't register the i2c device with the core in the driver source,
let the board code do that.  Now we can also get rid of wm8731_setup_data.
---
 I didn't want to touch the arch/arm/mach-pxa/{corgi,poodle}.c files, but
 if a variant of this patch somehow makes into the kernel, someone also
 needs to add i2c_board_info with codec device information.

 sound/soc/codecs/wm8731.c |   49 +++-----------------------------------------
 sound/soc/codecs/wm8731.h |    5 ----
 sound/soc/pxa/corgi.c     |    7 ------
 sound/soc/pxa/poodle.c    |    7 ------
 4 files changed, 4 insertions(+), 64 deletions(-)

diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 5814f9b..1ef8e6a 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -580,6 +580,7 @@ static int wm8731_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, codec);
 	codec->control_data = i2c;
+	codec->hw_write = (hw_write_t)i2c_master_send;
 
 	ret = wm8731_init(socdev);
 	if (ret < 0)
@@ -610,46 +611,6 @@ static struct i2c_driver wm8731_i2c_driver = {
 	.remove =   wm8731_i2c_remove,
 	.id_table = wm8731_i2c_id,
 };
-
-static int wm8731_add_i2c_device(struct platform_device *pdev,
-				 const struct wm8731_setup_data *setup)
-{
-	struct i2c_board_info info;
-	struct i2c_adapter *adapter;
-	struct i2c_client *client;
-	int ret;
-
-	ret = i2c_add_driver(&wm8731_i2c_driver);
-	if (ret != 0) {
-		dev_err(&pdev->dev, "can't add i2c driver\n");
-		return ret;
-	}
-
-	memset(&info, 0, sizeof(struct i2c_board_info));
-	info.addr = setup->i2c_address;
-	strlcpy(info.type, "wm8731", I2C_NAME_SIZE);
-
-	adapter = i2c_get_adapter(setup->i2c_bus);
-	if (!adapter) {
-		dev_err(&pdev->dev, "can't get i2c adapter %d\n",
-			setup->i2c_bus);
-		goto err_driver;
-	}
-
-	client = i2c_new_device(adapter, &info);
-	i2c_put_adapter(adapter);
-	if (!client) {
-		dev_err(&pdev->dev, "can't add i2c device at 0x%x\n",
-			(unsigned int)info.addr);
-		goto err_driver;
-	}
-
-	return 0;
-
-err_driver:
-	i2c_del_driver(&wm8731_i2c_driver);
-	return -ENODEV;
-}
 #endif
 
 static int wm8731_probe(struct platform_device *pdev)
@@ -681,10 +642,9 @@ static int wm8731_probe(struct platform_device *pdev)
 
 	wm8731_socdev = socdev;
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-	if (setup->i2c_address) {
-		codec->hw_write = (hw_write_t)i2c_master_send;
-		ret = wm8731_add_i2c_device(pdev, setup);
-	}
+	ret = i2c_add_driver(&wm8731_i2c_driver);
+	if (ret != 0)
+		dev_err(&pdev->dev, "can't add i2c driver\n");
 #else
 	/* Add other interfaces here */
 #endif
@@ -708,7 +668,6 @@ static int wm8731_remove(struct platform_device *pdev)
 	snd_soc_free_pcms(socdev);
 	snd_soc_dapm_free(socdev);
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-	i2c_unregister_device(codec->control_data);
 	i2c_del_driver(&wm8731_i2c_driver);
 #endif
 	kfree(codec->private_data);
diff --git a/sound/soc/codecs/wm8731.h b/sound/soc/codecs/wm8731.h
index 0f81239..cd7b806 100644
--- a/sound/soc/codecs/wm8731.h
+++ b/sound/soc/codecs/wm8731.h
@@ -34,11 +34,6 @@
 #define WM8731_SYSCLK	0
 #define WM8731_DAI		0
 
-struct wm8731_setup_data {
-	int            i2c_bus;
-	unsigned short i2c_address;
-};
-
 extern struct snd_soc_dai wm8731_dai;
 extern struct snd_soc_codec_device soc_codec_dev_wm8731;
 
diff --git a/sound/soc/pxa/corgi.c b/sound/soc/pxa/corgi.c
index 72b7a51..4837bdb 100644
--- a/sound/soc/pxa/corgi.c
+++ b/sound/soc/pxa/corgi.c
@@ -328,18 +328,11 @@ static struct snd_soc_machine snd_soc_machine_corgi = {
 	.num_links = 1,
 };
 
-/* corgi audio private data */
-static struct wm8731_setup_data corgi_wm8731_setup = {
-	.i2c_bus = 0,
-	.i2c_address = 0x1b,
-};
-
 /* corgi audio subsystem */
 static struct snd_soc_device corgi_snd_devdata = {
 	.machine = &snd_soc_machine_corgi,
 	.platform = &pxa2xx_soc_platform,
 	.codec_dev = &soc_codec_dev_wm8731,
-	.codec_data = &corgi_wm8731_setup,
 };
 
 static struct platform_device *corgi_snd_device;
diff --git a/sound/soc/pxa/poodle.c b/sound/soc/pxa/poodle.c
index f84f7d8..a6adb46 100644
--- a/sound/soc/pxa/poodle.c
+++ b/sound/soc/pxa/poodle.c
@@ -282,18 +282,11 @@ static struct snd_soc_machine snd_soc_machine_poodle = {
 	.num_links = 1,
 };
 
-/* poodle audio private data */
-static struct wm8731_setup_data poodle_wm8731_setup = {
-	.i2c_bus = 0,
-	.i2c_address = 0x1b,
-};
-
 /* poodle audio subsystem */
 static struct snd_soc_device poodle_snd_devdata = {
 	.machine = &snd_soc_machine_poodle,
 	.platform = &pxa2xx_soc_platform,
 	.codec_dev = &soc_codec_dev_wm8731,
-	.codec_data = &poodle_wm8731_setup,
 };
 
 static struct platform_device *poodle_snd_device;
-- 
1.6.0
