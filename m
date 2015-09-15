From: Pavel Machek <pavel@ucw.cz>
Subject: Re: System with multiple arizona (wm5102) codecs
Date: Tue, 15 Sep 2015 08:18:32 +0200
Message-ID: <20150915061832.GA25442@amd>
References: <20150914115439.GA29646@amd>
 <20150914115255.GE11200@ck-lbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150914115255.GE11200@ck-lbox>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi!

> > I've got an embedded system with two arizona / wm5102 codecs.
> > 
> > Unfortunately, kernel does not seem to be ready for that
> > configuration.
> > 
> > In particular, drivers/regulator/arizona-ldo1.c and
> > drivers/regulator/arizona-micsupp.c register system-wide "MICVDD" and
> > "LDO1" regulators, but with two codecs in the system, we really have
> > wm5102-codec.1.MICVDD, wm5102-codec.2.MICVDD, wm5102-codec.1.LDO1 and
> > wm5102-codec.2.LDO1.
> > 
> > That got me second codec working in two-codec configuration, but first
> > one still stops working as soon as two codecs are enabled.
> > 
> > If you have idea what else needs fixing, let me know.
> > 
> > Best regards,
> > 								Pavel
> 
> I must confess I haven't ever tested a system with two Arizona
> CODECs connected. Yes it seems you would get clashes on the
> regulator names, I guess that would need to be fixed up. If you
> were doing so wm831x-ldo.c would probably make a reasonable
> example.
> 
> I guess you would need to be careful with the machine driver as
> well, you will need to use a snd_soc_codec_conf structure for at
> least one (although I would do both) of the CODECs to give  a
> prefix for all the widget/control names, otherwise those will
> clash and everything will probably behave very strangely. See
> sound/soc/samsung/bells.c for an example doing this for wm9081.
> 
> Those are the only two things that spring to mind at the moment
> but keep me informed on how you are getting on and I will let you
> know if I can come up with any other traps.

It seems that davinci-evm takes data from device tree, but then uses
statically-allocated evm_soc_card, which would lead to problems in
dual-codec config....?

Thanks,
								Pavel

Signed-off-by: Pavel Machek <pavel@ucw.cz>

commit 977baecbcdb362bdc92096e7c454c379af319f8a
Author: Pavel <pavel@ucw.cz>
Date:   Tue Sep 15 08:16:02 2015 +0200

    Split card allocation in davinci-evm.c

diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index 3296116..de277ca 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -885,8 +899,12 @@ static int davinci_evm_probe(struct platform_device *pdev)
 	struct snd_soc_card_drvdata_davinci *drvdata = NULL;
 	struct clk *mclk;
 	int ret = 0;
+	struct snd_soc_card *card = devm_kzalloc(&pdev->dev, sizeof(struct snd_soc_card), GFP_KERNEL);
+
+	*card = evm_soc_card;
 
-	evm_soc_card.dai_link = dai;
+	printk("bluebox / davinci_evm_probe: probing!\n");
+	card->dai_link = dai;
 
 	dai->codec_of_node = of_parse_phandle(np, "ti,audio-codec", 0);
 	if (!dai->codec_of_node)
@@ -900,8 +918,9 @@ static int davinci_evm_probe(struct platform_device *pdev)
 	if (!dai->platform_name)
 		dai->platform_of_node = dai->cpu_of_node;
 
-	evm_soc_card.dev = &pdev->dev;
-	ret = snd_soc_of_parse_card_name(&evm_soc_card, "ti,model");
+	card->codec_conf = rx51_codec_conf_2;
+	card->dev = &pdev->dev;
+	ret = snd_soc_of_parse_card_name(card, "ti,model");
 	if (ret)
 		return ret;
 
@@ -938,8 +957,8 @@ static int davinci_evm_probe(struct platform_device *pdev)
 				 requestd_rate, drvdata->sysclk);
 	}
 
-	snd_soc_card_set_drvdata(&evm_soc_card, drvdata);
-	ret = snd_soc_register_card(&evm_soc_card);
+	snd_soc_card_set_drvdata(card, drvdata);
+	ret = snd_soc_register_card(card);
 
 	if (ret)
 		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
