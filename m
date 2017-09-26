From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: pcm: Sync delayed work before
	releasing resources
Date: Tue, 26 Sep 2017 09:13:55 -0700
Message-ID: <20170926161355.wcgpsvqlfgg64kd2@sirena.org.uk>
References: <20170825100407.5640-1-tiwai@suse.de>
 <87r2uub8rg.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2647424628396268005=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 47D5A267140
 for <alsa-devel@alsa-project.org>; Tue, 26 Sep 2017 18:14:30 +0200 (CEST)
In-Reply-To: <87r2uub8rg.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2647424628396268005==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5po4y2ryhs3ahm7p"
Content-Disposition: inline


--5po4y2ryhs3ahm7p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2017 at 12:39:14AM +0000, Kuninori Morimoto wrote:

> This patch solved my issue, can you consider this ?

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.
Sending content free pings just adds to the mail volume (if they are
seen at all) and if something has gone wrong you'll have to resend the
patches anyway.

--5po4y2ryhs3ahm7p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnKfMIACgkQJNaLcl1U
h9C3xQf/Yjbs9jDbYdli3p0JoVIfhqXBpFdDtHmrLkt8vBSBdo1uZ5lLtz5HlIki
wDhujKu/BwzKf9khliTV3ZEGfgqLzQv4vT8/vX8afoP6R9Ja72qOHoDADCWPjfeY
vYw8B4JOxDugysOqg0nNZTOcncxWVczxSrePtP6gyy3ZCGiLS5cntKS1lXspibM1
qqTvKT+iLCV/tWcZVSqde09+OuVJKXyo9jUK2cHyFYwZB9NN2AStPn+bGqyBrdm9
iRelghKxwghwkSePOEVivQ0mgxKf9D8oKRDWB1ybXWgOLqjcvA/PH6myr3U609p/
KSpQYEzlwvewi6sgZwzFq5nNnfin2Q==
=rkD+
-----END PGP SIGNATURE-----

--5po4y2ryhs3ahm7p--

--===============2647424628396268005==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2647424628396268005==--
