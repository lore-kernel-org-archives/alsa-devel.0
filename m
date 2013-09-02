From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 00/14] SPDIF support
Date: Mon, 2 Sep 2013 15:06:32 +0100
Message-ID: <20130902140632.GQ3084@sirena.org.uk>
References: <20130901123433.GR6617@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7666148009791946319=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C51826517F
 for <alsa-devel@alsa-project.org>; Mon,  2 Sep 2013 16:06:43 +0200 (CEST)
In-Reply-To: <20130901123433.GR6617@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Jason Cooper <jason@lakedaemon.net>, Jean-Francois Moine <moinejf@free.fr>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7666148009791946319==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CPn8Wy5ME997YUMW"
Content-Disposition: inline


--CPn8Wy5ME997YUMW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 01, 2013 at 01:34:33PM +0100, Russell King - ARM Linux wrote:
> On Sun, Sep 01, 2013 at 01:19:28PM +0100, Mark Brown wrote:

> > We do appear to have a fairly good success rate with systems working
> > with mainline; I can only think of one driver that didn't make it in and
> > that was one where we had a bit of an issue getting the code to visually
> > resemble Linux code so I don't feel too bad about it.  I am aware of
> > some people who didn't work upstream, we've generally had some useful
> > discussions with them once we've found each other.

> I wonder whether you include my ASoC sa11x0 assabet driver in that,
> which I gave up trying to get into mainline, because it didn't fit
> ASoC with its requirement to have the SSP transmit DMA running in
> order to capture, and didn't use the latest soc-dmaengine stuff.
> That driver remains in my tree, and is continually forward-ported,
> and built in my nightly ARM builds.

To be honest not really, you've only mentioned it by providing links to
the git repository (it's never been posted) and there has been no real
discussion of the issues or other interest in getting the code
integrated.  For the capture DMA requirement you mention I'd expect a
driver local fix should be OK so long as it's well abstracted - it's not
likely to be a common issue. =20

The approach I think I have suggested before is to get playback only
support merged then worry about dealing with the fun stuff needed for
capture support, that still seems like the most obvious way forwards if
there is a desire to get the code merged.

> > While it is correct that I have been saying the final result should use
> > DPCM (since this is what the hardware looks like) you will recall that I
> > did recently suggest either/or as a stepping stone towards a full
> > implementation, allowing systems with only S/PDIF to be supported while
> > the other issues are still being worked on.

> Yes, and when I asked for details how you'd like that done, you
> conveniently decided that you would not reply to that.

Indeed.  This was due to the way you asked:

   http://thread.gmane.org/gmane.linux.ports.arm.kernel/257542/focus=3D1119=
09

which didn't indicate a great deal of interest in pursing this,
suggesting that it wasn't worth the effort going into more detail.
Something more like "that sounds like a useful idea, I've looked but I'm
not quite sure how to implement it" would have done so.

> This is where those who are using mainline kernels with DT on Dove
> platforms (like Jean-Francois and Sebastian) need a working solution to
> this in a form which they can come up with a representative DT solution.
> This is not a one-person effort - there's multiple efforts working on
> this, and it's all inter-linked.

Yes, and this is one of the reasons for suggesting getting either/or
support merged - it will help things like the binding definition
progress (as well as being useful for any users with a S/PDIF only
system).

--CPn8Wy5ME997YUMW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSJJtkAAoJELSic+t+oim9p3AP/1wujcKzDanqY29ylPV12pxf
hpqZ4QDz1wAH1xzdrHyuqFXmDtHYTYb10w5Ta8mclPLNhLlO7ICp6vCwlx9v1Gr3
WAa9my1mvXNfvbNYvsfh3bB59CFKIG3GB0xtPe4hRK0pH7CcP6eyAj+dgJm3EU71
JW5Urd6BsutpO1HCY/GLyBTVKBULctLbM/X4VgUO6g+9by2SX7tiw/8NdYSAA6MO
t8JYpkmBJyn2sDNZ7q8YY3i4Wv73C9nHkxSs/wJIebZz1ym410kQgqWMnfc/PApa
nrIgRG+Apt09t5iOOgjcx8EADshsU7Kyk4j4FZqNSh3SAuicE9PVlQIAh0eTqv3d
eFeFBb24SNsrtXPtFZNIwcmdm83OVJ14+tw+5w4Lj3ZPOePW7ocQRrNcnL3LFpn5
Q47c1HQkeEMH5qvFpsRww1EO9Z0WTbSW51jR2JZTbcjOYH2+QKUe8TrexfMRFVFQ
w7FHWgxynWNfrrtmZsQZSUzOe86FW0efrGLoHyUcXGJhpLrpGbEpB/g6Uu73K3Sx
pUh0e3xyM8+kjSFUgIwfkV5Stxfi3oVBITEZypMfQwZYaYreEPp3FrbZnz1Vebfj
RQVFyVffXC33qmv1EiQyv3E+EUHRpZdJJ1OX9/vsAdowiCqrqbGLOx9orDgSmJtf
3vqGoBfoN3TKNu0dzMdU
=mGG7
-----END PGP SIGNATURE-----

--CPn8Wy5ME997YUMW--

--===============7666148009791946319==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7666148009791946319==--
