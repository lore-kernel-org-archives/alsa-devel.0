From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm5110: Power both channels for
 differential mono output
Date: Sat, 21 Jun 2014 11:35:30 +0100
Message-ID: <20140621103530.GX5099@sirena.org.uk>
References: <1402422062-7162-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2311985015406953579=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D6CCB2652E9
 for <alsa-devel@alsa-project.org>; Sat, 21 Jun 2014 12:35:56 +0200 (CEST)
In-Reply-To: <1402422062-7162-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2311985015406953579==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MYNCyPYCQT4ygp9S"
Content-Disposition: inline


--MYNCyPYCQT4ygp9S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 10, 2014 at 06:41:02PM +0100, Charles Keepax wrote:
> On the wm5110 CODEC both the left and right channel must be powered
> when an output is being used as a mono output, although no audio is
> routed to the right output channel. This patch adds additional DAPM
> routes to link the right channel to the left in the case where an output
> is marked as mono. Audio must always be brought in on the left channel
> for mono operation.

Applied, thanks.

--MYNCyPYCQT4ygp9S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTpV/vAAoJELSic+t+oim9GXgQAJQttXGTRKbUGKe/JS5wuj2X
uj4WWId38CWUHRjciHm3LNm+FZUKIZsQApkos053QBiugWFqOxwyqvX+Pjt3tzoD
28E8xeJLA6YtJSFSCEqy7P0i1auflKAeE+WHeMGiyJEfb67IsE4452VEzyPdYvio
lLVA5AWUdKfMSE2E4iShZcB6ao+A9eZPhw7O8bJcAaupWW3JMI4kyG1vgXJtK+be
whKAVMP9IWcj/ZLycu7PZ3A+CEDiS21NywSn0k7nMCMEWSQQpWFVu27X6cISozi/
TeB3CeHuO3Vf/jgGw16UNnqYi3AxWh/+2lYQt4QdYcSpJfs3pg7oRfBQnkLozst3
pa2/G/3de+JSN7HA7SgOZss+TLm9/yAxQ7fUK+KSz5qRn8CRbb2c+fw+kqBb1iyu
vJZ4lXgNBZDmbZAhE2opEZSK34/FeQBzF8HIGT+Q6eJCalFkNF6o9fg1VV2N1nQo
ReH32r+6vpZKgbA+8h66J3eZP7CaY2rNQosgtjg8KZgWrSrpIY6f30etpPie5c8A
Jd7SxMbLkiiOtMOobG33DURO56eaBD5ElgwY7LCeoEzxkW2KU1FZRp2eJqJdl7lV
v0r9zQI5mNv6z2AhtQV7Y/vtMagfrYu6i7kZNFLO5GISABoC6aqEb4JiSt5HwO8T
eG6EoPSOkXDrDuZVGpLb
=CgEu
-----END PGP SIGNATURE-----

--MYNCyPYCQT4ygp9S--

--===============2311985015406953579==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2311985015406953579==--
