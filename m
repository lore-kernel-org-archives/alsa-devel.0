From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Remove unused soc_pm_waitq
Date: Sat, 10 Aug 2013 12:13:10 +0100
Message-ID: <20130810111310.GS6427@sirena.org.uk>
References: <1376121194-21269-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5449420544751028767=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 62747261ABE
 for <alsa-devel@alsa-project.org>; Sat, 10 Aug 2013 13:13:13 +0200 (CEST)
In-Reply-To: <1376121194-21269-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5449420544751028767==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WaS+u6fw8ZDKobou"
Content-Disposition: inline


--WaS+u6fw8ZDKobou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 10, 2013 at 09:53:14AM +0200, Lars-Peter Clausen wrote:
> The soc_pm_waitq waitqueue has been around as long as the ASoC framework
> existed, but has never been used so far, so remove it.

Applied, thanks.

--WaS+u6fw8ZDKobou
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSBiBDAAoJELSic+t+oim9N5UP/2o/5D+/9zP/JC8KiX8itOhM
cNAiygBP1DGul/1pck2qWlRf9zzwpcrCKeFHQM+mdXiD96QiSaSUlDd2VyubqqFT
0+6MRh3vTtvYW7C9JK59813XIvxgXf3R6vL3GpDGWe0LjJrSq9u165aUzGvkKJOi
q/q39d/q3bEdcKbeKyvay45NpcfsdbpE/Jz2KQDWxZySbVDohGxy+o2GKcQ+yxKQ
Eb+LKeL/GrJvScBwecEjs0hRa8KLLbOD7P3MzWX+ueyfHTi5GRUnYYp+AEV+77pQ
La8PZh/FW+qw1maXgx41WifgohwX/bXasLcEUdZT/V4bG6WwVkWQHAv6cYmFzCdA
eH29MgQ+gKfDWKPAWUj9DRxdqf7xQmku5YuEFAzChhZi6d8gq20wHvD7NJKOIzP2
KV/MsOLqWN/co4/MM5EE+21mloM87TfLY2O3p+5ywkZfbRzkuEIC9V8lMxweTpzz
RyZHliPTeDVdJB6pccyE56cfQ/OzDak7u1C/OgxkZA6Mdxrju60vmbz3OnNqsaVj
Ki8al4kZA6FvgLhKpmca33HLvwPgGvRIg73R/cN5MvZg9IarcwdFmfR9Uw3qUz0p
XdA3Zy6n/gHrdiep6pL/ooaB3puqUVK0CkjxWU91v9sTtKY1wbk1u26Hb8I8ft4R
qjGBSEFf8AgBINqz7aeX
=NC4i
-----END PGP SIGNATURE-----

--WaS+u6fw8ZDKobou--

--===============5449420544751028767==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5449420544751028767==--
