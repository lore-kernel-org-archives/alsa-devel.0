From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5645: Init jack_detect_work before
 registering irq
Date: Fri, 5 Jun 2015 18:15:31 +0100
Message-ID: <20150605171531.GA14071@sirena.org.uk>
References: <1433500932-39431-1-git-send-email-drinkcat@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2102714234206487405=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EB2B72668BC
 for <alsa-devel@alsa-project.org>; Fri,  5 Jun 2015 19:15:41 +0200 (CEST)
In-Reply-To: <1433500932-39431-1-git-send-email-drinkcat@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolas Boichat <drinkcat@chromium.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, koro.chen@mediatek.com, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============2102714234206487405==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mMJklh8hhp8IL6EK"
Content-Disposition: inline


--mMJklh8hhp8IL6EK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 05, 2015 at 06:42:12PM +0800, Nicolas Boichat wrote:
> Prevents frequent panic on boot, if the irq handler rt5645_irq
> gets called before the workqueue rt5645_jack_detect_work is
> initialized.

Applied, thanks.

--mMJklh8hhp8IL6EK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVcdkyAAoJECTWi3JdVIfQBNsH/2XlUgFtxBs2i5VsnxL3Cb/P
YN13dG1Km5nv4c/uzLP6yUKDbpEq2WBS3xRYFmtYHuima9S6XPK/IRmseLpvZho3
xg9BjF7FO33z7a/xmOYDSuASzAN5UEPUMnNTrli5HHgBFX3c1Wu+l1T3Z76UtiTb
7W3ODPmOLjvUPgya/zdDO6dwkF7JkrzC3rIXvyEobTQR/Wc42C9ASnIsmn8HpDf4
75Ion+XAbcE5dcuCVNdg0CRxI/90FPz3WcBiWFSoS+RLwbUUm+fu7giyjL7HEBmD
YZbwyKkd0qa8O+xJ/3NyCoYBjFY6IXHSrww/gK/rDaHeXNQk8j857+8Tp/X2Z+M=
=1pyH
-----END PGP SIGNATURE-----

--mMJklh8hhp8IL6EK--

--===============2102714234206487405==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2102714234206487405==--
