From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: wm_adsp: Expose coefficient
 blocks as ALSA binary controls
Date: Wed, 17 Apr 2013 15:59:24 +0100
Message-ID: <20130417145924.GX13687@opensource.wolfsonmicro.com>
References: <1366196132-4302-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1548319938722319395=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 304BD2616BF
 for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2013 17:08:51 +0200 (CEST)
In-Reply-To: <1366196132-4302-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============1548319938722319395==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WVf18ZLo9bznw8Mz"
Content-Disposition: inline


--WVf18ZLo9bznw8Mz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 17, 2013 at 11:55:32AM +0100, Dimitris Papastamos wrote:
> Add initial support for runtime tuning for the ADSP cores.  This
> is achieved by exposing the coefficient configuration blocks as
> ALSA binary controls.
> The current code assumes that no controls on the DSP are volatile.

As discussed offline this doesn't test well for me with mainline.

--WVf18ZLo9bznw8Mz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRbrjDAAoJELSic+t+oim9VBgP/2G+AO9AGf0VZkzbvrfDZBEQ
AgU2z0/dZmQkX3osyjBgCu8eMYtRsESZjD16D3GSdugMAYBlrk4vMUaf16QAd64g
NT4aMa+j3frNE0rnyzweRaw0lPdT2TAtp9t0HBtLt6pEBv4XKZYTR2u3lBxAALR9
omzGrSX5+gVLAhWRENyqiyNOehm8AdNvqSG7HTaTZ5tXbRbSsNpdPqEfMLuympTG
X16EDi1Q0cKFZGuErTl2mLpIqHtiLvU61pWysTaFndJlTUeeaXeAxTYIq7fnwaxk
VL8olitOERM/045u+Kkqk1mKLRjV1ElFj02ZJ80ltWK0wMQTZRaQly254k1mbpCX
xU3MPG/px9ucwt3wVeVmLjwZ5bPlZDljtwKuTkSlZQOi7hDQGhFfeTCrYddqCSGR
leeW6YUVMkz46rZ62yD5YeUQ1ijzS2JFShbC05/rWeG9NUx9Gnf36eH/VYd96HdF
la11p1Sf+TIGkS/HHvYZKMzKz8rPJ83h9DtETlpWzwU+ZTvoMM9wYxzUtKg3j5/O
bUgjbWhQYo7zbtRwAVtaQEuVysSHsz4Ff2SOnNParF/sw2b8s42u//oTKjPRKY0V
WYU4FdTEffpD49G4PcatSkTb26lOHdvEvHx/MqIMRbLL4fzH3knOKJ6Wpa2rxxF+
xx3prLLrn8EW630K8RJJ
=cze6
-----END PGP SIGNATURE-----

--WVf18ZLo9bznw8Mz--

--===============1548319938722319395==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1548319938722319395==--
