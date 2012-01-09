From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Public ridicule due to sound/soc/soc-core.c abuse
	of the	driver model
Date: Mon, 9 Jan 2012 21:37:24 +0000
Message-ID: <20120109213724.GB7795@n2100.arm.linux.org.uk>
References: <20120106194052.GA7781@kroah.com>
	<20120106201458.GF2893@opensource.wolfsonmicro.com>
	<20120106205036.GB13857@n2100.arm.linux.org.uk>
	<20120106234135.GH2893@opensource.wolfsonmicro.com>
	<20120106234445.GC13857@n2100.arm.linux.org.uk>
	<20120106234923.GI2893@opensource.wolfsonmicro.com>
	<20120109095125.GG21765@n2100.arm.linux.org.uk>
	<20120109195211.GA30766@opensource.wolfsonmicro.com>
	<20120109201110.GA8377@kroah.com>
	<20120109203129.GA25743@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 1601A2412D
	for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2012 22:37:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20120109203129.GA25743@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, Frank Mandarino <fmandarino@endrelia.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 09, 2012 at 12:31:30PM -0800, Mark Brown wrote:
> If it's code like the rtd devices which is reasonably sensible and
> stable that's one thing but wading into code we know is fragile for
> what's essentially a warning fix is completely disproportionate.

You're still under the impression that it's "just a warning" and not
"a potential oops".

And I disagree with your assessment of how easy it is to fix each
problem.

The rtd devices are stored in an array - this array needs breaking
up into separate allocations for each rtd as the very first step in
fixing that.  That then needs more error checking added, etc.

On the other hand, the AC'97 code in ASoC should need this to fix it:

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index a25fa63..e85ae4d 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -452,14 +452,10 @@ static inline void soc_cleanup_card_debugfs(struct snd_soc_card *card)
 /* unregister ac97 codec */
 static int soc_ac97_dev_unregister(struct snd_soc_codec *codec)
 {
-	if (codec->ac97->dev.bus)
-		device_unregister(&codec->ac97->dev);
+	device_del(&codec->ac97->dev);
 	return 0;
 }
 
-/* stop no dev release warning */
-static void soc_ac97_device_release(struct device *dev){}
-
 /* register ac97 codec to bus */
 static int soc_ac97_dev_register(struct snd_soc_codec *codec)
 {
@@ -467,14 +463,12 @@ static int soc_ac97_dev_register(struct snd_soc_codec *codec)
 
 	codec->ac97->dev.bus = &ac97_bus_type;
 	codec->ac97->dev.parent = codec->card->dev;
-	codec->ac97->dev.release = soc_ac97_device_release;
 
 	dev_set_name(&codec->ac97->dev, "%d-%d:%s",
 		     codec->card->snd_card->number, 0, codec->name);
-	err = device_register(&codec->ac97->dev);
+	err = device_add(&codec->ac97->dev);
 	if (err < 0) {
 		snd_printk(KERN_ERR "Can't register ac97 bus\n");
-		codec->ac97->dev.bus = NULL;
 		return err;
 	}
 	return 0;
@@ -1729,6 +1723,12 @@ int snd_soc_platform_write(struct snd_soc_platform *platform,
 }
 EXPORT_SYMBOL_GPL(snd_soc_platform_write);
 
+static void soc_ac97_device_release(struct device *dev)
+{
+	struct snd_ac97 *ac97 = container_of(dev, struct snd_ac97, dev);
+	kfree(ac97);
+}
+
 /**
  * snd_soc_new_ac97_codec - initailise AC97 device
  * @codec: audio codec
@@ -1756,6 +1756,9 @@ int snd_soc_new_ac97_codec(struct snd_soc_codec *codec,
 		return -ENOMEM;
 	}
 
+	codec->ac97->dev.release = soc_ac97_device_release;
+	device_initialize(&codec->ac97->dev);
+
 	codec->ac97->bus->ops = ops;
 	codec->ac97->num = num;
 
@@ -1783,7 +1786,7 @@ void snd_soc_free_ac97_codec(struct snd_soc_codec *codec)
 	soc_unregister_ac97_dai_link(codec);
 #endif
 	kfree(codec->ac97->bus);
-	kfree(codec->ac97);
+	put_device(&codec->ac97->dev);
 	codec->ac97 = NULL;
 	codec->ac97_created = 0;
 	mutex_unlock(&codec->mutex);
