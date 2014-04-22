From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: rt5640: Add minimal support for
	RT5642
Date: Tue, 22 Apr 2014 18:12:45 +0100
Message-ID: <20140422171245.GA12304@sirena.org.uk>
References: <1397701446-11977-1-git-send-email-bardliao@realtek.com>
 <20140422115347.GR12304@sirena.org.uk>
 <CAD+35SMF1jtB_W1uY-8fhfbpd7-2yXp08Bz_vr3r5+DMDGiDWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4271127841232538616=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D29C32610A7
 for <alsa-devel@alsa-project.org>; Tue, 22 Apr 2014 19:13:02 +0200 (CEST)
In-Reply-To: <CAD+35SMF1jtB_W1uY-8fhfbpd7-2yXp08Bz_vr3r5+DMDGiDWA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder <oder_chiou@realtek.com>
Cc: Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, jarkko.nikula@linux.intel.com, Liam Girdwood <lgirdwood@gmail.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============4271127841232538616==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GCMzOpg3B+D8rDvC"
Content-Disposition: inline


--GCMzOpg3B+D8rDvC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 22, 2014 at 10:14:47PM +0800, Oder wrote:

> > Applied, thanks.  Now I look again and remember that it exists I see
> > there's no update to the DT portions of the code - please submit a
> > followup patch adding the device to the DT bindings and to the OF match
> > table.  rt5639 is also missing there.

> We've sent the patch of binding document to
> "/Documentation/devicetree/bindings/sound/rt5640.txt" for rt5639.
> If it is not satisfied, please kindly tell us what we need to do,
> thank you very much.

It's not in the match table in the driver as well, just the binding
document isn't enough.

--GCMzOpg3B+D8rDvC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTVqMKAAoJELSic+t+oim9sDcP/3YFLfd+5KUjbEwEm/oYRAy9
trF5pIY++GaGBVkCYhHrnGMBrssPNBKEST/HNhGOyrpgOLq0j/1Bz228AAZkzY6K
imXkgW8CQe3BCo2u3GCSu9PgGTHP0NP7D7rk3EOUEqWliTWd6yE945tYLIJHzzFl
YeNPytP1u9EaNhREFEXzm6WWvKlgxQDSkgmhT5n3GoHLt+ScUvMp8e71Kv8063SQ
7XeVnsLx2BYyJCsuOk0fkOlhUtrfbVfwEhUXOT+6EJAj3Jdof9Ff6W5Z7Ewllb5G
TpKiW8u6aR4J6Vgz8NXItafUKnEwaRKNxHf/mk1Xa7K5D5TlarYC7M/cUbRH43qw
LDQE9CO20zUBpqF0NNPu74ZvS/LHEZomzuKkqcSzFbNS1KpT8U+DaAJUEB2ejzeC
vSoH4yZE/t3g5TaA2ic5RPPej5XObPqMeYEZdoBtsWbSSvPQExl1N2L9PKf6nvy6
eBuxbhpYlE8tU24p5AN0VIi8QvuGSvcnRVR4FiwycHOe1obvLrVROOnegmVMzbY7
FbxiRicl/2KOeAH0d64aSEda3idXFJr1PXfd3YvT5XfUs4iZ64pNEIt37axpzMgG
3VOWnHtvp5Isn+gf5iJCfCEH0hXXNV37EpoXqw0DG0orBMjPaknYILOE4G91lB6X
89uzCtbF5QBrjBKkybuE
=hJw1
-----END PGP SIGNATURE-----

--GCMzOpg3B+D8rDvC--

--===============4271127841232538616==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4271127841232538616==--
