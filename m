From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: asoc: s3c24xx+uda1380 - some questions
Date: Tue, 27 Jan 2009 17:49:22 +0200
Message-ID: <200901271749.38788.anarsoul@gmail.com>
References: <200901271519.47119.anarsoul@gmail.com>
	<200901271720.03880.anarsoul@gmail.com>
	<20090127152556.GF11870@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6494364754652374024=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f11.google.com (mail-ew0-f11.google.com
	[209.85.219.11])
	by alsa0.perex.cz (Postfix) with ESMTP id AF5F31037F0
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2009 16:53:33 +0100 (CET)
Received: by ewy4 with SMTP id 4so3725619ewy.8
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2009 07:53:33 -0800 (PST)
In-Reply-To: <20090127152556.GF11870@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

--===============6494364754652374024==
Content-Type: multipart/signed;
  boundary="nextPart1516035.CjFGcyIP3U";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1516035.CjFGcyIP3U
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 27 January 2009 17:25:57 Mark Brown wrote:
> On Tue, Jan 27, 2009 at 05:19:53PM +0200, Vasily Khoruzhick wrote:
> > Uh-oh, I didn't thought that it will be so complicated to decide when
> > turn one gpio line to 0 or 1 :) Btw, I'm thinking about using own write-
> > and read- wrappers for uda1380, in this way I can check on each
> > read/write whether codec power is enabled.
>
> Are you really cutting all power to the codec or just the analogue
> supplies?  Normally the digital is powered off a separate supply shared
> with other bits of the system.

Yep, I'm really cutting all power to the codec. AFAIR it saves ~10-15mA of=
=20
current consumption.

Regards
Vasily

--nextPart1516035.CjFGcyIP3U
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBJfy0SRM6pQpltKE4RAuEgAJ4ufIRsXMo6AVzQvJdPQ2KIqOErhwCdE7Ph
zLLzQgyl3w0YDtTXl71vOPw=
=a3N7
-----END PGP SIGNATURE-----

--nextPart1516035.CjFGcyIP3U--

--===============6494364754652374024==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6494364754652374024==--
