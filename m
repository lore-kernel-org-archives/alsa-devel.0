From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: asoc: s3c24xx+uda1380 - some questions
Date: Tue, 3 Feb 2009 13:57:12 +0200
Message-ID: <200902031357.12297.anarsoul@gmail.com>
References: <200901271519.47119.anarsoul@gmail.com>
	<200902030146.38863.anarsoul@gmail.com>
	<20090203114136.GA23827@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2319392125581509210=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f11.google.com (mail-ew0-f11.google.com
	[209.85.219.11])
	by alsa0.perex.cz (Postfix) with ESMTP id 907E9103826
	for <alsa-devel@alsa-project.org>; Tue,  3 Feb 2009 12:57:15 +0100 (CET)
Received: by ewy4 with SMTP id 4so2195517ewy.8
	for <alsa-devel@alsa-project.org>; Tue, 03 Feb 2009 03:57:15 -0800 (PST)
In-Reply-To: <20090203114136.GA23827@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, pHilipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

--===============2319392125581509210==
Content-Type: multipart/signed;
  boundary="nextPart1420349.TUiutHCACy";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1420349.TUiutHCACy
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 03 February 2009 13:41:37 Mark Brown wrote:

> > One more question: it seems that my rx1950 clocked in a way that I can't
> > get precise divisor for 44100 and 22050 rates, but uda1380 driver propo=
se
> > them (look UDA1380_RATES define and struct snd_soc_dai uda1380_dai[]. H=
ow
> > to exclude all rates except 16000 and 48000? Should I declare my own
> > snd_soc_dai and copy necessary members from uda1380's one?
>
> Set up additional constraints in your machine driver - see how drivers
> like wm8903 enforce symmetric configurations for playback and record for
> an example.

Cool, thanks :)

> >  	/* FIXME enable DAC_CLK */
> > -	uda1380_write(codec, UDA1380_CLK, clk | R00_DAC_CLK);
> > +	uda1380_write(codec, UDA1380_CLK, clk);
>
> ..are you sure this fix won't break existing users?  Based on your
> explanation above (which should *really* go into the commit) I'd expect
> this to be conditional on something.  It looks like what you really want
> to do here is clean up the FIXMEs :)

Yep, I'm pretty sure. It will restore WSPLL bit if it was set before. It on=
ly=20
changes behavior of driver if SYSCLK was chosen. It seems that FIXMEs can b=
e=20
removed, I can resubmit patch if you want.

Btw, Philipp, what do you think about it?

Regards
Vasily

--nextPart1420349.TUiutHCACy
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBJiDEYRM6pQpltKE4RAmxTAJ9dq0ipLu7QJkc91pUHRpYYV2/nMACg4XAy
Orgo+djbCQXbPKHZ9FUKbwo=
=Xtoy
-----END PGP SIGNATURE-----

--nextPart1420349.TUiutHCACy--

--===============2319392125581509210==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2319392125581509210==--
