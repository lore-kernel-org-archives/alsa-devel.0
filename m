From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: asoc: s3c24xx+uda1380 - some questions
Date: Tue, 27 Jan 2009 22:14:36 +0200
Message-ID: <200901272214.45021.anarsoul@gmail.com>
References: <200901271519.47119.anarsoul@gmail.com>
	<200901271822.32537.anarsoul@gmail.com>
	<20090127200051.GA6424@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5030699690798471349=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f11.google.com (mail-ew0-f11.google.com
	[209.85.219.11]) by alsa0.perex.cz (Postfix) with ESMTP id 4455C243AD
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2009 21:18:24 +0100 (CET)
Received: by ewy4 with SMTP id 4so3949103ewy.8
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2009 12:18:23 -0800 (PST)
In-Reply-To: <20090127200051.GA6424@sirena.org.uk>
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

--===============5030699690798471349==
Content-Type: multipart/signed;
  boundary="nextPart3460444.9xkpurvzjn";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3460444.9xkpurvzjn
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 27 January 2009 22:00:52 Mark Brown wrote:
> On Tue, Jan 27, 2009 at 06:22:25PM +0200, Vasily Khoruzhick wrote:
> > Btw, on rx1950 there're 4 gpio pins involved:
> > GPJ0 controls codec power
> > GPA1 controls amplifier power
> > GPG12 is jack sense pin, it's value depends whether headphone jack is
> > inserted
>
> You might want to have a look at the jack reporting API that was
> recently added, it should save you a bit of code:
>
> 	http://git.kernel.org/?p=linux/kernel/git/broonie/sound-2.6.git;a=commit;h
>=8a2cd6180f8fa00111843c2f4a4f4361995358e0
>
> It'll need a little helper for GPIOs adding to the core but that should
> be reusable.

Ok, thanks for advice

> Hrm.  The completion makes this look more like it could use a full blown
> regulator - it's certainly a pattern that will get reused often enough.

It's commented out, I don't use completions anymore.

> > 	/* configure some gpios */
> > 	s3c2410_gpio_cfgpin(S3C2410_GPD0, S3C2410_GPIO_OUTPUT);
> > 	s3c2410_gpio_cfgpin(S3C2410_GPG12, S3C2410_GPIO_IRQ);
> > 	s3c2410_gpio_cfgpin(S3C2440_GPJ0, S3C2410_GPIO_OUTPUT);
>
> The S3C24xx now supports gpiolib so you should be able to use that - the
> platform specific GPIO API will probably get killed at some point.

Yep, but s3c24xx gpiolib doesn't support all gpio pins, especially port J :)

Regards
Vasily

--nextPart3460444.9xkpurvzjn
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkl/azQACgkQRM6pQpltKE65dwCdGgZWsDjty0xdv/WxR81ve14v
PU8An2xiDwuNB7g3NI+wo5Z3hYOxW0OZ
=HiQ5
-----END PGP SIGNATURE-----

--nextPart3460444.9xkpurvzjn--

--===============5030699690798471349==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5030699690798471349==--
