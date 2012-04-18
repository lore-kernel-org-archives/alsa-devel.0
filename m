From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: dapm - Add API call to query
	valid DAPM paths.
Date: Wed, 18 Apr 2012 18:23:18 +0100
Message-ID: <20120418172318.GF3099@opensource.wolfsonmicro.com>
References: <1334745671-29949-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1809564007480569499=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 859FA244AF
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Apr 2012 19:23:20 +0200 (CEST)
In-Reply-To: <1334745671-29949-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1809564007480569499==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6v9BRtpmy+umdQlo"
Content-Disposition: inline


--6v9BRtpmy+umdQlo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 18, 2012 at 11:41:11AM +0100, Liam Girdwood wrote:
> In preparation for ASoC DSP support.
>=20
> Add a DAPM API call to determine whether a DAPM audio path is valid betwe=
en
> source and sink widgets. This also takes into account all kcontrol mux an=
d mixer
> settings in between the source and sink widgets to validate the audio pat=
h.

Applied, thanks.

--6v9BRtpmy+umdQlo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPjvh9AAoJEBus8iNuMP3dXRkQAJTy8sd0IKkvEERV1tDTf+G5
AiLFMhptIMewCyQIxs9JG4N24zox4xzfzilNJYGHBb7Ul22NzwooU8bMsx099jOf
6vzzUk82lZa3KCBi3wWTg7rwy8N+5R1zpKf0wRefQ7lzK825CqIu4/o3ZFvTXOz6
Gj142LSlsuUn1496LQkwdKllb2g4nHKEhki2+0EeLkCKuBx7ka8pL3rW3rrmpg3x
yZyBIJFAjodr/OpPJuWT+yPDoqhKJkGiTi5Son7Z+L0vMIB39JTGUfNUCNYMZy9+
wkK2ksO+hcvsAv9tNlbIimERjQuNRT1+JtifnDyLRbyICd5heSxblrbu7o47KRYL
5nKqol9rXHHueZMyzct50dx4+JIvQRJ+zWMwCPqOQmaz1TfWxmLfcoXiMqsBKdtz
9hs2+/gZPSNxIufdrbpTZkIdDjz0WEERnKzc8srdAMNF5vKPHU9c49vJm+RLn+cU
qysSHtrE643uS89yWWPkW4o7LXF25fJXhnEW/PtcbQHnc3VnI3h7x8NgY02IZDLJ
SNtUBNV/sF9lpb1o/E5cV1LyHafaLgZgyQW6ImYWnYQkFvmrMp0U7KMZM06upFvA
h2QIzOVtpVevO0QtYEN5pud4Udeo84WWocUUizrwjQPSUxabwF3c9j7NgQN1jqtR
iyuxOawYSQYaRME3JNgF
=5bt3
-----END PGP SIGNATURE-----

--6v9BRtpmy+umdQlo--

--===============1809564007480569499==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1809564007480569499==--
