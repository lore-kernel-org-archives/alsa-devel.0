From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/7] ASoC: rt5677: clean up gpiolib callbacks
Date: Tue, 2 Jun 2015 21:50:17 +0100
Message-ID: <20150602205017.GY14071@sirena.org.uk>
References: <1433200158-6890-2-git-send-email-vz@mleia.com>
 <20150602193818.GG14071@sirena.org.uk>
 <556E1467.9030406@mleia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0q9y5TNQq+E02vJE"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <556E1467.9030406@mleia.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <acourbot@nvidia.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-gpio@vger.kernel.org, alsa-devel@alsa-project.org, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
List-Id: alsa-devel@alsa-project.org


--0q9y5TNQq+E02vJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 02, 2015 at 11:39:03PM +0300, Vladimir Zapolskiy wrote:
> On 02.06.2015 22:38, Mark Brown wrote:
> > On Tue, Jun 02, 2015 at 02:09:13AM +0300, Vladimir Zapolskiy wrote:

> >> +		if (value)
> >> +			val = RT5677_GPIO_OUT_HI(offset);

> > It seems like a greater variation in variable names might be called for
> > here.

> thank you for review, you mean "val" vs. "value" I guess. May be you
> have a better register value naming in mind?

I mean val vs value, yes.

> >>  		regmap_update_bits(rt5677->regmap, RT5677_GPIO_CTRL2,
> >> -			0x1 << (offset * 3 + 1), !!value << (offset * 3 + 1));
> >> +				   RT5677_GPIO_OUT_MASK(offset), val);

> > Besides, isn't the minimal change here just to remove the !! (or do
> > nothing)?

> this particular change mainly addresses "clean up gpiolib callbacks"
> target as it is stated in subject/commit message. Removing of "!!" might
> be unsafe, because the input value is not necessary 0 or 1 at the moment.

Sure, but if we use that we could also just not make any change to the
code except for changing the type of the argument when that's needed.

> >  C defines a mapping between boolean and integer values.

> As for today it is correct. In the kernel right now there is a movement
> of replacing for instance explicit integer constants to false/true, when
> they are used with variables of bool type, e.g. see
> scripts/coccinelle/misc/bool{init,return}.cocci.

Hrm, right.  I suppose it's more useful than checkpatch cleanups.  In
any case I'm not sure it's relevant here where we're reading a value?

> In my opinion changing GPIO level argument from int to bool should be
> done, when all confusing cases like "!!false << (offset * 3 + 1)" above
> (if just type of "value" is modified) are cleaned up in the code firstly.

I have to say I'm not sure I'm finding this is actually adding to the
clarity - it was partly a cheap trick for compiler implementation but
the int as boolean thing C has does also make this sort of code for
mapping values onto bitfields more direct which is handy for low level
systems programming like drivers.

--0q9y5TNQq+E02vJE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVbhcIAAoJECTWi3JdVIfQUSAH/2MPdH+FS3sapbBwL2mXCg4D
yGKvz6a2aISY4Cec+SFrfTg59QOgbAK1AkFDU/m9B1ePt1e9swf2Sog0lH7/zzvd
//hgoc/7lB2mxJWgzM/ptWC3Pp3WQWt+3sa2yGLY6dj44x/x0QykI7xMNcqtLufD
8NLCAuuZWucf0Oh1m95W//j2hOUF+SBCCajE8miiq5RZ+Ku7LvPjcd3qba2GV4rH
K4a5ncAC5bSVMa4k2FwkijS5GtyCNZemTZSee7Nl/od97xp/eG6ZL8a/WZEJ5Pql
jCpQYDx456GvWGLi43FLfOCmS2THqRsdwM1yQqGMAfyV26sYdosLkZoRchaSl+4=
=isxT
-----END PGP SIGNATURE-----

--0q9y5TNQq+E02vJE--
