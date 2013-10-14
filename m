From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/4] sound/soc/atmel: don't use
 devm_pinctrl_get_select_default() in probe
Date: Mon, 14 Oct 2013 14:17:48 +0100
Message-ID: <20131014131748.GU2443@sirena.org.uk>
References: <1381681071-6021-1-git-send-email-wsa@the-dreams.de>
 <1381681071-6021-5-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7906000682226353145=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id D93E32608EC
 for <alsa-devel@alsa-project.org>; Mon, 14 Oct 2013 15:18:16 +0200 (CEST)
In-Reply-To: <1381681071-6021-5-git-send-email-wsa@the-dreams.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============7906000682226353145==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="N4FnyIpcgIJc+tmW"
Content-Disposition: inline


--N4FnyIpcgIJc+tmW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Oct 13, 2013 at 06:17:50PM +0200, Wolfram Sang wrote:
> Since commit ab78029 (drivers/pinctrl: grab default handles from device core),
> we can rely on device core for setting the default pins.

Applied, thanks.  Please use subject lines appropriate to the subsystem.

--N4FnyIpcgIJc+tmW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSW+75AAoJELSic+t+oim9TdcP/1UZSjKtrdUF8tH9xDZXwSdb
XK8bn1mrnmsyfBHLL9h1bzmyaGH/DsL4StbeomL7oRvCGqjCoaz3FdPtDSN3Biv2
CY3tpiX3Vebq8qRCcwmMrVB682yKnshm2VulyCNeUrhJz2Z1S6bvSp+yfs38LPmp
3yZFoDDSQgTfWM/igbeT2fRWfgzHMcXHyq6PdMUo50klJsddQmzjhy8LKHSttppY
luEJoMqkCeEa+Sg7ZwEV0fSBZwjCQZ7Bs/Jx3D5AKUCqGS3lvqbAVergJz1QmzfV
op9bAgMitCRqnlHiyHdKOvgqiLO9BWeUe21NLOS6OZAX3W7t7jzYWBZNVlPekg2A
S/xFgiScloQOwqalfZFr6yXflJ5iyeaOABWZPciqBZMJr5bhn2Fj5Wh82UZioOGt
1+VGp5Bf1U5PE+UBZ7/NrjDjrhaTWsyki6XcbbFEuzJTb877D5IJbS76lxKHTpNU
FALIHkIf6BQtUrYyIzPkNJDrkPfTUQUdwRNEAzUbmJnXbD6Ln6Sbd9WXnhINBZgl
isL7tlTsgJIITseVvsVBFdEZsfP6nWatwEXumM/yYnKaebUeSNnKQus6n93O9VJd
kHQb9GVaYX9vtNpBsNJ3JpXlon2d2Ln+J3e1+GXeTkV0PJIs1oCnm51UTbAldCZ2
Hcgrt3oxFsscIOJQvrJ2
=sHl6
-----END PGP SIGNATURE-----

--N4FnyIpcgIJc+tmW--

--===============7906000682226353145==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7906000682226353145==--
