From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v0 3/3] ASoC: max9867: Fix volume controls
Date: Mon, 30 Jul 2018 11:57:51 +0100
Message-ID: <20180730105751.GJ5789@sirena.org.uk>
References: <20180728154134.GA9665@lenoch> <20180728154415.GD9665@lenoch>
 <20180730101115.GD5789@sirena.org.uk>
 <20180730104503.GA7186@lenoch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2718743733420761044=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A140026779C
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2018 12:57:52 +0200 (CEST)
In-Reply-To: <20180730104503.GA7186@lenoch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: alsa-devel@alsa-project.org, anish kumar <yesanishhere@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2718743733420761044==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j+MD90OnwjQyWNYt"
Content-Disposition: inline


--j+MD90OnwjQyWNYt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 30, 2018 at 12:45:03PM +0200, Ladislav Michl wrote:
> On Mon, Jul 30, 2018 at 11:11:15AM +0100, Mark Brown wrote:
> > On Sat, Jul 28, 2018 at 05:44:15PM +0200, Ladislav Michl wrote:
> > > Build proper audio paths and fix volume controls to match datasheet.

> > This sounds like it should be split up into separate patches for at
> > least the routing and volume control stuff.  It also needs a bit of a
> > better changelog as I'm not sure what the issues with the volume
> > controls were or what was improper about the old audio paths.

> Oh well, will do. Perhaps driver author wants to step in and describe
> setup driver was tested with. This is not meant as an offense, but
> it does really look like code was copied over from other drivers
> (sometimes without renaming) until it compiled and then submitted.
> As it is I'm unable to play or record anything as power domains
> are not enabled, but there still is a chance I'm doing something
> wrong.

It wouldn't be the first driver that was used mainly for one use case
and not fully tested, people don't always even have the hardware wired
up to cover everything and try to write things blind from the datasheet
for completeness.

> > >  I'm still unsure about control names, please see yet unaswered mail
> > >  here: https://www.spinics.net/lists/alsa-devel/msg80006.html

> > Always CC maintainers on mails - you really shouldn't rely on anyone
> > seeing anything that only goes to the lists, they're quite high volume.

> Well, in this case I decided to sent general question to the list in a
> hope anyone with enough knowledge could answer that... But point taken,
> will Cc maintaniners next time.

Yeah, it's good to send to the list in case someone else chimes in but
the copy to maintainers helps a lot still even for things that are just
discussions.

--j+MD90OnwjQyWNYt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlte7y8ACgkQJNaLcl1U
h9AWngf+IG1fTd1y+cj/qXblgd+ZGnxuSBCKAjH1RUZrxhpM9YFf/30A0yMjx6Q4
3ogoLMRU2B226v3VIkT+Vkz1I4zjW91kPM6TVWG+JFmgQtdu8qREdjqgBzPrsGe0
cpk125lLpwRmFtnqdJHw9lIZa2ih4rPtSZLVSFm+MmbCDjbKec6eIzbfsDx8RPma
SgIoOWGiybLs0GQIo5IDK2ZAuCRKHLte1JZrimtI7iyOUoidpxOm2yW6l+99kDVr
btto+O9VZbJsZ/AJkgJlWwtXZE6E9lkrKFuQwHKkHZcmm9tmRptHkN9os1CQHXcM
Mgh4pHfyuF+DY/kvYo620HoDIzk37w==
=JnBo
-----END PGP SIGNATURE-----

--j+MD90OnwjQyWNYt--

--===============2718743733420761044==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2718743733420761044==--
