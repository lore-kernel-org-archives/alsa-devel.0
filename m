From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] sound: soc: codecs: Add es8328 codec
Date: Mon, 10 Feb 2014 14:23:14 +0000
Message-ID: <20140210142314.GL1757@sirena.org.uk>
References: <1391749517-11787-1-git-send-email-xobs@kosagi.com>
 <1391749517-11787-2-git-send-email-xobs@kosagi.com>
 <20140207181238.GL1757@sirena.org.uk>
 <52F5E661.5010807@kosagi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WI+ghjzd0JGVd6h/"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52F5E661.5010807-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--WI+ghjzd0JGVd6h/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 08, 2014 at 04:10:09PM +0800, Sean Cross wrote:
> On 8/2/14 2:12 AM, Mark Brown wrote:

> > In general this looks like it should be making much more use of the
> > framework rather than open coding, it looks like it's very much hard
> > coded for one use cae.

> Alright, I'll try to use more of the framework provided.  I tried to use
> one of the Wolfson codecs as an example.  Is there a "canonical" driver
> that's up-to-date and uses an appreciable amount of framework?

Try wm8731 I guess, something similar to the device, there's a lot of
variation in device complexity and several generations of hardware?  I'm
not sure what driver you were looking at here.

> >> +static const struct snd_soc_dapm_widget es8328_dapm_widgets[] = {
> >> +    SND_SOC_DAPM_DAC("Speaker Volume", "HiFi Playback",
> SND_SOC_NOPM, 0, 0),

> > Don't declare a stream by name, use DAPM routes to connect the stream to
> > the widget.

> Where can I read up on DAPM routes?  I don't see the word "route"
> mentioned in the dapm.txt SoC documentation.

Paths.

> >> +static int es8328_adc_enable(struct snd_soc_codec *codec)
> >> +{
> >> +    u16 reg = snd_soc_read(codec, ES8328_CHIPPOWER);
> >> +    reg &= ~(ES8328_CHIPPOWER_ADCVREF_OFF |
> >> +         ES8328_CHIPPOWER_ADCPLL_OFF |
> >> +         ES8328_CHIPPOWER_ADCSTM_RESET |
> >> +         ES8328_CHIPPOWER_ADCDIG_OFF);
> >> +    snd_soc_write(codec, ES8328_CHIPPOWER, reg);

> > This looks like it should be done in DAPM.

> The codec has very strict power sequencing.  If I'm understanding the
> document correctly, I'd add a DAPM widget for the DAC, and then register
> a widget event for when the DAC gets opened, and do power sequencing
> there?  Or is there a way to have multiple register writes defined as a
> single DAPM widget?

An event callback is the way to go.  However please check what the
datasheet is actually trying to say - I suspect you will find it's
giving you a procedure that's got common elements for core power up and
then is saying something like "keep the outputs muted while you power
them up" but is doing it with lots of examples.

> >> +    /* Frequency clock of 272 */
> >> +    snd_soc_write(codec, ES8328_ADCCONTROL5, 0x02);

> > What is the frequency clock in this context?

> The frequency is a specific divider defined in the datasheet.  There is
> a table of frequencies and dividers for various frequencies.  One option
> is to code this table into the driver and pick the frequency clocks out
> of the table.

That seems much better.

> I decided to assume the codec has a fixed input frequency of 22.5792
> MHz.  This means the codec can support 11.025, 22.05, and 44.1 kHz, but
> cannot support 48 kHz.  It should be possible to instead feed the codec
> a 24 MHz clock and run it at 48 kHz.  Pulseaudio runs at 44.1 by
> default, so I went with that.

This is what set_sysclk() is for, letting the driver know what the clock
rate is on the current board (if you are willing to go DT only you can
just use the clock API).

> My fault for omitting one.
> Much of the code in adc_enable() and dac_enable() come from the
> reference manual.  They indicate that the codec has very strict ordering
> requirements on registers that must be set during playback and
> recording.  Again, is there any way to ensure that hw_params(),
> set_dai_fmt(), and the DAPM widgets are called in a specific order?

No, there's no way to do that.  Like I say I am somewhat mistrustful of
the clarity/accuracy of the hardware limitations being described here.

--WI+ghjzd0JGVd6h/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS+ODOAAoJELSic+t+oim9o9cP/0NM6vCjAQKwpfwgUqXZPw8R
37UNVjitjjWfMhM5EYNDNFbWS9reylveBDJT4VvLuhTayze2rrbsCCwKmaHrsAP8
JwI4CvIXOgY9gV82BTRp1iN4n02qCbpMEcvniVsMx/L1D/6DUvAdwK8TQO1bfWp7
+pDDpAhpfghj/j428RLt9V/Cam+6D/e8Wfag+RZDxx4ApboAZmxZNxnCYIFUUVKS
EdVBN1p3OqpDVI22uOqb4PW+UHLTWROz/e6AWEW3HwdO2jiLKXNRpYxLH9sFMgTu
ixl7DWoWJhpjIvyTmdqNY6diIZ1yiTsnOLFgVOtoowCtt+SJRiTsBsLV3z1Z5Ir0
tOtC3ubGvTlLqdYtlnVSOwsj4PG80sb7E2NRzatfnRfhqxj8Gz+91sDprFFyvj6j
RsCFza1MxDrP/d2Mn1llKXdieCfd0kahYKjeIJBu2BCSev/4jIsDY6GYTUj871OY
8GJc5PPoBB78KE69tOaS4gdVACvmmXnQ1WXSx5wvR0KCxNfiGduAQHgBAGWI5qNV
reTb7+ygtdIsFm3aycjiQqy9KNuWIMPAukdNUJzF7aEJpyFnRLiS2Fi10k05/2m0
imHKomWc6623mxGXKqOMBkzvVs8N3h/Zec0xx2Z7VBSl/zKPqG1sU78TuwFU8aQ+
EYjvU/bf/U/vnULSYTHr
=8kQ+
-----END PGP SIGNATURE-----

--WI+ghjzd0JGVd6h/--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
