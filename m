From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] ASoC: tlv320dac33: Change RT wq to singlethread wq
Date: Fri, 27 Nov 2009 17:50:46 +1100
Message-ID: <20091127175046.ee37c8f6.sfr@canb.auug.org.au>
References: <1259236511-25805-1-git-send-email-peter.ujfalusi@nokia.com>
	<20091126154746.GA10674@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__27_Nov_2009_17_50_46_+1100_JOagmm34_4TSLs4I"
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20091126154746.GA10674@rakim.wolfsonmicro.main>
Sender: linux-next-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>, alsa-devel@alsa-project.org, tj@kernel.org, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

--Signature=_Fri__27_Nov_2009_17_50_46_+1100_JOagmm34_4TSLs4I
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 26 Nov 2009 15:47:46 +0000 Mark Brown <broonie@opensource.wolfsonmi=
cro.com> wrote:
>
> On Thu, Nov 26, 2009 at 01:55:11PM +0200, Peter Ujfalusi wrote:
> > RT workqueue is going away in the near future, replace it with
> > singlethread wq for now, which is still supported.
> >=20
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
>=20
> Applied, thanks.

I also put this patch in linux-next (after the sound tree merge) for
today.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__27_Nov_2009_17_50_46_+1100_JOagmm34_4TSLs4I
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAksPdsYACgkQjjKRsyhoI8xSMwCeP0VrFTOt1+nhBg1atgarZD/S
AuEAn0yWIoDegzPTRqjczwcp5EqHnV0a
=u6ZS
-----END PGP SIGNATURE-----

--Signature=_Fri__27_Nov_2009_17_50_46_+1100_JOagmm34_4TSLs4I--
