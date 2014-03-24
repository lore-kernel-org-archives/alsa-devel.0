From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/4] Add fsl_asoc_xlate_tdm_slot_mask()
Date: Mon, 24 Mar 2014 21:07:17 +0000
Message-ID: <20140324210717.GQ2269@sirena.org.uk>
References: <1395382635-16349-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3077424564106013052=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C6A17261A9A
 for <alsa-devel@alsa-project.org>; Mon, 24 Mar 2014 22:07:31 +0100 (CET)
In-Reply-To: <1395382635-16349-1-git-send-email-Li.Xiubo@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, Guangyu.Chen@freescale.com, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============3077424564106013052==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jigfid2yHjNFZUTO"
Content-Disposition: inline


--jigfid2yHjNFZUTO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 21, 2014 at 02:17:11PM +0800, Xiubo Li wrote:

> Xiubo Li (4):
>   ASoC: core: remove the 'of_' prefix of of_xlate_tdm_slot_mask.
>   ASoC: fsl-utils: Add fsl_asoc_xlate_tdm_slot_mask() support.
>   ASoC: fsl-esai: Add .xlate_tdm_slot_mask() support.
>   ASoC: imx-ssi: Add .xlate_tdm_slot_mask() support.

This looks OK but I'll wait until after the merge window to apply it
since that should happen any day now (due to my scripts that means after
the merge window opens).

--jigfid2yHjNFZUTO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTMJ6CAAoJELSic+t+oim9ScEP/0v+w/2C5uQDVWumNhVUes0I
ojqTwsbnGIsIelMzD/vpcwELEQ8VsI3BhkpgMuVYdUvw/KsVqsRdtplKn5vhqhKR
o5SNXn7LYZ7teGj1Y7axGdETgLuTQxrhe8rVXzbnX0Lv7KJ7YTTq3Wk/Xpp9P+w2
sUNwk+iDcYERu/lAqXv3UN4DzdLY/8R4aFw8LJpgqlEUKxx5GYSyRAHqElUnpvcs
uMPJhNXOtj96N/o3vrvQPOKAa4t+b0kKToVIzVIM4phOaVnhWCZTCzjWgD5cv/H1
KpYzaPFkXIoh9J6U4LPxMJylqvCnXKW8x2ZsqW7HXK7mQArvKR8Bx1b3BHnmN43e
xvYVPQ8Gg6dDlTm5EPCumNDHQUAbLIb12dmCbRxfInqGxx3vOYZAKUAbZHpg5AgB
XC9qi8KLtnTOZGZ/FjkLNTDIDiB6hYH6hMM6c6LBIbe/lOFtrIZaDwn1a7HiC4FS
AKGzyi503wcT4UC/xeQ1A0g4Smp+ONJJ0AeF9FhPauej+++gCATpjYzfJzmKlSHy
PaL8PHbn2A5WymJyxTGlTpHfMVixrwaGw5cphy8hjhZici7egDBNcaaNBGQmn8Gy
E8GndpIPYaDyhioQvV0iH1KrRYocbo3Jf6soPu+A83X3q+c+gFffo6UpDqbpinDI
2X34ZnLTW8SkjaK+V7Li
=U2MT
-----END PGP SIGNATURE-----

--jigfid2yHjNFZUTO--

--===============3077424564106013052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3077424564106013052==--
