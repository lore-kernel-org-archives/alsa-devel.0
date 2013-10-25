From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC] ASoC: core: Allow DAI links to be specified
 by using ACPI names
Date: Fri, 25 Oct 2013 11:06:18 +0100
Message-ID: <20131025100618.GR18506@sirena.org.uk>
References: <1380803636-24079-1-git-send-email-jarkko.nikula@linux.intel.com>
 <20131024095118.GH31415@sirena.org.uk>
 <526A1568.9010100@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2167012130669932339=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id A8F09265517
 for <alsa-devel@alsa-project.org>; Fri, 25 Oct 2013 12:06:22 +0200 (CEST)
In-Reply-To: <526A1568.9010100@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, alsa-devel@alsa-project.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2167012130669932339==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1GSL5ZULXUIqbbH1"
Content-Disposition: inline


--1GSL5ZULXUIqbbH1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 25, 2013 at 09:53:28AM +0300, Jarkko Nikula wrote:
> On 10/24/2013 12:51 PM, Mark Brown wrote:

> >Did anything happen with the idea of making dev_name() use the ACPI
> >name?

> Well, looks like I manage to put it aside. I'll spin it again as
> next merge window starts to be too near now.

OK, I was asking because I was thinking of applying the patch for now;
it's not that it's a bad idea it just seems like it's something that
might might make sense solved at that level.  Equally well I don't know
if these systems will work with v3.13 anyway so perhaps it's not so
urgent.

--1GSL5ZULXUIqbbH1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSakKWAAoJELSic+t+oim9Tn0QAI0129o24pRL4QV4hZDAM7aP
6oHdfMvrGh5+qAIoPiOCigWkmllx295DYSgzOzNODG6WYimYOx5BdIbSMYlagrJc
QTS7pLXoTt3LBgoPB/NORo/1PeGifaUkzQ2hag5hW4XgN7EE7aqC/5aNKejwVeO5
HJhwt4ZTGqaGsqn06azQeEBRTgW9XjXcT/KZ6FkIMSLwDr97HWQM5u2hXYPSnLMv
foB1ak3L5ENn4WJhxoH59FCuhIBlgWGpG/aKqB/F9Aa+Uc2OvKx4WuwoFNGymWfM
pcZEabAVhuTzBuKFcnWdhEThgzSLk8LNX/g2LYCJmJQDKE8zDOnmv7bH6UGfbwvL
j9z5/jFYfxQnNYXXI6jDwVs+xEKM0W1aMpGee8pxiE1Gr+UsVcWCXLAJwUXhJE0e
hEdJ7fMykxucaUFaOj8YKQNaNvGL2Swe/V5YNcI1oPY4nz0R5W73J1rzIYmEtDiV
1nYwezGoFHS0QeHhSuUGYwbFEc3ql4zvTeebdjF1xg58Nsf5oayl0NXscjFWSEt1
tZmQCLkn5E7LAbzAM1gxhcFIXmehVAxPveIWAn5rTEwb3DOxcvYhbcWcFAuZHJQJ
Q7pl7zMcKud5L9WkQZrXC9A/zJXbUiVSQflAOo/wQsLQwGtsXvQQHxNg9ootVVJW
KJ2OjP2X6amSRQvLplVH
=QzXH
-----END PGP SIGNATURE-----

--1GSL5ZULXUIqbbH1--

--===============2167012130669932339==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2167012130669932339==--
