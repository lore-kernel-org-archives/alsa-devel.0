From: Rhyland Klein <rklein@nvidia.com>
Subject: Re: [PATCH] ASoC: max98095: add jack detection
Date: Tue, 13 Mar 2012 16:15:24 -0700
Message-ID: <1331680524.9410.11.camel@rklein-linux>
References: <1331667848-8168-1-git-send-email-rklein@nvidia.com>
	<20120313230939.GO3177@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C377104455
	for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2012 00:14:32 +0100 (CET)
In-Reply-To: <20120313230939.GO3177@opensource.wolfsonmicro.com>
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
Cc: Peter Hsiang <cdefgab1288@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 2012-03-13 at 16:09 -0700, Mark Brown wrote:
> * PGP Signed by an unknown key
> 
> On Tue, Mar 13, 2012 at 12:44:08PM -0700, Rhyland Klein wrote:
> 
> > This change adds the logic to support using the jack detect mechanism built
> > in to the codec to detect both when a jack was inserted and what type of
> > jack is present.
> 
> This looks mostly good, a few things below.
> 
> > @@ -51,6 +52,9 @@ struct max98095_priv {
> >  	u8 lin_state;
> >  	unsigned int mic1pre;
> >  	unsigned int mic2pre;
> > +	int irq;
> 
> You can just get the irq from the I2C device.

Right, will do.

> 
> > +	if (max98095->headphone_jack == max98095->mic_jack)
> > +		snd_soc_jack_report(max98095->headphone_jack,
> > +					hp_report | mic_report,
> > +					SND_JACK_HEADSET);
> > +	else {
> 
> Braces on both sides of the if for clarity.

will do. 

> 
> > +static irqreturn_t max98095_jack_handler(int irq, void *data)
> > +{
> > +	struct snd_soc_codec *codec = data;
> > +	int ret;
> > +
> > +	ret = max98095_report_jack(codec);
> > +
> > +	return ret ? IRQ_NONE : IRQ_HANDLED;
> 
> There is no point in having a separate function here, this function has
> no contents.  Just inline it.  Please also avoid the use of the ternery
> operator.

will do.

> 
> > +	/* configure jack detection: slew is calculated as 4 * (delay + 1)
> > +	 * The default is 24 (0x18) to get 100ms delay.
> > +	 */
> > +	ret = snd_soc_write(codec, M98095_08E_JACK_DC_SLEW,
> > +				M98095_DEFAULT_SLEW_DELAY);
> > +	if (ret < 0) {
> > +		dev_err(codec->dev, "Failed to cfg auto detect %d\n", ret);
> > +		return ret;
> > +	}
> 
> Platform data?

As of now there isn't. But that does make sense to support. Will add.

> 
> > +	enable_irq(max98095->irq);
> 
> You shouldn't be fiddling around with enable_irq() and disable_irq().
> Why are you doing this?

this can be removed.

> 
> * Unknown Key
> * 0x6E30FDDD

Thanks for quick review,
Rhyland
