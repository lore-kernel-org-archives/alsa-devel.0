From: Mark Brown <broonie@kernel.org>
Subject: Re: aplay lists both Playback and Capture devices
Date: Sat, 1 Jun 2013 23:09:55 +0100
Message-ID: <20130601220955.GX16790@sirena.org.uk>
References: <CAOMZO5Cq8xSj3fGoZEO+K5xxJNfHotC2PiuX62q+p+yw1-i9Ng@mail.gmail.com>
 <51A736C6.2060500@ladisch.de>
 <CAOMZO5C3eDi_wicdJLab5Dg1yqexkJ6Ffhwwft_2XnO5KHPD+Q@mail.gmail.com>
 <CAOMZO5CfQUnRN8h5gSFV8qAu2YYw4B3hZRBfgkW5DzEmAb3-2A@mail.gmail.com>
 <20130601190622.GM16790@sirena.org.uk>
 <CAOMZO5BTv2oqZzwXcWs=K8r+tdzCR8MA+DuopYaBnH+fw5Hsug@mail.gmail.com>
 <20130601210534.GU16790@sirena.org.uk>
 <CAOMZO5Cn6ANtrb675v7A90aRsS1+L7nB3RaN+vp_OJc+FROF9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0793507559903078963=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F827265579
 for <alsa-devel@alsa-project.org>; Sun,  2 Jun 2013 00:10:12 +0200 (CEST)
In-Reply-To: <CAOMZO5Cn6ANtrb675v7A90aRsS1+L7nB3RaN+vp_OJc+FROF9g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Marek =?utf-8?B?VmHFoXV0?= <marex@denx.de>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org


--===============0793507559903078963==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jn/MQTzma+jNUHFC"
Content-Disposition: inline


--jn/MQTzma+jNUHFC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 01, 2013 at 06:36:49PM -0300, Fabio Estevam wrote:
> On Sat, Jun 1, 2013 at 6:05 PM, Mark Brown <broonie@kernel.org> wrote:

> > If it's not got any playback or capture capabilities.

> On mx28evk there are two DAIs connected to a single sgtl5000:

> - One corresponds to the serial audio interface 0 (SAIF0) and it is
> playback only

> - The other corresponds to the serial audio interface 1 (SAIF1) and it
> is capture only.

These are not DAIs, they are DAI links.  The capabilities of the links
should be being worked out by examining

> Should I create and pass device tree bindings like "playback-only" and
> "capture-only", so that we can avoid having both playback and capture
> capabilities for SAIF0 and SAIF1?

No, it's not sensible to require users to set DT properties for basic
features of the harwdare.  If for some reason the interface could be
bidirectional but the board design breaks that for some reason then it
may make sense but otherwise the kernel ought to be able to work this
out based on the fact that one or both ends of the link can only do one
direction.

> Or is there already a mechanism in place that I can use to configure a
> DAI as unidirectional?

How is the kernel currently managing to get properties for playback?

--jn/MQTzma+jNUHFC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRqnEwAAoJELSic+t+oim9JBYP/1cmRo8zElUQ+JZRmG1yxUmf
jnBagLidRdEccaBgaoLfwQf0IgFPG3GwBsVozUtzIrn6NJSiu42hDr5Nn0lXpFCt
0nr4z14mejZOvoUZPaZOfFRVr3yvp0A06WtCf5WnKdMNKCWNUi6ypXf56e40IADL
HKlO/Sm5YRrB6RvjVYp5zQl24T1gYcwGaEZmIek/aGxXWuiUu5UU1tt8o+ZSJ9AB
/eL8gtkHOdFhQjt4OXbfpSNongU6tGf8U2ILMJstEGGFZJ/SGVfBl2xFROyd+8gV
nQSRnz2XcK5wDb3z3QA+3Y8pDJzI5mXqNXm1k7fSUOgFaLrP/uaDFhUda26tEUsL
3G5Ygdor1mwXjlccoBEsyoentnZHnwYnsFHN1mtXsivATC/TS6AFQFpKauAxvy4N
OGzfMMBvGWL/JMNH3RtD9lbkYvko9hTW7NZ1K4xGjxPQ9cuIr3AryIu94Y6NbVpO
w5Y92VY5lJ0PmVqvIHbpa2lyGFty8B9TobNxEYfZDwgoAGqw0fS0FWi1Ef0kPhe/
bCl2aQasHgdEfH9WpKNRUJRyAaoESnDjWN8B1bNIJqc5bNKXGP8RWI9HOEYndoTU
aMzd3CvDW+TTAsul73+gHWFC61P67r4OTgnDnpzI8RaGRH2Gl5XuP3nxUM9mJh/z
m/hlw3hRu8fdPtR/d0jK
=SIV6
-----END PGP SIGNATURE-----

--jn/MQTzma+jNUHFC--

--===============0793507559903078963==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0793507559903078963==--
