From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/4] ASoC: eukrea-tlv320: Fix of_node_put()
 call with uninitialized object
Date: Tue, 7 Oct 2014 18:18:00 +0100
Message-ID: <20141007171800.GP4609@sirena.org.uk>
References: <1412698794-25536-1-git-send-email-tiwai@suse.de>
 <1412698794-25536-3-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3007536253942394242=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A519260594
 for <alsa-devel@alsa-project.org>; Tue,  7 Oct 2014 19:18:22 +0200 (CEST)
In-Reply-To: <1412698794-25536-3-git-send-email-tiwai@suse.de>
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


--===============3007536253942394242==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RvYRPxT9kmUw5evD"
Content-Disposition: inline


--RvYRPxT9kmUw5evD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 07, 2014 at 06:19:52PM +0200, Takashi Iwai wrote:

> -	struct device_node *ssi_np, *codec_np;
> +	struct device_node *ssi_np = NULL, *codec_np;

As well as the NULL thing mixing initialized and unintialized things in
one declaration is something that's normally avoided.

--RvYRPxT9kmUw5evD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUNCBHAAoJECTWi3JdVIfQBHsH/iXrfglFtZGvgDWfA8HLDHtN
E3+LPCORFxcT1r8R5GuFvELktY2KawJj5FrPZihXRbgtHFjIPo6psDlkiMSVf4uS
lICNb+64n8ZXY+GZuWNPuiVtEopxBPT2BB8SLcxNN5+riUyitJ67gAekoyjqZoOg
fnDFBg2hwPflJcvf+W63Pr/0cZIS8TKFfidqjyKQSSr60tvVwDCpdGZLRMy2VSs1
I6m0ndeulOX+1pdSHjyP+j0cexAjeRsPGPQVKDs/U5u56DGspMhZbcDxrQ3Ycxpt
NjWRXYqC/FxuoKS3laeMs4vsv6JP0Eedjj86q91kvr+cV/HZgxVpwUgiko4YajQ=
=6T4V
-----END PGP SIGNATURE-----

--RvYRPxT9kmUw5evD--

--===============3007536253942394242==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3007536253942394242==--
