From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl: imx-wm8962: Do FLL
 configuration in hw_params() and hw_kree()
Date: Thu, 5 Dec 2013 11:15:08 +0000
Message-ID: <20131205111508.GM29268@sirena.org.uk>
References: <1386176048-6960-1-git-send-email-b42378@freescale.com>
 <20131204190211.GD29268@sirena.org.uk>
 <20131205025630.GG8609@MrMyself>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2983133698215746950=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B2A62654E5
 for <alsa-devel@alsa-project.org>; Thu,  5 Dec 2013 12:15:13 +0100 (CET)
In-Reply-To: <20131205025630.GG8609@MrMyself>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2983133698215746950==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6cCUF33RYdKJBOlz"
Content-Disposition: inline


--6cCUF33RYdKJBOlz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 05, 2013 at 10:56:31AM +0800, Nicolin Chen wrote:

> As far as I can understand, the point that all the outputs needs the device
> to be clocked is undeniably true, but the external MCLK should be sufficient
> to source the SYSCLK of WM8962. Does the bypass mode also need to set FLL
> to get an accurate frequency?

The device is going to need a clock that's in spec to make sure that the
device performs in spec, if the device is clocked from a 32kHz clock
(which is quite a common configuration and one that's supported by the
machine driver since it gets the clock from DT) that's definitely not
going to be the case and I'd not expect it to work at all sensibly.

--6cCUF33RYdKJBOlz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSoGA5AAoJELSic+t+oim9zjQP+gN8oWNFT0Fmj9kZLbOK7YMP
+8ad9boPQPuzeKqjJDtGkMLxFIx7sSO6aUcrGNiZ4wZID225V4I0OTYmp1HmfXrm
dSOkWdhnL4p3pcDgnwUWpWfR/vFzP27cJvWQ5VLjLZ1JeK2yqeqy9VToe06eY2Ek
C2jJdp8omI1hAX41iTJzORC/rfgdDrQeMZ0OSOSZ6psw5jyuBt91ReAZYykKjQUO
4vs1TRi6B68LkvDYdjEqeOL4tVQ8aacsplhpABOAsKUM6HwtNp+p54O8T5jt3VpM
nqYd8geXLYcuujzRaM5wdVSFIZQs4XbK/IV2lGpaLnQqRMVb6Lto+jmQmUMdqeeM
fvXPy90rwE4CXNaX82wwaW5BZQn0goAeCWXai/TUpoRs0IC0FEPsFNHWCQyIVRGC
6yvIl0PUX3YJLh0tRUVktvVDFLan4opXJpDuludulrqaPiugw/gTuQJw9nge0em7
rLtZAUaLFFqUenbIDJxn0yM8Tbcjnhg/WLhcZK2r+iM8HkX0fIJ5XENOJ3XFWzfv
03xt5DW/8YOHhBvYiRJnEN6ggF2P7ud7iBZBxqQgs80Iq9uH5Am52kqubeDoipni
brSjayN5OGYbjT43RgeS/releuX7IqzvxlN1NUAkSPNeRhuoB1ZapQaTrdlGslFv
nH0tFW2t3cmHAMPlU8Pc
=jMX4
-----END PGP SIGNATURE-----

--6cCUF33RYdKJBOlz--

--===============2983133698215746950==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2983133698215746950==--
