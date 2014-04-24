From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: simple-card: is_top_level_node
 parameter to simple_card_dai_link_of()
Date: Thu, 24 Apr 2014 18:24:04 +0100
Message-ID: <20140424172404.GE12304@sirena.org.uk>
References: <1398357720-2000-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7379604940410629868=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 88D6A2652E2
 for <alsa-devel@alsa-project.org>; Thu, 24 Apr 2014 19:24:20 +0200 (CEST)
In-Reply-To: <1398357720-2000-1-git-send-email-jsarha@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>
Cc: moinejf@free.fr, alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, tiwai@suse.de, lgirdwood@gmail.com, Guangyu.Chen@freescale.com
List-Id: alsa-devel@alsa-project.org


--===============7379604940410629868==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hWWUi4vh68gqffvI"
Content-Disposition: inline


--hWWUi4vh68gqffvI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 24, 2014 at 07:42:00PM +0300, Jyri Sarha wrote:
> Restore correct parsing of dai-link subnodes with more explicit
> implementation for applying the "simple-audio-card,"-prefix to
> dai-link property and subnode names.

Applied, thanks.

--hWWUi4vh68gqffvI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTWUixAAoJELSic+t+oim9a94P/iLxc0jAw0YLRQkajh0b8yNO
3yGoBCP8GqsBAJXVL+xxVs5DM6H4/IJxEaNPP9uvZH6lPtFr/koX0lXkTtVHPCVx
lA1M5F4DJs9Ka0NHm8MB/kiaaIGLh8snpu4rlziEbCH6/zeGlDNz7sbd6ZQURFvu
uv2y0EdRlewnEK6iizX8JfImgh7HfRbqbYV+DVieZn5xsKRye4k0MeLuXUSSU8IN
bAGWpQg6Foh4fk/1moQO3sgiC+2GvQUpyFpPIWWPDLZOVZluZmT0rWfQT5KLBmgg
9vhojv5XBQFMepvMjVF4rR80HeOSY7fC5G3XcgseoytoXiQxZT7/A+0dqNB/IEVd
kJsr0k4fSs6XlpyoQejtLig84P3RJoauX4lCti+OvC1Bq2gmzpOluUmVNVbJ1XaB
rA5hhbIW9x3tQmaWMT430s9iObyRZqa9SqyrAt3dMfVYrkT+T4gD/yVnuqAR+TXW
sWSlcA88oUk8Aq6wbQG8sU03c86aC/aFlSEYO9l7gjgPiBTS9CbuLahZ7mI2E9CM
VVjEgosU5N/bicNhpSmJxqHzFTfXr+Mj+qdsATVFhx/TlG2EmFGTa4vW+8zlnzBD
cb3BAvSI6UCnCnpO6XZk3cS2eZxBAajiiDzYKWBWHk9cNpdoaajBKLcwj3f8xLLu
66O1TizSKQVGlH7Epfs/
=Jd7/
-----END PGP SIGNATURE-----

--hWWUi4vh68gqffvI--

--===============7379604940410629868==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7379604940410629868==--
