From: Zeng Zhaoming <zhaoming.zeng@freescale.com>
Subject: Re: [PATCH] asoc,
	codec: Add SGTL5000 codec support to asoc
Date: Thu, 9 Dec 2010 03:22:35 +0800
Message-ID: <20101208192235.GA24928@ubuntu.localdomain>
References: <1291773989-22747-1-git-send-email-zhaoming.zeng@freescale.com>
	<20101208121155.GC16418@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from DB3EHSOBE003.bigfish.com (db3ehsobe003.messaging.microsoft.com
	[213.199.154.141])
	by alsa0.perex.cz (Postfix) with ESMTP id F163410384F
	for <alsa-devel@alsa-project.org>; Thu,  9 Dec 2010 04:24:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20101208121155.GC16418@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, zhaoming.zeng@freescale.com, festevam@gmail.com, arnaud.patard@rtp-net.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed 2010-12-08 05:11:55, Mark Brown wrote:
> On Wed, Dec 08, 2010 at 10:06:29AM +0800, zhaoming.zeng@freescale.com
> wrote:
> > From: Zeng Zhaoming <zhaoming.zeng@freescale.com>
> 
> Broadly speaking this is OK - there's quite a few comments below but
> they're mostly fairly small and local things rather than major
> structural issues.  The one thing that needs real work is the power
> management which is fairly non standard and seems to follow a mix of
> hard coding and DAPM.  A lot of the issues here seem to be due to some
> rather nasty hardware issues so there's likely to be limits on how nice
> the software can be.
> 
> For the subject line, please use a prefix such as "ASoC: " like other
> patches do - in general check the changelogs for the area you're
> submitting against for things like this.

hi, Mark, thanks for so carefully review, and so many suggestion.

> 
> >  config SND_SOC_WM9090
> >  	tristate
> > +
> > +config SND_SOC_SGTL5000
> > +	tristate
> 
> Keep both Kconfig and Makefile sorted, and remember to add your CODEC to
> SND_SOC_ALL_CODECS.
> 
> > +	struct regulator *supplies[SGTL5000_SUPPLY_NUM];
> > +	int regulator_volt[SGTL5000_SUPPLY_NUM];
> > +	struct regulator *reg_vddio;
> > +	struct regulator *reg_vdda;
> > +	struct regulator *reg_vddd;
> > +	int vddio;		/* voltage of VDDIO (mv) */
> > +	int vdda;		/* voltage of vdda (mv) */
> > +	int vddd;		/* voltage of vddd (mv), 0 if not
> connected */
> 
> You appear to be keeping two copies of the regulators and their
> voltages.  TBH I'm not clear why you're caching the voltages - you may
> as well just read them when you need them, you only refer to them at
> probe time anyway.

Sorry, I forget to clean up this code.

> > +static int sgtl5000_pcm_hw_params(struct snd_pcm_substream
> *substream,
> > +				  struct snd_pcm_hw_params *params,
> > +				  struct snd_soc_dai *dai)
> > +{
> 
> > +	switch (sgtl5000->lrclk) {
> > +	case 8000:
> > +	case 16000:
> > +		sys_fs = 32000;
> > +		break;
> > +	case 11025:
> > +	case 22050:
> > +		sys_fs = 44100;
> > +		break;
> > +	default:
> > +		sys_fs = sgtl5000->lrclk;
> > +		break;
> 
> A comment explaining what's going on here would be helpful - it
> looks like the device is running internally at 32kHz or higher and
> downsampling somehow to present lower output frequencies?

Right, we need to downsampling for low frequencies.

> pop/clicks */
> > +	sgtl5000_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
> > +	if (codec->suspend_bias_level == SND_SOC_BIAS_ON)
> > +		sgtl5000_set_bias_level(codec, SND_SOC_BIAS_PREPARE);
> > +	sgtl5000_set_bias_level(codec, codec->suspend_bias_level);
> 
> The CODEC will never be in any state above STANDBY at suspend.

Is there any documentation describe the state machine? 

> 
> > +	for (i = 0; i < SGTL5000_SUPPLY_NUM; i++) {
> > +		struct regulator *reg;
> > +		reg = regulator_get(&client->dev, supply_names[i]);
> > +		if (IS_ERR(reg))
> > +			continue;
> > +
> > +		sgtl5000->regulator_volt[i] = regulator_get_voltage(reg)
> / 1000;
> > +		regulator_enable(reg);
> > +
> > +		sgtl5000->supplies[i] = reg;
> > +	}
> 
> > +	sgtl5000->regulator_volt[VDDA] = 3300;
> > +	sgtl5000->regulator_volt[VDDIO] = 3300;
> 
Sorry again, forget to cleanup.

> 
> > +	msleep(1);
> 
> This delay looks like it's in the wrong place?

The SGTL5000 has an internal reset that is deasserted 8 SYS_MCLK cycles after 
all power rails have been brought up. After this time communication can start.

So I think delay 1ms is safe for the next operations.
