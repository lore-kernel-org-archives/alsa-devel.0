From: Mark Brown <broonie@kernel.org>
Subject: Re: [v4 01/12] ASoC: Intel: mfld-pcm: add FE and BE ops
Date: Wed, 13 Aug 2014 20:35:30 +0100
Message-ID: <20140813193530.GL17528@sirena.org.uk>
References: <1407145563-1303-1-git-send-email-subhransu.s.prusty@intel.com>
 <1407145563-1303-2-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4796380653085041833=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2FC09265579
 for <alsa-devel@alsa-project.org>; Wed, 13 Aug 2014 21:35:43 +0200 (CEST)
In-Reply-To: <1407145563-1303-2-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4796380653085041833==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xCjm2wpdygft75H8"
Content-Disposition: inline


--xCjm2wpdygft75H8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 04, 2014 at 03:15:52PM +0530, Subhransu S. Prusty wrote:
> From: Vinod Koul <vinod.koul@intel.com>
>=20
> Now that we have added code for managing DSP pipelines we need to add the=
 code
> for DSPs FrontEnd and Backend dai.

This would be a lot easier to apply if the changelog were clearer, I
can't tell how we get from having code to manage the pipelines to
needing or wanting this code.  Is the current code broken and this a bug
fix or is this preparing for future changes?  The changelog says that
this is adding ops but the diff is adding DAIs none of which have any
ops defined.

I'm also a bit surprised to see this without anything to add routes
between the front and back ends or updates to the machine drivers for
new DAI names - won't this cause problems for the machine drivers?

--xCjm2wpdygft75H8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT673+AAoJELSic+t+oim9pLwP/2kyvJ0hRmPtqYxlxDtHmUej
2g1TZzqiMiLiVIZjAhwAbzt6xBRKhTtYhc9rOQbYhzrfukX6A0MEVzGTfnmd+21f
VwmW2IEByHAP51h6jO7UNpSUqr/sdbFEwTw7xDwfqiHMNh7Vz8p0cCORoq5/atHZ
5KkBcXlGcDg4cPi53Gc7QEXFhBNFNuWsKrt6PkfWoSfMhEoqMiKqmA7sgKKx22kG
T8tqcDPVGTTIt1GFTybzdphjGXTpKd3sIadZS5bc8SR/rXuH+oFhW/hm+QwMVTKp
m2GGabONZgCeX62LXrZnjt/6SOwnOwlvBD6QA66mwboYJ4Y3kroJRn/qH9zVd4v/
+1T2hzEXjNj57Ugc22of7tC5btSrCzGRTofzibNtGwVUzNw5QhKM/Ck5j21Vj+gS
XIDMtyvpfHg9ndT4qKUuaoTH0qrS66qsfW6iND5PY3XtkPvS7eTrXI5N2ZGorK7y
MX6r41Uot7g320rJlj46s7kykBF+QitxSq/OzMGmpMyIx7KUuiPF4kcmRl/+k0vF
+ntEjPzSBnMXMmsKoBdIMYaqDFOEbBz2F52hO3SiZsVBk022pCjhHK7FFOPxVery
CBQdMazbLuvkiuijmMMxTQ0ROQSCB8+LzFy6v/z/Dv7pV/ZnneHutC5qYMjWnoJZ
0qPQAnE7Zd9tEUCQw1cC
=/Bj6
-----END PGP SIGNATURE-----

--xCjm2wpdygft75H8--

--===============4796380653085041833==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4796380653085041833==--
