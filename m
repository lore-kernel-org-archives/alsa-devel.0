From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: tlv320aic3x: Add TDM support
Date: Mon, 10 Nov 2014 12:06:32 +0000
Message-ID: <20141110120632.GM3815@sirena.org.uk>
References: <1415615253-28919-1-git-send-email-peter.ujfalusi@ti.com>
 <1415615253-28919-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1954390236157619619=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B46B42605D4
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 13:08:00 +0100 (CET)
In-Reply-To: <1415615253-28919-2-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1954390236157619619==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nw7Js0ltx4YC415X"
Content-Disposition: inline


--nw7Js0ltx4YC415X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 10, 2014 at 12:27:33PM +0200, Peter Ujfalusi wrote:
> TDM support is achieved using DSP transfer mode and setting a
> programmable offset which specifies where data begins with
> respect to the frame sync.

Applied, thanks.

> +	if (unlikely(!tx_mask)) {
> +		dev_err(codec->dev, "tx and rx masks need to be non 0\n");

There's no real point in using unlikely() outside of hot paths.

--nw7Js0ltx4YC415X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUYKpHAAoJECTWi3JdVIfQFmAIAIThCHWSFDG89pFJ3WYZXyP2
YTlyyLSAezWcVwq9+LQLT88Y9jlWMu3OwDHXb9X+1fUGs1EIzcpLDQmePVbOBquW
pwqPJDTF8B2qfqFhG91gZ3Qjh380JZMoB8tWevSbp0Kycx/viOFOq7+03XfYFJq9
5Jw2oImAnOW1kglkzjdqzammcc4iZWb+5oCkARjwH+6eA3IAsbwORFFAifSoiKLs
Zbg77UWWeggEtiTwIK2dv+E9dGzHX/wfipYbJVMcicBH4Pa8OPnnauzJ6EyCXaeN
+wu+ZpWz9sqgb/BDCXRpZD8HdzRzgVv0ug9EX/OzoQCoYlXCyjm+FXICBxNpjkM=
=B2A8
-----END PGP SIGNATURE-----

--nw7Js0ltx4YC415X--

--===============1954390236157619619==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1954390236157619619==--
