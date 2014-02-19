From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 018/102] ASoC: ad1980: Fix wrong number of
 items for capture source
Date: Thu, 20 Feb 2014 01:50:27 +0900
Message-ID: <20140219165027.GC2669@sirena.org.uk>
References: <1392723422-12689-1-git-send-email-tiwai@suse.de>
 <1392723422-12689-3-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7443081906887959874=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 305A92652E3
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 00:20:30 +0100 (CET)
In-Reply-To: <1392723422-12689-3-git-send-email-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7443081906887959874==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6Q9I5lwF1twsf+4u"
Content-Disposition: inline


--6Q9I5lwF1twsf+4u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:36:53PM +0100, Takashi Iwai wrote:
> The number of capture sources is 8, not 7.
> Use SOC_ENUM_DOUBLE_DECL() macro and it's automatically fixed.

Applied, thanks.

--6Q9I5lwF1twsf+4u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBODPAAoJELSic+t+oim94pcP/Atd5DF5PQagSZ64GabGGyEl
8cUvifK0ZZ9NYSrfSl8f9/ZuPfUzksyX549uN/h4IJHQJfeIPhqWvDP1b4A10OSq
g57b0TFcqDD0dJ6HwpIxPcTDYVAFX6BMEODHbEyvIxOTVoiWX21Hr80lrPRVfxiH
VVKUOXdzvJeXuZgsxfqkMbgQR7HFRHGYg+Txw7MeqqxJK072puE1VZueEbC0qV2F
7ubnw9AVEQE4kZxXXaf12CajVz4/fVr1IJyfHNQr6VOwj3WIbcOSf+PUqM9vP5qG
fM8ps5GEmWiippxsntl9dgv1Q8fLoxEUDMghiwk0AJv/qCVea1xItsDGIjp2DUuV
xqJtzoFfkBmpzAtEH8Vw1QxWsn4GiQJYM+bHocLoQl4xR3VIpb73X/IY+6/qdZDK
OcI280Rkqap8hvxeBaV3pKF9jgy3CkxaKSbFqujV5r8KFJ54oAH1HybD7lyBTi6V
y4NnCRXvQds8uGd/XYT0DiUlN0ShSGFqFa3bPz8AC/xCys8ZYt0/a51Tk6pJvmwg
s5618Z4GOeh+k0SfWqr37YrmWzqqeYE42Sl4Gb8H/jIwXfvaLOvAiBjyeiaQX9MI
0iSZ45w+8fSyZ90M/lxqPBy3JTkbodftftgm/n2g43KV0AET43lKTJUCVL+CHvja
I5JDMeeoW1VhOoN7j+Yc
=c+rP
-----END PGP SIGNATURE-----

--6Q9I5lwF1twsf+4u--

--===============7443081906887959874==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7443081906887959874==--
