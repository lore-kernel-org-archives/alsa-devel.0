From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/5] ASoC: Add ADAU1361/ADAU1761 audio
	CODEC support
Date: Thu, 29 Aug 2013 10:53:56 +0100
Message-ID: <20130829095356.GQ10783@sirena.org.uk>
References: <1377703214-23234-1-git-send-email-lars@metafoo.de>
 <1377703214-23234-2-git-send-email-lars@metafoo.de>
 <20130828172400.GM10783@sirena.org.uk>
 <521F0027.5010002@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1707308252857976915=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 95B682616B4
 for <alsa-devel@alsa-project.org>; Thu, 29 Aug 2013 11:54:01 +0200 (CEST)
In-Reply-To: <521F0027.5010002@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1707308252857976915==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u2qWrZzts+9rBanj"
Content-Disposition: inline


--u2qWrZzts+9rBanj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 29, 2013 at 10:02:47AM +0200, Lars-Peter Clausen wrote:
> On 08/28/2013 07:24 PM, Mark Brown wrote:

> > Not a requirement and perhaps it has no effect but these seem like they
> > ought to integrate with the bias level configuration - since only the
> > clocks seem to be managed by set_bias_level() the driver could
> > presumably save a bit of power by dropping down to the minimal power
> > consumption bias while the device is idle.  This is what the STANDBY to
> > ON transition is all about.

> Hm, I'm not sure if it makes a difference since all the components have
> individual power control bits that are managed by DAPM. I would expect the
> bias current setting to only make a difference if the component is actually
> powered up. I'll check with the designers, but I think this can still be
> improved later on if it turns out that it saves power.

Given that the device has non-capless headphone outputs I'd expect
there's something being maintained normally, though it's possible that
it's still ground referenced.

> >> +static const struct snd_kcontrol_new adau1761_jack_detect_controls[] = {
> >> +	SOC_SINGLE("Jack Detect Switch", ADAU1761_DIGMIC_JACKDETECT, 4, 1, 0),
> >> +};

> > Why is this a user visible control and not using the jack detection
> > framework support?

> The CODEC unfortunately does not support reporting the jack state. All it
> can do is mute the speaker output in hardware if something is plugged into
> the headphone jack. The switch allows the users to control whether the
> output should be auto-muted or not.

In that case it should be called something like "Speaker Automute
Switch" or similar.  It's a bit unfortuante that there's not even any
readback for the function.

--u2qWrZzts+9rBanj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSHxoxAAoJELSic+t+oim9oTwP/AoKdUMKprdLJnHEx1ML8Cm1
60xjosBPocScoaenD9G0UZNZrylpD3RxyNGNUi83ISKSgu2d1wUoDnnPSeyGldZ0
7bC8d1Ixu2tpkHuKtPuoWFNQ9WJ70aDKaXXI2kyQKJbDvZd42sWMf7BlnHNQYkc9
BxcIHJl8+zxHTeU4XiLdmCSq07OyLFm96C/MG0b8UkmdoRuLzwkK0ZU0Ipf8xS6a
i3AU7p0BmzWAhDRq0TArG9M4l9kiBj7bIEfT9cHWLPZavOEXviC9p21ZlLT5wYus
hqNYTsEr65CRoA6AIv7L57G8mfiOJCjsw71H5SW8D9Fh5iLK9F6fENhuQMGI39BT
SvbvW/c/blZ70GrP4X+P1Eti3kmXU3o1kLmkWR6/qjRhui8p3VIOji/ky4zS3MYG
hWb2urXMykJNzGhjmF8jRFr5dJvh6/1RQEBT0LxzgNhV06rIR0tmAGtOJR6B7zbG
LdiINduT5JV6DcdhR4nXlXokkcrBJAvj39uJNzUoKW66HpSZh9qTT9AS2eAXB5nK
TEhaEPfGvErW3FWWiSvJNr4uopAVJeUvN9RC15qzGecF9x/BtsJO0ZLJpp6eV2ZB
GPK2SSBzLCdCTOR+KNGNuerr1VjDjrUjMERJhLjtRaeOtrqFwfIypH8C6nojpX5S
RETzufPXxDT7uuw+pCKd
=PY7T
-----END PGP SIGNATURE-----

--u2qWrZzts+9rBanj--

--===============1707308252857976915==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1707308252857976915==--
