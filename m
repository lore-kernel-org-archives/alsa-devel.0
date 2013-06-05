From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dapm: Treat DAI widgets like AIF
 widgets for power
Date: Thu, 6 Jun 2013 00:27:06 +0100
Message-ID: <20130605232705.GJ31367@sirena.org.uk>
References: <1370457440-27867-1-git-send-email-broonie@linaro.org>
 <51AFA31C.3000602@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7518144208334761316=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id C133E2654EA
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2013 01:27:12 +0200 (CEST)
In-Reply-To: <51AFA31C.3000602@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============7518144208334761316==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dvhSTuvbbQltApUS"
Content-Disposition: inline


--dvhSTuvbbQltApUS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 05, 2013 at 02:44:12PM -0600, Stephen Warren wrote:
> On 06/05/2013 12:37 PM, Mark Brown wrote:

> > -		if (dai_w->id != snd_soc_dapm_dai)
> > +		switch (w->id) {

> That should be dai_w->id not w->id.

> With that fixed,
> Tested-by: Stephen Warren <swarren@nvidia.com>

Great, thanks for testing.

--dvhSTuvbbQltApUS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRr8lGAAoJELSic+t+oim9BTgP/j8Gufua4gstL1HvUddVI9rG
5cOfL9Kp0VYZvrdMUozVQlMVaJfpP/MneQd+0Da4L/Jf/CQ5Ir51P7xVHbLFMFv/
ZqvHOLFILtOZ+mqd4J2q41UJJJEarAcQWgDvHhsGpB1mB/cUzaNZdF2dMLfVVrR8
GpdmTK9FyH451bpoKDH2xZCJ7cldG6PJAx9zt7RthOL3hraxiJY/UxYyP72JdVEB
ko4DXaXXQ4CvlDbT0MWgwkKrJJvLFJG/bCMab0QXH8HJ6p0k0NH5/V427pg8bi6H
y5Q8ivUzpMlg62VMBbien+9MAxXNEvk0hcPJEbh1DIJEfr/K55do/VT+bFP9CJf0
jCkhgVSEmotSLr/uSwoZtX2IB81XHNZcmQiccUUN9qR40EJwMApgeP/DkLVl2CRg
Pwz/by98BTAa/cQD0sTqyHZBBrGQzpq2Y4MO4vn4z0zsgrITL4vw4nRrqqyA66TU
2mJ/zdG7vycyjWLULYutCm4r/jf6SPaYJXbrIORo6cqe+5nc8HWZ36kCOzxz/4Jm
l3I0AvOC8YJBpMKtzsv6/0cDSlT4iUahqeIX7jBn/1nWLSWOB5H8VJiYDaudroOa
fqzXCwY5WXJ9ttyM1bY2WuntNymt5RI4YYxWozv2mwsV70r6S6X5L45m0IEnHQQ/
NC7BPLQrhEtc8RKjal1z
=6ENT
-----END PGP SIGNATURE-----

--dvhSTuvbbQltApUS--

--===============7518144208334761316==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7518144208334761316==--
