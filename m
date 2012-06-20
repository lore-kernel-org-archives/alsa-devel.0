From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: Add missing include of pcm.h to
	pcm_params.h
Date: Wed, 20 Jun 2012 10:34:25 +0100
Message-ID: <20120620093425.GA3978@opensource.wolfsonmicro.com>
References: <1340130709-2857-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5hvcim7cwi.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0354079797631680542=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2243B24417
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Jun 2012 11:34:28 +0200 (CEST)
In-Reply-To: <s5hvcim7cwi.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0354079797631680542==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 20, 2012 at 07:47:25AM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > There's a dependency but no #include.

> I don't mind to put it, but it wasn't done because we didn't want to
> let the driver code including only pcm_params.h without pcm.h.

I noticed it because I was writing some library code which only directly
referenced things in pcm_params.h so just included that directly.  The
general idea is that headers shouldn't have external dependencies...

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP4Zi5AAoJEBus8iNuMP3dkUgP/jD4UR8KT9hyO3tXbjoJqqKL
cirfS+P1t+RkJNZc/THMWVB6dDDAHIVuFhPjzjg2hAFxiuTpwLaRqUQTr0w3/D0C
mrKtF0FIb26pCkb9MU6aJqm920Zvvoed7bigO0xAD6AWAkaCm/lcodUUd7e6TbA/
VlaPBbScXkTFgYGPGz0FEMtU9cN0V+7lue+nCoRkB+rmLqIkTauD2gZ/lNOxUcJK
cpGh4zEMbgG50oCW5lTTLNKsZmjjv9/jEtbzXVjXYK1q9nDOUlcyQj2eP363TPs7
LEAv+c5hgSYydEM6vX8Z6+4LQwK9udXI4mnUv47/JZ6lxVN5tBH6vRZoe4+GUNQo
Z/TIg9/HrP+YR71CDXtHFEIAJnga/C+PuE+dA3iv4+iLhSwtHDTrECOSTOirVc0A
qg9hn3vK1jfr63LlMK0cnwQebtdhx9igtP544CL6juj6WDQ2QtGf+aoBFjjOqfL/
owfGaqnnnPcM5rYcYFFAr84OjbjlwahSS5TFbyEpAi0Ucmy0yVdpqfQ7Oddb8wOb
tg/8JSSfT7VRbhukqdAsMR6UNWWQlc0ARKF2nvHGxDjOzfk3vH8PnuzQhBaQUIyt
skoFLPxOr9eBYpVvBhFPjkS+TxHpQ6TX2GSVK7OgbKKph2+TS3i42Zh9oMrz1pc/
+KYku8NSCpEB1EEtij4k
=LR30
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--

--===============0354079797631680542==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0354079797631680542==--
