From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: cs4271: free reset gpio in
	cs4271_remove()
Date: Wed, 19 Feb 2014 23:00:48 +0900
Message-ID: <20140219140048.GZ2669@sirena.org.uk>
References: <1392808032-25756-1-git-send-email-zonque@gmail.com>
 <20140219111529.GI2669@sirena.org.uk> <53049467.60106@zonque.org>
 <20140219114303.GJ2669@sirena.org.uk> <53049EF7.5040709@zonque.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5647489779088603556=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F30226535B
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 15:04:31 +0100 (CET)
Received: from e0109-106-188-144-10.uqwimax.jp ([106.188.144.10]
 helo=finisterre)
 by cassiel.sirena.org.uk with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
 (Exim 4.80) (envelope-from <broonie@sirena.org.uk>)
 id 1WG7lE-0005oR-JI
 for alsa-devel@alsa-project.org; Wed, 19 Feb 2014 14:04:30 +0000
In-Reply-To: <53049EF7.5040709@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: brian.austin@cirrus.com, subaparts@yandex.ru, alsa-devel@alsa-project.org, Paul.Handrigan@cirrus.com
List-Id: alsa-devel@alsa-project.org


--===============5647489779088603556==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ims+H+fSKJm6k6PB"
Content-Disposition: inline


--Ims+H+fSKJm6k6PB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 19, 2014 at 01:09:27PM +0100, Daniel Mack wrote:

> Alright. I thought there was a verdict once that resource claiming
> should be done right before usage, but you're right, it really rather
> belongs into the bus probe functions.

No, that's not ever been the case as far as I can recall.  There were
some things it used to not be possible to do due to the ASoC level I/O
only working after the card comes up but that's a different issue.

--Ims+H+fSKJm6k6PB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBLkNAAoJELSic+t+oim9hb8QAJcr1WsXRZhYoWWk0fYTYnXS
BvqJJEwX49Xjmj6XU23ac5YEl4Ptv+3ga9Wj3jUKCZyaHidggmo5nFVKdZ+HaVzj
KuXpt3vyBECrqDBNOKN2FiS9588Q3UXIlVtb4JY4Zbyg1WU8OZFt4rKVzzVMHdQ0
jbLzsB7oJrbj16BVdSs8AfS2ArSh5fc1ZWJJ2J8YZQHspQ26JHmwnVCoo6awIB2i
8HYcYQhldjPonw9WAl+p7aYVJqIo+JYV1/VzygmO+ApYA+V4A/0oJSwpGnOibRDF
gKFL+8TnC13VYxuUXQDKJJtZzprYfAJd4/n1Fu+G/gX4E5MdPzXmzVoCiBXFIdWX
frxevgGjZrvQpYFb0D8s/JO41JUcT0ByUGjAH2q4f2A2ofCO8kKUvVOj/qLxRYzS
IB+/0igBWH6vKZMfZfD/mHkIBRMjLl70+AWegvTySL4aVnNuhVv1UDpQs2HP7IzP
A04z2CAfeR0legI5ihPcvn1Iu0ssjH0HikS1zW4lKatKfADhmOYhxyZD9LAvJXuS
xSj//epOfF0daX3e2AjPjNLsGLMWrprrOcKSksh73E7SR430tig5n79tS/6LFdSk
KhoDbnr19PIjEoqWksUKXlsg4d5wvjIV47LHVO8PAdFM0FDEiGMYLsklZEcnsmYn
2RLJR6/zezk1BhxXBC3V
=ZZ/c
-----END PGP SIGNATURE-----

--Ims+H+fSKJm6k6PB--

--===============5647489779088603556==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5647489779088603556==--
