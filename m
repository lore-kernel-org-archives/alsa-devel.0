From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Codec driver for Texas
	Instruments	tlv320dac33 codec
Date: Tue, 13 Oct 2009 10:26:22 +0100
Message-ID: <20091013092622.GA1230@sirena.org.uk>
References: <1255348139-13609-1-git-send-email-peter.ujfalusi@nokia.com>
	<20091012151800.GB18283@rakim.wolfsonmicro.main>
	<200910131013.00050.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3EFCB103802
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Oct 2009 11:26:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200910131013.00050.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 13, 2009 at 10:12:59AM +0300, Peter Ujfalusi wrote:
> On Monday 12 October 2009 18:18:00 ext Mark Brown wrote:

> > > +	if (dac33->power_state) {
> > > +		val = i2c_smbus_read_byte_data(codec->control_data, value[0]);
> > > +		if (val < 0) {

> > This is happening a lot - it should probably be factored into the shared
> > register cache code, there's a lot of devices which could use something
> > like this especially as regulator support is added to more and more
> > drivers.

> Actually this does not happen that much, since the reg_cache is used for most of 
> the read operation, but the write through I2C might be happening more.

I mean the pattern of suppressing I2C writes while the chip is powered
down rather than the 

> I'm not sure how to make sure that we can access to the chip, and at the same 
> time do not use extensive mutex lock/unlock for the I2C accesses.
> Ideas?

Perhaps just call the mutex something more descriptive like chip_power
or something might be enough make it clear what it's protecting?

> > Hrm.  I'm finding the set_power/soft_power thing a little abstruse here,
> > partly due to the very close naming and partly due to the asymmetry in
> > the calls - I can see what they do but it's not entirely obvious.

> Hmm, yes you are right, it is kind of a mess...
> I can think of the following:
> dac33_set_power -> dac33_hard_reset
> dac33_soft_power -> dac33_soft_reset

> In dac33_set_bias_level only toggle the dac33_soft_reset.
> In dac33_soc_suspend/dac33_soc_resume I can use the dac33_hard_reset with 
> register restore.

> Does it makes it a bit cleaner?

I think so - it'd probably also help if the cache restore were merged
into one of the functions too.  I'd be inclined to keep _power too.

> > > +	pwr_ctrl &= ~(OSCPDNB | DACRPDNB | DACLPDNB);
> > > +	dac33_write(codec, DAC33_PWR_CTRL, pwr_ctrl);

> > This looks like a case for DAPM?
> 

> Well, yes. I have tried that. The problem is that tlv320dac33 is really picky on 
> the sequence of the register writes. what I mean by 'picky' is that if the 

OK, fair enough.

> > Is there any great reason for setting all of this stuff rather than
> > using the hardware defaults?

> Yes and no. I can wipe out the unneeded things, but most of the settings here is 
> needed to get the dac33 working. If we use the HW defaults, than dac33 would not 
> work.
> The DAC_CTRL_B register for example controls the digital routing to the DACs.
> I will try to find a way to use user controls for most of the settings in a 
> future, if it is OK.

OK.  I'd expect that at some point people will want to control things
like the digital routing.
