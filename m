From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Add max98925 codec driver
Date: Tue, 24 Feb 2015 23:50:12 +0900
Message-ID: <20150224145012.GO6236@finisterre.sirena.org.uk>
References: <1423884301-13292-1-git-send-email-yesanishhere@gmail.com>
 <20150214051407.GH9110@finisterre.sirena.org.uk>
 <CABCoZhCHXd3ybD4_wY3CnSxTTQBBRELRtjG+2os8_Q9A24CT3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3043434150957217189=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 342032604BB
 for <alsa-devel@alsa-project.org>; Tue, 24 Feb 2015 15:51:17 +0100 (CET)
In-Reply-To: <CABCoZhCHXd3ybD4_wY3CnSxTTQBBRELRtjG+2os8_Q9A24CT3A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: anish <yesanishhere@gmail.com>
Cc: "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, Maxwell McKinnon <Maxwell.McKinnon@maximintegrated.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Nitin Mittal <nitin.mittal@maximintegrated.com>
List-Id: alsa-devel@alsa-project.org


--===============3043434150957217189==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+cdUESGy8E0PQTBL"
Content-Disposition: inline


--+cdUESGy8E0PQTBL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 13, 2015 at 10:35:42PM -0800, anish wrote:
> On Fri, Feb 13, 2015 at 9:14 PM, Mark Brown <broonie@kernel.org> wrote:

> >> +     switch (reg) {
> >> +     case MAX98925_R000_VBAT_DATA:

> > Putting the register numbers in the define for the register name seems
> > to defeat some of the point of the defines...

> Looked at the other driver and everyone is using the same way.
> Sorry but didn't get your point.

Nobody else has the register numbers as part of the names defined for
the registers which was what my point was.

> >> +     max98925_regmap_update_bits_stereo(max98925,
> >> +                     MAX98925_R01B_DAI_CLK_MODE2,
> >> +                     M98925_DAI_BSEL_MASK, M98925_DAI_BSEL_64);

> > This looks to be a mix of setting slave mode and setting some clocking
> > configuration that ought to be configurable - for example I'd expect
> > clock sources to be configured via set_sysclk().

> Slave mode also should be configured in set_sysclk? I will move
> bclk and lrclk setting to set_sysclk.

Not slave mode but the other bits.

> >> +             max98925_regmap_update_bits_stereo(max98925,
> >> +                     MAX98925_R036_BLOCK_ENABLE,
> >> +                     M98925_BST_EN_MASK |
> >> +                     M98925_ADC_IMON_EN_MASK | M98925_ADC_VMON_EN_MASK,
> >> +                     M98925_BST_EN_MASK |
> >> +                     M98925_ADC_IMON_EN_MASK | M98925_ADC_VMON_EN_MASK);
> >> +
> >> +             max98925_regmap_write_stereo(max98925,
> >> +                     MAX98925_R038_GLOBAL_ENABLE, M98925_EN_MASK);
> >> +     }
> >
> > This doesn't look like it's muting, it looks like it's doing a whole
> > bunch of other things.  The mute operation should mute and only mute
> > (and then only if the device usefully supports it).

> Coming to think of it, you are right. I am wondering if this(turning on voltage)
> and current along with global audio enable bit) should
> be dapm widget as it should always be turned on whenever
> playback starts. I think i will make it a callback of
> SND_SOC_DAPM_DAC_E

If it's really a global enable used in all cases set_bias_level() is
probably the place to do it - it's for chip wide stuff.  If there are
some cases where it's not needed then DAPM widgets (normally a supply
widget) are the best place.

--+cdUESGy8E0PQTBL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU7I+kAAoJECTWi3JdVIfQ6ksH/0gbZgCvQzcxbcq4jDJBAB6S
LOXkc5vhVVfwSqGFbKGGYHqmybtpllLAJOAufuqmMMNn58edh/ipE+ojTGnP4XFj
S2bJtJ2Z/7cwMsWmfrUN/eoJ9ojv8COzWa0TRvnFw3vwm2UArHZs9vsuj1k3ht+y
GqvwVoGCcbNC2Oxe8qvvrsvKDRNf9ESBhYwNTZcHcjvg7fKu7Sm/MS3aaHTWH2qm
Izz3JrU7OMtV/L+98oIalUME/9TplYnoLER8cCNnqkOQTuOYDXvnpyzhGF/6yZKD
YGviJuIAozRZaxhLwnvXFJj21EXmAmmndYyKz903O4YwdOyf+euxt2Rnu8r2DTk=
=i3qy
-----END PGP SIGNATURE-----

--+cdUESGy8E0PQTBL--

--===============3043434150957217189==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3043434150957217189==--
