From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [patch 1/3] ASoC: add support for alc562[123]
	codecs
Date: Wed, 8 Sep 2010 11:08:27 +0100
Message-ID: <20100908100826.GA1219@rakim.wolfsonmicro.main>
References: <20100907070127.305740006@rtp-net.org>
	<20100907071008.224980268@rtp-net.org>
	<20100907102112.GE7886@rakim.wolfsonmicro.main>
	<87d3spd6wn.fsf@lechat.rtp-net.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 71DC024457
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Sep 2010 12:08:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <87d3spd6wn.fsf@lechat.rtp-net.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: alsa-devel@alsa-project.org, Saeed Bishara <saeed@marvell.com>, Martin Michlmayr <tbm@cyrius.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 07, 2010 at 03:23:20PM +0200, Arnaud Patard wrote:
> Mark Brown <broonie@opensource.wolfsonmicro.com> writes:

> > It looks like it'd be simpler to do something like:

> > 	{ "HPL", NULL, "HP" },
> > 	{ "HPR", NULL, "HP" },

> > then have the two ADC channels feed into the left and right channels of
> > the headphone while having the single switches feed into the HP widget
> > (which would be a NOPM dummy widget for routing purposes).

> hmm... I'm not sure to understand correctly. The two bits
> ALC5623_PWR_ADD2_?_HP_MIXER are for the HP mixers. There are 2 mixers
> but I'm doing like there's only 1 mixer due to the single bit inputs.
> Can you please give more details about your suggestion ?

Add on to the above things like this:

	{ "HPL", "ADC Switch", "ADCL" },
	{ "HPR", "ADC Switch", "ADCR" },

	{ "HP", "AUX Switch", "Aux" },

so you get separate left/right control where you have stereo control
while still getting the mono control on the virtual mono HP widget.

> >> +#define ALC5623_ADD1_POWER_EN_5622 \
> >> +	(ALC5623_PWR_ADD1_MAIN_I2S_EN | ALC5623_PWR_ADD1_MIC1_BIAS_EN \
> >> +	| ALC5623_PWR_ADD1_SHORT_CURR_DET_EN \
> >> +	| ALC5623_PWR_ADD1_HP_OUT_AMP)

> > Most of the stuff in here looks like it ought to be managed by DAPM?

> hmm... I thought it was easier/better done like this. Is it a hard
> requirement ?

Given that you're already defining widgets for things like the I2S (the
AIF widgets) it seems silly not to.  For the micbias I'd say it's a hard
requirement since driving the micbias when not needed is potenially
harmful.

> > Since we now support out of line resume for ASoC devices (so we don't
> > hold up the rest of the system) it should be possible to just do this
> > stuff in the set_bias_level() function rather than faffing around with
> > delayed work like this.  This is less racy.

> I was even wondering about removing that stuff but as it was there in
> original driver, I choose to keep it. WDYT ?

If you look at the current WM8753 driver you'll see that it's been
removed from there.

> >> +	if (alc5623->add_ctrl) {
> >> +		snd_soc_write(codec, ALC5623_ADD_CTRL_REG,
> >> +				alc5623->add_ctrl);
> >> +	}

> > Hrm?

> this register contains some board specific values and I didn't see how
> it could be handled except by using platform_data.

What are they?

> >> +#ifndef _INCLUDE_LINUX_ALC5623_H
> >> +#define _INCLUDE_LINUX_ALC5623_H
> >> +struct alc5623_platform_data {
> >> +	unsigned int add_ctrl;
> >> +	unsigned int jack_det_ctrl;
> >> +};

> > Some documentation explaining what these are would probably be useful.

> The names are really near to the names in the specs. As you need to look
> at the specs to have their values, I thought it would be enough.

So saying something like "Values to be written to the add_ctrl and
jack_det_ctrl registers" would cover it.  Remember, if a software
engineer is picking up a preexisting driver they may never even look at
the datasheet.
