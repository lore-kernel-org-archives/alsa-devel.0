From: Mark Brown <broonie@kernel.org>
Subject: Re: Broken outmixer_event function in
	wm8400/wm8990/wm8991
Date: Mon, 12 May 2014 21:47:34 +0100
Message-ID: <20140512204734.GO12304@sirena.org.uk>
References: <5370840E.10009@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2975346488130669878=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 30C832650FE
 for <alsa-devel@alsa-project.org>; Mon, 12 May 2014 22:47:53 +0200 (CEST)
In-Reply-To: <5370840E.10009@metafoo.de>
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
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============2975346488130669878==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CcDY5IQM3C8zBYt/"
Content-Disposition: inline


--CcDY5IQM3C8zBYt/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 12, 2014 at 10:19:26AM +0200, Lars-Peter Clausen wrote:

> I was looking at the drivers that were using the SND_SOC_DAPM_PRE_REG event
> and I noticed that the outmixer_event function for the wm8400, wm8990 and
> wm8991 is broken. They do a switch statement to determine which kcontrol
> cause the event in the form of 'switch(kcontrol->private_value) { case (REG
> | (SHIFT << 8)): ...'. Long long time ago we used to store the register and
> the shift in the same integer which was stored in private_value. But this
> was changed in commit 4eaa9819 ("ALSA: ASoC: Convert bitfields in ASoC into
> full int width"). This was long before the wm8400 and wm8991 drivers were
> merged and just a month after the wm8990 driver was merged. So these
> functions have been dead code pretty much for as long as they existed. Do
> you want to fix this up? If not I'm going to send a patch that removes the
> functions. If you want to fix this up, this should be re-implemented as a
> custom put handler for the kcontrols rather than a event callback, which
> checks whether the change is valid before doing any DAPM changes. The event
> callback runs in the middle of the DAPM sequence, so half of the changes
> will already have been applied before the check is made whether the change
> should be done or not.

Paragraphs are good for legibility...  it would be better to fix this up
since it's a useful example for people to have, I have seen this sort of
"A but not B" thing in other devices.  Looking briefly at the WM8400
datasheet custom put controls would be better though looking at the code
I'm not sure that the intention with the original code (which predates
me) wasn't to enforce a limitation based on the outputs being enabled.

--CcDY5IQM3C8zBYt/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTcTNjAAoJELSic+t+oim9tK8QAIapOUXNfqVravPT6Z0zSxm9
sS0K7wlJcM/lxxjBR/CDgYX9ANMiVhwwVgsOUkLf7LUwiFKT0E7Fpz+q4BIjYM3A
tPjSBD/sEqtiGug55WIfAhS8btqZEZeakFWclEmk/6+iOuD1yR70nGjTufwgGz8r
ueC4UcMVe1Yx98+j3FeE0D8zS1mDKiBQS5phrf5hl5cMLE0QX4eSo7PsE5c8RaVF
m2qkaZYPWPbCZn152upFpgMG6htkCs9hogDzfZ/HzrMvBegI08RSaD2jM/5QvVwY
Q4RUJ/v2EazCiWhKjThG+n0/oXTWx2Wg5gzNqw+k6C67zuSKqOGsjj+UfOPsErcS
xrTRayWdFNdtftc1/ptv1lxdEtOjx6QYEShgwmCvf5mglGu3uRy9vvEotrd1+YDY
D6+5Y6auUSDk0cOHbgoCi7xyHfImVUXKngWX3vxSv6i9Lwg7EZnHtf6pc0CGBNZ4
a/yb1UF5IwcQceKsmGosUxMR1ah3zKnP0p6q+Q1wMtkRuh8gilE+Q27ml7WjE/0q
jHPsSccUhJ4jza80B16/Z9oOHrSrFWYHbCk4FR8TbsGrR9kiKdDoh9AvLK7WTs8B
bG6L2a2BpwHpCBYy6DQCJdXjAXW6zaM4g6AV6a7Abau2TZyyYwyYa9CL+00XRywX
/J2mSt1F3X6bz3culj9y
=UXeY
-----END PGP SIGNATURE-----

--CcDY5IQM3C8zBYt/--

--===============2975346488130669878==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2975346488130669878==--
