From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Add max98926 codec driver
Date: Sun, 10 Jan 2016 12:52:53 +0000
Message-ID: <20160110125253.GA6588@sirena.org.uk>
References: <1451946574-22918-1-git-send-email-yesanishhere@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1886998191879576977=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 59B61265DFF
 for <alsa-devel@alsa-project.org>; Sun, 10 Jan 2016 13:53:05 +0100 (CET)
In-Reply-To: <1451946574-22918-1-git-send-email-yesanishhere@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: anish kumar <yesanishhere@gmail.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1886998191879576977==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yHgig3XI5r20tkjN"
Content-Disposition: inline


--yHgig3XI5r20tkjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 04, 2016 at 02:29:34PM -0800, anish kumar wrote:
> Signed-off-by: anish kumar <yesanishhere@gmail.com>

This looks mostly good, a couple of small things.

> +static const struct snd_kcontrol_new max98926_mixer_controls[] = {
> +	SOC_DAPM_SINGLE("PCM Single", MAX98926_SPK_AMP,
> +		MAX98926_INSELECT_MODE_SHIFT, 0, 0),
> +	SOC_DAPM_SINGLE("PDM Single", MAX98926_SPK_AMP,
> +		MAX98926_INSELECT_MODE_SHIFT, 1, 0),

Most of these mixer controls look like they're on/off switches (I'd
expect them to be as mixer controls) so should have names ending in
" Switch" as per ControlNames.txt so userspace can understand them.

> +static const struct of_device_id max98926_of_match[] = {
> +	{ .compatible = "maxim, max98926", },

There shouldn't be a space in the compatible string.

--yHgig3XI5r20tkjN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWklQlAAoJECTWi3JdVIfQMqYH/RQPsgZhi3bmQpJrXyTrSlYr
cp9iy2tln/NZDbu3dUiyPoA3nk14opzZ8aWquTEcDd885WIgm8f+gUgXnwi+2H6m
lpX662lVZFq8zjpMlrOtbvwxNcDFHeMQFSe6UltmtdyuO+yQoSiDV7HWhteo+GP/
lFbZmmlgKeTCs0xaj6oO7b3G6r19v2kmYgmInsgYqfp9enYqP6qpTNxRJ7Rjt+fi
JWdK3HGiGrTe/4KWdg27BIstjbIuuCeiWBIwSbdIYzWiI50JK388dxoAffjSZbpL
FgjejumRuGhioI0s2A0P+ERSqSoGJ8GgcmRCk0UL2qLSpiUiAV2G0JBBcTFakYc=
=4Lx0
-----END PGP SIGNATURE-----

--yHgig3XI5r20tkjN--

--===============1886998191879576977==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1886998191879576977==--
