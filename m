From: Oder Chiou <oder_chiou@realtek.com>
Subject: Re: [PATCH] ASoC: add RT5639 CODEC driver
Date: Wed, 26 Mar 2014 06:39:38 +0000
Message-ID: <7EB0DE829A537248AF2ED30C97D126943581B0@RTITMBSV03.realtek.com.tw>
References: <1395627397-6580-1-git-send-email-oder_chiou@realtek.com>
 <20140325133017.GY2269@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C2A8265141
 for <alsa-devel@alsa-project.org>; Wed, 26 Mar 2014 07:39:45 +0100 (CET)
In-Reply-To: <20140325133017.GY2269@sirena.org.uk>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Tuesday, March 25, 2014 9:30 PM
> To: Oder Chiou
> Cc: lgirdwood@gmail.com; alsa-devel@alsa-project.org; Flove; Bard Liao
> Subject: Re: [PATCH] ASoC: add RT5639 CODEC driver
> 
> On Mon, Mar 24, 2014 at 10:16:37AM +0800, oder_chiou@realtek.com wrote:
> > From: Oder Chiou <oder_chiou@realtek.com>
> >
> > This patch adds the RT5639 codec driver.
> 
> Looking at the level of code similiarity between this and the rt5640 driver I can't
> help but think that these should be supported from a single driver - a few quick
> spot checks of the register map suggests that there's at least some overlap.
> There will need to be some device specific handling but it looks like there's more
> shared than not shared.
> What are the issues that prevent the code being shared, there may be something
> I've missed?
> 

We will merge the RT5639 driver to RT5640.

> > +static int rt5639_probe(struct snd_soc_codec *codec) {
> > +	struct rt5639_priv *rt5639 = snd_soc_codec_get_drvdata(codec);
> > +	int ret;
> > +
> > +	rt5639->codec = codec;
> > +	codec->control_data = rt5639->regmap;
> > +
> > +	ret = snd_soc_codec_set_cache_io(codec, 8, 16, SND_SOC_REGMAP);
> > +	if (ret != 0) {
> > +		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
> > +		return ret;
> > +	}
> 
> There have been some API changes here this release cycle, you should be able to
> just remove the cache_io() and regmap setting code here.

Do you mean that the cache_io() can be removed here?
Please tell us which codec driver can be for our reference, thank you.
