From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/31] ASoC: blackfin: Use WARN_ON()
	instead of BUG_ON()
Date: Wed, 6 Nov 2013 10:00:55 +0000
Message-ID: <20131106100055.GH11602@sirena.org.uk>
References: <1383673218-18405-1-git-send-email-tiwai@suse.de>
 <1383673218-18405-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1681666649032896761=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C4B42610CF
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2013 11:00:59 +0100 (CET)
In-Reply-To: <1383673218-18405-2-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1681666649032896761==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZFKeWUZP29EKQNE"
Content-Disposition: inline


--LZFKeWUZP29EKQNE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 05, 2013 at 06:39:48PM +0100, Takashi Iwai wrote:
> BUG_ON() is rather useless for debugging as it leads to panic().
> Use WARN_ON() and handle the error cases accordingly.

Applied, thanks.

--LZFKeWUZP29EKQNE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSehNTAAoJELSic+t+oim9wUsP+QHeuezmm1EDiwZWlZUGKbYF
sD5QcnRzyxZBEfKcgxYE5w9X44SHpjM1YXHv3H9uZFu5QWtPRj7XbsL4n6Y80T/2
rwFobmyIgMQl8DXOJHuxjGCb4IchpBFXmm9DXvXEgc/MMfniyGIEfGIcGg0HnKJe
R/DoQVe5VjHH81p5a7fdoYNHrHEmVjfc17rr9IkgsqOlj3rVuUxhTlYrZWcU7yRM
+WoldTfnshogd+oKHflzWUKyd4q+zPBfBfTjDM0ah2amXIFU3fwc8rSwIXJQ4OuD
ZxqSeAWIaobSKiotFTrzA7aOVcNaKVVWQIidcuUHT6pREmlFjomopjPUI4MNcfV/
ZKXg3s5cjcYB/JX0V0Lqo/cNRXWlA9RkufKFtvTBsj+dmBOqm/nu5p+2JjYxBdoF
gBnUebzVKC/48TSo+nWRB4iGhOa0hVznO0XcVaN0MK0EXd+7uGlF2a9pCTNHTtXo
GbotW4+K/gBLjxnq3/cr/rD6IwQRRl5yEL8C2M/EjpaVjriZwy/HPmffG+uXV4+f
k2zqHfAmot1OMs1RMz4HNUyinPxlsmsHl9mDY13sMI5Awzhq4Cy9BS1E4JhSKn30
tR28gf5rZx9KMA+G43NMRFSWMfohi+PKhtrY6CbUeLODPTVzRzAvOe2KaiuEJ0wk
PgJW5SfJdeEkZd9FKogo
=CNVM
-----END PGP SIGNATURE-----

--LZFKeWUZP29EKQNE--

--===============1681666649032896761==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1681666649032896761==--
