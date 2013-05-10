From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 41/42] sound/soc/fsl: don't check resource
 with devm_ioremap_resource
Date: Fri, 10 May 2013 11:56:02 +0100
Message-ID: <20130510105602.GP3200@sirena.org.uk>
References: <1368173847-5661-1-git-send-email-wsa@the-dreams.de>
 <1368173847-5661-42-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2667682281983908653=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 04BD726158D
 for <alsa-devel@alsa-project.org>; Fri, 10 May 2013 12:56:26 +0200 (CEST)
In-Reply-To: <1368173847-5661-42-git-send-email-wsa@the-dreams.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2667682281983908653==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v+Mbu5iuT/5Blw/K"
Content-Disposition: inline


--v+Mbu5iuT/5Blw/K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 10, 2013 at 10:17:26AM +0200, Wolfram Sang wrote:
> devm_ioremap_resource does sanity checks on the given resource. No need to
> duplicate this in the driver.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

--v+Mbu5iuT/5Blw/K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRjNI/AAoJELSic+t+oim9mrEP+wZGhG/LMG1B/Oki5RlZWiTP
kkyXn1Db4WZjc6od5hHGc5oSXyolSezbl8wpu1kpTrK3l33EjhSHmHZE2dWYLg2K
bkzOqro+TKIu/tl5uNZZaYP7W5NXnhgtF622+KGMQHhNcQ91ugpPDzjeMPc2jN1J
wV24J4G0ktBWECGegsZDz7e384LjE2SxlJYBAT5Ig7BJiEOhgo3VkT+o+0De7Pdn
BA7JdJnLnUbbfIq4StK0kw/DjzYzxgPGRd8khN84dwzpz/7zofnhyZnLw82IfJ+P
UxVZMITJKCQPaJMxcHDLycm8C57UIHr687M4QVoJsM8mHdEAFtvvIl/oqUD/pEIX
Y6S+eLBbxaSo68YnjYxgIMQ37jPnD4vILN1km8Q6k/F3LkVu6vWzcZAyTEbUTo8Y
vOwqiw35sSuSW0LC5l6sHDs1u7vMGJSax0q5PATWrFIXQ1DELyoWbWM/tkAS27Aq
YwPp6UVgFPQZTl/MuyrIElmCqDTA2vjgyLXEVHEj6CgY6E80L+RrRKHNdt11nE3E
A46/DzGxljDT/S8bIxzrlByTEtGGr67LLdxQS1S46xs+vL6npERI1o2sltO3aNZg
l+u73Dzxb8065zOOorJsnZhndP5i4wghGSPzZrmYqXTSocH4/+SbYuwVOfHWcA1c
3PI/rCu4/ep67kZwCkxz
=C3Zx
-----END PGP SIGNATURE-----

--v+Mbu5iuT/5Blw/K--

--===============2667682281983908653==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2667682281983908653==--
