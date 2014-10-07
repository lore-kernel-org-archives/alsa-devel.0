From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/4] ASoC: eukrea-tlv320: Fix
 of_node_put() call with uninitialized object
Date: Tue, 7 Oct 2014 20:10:44 +0100
Message-ID: <20141007191044.GE4609@sirena.org.uk>
References: <1412698794-25536-1-git-send-email-tiwai@suse.de>
 <1412698794-25536-3-git-send-email-tiwai@suse.de>
 <20141007171800.GP4609@sirena.org.uk>
 <s5hk34blqxe.wl-tiwai@suse.de> <s5h61fvlndu.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6072569113880566986=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E2F5260427
 for <alsa-devel@alsa-project.org>; Tue,  7 Oct 2014 21:11:13 +0200 (CEST)
In-Reply-To: <s5h61fvlndu.wl-tiwai@suse.de>
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


--===============6072569113880566986==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qvqe4mReYAfpWQmG"
Content-Disposition: inline


--qvqe4mReYAfpWQmG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 07, 2014 at 08:56:29PM +0200, Takashi Iwai wrote:
> The of_node_put() call in eukrea_tlv320_probe() may take an
> uninitialized pointer, as compiler spotted out:
>   sound/soc/fsl/eukrea-tlv320.c:221:14: warning: 'ssi_np' may be used uninitialized in this function [-Wuninitialized]

Applied, but please don't send new patches in the middle of e-mail
threads - it can get really confusing trying to work out what the
current version of the series looks like.

--qvqe4mReYAfpWQmG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUNDqzAAoJECTWi3JdVIfQc34H/AtgVFgWpd5X/qPUmuo5fAhx
pVZLSrM7ldZHKDXdKPLbM97geUI/Ll21LRJEI65rWSrvlbayouCGepPKgWvDF147
aW8b5iVj3KAimg+LMkZMzXtmuM5GSSifzgW7BJi6YBJNRsMjTDIXC5s3dAVeUOY3
MifphFVMERMCWQ4CmyEfxLeC4PFXDZTEk3Iq+Yj4milbIABB3MYs5Bh4bDT1vUtw
UIosREb0dSRkVcqcukVEswQAKPiuXG3kGR0I3fbCS1Wu/z3fJ9IQJsUAA/PDinWe
S5tPIlQ4si+4NXVWznVmLCJZTUuISynQqS7+eQtHIoTaFG4jGoor7GbyUS/ySyw=
=4A4E
-----END PGP SIGNATURE-----

--qvqe4mReYAfpWQmG--

--===============6072569113880566986==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6072569113880566986==--
