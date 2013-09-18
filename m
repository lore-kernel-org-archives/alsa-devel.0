From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5640: ifdef for ACPI module table
Date: Wed, 18 Sep 2013 16:38:42 +0100
Message-ID: <20130918153842.GA21013@sirena.org.uk>
References: <1379484624-11029-1-git-send-email-olof@lixom.net>
 <20130918094158.GL21013@sirena.org.uk>
 <CAOesGMj52_xcKS4q54i_gw_T2xWt=c6rwBtP9Ds2LbytjRuNKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8108970583300498608=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 681E726158D
 for <alsa-devel@alsa-project.org>; Wed, 18 Sep 2013 17:38:51 +0200 (CEST)
In-Reply-To: <CAOesGMj52_xcKS4q54i_gw_T2xWt=c6rwBtP9Ds2LbytjRuNKQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Olof Johansson <olof@lixom.net>
Cc: liam.r.girdwood@linux.intel.com, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============8108970583300498608==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PgFjNgMZ2k7V6t4+"
Content-Disposition: inline


--PgFjNgMZ2k7V6t4+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 18, 2013 at 08:13:14AM -0700, Olof Johansson wrote:
> On Wed, Sep 18, 2013 at 2:41 AM, Mark Brown <broonie@kernel.org> wrote:
> > On Tue, Sep 17, 2013 at 11:10:24PM -0700, Olof Johansson wrote:

> > Please send things to the advertised maintainer addresses.

> I sent it to the person signing off on the patch that this fixes up,
> you should probably use your maintainer address for that.

In that case you should've also CCed the maintainer address, you should
always CC maintainers on patches.

> > Shouldn't the fix for this be to do the same as we're doing for the OF
> > tables and have an acpi_match_ptr()?  It seems like we're doing the same
> > thing so we should be handling it in a similar fashion.

> There's already ACPI_PTR(), which is exactly why this warning shows
> up. of_match_ptr() and ACPI_PTR() will evaluate to NULL if
> CONFIG_OF/ACPI aren't set, which is the case here -- which in turn is
> why there's a warning that the match table is defined but never used.

> So, the solution is either to not define the table, i.e. ifdef, or to
> not use the ACPI_PTR() macro. It makes sense to not advertise the
> driver as capable of probing on ACPI if ACPI is not enabled in the
> kernel config, which in turn means ifdef.

> Unless I'm missing something here, of course. :)

We're supposed to be able to do this sort of stuff without the ifdef
noise and have the compiler eliminate unreferenced static symbols
automatically, though I can't see how of_match_ptr() actually does this
now.  I don't immedately seem to be able to persuade Kconfig to turn
off OF to verify though we do have some examples which nobody has
complained about...

--PgFjNgMZ2k7V6t4+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSOcj/AAoJELSic+t+oim9HyoP/0YIkunemtH6X2YAMRU/uMl1
N0zX0ag2kESalAbB0k/Vq6jUvsofM8ALfUMofV/cQ8y60twWj6lt/HgVtz8Vhh4b
748DR1I4KJbtN25GhV9lS6QKu7hhDv4KWcot3KcTtlhc2md7q0YWt1K/T9L7niPI
nyyBBSDRCDpGuBWl5ViJ6+cQ7uGdfvjoi0RaIKotXWA3Upo2AAv2YSMhtLnLUuOS
d1SkHxGMrwVAkZU3sMCAwDq4hFK14dfjG0bmNqbB47C1ogeTLi5vLpKpcvAf0Nmo
nj2blQCpODeWgMig7MmwckzF8HEktvYcYzz/r57wQZ65AAdvkxE9q2QZmSQhgrg5
HAxVikPuKyG1wwEd428riTZcquZHVI4LzJ7rihiUpHijmUoKLPgJgRQ8FJ38fgi9
vhGeLLHVb4vFddopu8vhShgIHTztfbTS+VqddbKI3etqlPuc9wg04btk5a28HuHo
VPYqmnbj/kOdS/J7r5zrVSJuWdoaKCMOfIdXXiBZhg0LQ4b8+7+O6XrKNkc5bnxI
WJ/davvSdbdfHM9tIQ1/9IaDf1gpgvhV6vu2qQrd0vt4kP/dByjMKZSjr9CZToan
OoiZBbJyVVYEUEbjR8xaWHuboF5eqm0096bBeYjIsYq75yiHakD0mEcXO+zZKhsZ
gluS88udwgqSKb57g1io
=1Qny
-----END PGP SIGNATURE-----

--PgFjNgMZ2k7V6t4+--

--===============8108970583300498608==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8108970583300498608==--
