From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ALSA: jack: Unregister input device at
	disconnection
Date: Thu, 14 Nov 2013 16:17:53 +0000
Message-ID: <20131114161753.GR26614@sirena.org.uk>
References: <1384440580-29234-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5481387101559236422=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 6120B261A2F
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2013 17:17:58 +0100 (CET)
In-Reply-To: <1384440580-29234-1-git-send-email-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============5481387101559236422==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Tcb1KvpfnM4LxW2s"
Content-Disposition: inline


--Tcb1KvpfnM4LxW2s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 14, 2013 at 03:49:40PM +0100, Takashi Iwai wrote:
> The recent change in sysfs triggered a kernel WARNING at unloading a
> sound driver like

Reviwed-by: Mark Brown <broonie@linaro.org>

--Tcb1KvpfnM4LxW2s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJShPekAAoJELSic+t+oim9cz0QAJDZS/XkrSaXv1OWOtd24J8O
Z1aAANAwoj0FJb8yau6C9i+ZFiMQ4YW0yyTWQJAJmB0sN4M5rbx4hwt7480u/vNl
eBKERHflQ/hFJ5jNc0UdiD3/VhFcfLdtQ0Z1Vcjk3tG1gfZDcb8AoryZcfoRkN/j
Uj/MNz9AtCan2thTel024BU+UtMHLr8Wkml9ZTJtGFrerz+4WE0YLo6TGG8wJSWL
7NAzOvYcgizEvDA1nOX5Vx1eayX9jH0BAgp2bq5trpQ7RAIhaCPvkcKRi4l5ElMo
wBhvbooO2AoNSqywiyhS3npr6I4aQxR4ewaxEy9XN8SKH8lRlywwMhbhtHM0S3pU
0feseUljd9CXDdrsA8S7dLWM9q0fAv3w/rvarSQj2I/OxufJeijGNEtKtBBPSSbQ
eXNTsMS+oCwFqJ5TyroGwPGl74qJFbyF22G5BEtLsnQsf+c8yxBzc3vKzHoNBxuq
bNT9ODmDTMFMr/YCoORoFXK4wQtLMDbk+rAx1uJTjTr6MpIwu7mJVjLX7dqEBnK3
3VdozanUp/Ij0GAtkVltWcuKmNH9wo7bLFcGYNgD27Mr4eszBTWzDxTO4+aDzVCo
WXbwL//HSfMVPuHPyhkEDzDl6AmJDKUM0fIzJL+By05NMxkBzaPzNS4LgdkL+U1Q
TiHYxfeOL1ZxiCJ5QlHn
=mAHw
-----END PGP SIGNATURE-----

--Tcb1KvpfnM4LxW2s--

--===============5481387101559236422==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5481387101559236422==--
