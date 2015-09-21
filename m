From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: codecs: Add da7219 codec driver
Date: Mon, 21 Sep 2015 10:11:00 -0700
Message-ID: <20150921171100.GX30445@sirena.org.uk>
References: <cover.1442500784.git.Adam.Thomson.Opensource@diasemi.com>
 <d709bef63c2dbef6b3d654435b50e183d1e7a1e7.1442500784.git.Adam.Thomson.Opensource@diasemi.com>
 <20150919174414.GJ30445@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A0337D46037AA@SW-EX-MBX01.diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yBbBYFH0ZHvzMoI/"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337D46037AA@SW-EX-MBX01.diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Support Opensource <Support.Opensource@diasemi.com>, Jason Coughlan <jason.coughlan@diasemi.com>
List-Id: alsa-devel@alsa-project.org


--yBbBYFH0ZHvzMoI/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 21, 2015 at 03:08:03PM +0000, Opensource [Adam Thomson] wrote:
> On September 19, 2015 18:44, Mark Brown wrote:

> > This is obviously a massive reconfiguration of the device.  I'm not
> > seeing anything here which prevents userspace coming in and change the
> > configuration while we're in this function, that would obviously have
> > serious issues.

> In a system scenario the likelihood of that happening is small as you
> cannot use the mic or headphones until they've been inserted. The system is
> only likely to act after the jack insertion events have occurred. However, it

This really isn't an OK approach here, you're making a whole bunch of
assumptions about how the system is implemented that aren't robust and
will lead to loss of audio if things go wrong which is a pretty serious
consequence.  Are you *sure* there's going to be a quick enough response
to cover all jack inserts and remove (especially under load), or that
userspace even bothers paying attention given that there's no other
input and output devices?

> would be better to prevent any chance of concurrent access. The problem is how
> best to lock the Kcontrols whilst the test procedure in progress. At the moment
> the only way I can see is to add explicit control set() functions which would
> use a lock that can also be controlled by the HP test code. Does this make sense
> to you or do you know of a simpler method? Obviously dapm has function to lock
> as required.

Yes, you're going to have to do something like that if you want to do
this - you'll also need to lock the reads since otherwise userspace will
see the intermediate control states.

> For the cache resync idea, in terms of code, it will look cleaner, but you are
> talking about 4 to 5 times the number of I2C accesses to the device, to restore
> configuration. Does that not seem like a bit too much overhead?

There's regcache_sync_region().

> > Why are we scheduling work - we're already in thread context?

> hptest will take some time to complete (over 100ms), and in that time it's
> plausible that a user could remove the jack. If we deal with this in the IRQ
> thread, we won't be aware of jack removal during the process, and will send a
> report regardless, which will almost definitely be incorrect, and unnecessary.
> By spawning off work, it allows the removal to be dealt with if the hptest work
> procedure is currently in process, and then we can avoid sending incorrect jack
> reports at the end.

OK, please document this then.

> > > +			/* Un-drive headphones/lineout */
> > > +			snd_soc_update_bits(codec, DA7219_HP_R_CTRL,
> > > +					    DA7219_HP_R_AMP_OE_MASK, 0);
> > > +			snd_soc_update_bits(codec, DA7219_HP_L_CTRL,
> > > +					    DA7219_HP_L_AMP_OE_MASK, 0);

> > This looks like DAPM?

> The control of driving the headphones or making them high impedance is handled
> in the AAD code because we cannot have the headphones driven before a jack is
> inserted as it will affect the pole detection. Adding it to DAPM seemed like it
> would cause more problems in terms of controlling when it would and wouldn't be
> enabled.

IIRC you had some DAPM updates in adjacent code?

> > > +	default:
> > > +		return DA7219_AAD_JACK_INS_DEB_20MS;

> > This isn't an error?

> Opted for HW default in case of invalid values provided. Maybe a dev_warn()
> would be useful though to indicate this is the case?

Yes - the user has explicitly tried to set something and the driver is
ignoring it.

> > > +	ret = regmap_bulk_read(da7219->regmap, reg, &val, sizeof(val));
> > > +	if (ret)
> > > +		return ret;

> > > +	ucontrol->value.integer.value[0] = le16_to_cpu(val);

> > This is *weird*.  We do a bulk read for a single register using an API
> > that returns CPU endian data then make it CPU endian (without any
> > annotations on variables...).  Why not use regmap_read()?  Why swap?
> > Why not use raw I/O?

> The device is 8-bit register access only, and the value spans two registers,
> hence why this is done here. The register defined for the Kcontrol is the first
> in the sequence of two registers (first lower byte, second upper byte). Thought
> this was cleaner than having two separate controls to configure upper and
> lower bytes.

Again some documentation would help, and also using raw reads rather
than bulk reads (which imply that all endianness issues will be taken
care of).  If you're doing a bulk read and handling endianness that's
worrying.  You should also have an endianness annotation for val.

> > This looks like a standard enumeration with a simple mapping to the
> > register map?

> The bit values aren't sequential as per a normal enumeration, which is why I
> added this approach to setting the correct bits. However, I've just spotted the
> SOC_VALUE_ENUM_SINGLE macro which looks like it will do the job, so I'll use
> that instead. Thanks.

Yes, you want a VALUE_ENUM.

> > > +	/* ADCs */
> > > +	SOC_SINGLE_TLV("ADC Volume", DA7219_ADC_L_GAIN,
> > > +		       DA7219_ADC_L_DIGITAL_GAIN_SHIFT,
> > > +		       DA7219_ADC_L_DIGITAL_GAIN_MAX, DA7219_NO_INVERT,
> > > +		       da7219_adc_dig_gain_tlv),
> > > +	SOC_SINGLE("ADC Switch", DA7219_ADC_L_CTRL,
> > > +		   DA7219_ADC_L_MUTE_EN_SHIFT, DA7219_SWITCH_EN_MAX,
> > > +		   DA7219_INVERT),
> > > +	SOC_SINGLE("ADC Gain Ramp Switch", DA7219_ADC_L_CTRL,
> > > +		   DA7219_ADC_L_RAMP_EN_SHIFT, DA7219_SWITCH_EN_MAX,
> > > +		   DA7219_NO_INVERT),

> > Capture Digital rather than ADC.

> Ok, fine. Is this now the common naming to be used for all future codecs?

It's always been the naming in ControlNames.txt - we don't generally
worry about it on devices with more flexible routing which mean that the
associated meaning won't always be really true but for this device it
seems that the options are sufficiently limited to allow userspace to
use the standard name.

> > > +			/* Internal LDO */
> > > +			if (da7219->use_int_ldo)
> > > +				snd_soc_update_bits(codec, DA7219_LDO_CTRL,
> > > +						    DA7219_LDO_EN_MASK,
> > > +						    DA7219_LDO_EN_MASK);

> > If there is an option to use an external supply I would expect to see
> > the regulator API used to discover the external LDO (and ideally also to
> > configure the integrated LDO).  If the driver works outside the
> > frameworks then it is likely this will lead to integration issues later
> > on.

> Given the simplistic nature of the internal LDO, I didn't think it would be
> necessary to use the framework as it seemed overkill. I assume you mean
> following something like what is done in the sgtl5000 codec?

That should work I think.  The point here isn't really the control of
the LDO itself, it's making sure that the integration with external
supplies works well - the key bit is that how we figure out that we
don't have an external supply connected should be joined up with how we
normally integrate external supplies.

> > > +	/*
> > > +	 * There are multiple control bits for the input mixer.
> > > +	 * The following can be enabled now as it's not power related.
> > > +	 */
> > > +	snd_soc_update_bits(codec, DA7219_MIXIN_L_CTRL,
> > > +			    DA7219_MIXIN_L_MIX_EN_MASK,
> > > +			    DA7219_MIXIN_L_MIX_EN_MASK);

> > So the chip designers just put these in for randomness?  Fun.  It'd be
> > more idiomatic to do something like making these supply widgets so
> > they're controlled via DAPM even if they don't matter much.

> Figured we'd be saving on additional I2C accesses if it's just done the once.
> Do you really think it needs to be a widget as it seems a little unnecessary
> enabling and disabling every time that path is powered up and down?

It seems likely to be more robust against someone realising that the
register bits actually do something useful and need toggling and it
raises less eyebrows code wise.

If you're worried about the register writes you should also be able to
arrange to map these in as mixer widgets which would mean that the the
core will combine the writes with the main power controls.

--yBbBYFH0ZHvzMoI/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWADojAAoJECTWi3JdVIfQIP0H/3JhYZCh++UApw1tRVjDOmxJ
eTY+VNHaBpE4YBFeXOk1nAe4+JuFbRV6BIVcQjx6/CIN9L9lJlaZ0Ac4Q61aCTLF
oxPyk2KMYLtMMK/GmOXLdDztrH/Gc5vdypJ7J2B6kAZ0TWqhRNqPx/oBX2f7o+cO
6OISpm2/1m/LU7TLx3gpVaahecwc9Jz10fwXf8tyS1f5TPIn3Ni4WLDfn6oK1t0P
fpIT0AdEgqOeoua0i5hTCdXHvI17lU7iBSNPH0tnnsW/wU0qmPTD2ghbxH/ZOy71
rmt7oDjW5tBROdVGE2dxZnIOp7tyP6AmpO/ZywxTl0vAUoGFEA1fA8mu8xBHTM0=
=BhSd
-----END PGP SIGNATURE-----

--yBbBYFH0ZHvzMoI/--
