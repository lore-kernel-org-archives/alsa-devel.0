From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: i.MX SDMA support
Date: Wed, 11 Aug 2010 10:44:30 +0200
Message-ID: <20100811084430.GO27749@pengutronix.de>
References: <20100809091157.GC20065@pengutronix.de>
	<1281350823.3035.54.camel@odin>
	<20100809121956.GA27749@pengutronix.de>
	<64008892-3D75-4309-A623-CCE9B335F77F@opensource.wolfsonmicro.com>
	<20100810131527.GK27749@pengutronix.de>
	<1281449263.3059.53.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 0C7CD103842
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Aug 2010 10:44:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1281449263.3059.53.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 10, 2010 at 03:07:43PM +0100, Liam Girdwood wrote:
> On Tue, 2010-08-10 at 15:15 +0200, Sascha Hauer wrote:
> 
> > I just looked at the i.MX part in the multi-component update and this
> > is currently far from being in a working state, so there's still some
> > work to do before thinking about possible conflicts...
> 
> Ok, I don't think it's that far off. Everything builds for i.MX and all
> components should register. The part I can't test is the component
> probe() and playback/capture.
> 
> Have you seen an oops ?
> 

Besides the patch that I just sent I get a null pointer deref without
the following patch. I couldn't find who should set
codec->ac97->bus->card, but it's null when I get here. Is this an i.MX
fault or is there something else missing here?

Sascha

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 81a77e0..eddb26e 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -312,7 +312,7 @@ static int soc_ac97_dev_register(struct snd_soc_codec *codec)
 	codec->ac97->dev.release = soc_ac97_device_release;
 
 	dev_set_name(&codec->ac97->dev, "%d-%d:%s",
-		     codec->ac97->bus->card->number, 0, codec->name);
+		     codec->snd_card->number, 0, codec->name);
 	err = device_register(&codec->ac97->dev);
 	if (err < 0) {
 		snd_printk(KERN_ERR "Can't register ac97 bus\n");
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
