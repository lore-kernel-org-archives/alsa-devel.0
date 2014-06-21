From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 05/11] ASoC: Add a set_bias_level()
 callback to the DAPM context struct
Date: Sat, 21 Jun 2014 21:14:37 +0100
Message-ID: <20140621201437.GS5099@sirena.org.uk>
References: <1402935191-18398-1-git-send-email-lars@metafoo.de>
 <1402935191-18398-6-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2493848666643284722=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9FD2A2617A4
 for <alsa-devel@alsa-project.org>; Sat, 21 Jun 2014 22:15:02 +0200 (CEST)
In-Reply-To: <1402935191-18398-6-git-send-email-lars@metafoo.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2493848666643284722==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9LnT2hzikWZ9nuHF"
Content-Disposition: inline


--9LnT2hzikWZ9nuHF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 16, 2014 at 06:13:05PM +0200, Lars-Peter Clausen wrote:

> CODEC specific set_bias_level callback(). Not looking directly at the CODEC
> driver struct will allow non CODEC DAPM contexts to implement a set_bias_level()
> callback.

It will indeed, but do we want them to?  set_bias_level() is partly
legacy and partly there for the benefit of analogue devices which can
have more complex needs than digital ones which can mostly just use
runtime PM.  On the other hand there's a consistency thing going on
here, but that applies both within ASoC and throughout the kernel.

--9LnT2hzikWZ9nuHF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTpeeqAAoJELSic+t+oim9nKMP/Rvxp0d5uf3tF2T2CGOTgyKc
x3Xu3qswjV5/3qcaz5zpFfxTL++z/wImkzUkTEC8YlgRZCDG5wKoH7iRiNRoDJgz
DYYKQv13x/TU+aPIk7yDV8M5mBKrzxyOWvAovBMEbBE73PVWMPURoEdU7yH3VKsx
R+UoY61JDfLxdS+xbApuT/rzXgzqIyOA5pkMWmsJ0fUOSipPCs9ujKBYyqgHLtR6
uzCGE6gODiD5i4+hWjY3Ti128zz5cknKuWhJctKRd9o21rfS+Pcxje0yjRZEdxcB
VVphg8RYGIawNSlVnnVURWOGmUJNuinrhsYHSwsArEFt84Ybldmpca8EIxdJyPqZ
XGPqYl4yVRN5E566bpCIfP9W67QfI56JM4BZWawrZO7kSSN5PSgVN3CGNPvjHpS6
YsOo6Q3HPB0DRMKwkn+8RMhVAT/G2McjhZSB6Qod0U9k1VnQUiGaGOGAsucBvKLv
ILAbyoos0CrUYNzmlkddQfJFuw3EoufczNNtQIbx7+l0X6gmnnOAFkyfaMBBFOKB
Qn0tEoiJhSGub8yS8Zb/Vg6n2DaCBiK1QM9LWiC/Ww/1m8dxYbUrcmuri8Q2No7Q
DXEqCnBrEghLe1yBMNB/mpR8KKrKY7uaqXinTTOLwEp9YZEhGOHtHITJqsBWcylf
hReEvnZ9IaxVBHgHC0TJ
=MNtx
-----END PGP SIGNATURE-----

--9LnT2hzikWZ9nuHF--

--===============2493848666643284722==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2493848666643284722==--
