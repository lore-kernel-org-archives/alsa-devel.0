From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH 1/3] ASoC: codecs: Add da7219 codec driver
Date: Tue, 22 Sep 2015 13:00:27 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337D46048E8@SW-EX-MBX01.diasemi.com>
References: <cover.1442500784.git.Adam.Thomson.Opensource@diasemi.com>
 <d709bef63c2dbef6b3d654435b50e183d1e7a1e7.1442500784.git.Adam.Thomson.Opensource@diasemi.com>
 <20150919174414.GJ30445@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A0337D46037AA@SW-EX-MBX01.diasemi.com>
 <20150921171100.GX30445@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta14.messagelabs.com (mail1.bemta14.messagelabs.com
 [193.109.254.110])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D038261B28
 for <alsa-devel@alsa-project.org>; Tue, 22 Sep 2015 15:00:34 +0200 (CEST)
In-Reply-To: <20150921171100.GX30445@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Support Opensource <Support.Opensource@diasemi.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Jason Coughlan <jason.coughlan@diasemi.com>, Kumar Gala <galak@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On September 21, 2015 18:11, Mark Brown wrote:

> > In a system scenario the likelihood of that happening is small as you
> > cannot use the mic or headphones until they've been inserted. The system is
> > only likely to act after the jack insertion events have occurred. However, it
> 
> This really isn't an OK approach here, you're making a whole bunch of
> assumptions about how the system is implemented that aren't robust and
> will lead to loss of audio if things go wrong which is a pretty serious
> consequence.  Are you *sure* there's going to be a quick enough response
> to cover all jack inserts and remove (especially under load), or that
> userspace even bothers paying attention given that there's no other
> input and output devices?

You make a fair point, and I'd much rather it was bullet proof.

> > would be better to prevent any chance of concurrent access. The problem is how
> > best to lock the Kcontrols whilst the test procedure in progress. At the moment
> > the only way I can see is to add explicit control set() functions which would
> > use a lock that can also be controlled by the HP test code. Does this make sense
> > to you or do you know of a simpler method? Obviously dapm has function to lock
> > as required.
> 
> Yes, you're going to have to do something like that if you want to do
> this - you'll also need to lock the reads since otherwise userspace will
> see the intermediate control states.

Ok, will look at adding set() and get() functions for the controls affected.

> 
> > For the cache resync idea, in terms of code, it will look cleaner, but you are
> > talking about 4 to 5 times the number of I2C accesses to the device, to restore
> > configuration. Does that not seem like a bit too much overhead?
> 
> There's regcache_sync_region().

That's fine if the registers are clumped closely together. Will have a look and
see if it works out cleaner. Thanks.

> > > Why are we scheduling work - we're already in thread context?
> 
> > hptest will take some time to complete (over 100ms), and in that time it's
> > plausible that a user could remove the jack. If we deal with this in the IRQ
> > thread, we won't be aware of jack removal during the process, and will send a
> > report regardless, which will almost definitely be incorrect, and unnecessary.
> > By spawning off work, it allows the removal to be dealt with if the hptest work
> > procedure is currently in process, and then we can avoid sending incorrect jack
> > reports at the end.
> 
> OK, please document this then.

Ok, will add comments to clarify.

> 
> > > > +			/* Un-drive headphones/lineout */
> > > > +			snd_soc_update_bits(codec, DA7219_HP_R_CTRL,
> > > > +					    DA7219_HP_R_AMP_OE_MASK, 0);
> > > > +			snd_soc_update_bits(codec, DA7219_HP_L_CTRL,
> > > > +					    DA7219_HP_L_AMP_OE_MASK, 0);
> 
> > > This looks like DAPM?
> 
> > The control of driving the headphones or making them high impedance is handled
> > in the AAD code because we cannot have the headphones driven before a jack is
> > inserted as it will affect the pole detection. Adding it to DAPM seemed like it
> > would cause more problems in terms of controlling when it would and wouldn't be
> > enabled.
> 
> IIRC you had some DAPM updates in adjacent code?

Yes, there's a disable_pin() call for micbias. However that will not
disable the pin indefinitely which is what I would require for this. I need to
know that there's no chance of the pin being enabled prior to jack insertion.
 
> > > > +	default:
> > > > +		return DA7219_AAD_JACK_INS_DEB_20MS;
> 
> > > This isn't an error?
> 
> > Opted for HW default in case of invalid values provided. Maybe a dev_warn()
> > would be useful though to indicate this is the case?
> 
> Yes - the user has explicitly tried to set something and the driver is
> ignoring it.

Agreed. Will update accordingly.

> 
> > > > +	ret = regmap_bulk_read(da7219->regmap, reg, &val, sizeof(val));
> > > > +	if (ret)
> > > > +		return ret;
> 
> > > > +	ucontrol->value.integer.value[0] = le16_to_cpu(val);
> 
> > > This is *weird*.  We do a bulk read for a single register using an API
> > > that returns CPU endian data then make it CPU endian (without any
> > > annotations on variables...).  Why not use regmap_read()?  Why swap?
> > > Why not use raw I/O?
> 
> > The device is 8-bit register access only, and the value spans two registers,
> > hence why this is done here. The register defined for the Kcontrol is the first
> > in the sequence of two registers (first lower byte, second upper byte). Thought
> > this was cleaner than having two separate controls to configure upper and
> > lower bytes.
> 
> Again some documentation would help, and also using raw reads rather
> than bulk reads (which imply that all endianness issues will be taken
> care of).  If you're doing a bulk read and handling endianness that's
> worrying.  You should also have an endianness annotation for val.

If I had used bulk_read() and an array of 2 u8 values instead, and then
converted what was read into a u16, would that have been better/clearer? I can
do that, but figured this might be a more elegant soluion. Either, way I'll
add some comments to clarify what's going on.

> > > Capture Digital rather than ADC.
> 
> > Ok, fine. Is this now the common naming to be used for all future codecs?
> 
> It's always been the naming in ControlNames.txt - we don't generally
> worry about it on devices with more flexible routing which mean that the
> associated meaning won't always be really true but for this device it
> seems that the options are sufficiently limited to allow userspace to
> use the standard name.

Ok, understood.

> > > > +			/* Internal LDO */
> > > > +			if (da7219->use_int_ldo)
> > > > +				snd_soc_update_bits(codec, DA7219_LDO_CTRL,
> > > > +						    DA7219_LDO_EN_MASK,
> > > > +						    DA7219_LDO_EN_MASK);
> 
> > > If there is an option to use an external supply I would expect to see
> > > the regulator API used to discover the external LDO (and ideally also to
> > > configure the integrated LDO).  If the driver works outside the
> > > frameworks then it is likely this will lead to integration issues later
> > > on.
> 
> > Given the simplistic nature of the internal LDO, I didn't think it would be
> > necessary to use the framework as it seemed overkill. I assume you mean
> > following something like what is done in the sgtl5000 codec?
> 
> That should work I think.  The point here isn't really the control of
> the LDO itself, it's making sure that the integration with external
> supplies works well - the key bit is that how we figure out that we
> don't have an external supply connected should be joined up with how we
> normally integrate external supplies.

Ok, thanks. Will update.

> > > > +	/*
> > > > +	 * There are multiple control bits for the input mixer.
> > > > +	 * The following can be enabled now as it's not power related.
> > > > +	 */
> > > > +	snd_soc_update_bits(codec, DA7219_MIXIN_L_CTRL,
> > > > +			    DA7219_MIXIN_L_MIX_EN_MASK,
> > > > +			    DA7219_MIXIN_L_MIX_EN_MASK);
> 
> > > So the chip designers just put these in for randomness?  Fun.  It'd be
> > > more idiomatic to do something like making these supply widgets so
> > > they're controlled via DAPM even if they don't matter much.
> 
> > Figured we'd be saving on additional I2C accesses if it's just done the once.
> > Do you really think it needs to be a widget as it seems a little unnecessary
> > enabling and disabling every time that path is powered up and down?
> 
> It seems likely to be more robust against someone realising that the
> register bits actually do something useful and need toggling and it
> raises less eyebrows code wise.
> 
> If you're worried about the register writes you should also be able to
> arrange to map these in as mixer widgets which would mean that the the
> core will combine the writes with the main power controls.

Just didn't seem necessary. However, will change it as requested.
