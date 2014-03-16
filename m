From: Mark Brown <broonie@kernel.org>
Subject: Re: compress: adding support for hardware dependent
 params
Date: Sun, 16 Mar 2014 20:00:16 +0000
Message-ID: <20140316200016.GQ366@sirena.org.uk>
References: <CAES_P+_Wztn3udEbc5vcUgAmFKuNLXh6MwHpcOSzLkah0c0Oxg@mail.gmail.com>
 <77e1ff531b0670bae0c47d32a76bb6f4.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2343347209799336926=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 94AB72615B9
 for <alsa-devel@alsa-project.org>; Sun, 16 Mar 2014 21:00:24 +0100 (CET)
In-Reply-To: <77e1ff531b0670bae0c47d32a76bb6f4.squirrel@www.codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Banajit Goswami <bgoswami@codeaurora.org>
Cc: noman pouigt <variksla@gmail.com>, vinod.koul@linux.intel.com, alsa-devel@alsa-project.org, plai@codeaurora.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============2343347209799336926==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhNoKa8EeSU2TVlt"
Content-Disposition: inline


--AhNoKa8EeSU2TVlt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 16, 2014 at 05:55:37AM -0000, Banajit Goswami wrote:

> audio. The parameters we are looking to set is not specific to gapless
> audio, but rather a few hardware/board specific parameters (for passing
> to our driver)

Why not just use ALSA controls for this - that's the normal way of doing
things like this, if the parameters aren't part of the stream data it's
not obvious to me why they're being set on the stream.  I'm also a bit
concerned about the idea that applications would need to support another
custom API for passing opaque blobs to drivers, we already have bytes
controls.  Can you give any examples of the sort of thing that would be
configured here?

--AhNoKa8EeSU2TVlt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTJgLNAAoJELSic+t+oim9GP0P/A9wPYrrAUjLob3rj/p1rJ+3
fZl33nGbL4svtwK1XSpkYhFTVOFkVKDjoXja+h5utlFZHfwbb8sqc3GdZqbLlDW9
jRNKm8lBU8U5PSCJDNl3cOQXgN92Yc2VxVjAsZBr3Fz6v3G+SiRtxfwIS7ZnP/X3
x0fFUFOu20bkgLGLfKalZBNjGaDxHCQzDQ573BN7CR1uZalEC7zQ1UIsDTUaPe9K
whhsFbW6ggfheGOMpMqDWe8BgTrmw34plK87Rsp/S7ufZiYmu9lipTXJfySLFlBD
ITWXR1K9qCUV5lT3UJpBd/PsO2spFNC45Nku2cOgjZwwASCYW7syUdWold7ZD9rr
VbffX7vD8C4r4RkQhoTGswyvBmpjldVtUhoNuoWhgV41g3X2cfkvv6tCY4EzUfm+
LYdBC2MZH6Cpkjf2JkIOBK4B5j9DqHpLXoX4AFtheGnXqO3Ja7j4v1LCY9D9YVRP
maDTK2ffWtKmecWLGFXXt0AjV2IGZEdBZZ+RDxa0mDNs3nHZtETknGx59yP2rPec
XJ2cgTup/mZpzoLNV4xLi+MrCRzunTDze4VEh+Z0+WSW6e+P7mbF56+AdWeKdgms
W+S1U4hpRn8HygzeQYjGjy71a8/rOgT9oqP8X7zw5jU5C8FdLEQIqaHk85ji3pcn
Vj3G2IsdF0GEYJQPExTC
=nLtu
-----END PGP SIGNATURE-----

--AhNoKa8EeSU2TVlt--

--===============2343347209799336926==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2343347209799336926==--
