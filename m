From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/4] cs42l52: fix master playback mute mask.
Date: Wed, 22 May 2013 13:39:32 -0500
Message-ID: <20130522183932.GZ1627@sirena.org.uk>
References: <1369243167-28700-1-git-send-email-nschichan@freebox.fr>
 <1369243167-28700-5-git-send-email-nschichan@freebox.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0897168510167006628=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 502E326171D
 for <alsa-devel@alsa-project.org>; Wed, 22 May 2013 20:39:36 +0200 (CEST)
In-Reply-To: <1369243167-28700-5-git-send-email-nschichan@freebox.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolas Schichan <nschichan@freebox.fr>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Brian Austin <brian.austin@cirrus.com>, Georgi Vlaev <joe@nucleusys.com>
List-Id: alsa-devel@alsa-project.org


--===============0897168510167006628==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="muH0jftA0RW8bb09"
Content-Disposition: inline


--muH0jftA0RW8bb09
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 22, 2013 at 07:19:27PM +0200, Nicolas Schichan wrote:
> The mask should define the bits to change in the register, not the
> bits to preserve.

Applied, thanks.

--muH0jftA0RW8bb09
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRnRDhAAoJELSic+t+oim93aQP/1ves8is5bsoxUooGoXhifo2
hy9rdvtO2T7zJSDM0md0z5qte+M4cPKu3l8eA4Q2K7Woi0ECmQlkDPh82mGFK2Hj
W947FJ5EfcINYy7yBAuPcZ3SARTJ8l71g33J0doCXY4nV3knfZyhjmjO7DpwoH6j
3KpzzuTsUFL7ikN1xhcgxgqHBHTHagJaxrv1/CF57olppCrHjYax6lBEiuF6HIsa
hCmjpSKlOzJLnuU9yjvHgEBjF0AfMrZrSMwrEgBLbnCX2DUE42lTqGlWaVJlE2gf
a1gcitsoq5KMI19MqGWt46YG/RDOQ9MhS4Keb/f0/6YTO0Z5xGJLXmZ1xTHu46SP
AsO+YyQ7meGN82X2/6nzVfcOUA+ZWzZRSMVIwdcFkTGW0wcuTykEfjeVx+KDyBjX
hFlkiVoAFDOXkwjvOgJwuIZ8ll6Madk9rrCpaZtS9BaBzl5gBZv9jEC+IKXZtL/w
4pR0V4pYiJKPf++XpUWQzqJFWbsV/5ge5HkBWW3fQ2Tg9lhtJ2S1S6b8J3q5igcf
Oh6VWZkjL3SmWdwf8ufqscNA/Z0JKxjFyRhhiQyX41kxvlKmPeu9PZGFIdmwifCo
9OMODsHLU5GnP+4g3mIM7n6jZtjNRVfP4MAAL4VbuH2TZQhG7RxILBksMsJnWmF1
YR0HMjmFQe5KKgm4cZ2M
=ViJ9
-----END PGP SIGNATURE-----

--muH0jftA0RW8bb09--

--===============0897168510167006628==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0897168510167006628==--
