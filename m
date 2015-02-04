From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/2] ASoC: rsnd: tidyup .remove method
Date: Wed, 4 Feb 2015 20:55:03 +0000
Message-ID: <20150204205503.GM21293@sirena.org.uk>
References: <87h9v4gbhg.wl%kuninori.morimoto.gx@renesas.com>
 <87iofj7qhc.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2931211159701877194=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 632E8260591
 for <alsa-devel@alsa-project.org>; Wed,  4 Feb 2015 21:55:10 +0100 (CET)
In-Reply-To: <87iofj7qhc.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2931211159701877194==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WoJAn93zv47S/Oyu"
Content-Disposition: inline


--WoJAn93zv47S/Oyu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 03, 2015 at 01:05:52AM +0000, Kuninori Morimoto wrote:
> > BTW, we found ALSA SoC bind/unbind issue on latest upstream kernel.
> > ALSA SoC is using like this.

> > 	[CPU] - [CARD] - [CODEC]

> > If we unbind CPU here, it still has CARD infomation.
> > And, kernel doesn't call initialize function when re-bind,
> > and it will panic when playback

> Is this open bug ?
> Or, Renesas sound only ?
> fsi/rsnd both have this issue.

I'm not aware of anything here - when we rebuild the card we should be
reinitializing everything.  It's possible this is just broken for
everyone though, most people don't unload devices and where they do they
tend to remove the card first.

--WoJAn93zv47S/Oyu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU0ocmAAoJECTWi3JdVIfQRVIH/1uaPpNPzieb2YAnLsYGTE0R
GsseJEPLTpGAkZ1K2P3xolcQ1oIdLwOezuW3VUJrxs3OBhztzqVZxDaZ0polS1Ts
L3vdWCVpe1hbAZOGlymaMMB81rwNXRtXs72AI8fzxEtmyqjbNzYC+NVPEx8vaAly
8uaiCVMDU1DnOkkGknpx3JPnUYWBx+LMVUl0vUi1BNFqZcbUG597iEbQurMFXiy2
ptwqyA/BaxJV0KlfAxeDN4xKyvzzjzp+D0PP46BHfs/1gYGG3ZlIb7tf5k8eHitE
qUqCE2ix42TaIPyJEOaMfqPjihk0e/2jPpkT1Dn3C+t8uujp6sRa7iSbo2QFzn4=
=l8hC
-----END PGP SIGNATURE-----

--WoJAn93zv47S/Oyu--

--===============2931211159701877194==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2931211159701877194==--
