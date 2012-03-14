From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 13/16] ASoC: codecs: Add AB8500 codec-driver
Date: Wed, 14 Mar 2012 13:45:08 +0000
Message-ID: <20120314134508.GL3133@opensource.wolfsonmicro.com>
References: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
	<1331651503-16917-14-git-send-email-ola.o.lilja@stericsson.com>
	<20120313224529.GL3177@opensource.wolfsonmicro.com>
	<AC3CA153830A24419D7BF22D87B39D0557F2F28251@EXDCVYMBSTM006.EQ1STM.local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1161463330827960743=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C99C410416B
	for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2012 14:45:10 +0100 (CET)
In-Reply-To: <AC3CA153830A24419D7BF22D87B39D0557F2F28251@EXDCVYMBSTM006.EQ1STM.local>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ola LILJA2 <ola.o.lilja@stericsson.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============1161463330827960743==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WuT04sMzYDXq8et0"
Content-Disposition: inline


--WuT04sMzYDXq8et0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 14, 2012 at 02:27:13PM +0100, Ola LILJA2 wrote:

Fix your mailer to word wrap properly, I've reflowed your text for
legibility.

> > > diff --git a/sound/soc/codecs/ab8500_audio.c
> > > b/sound/soc/codecs/ab8500_audio.c

> > Everything else uses -codec.

> Could just see one codec named with "-codec". The reason for appending _audio
> Is that the AB8500 is not only audio and we already have files elsewhere named
> ab8500.c but I probably could rename it to ab8500-codec.c.

The drivers for MFDs pretty much all call themselves -codec internally
(as yours does).

> > Why are you doing this virtual register stuff?  It's making the code a
> > lot more complex and doesn't look at all driver specific.

> There is a chain of events leading up to the decision of having it
> like this.  The HW is designed so that only one coefficient-register
> is present and when we write a value to it the HW increases a HW-index
> so that the next time we write to it the value will set the next
> coefficient and so on.  Also, we don't want to be able to first set
> all FIR/IIR-coefficients with the ALSA-controls And when we are happy
> we write all the coefficients to the HW by committing them using the
> strobe-control.  Furthermore, we cannot read the coefficients from the
> HW, so to be able to provide this to userspace we use the
> SOC_HWDEP_MULTIPLE_1R, and since these values actually is not exposed
> as separate registers we use a set of virtual register. When we commit
> the coefficients we then take the values from the virtual registers
> and write them down to the HW in a loop.

Don't do this, this just makes things a lot more complicated in the
register I/O code and making it much more difficult to work with both
locally and from a framework point of view.  Store the coefficients in
your driver data rather than shoehorning them into the register cache.

> > > +static const char * const enum_ena_dis[] = {"Enabled", "Disabled"};
> > > +static const char * const enum_dis_ena[] = {"Disabled", "Enabled"};

> > Why are the controls using these enums and not Switch controls?  UIs
> > know how to display switches.

> We need to make the switches virtual, as we don't want them to
> actually set any bits, just break or complete a DAPM-chain. That is
> why we made the as MUX:es.

This is completely orthogonal to how the controls are displayed to
userspace, it's an implementation detail of your driver.  Though if your
routing control doesn't actually touch the device one has to wonder what
it actually does...

> > > +/* Earpiece - Mute */
> > > +static const struct snd_kcontrol_new dapm_ear_mute[] = {
> > > +	SOC_DAPM_SINGLE("Playback Switch", REG_MUTECONF,
> > > +REG_MUTECONF_MUTEAR, 1, 1), };

> > This looks like it's just a mute rather than a mixer input enable
> > (there's only one control...) so should be a regular sound control;
> > unless there's a very good reason mutes other than mixer inputs
> > normally don't affect the audio path as you might get pops and you
> > probably don't want to do things like stop clocking just because the
> > output is silenced.  Similar thing applies in several other places.

> Most of the mutes need to be apart of the DAPM-chain to actually prevent
> click-n-pops. So it cannot be used by the user as a normal ALSA-control.
> Muting can be done by setting certain gains to -inf.

This explanation doesn't correspond to what you've actually written -
the code above will result in a user visible control.

> > > +			unsigned int fmt,
> > > +			unsigned int wl,
> > > +			unsigned int delay);
> > > +void ab8500_audio_anc_configure(struct snd_soc_codec *codec,
> > > +			bool apply_fir, bool apply_iir);

> > No, you shouldn't be exporting this stuff - it all looks like basic
> > framework stuff.

> Hmm.. ok... the power_control is needed for reasons explained before
> (vibra-driver and Accessory-detection-magic), but I guess I have to
> remove these features for now and I can then remove this export.

You've not mentioned accessory detection before...  there's certainly
no obvious excuse for doing the power management for accessory detection
outside of DAPM, we've got a bunch of drivers in mainline already which
manage to do this quite successfully, but since you've not explained
what the issue you think you see is it's hard to comment.

--WuT04sMzYDXq8et0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPYKDWAAoJEBus8iNuMP3d8uQQAIhFKMPKpkB2STTxVGhie/uz
xiFA5qQGYgWs6U+9POAnM9BtVoDv1VEtojZpX6Yf4XcRCwl7gKQk+gH2JtVAq8I2
8QzFHFbQ6YbFDZf4cjLz+c/f2Y2GlG+9B8wyNQgLTOzSHcVd9gmm5czUK44Bs5oi
devrhY6HZ1CwFInQF/7cH8yeOE6vNwNc3rwobts8swieS5z6kHCWnQo7jrU5CaDc
eikNQ95M5E8tvFX/b42tPvVwDBGQ/YQl86jPwLFOzE+05GifnAPPXR1u0jdWjxhK
pBduYiv5t+CGkQpTP9CAHmYCKCt27+PNXzE4fFHF2/9hUzWspvfHKlpGMd9j4lVX
OUvHx4vTy3+eb5vHgZCOPlAvXmfGit6QN0bo1LVgJPrOK33Jg+3L1VPVzn51KO9S
r39UYFPjwtaRoQDusOkAPSPV4w27O/uYpSNo5NUM+kiYN055Z47puBtVgd1q0L2K
VOn52lCGzWi4JG4XL5SEBFWKEhOLvlrDvSdHqcIbCzp4a3IzGO/KAms3xr3C0cMa
tmw+ZmipBNO252gASg3bO0i8XVep5OMgc2aVscbSgpdqcXkHETn+1vTXRI9Rizgk
hUOgHM3OOYaRGAMrr0Ip0Gl5YUQRIaQ8P7KYNLlPl7D9WbwadJCMh+cYUL3vvqbl
cvw2WNOaQ0n4kxHuZ84u
=M3pO
-----END PGP SIGNATURE-----

--WuT04sMzYDXq8et0--

--===============1161463330827960743==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1161463330827960743==--
