From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/3] ASoC: DPCM can care FE/BE merged format
Date: Tue, 21 Apr 2015 11:42:10 +0100
Message-ID: <20150421104210.GE22845@sirena.org.uk>
References: <87mw22ufs3.wl%kuninori.morimoto.gx@renesas.com>
 <s5hr3reklel.wl-tiwai@suse.de>
 <87y4llucde.wl%kuninori.morimoto.gx@renesas.com>
 <s5hiocplv8x.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4181625803411380465=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 389BC2608ED
 for <alsa-devel@alsa-project.org>; Tue, 21 Apr 2015 12:42:18 +0200 (CEST)
In-Reply-To: <s5hiocplv8x.wl-tiwai@suse.de>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============4181625803411380465==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WBsA/oQW3eTA3LlM"
Content-Disposition: inline


--WBsA/oQW3eTA3LlM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 21, 2015 at 10:51:26AM +0200, Takashi Iwai wrote:

> There are indeed cases where a BE takes incompatible hw configuration,
> which needs be_hw_params_fixup.  But, in general, the FE's hw_params
> is just copied to BE.  That is, we assume here blindly that FE's
> configuration is compatible with BE's.  And, now this assumption isn't
> true in rcar's case, so we face the issue.

Well, it's as much that we're assuming there's rewriting going on which
handles things - in many of these systems everything will be going
through a DSP which rewrites everything on the way.

--WBsA/oQW3eTA3LlM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVNimCAAoJECTWi3JdVIfQHcEH/1Qz4/2cSWDXphT/MvBkUTwN
hTR3SSDXfwXCNBcoSuwml5DRmjyNdsY+PT/+/+5XCX3hPKPkFCsJa9YEQLt4ytoU
kG1cI9AJvfu4Yer4/eaVI7HSpJNRxBoPwUb20uC7vfS+CFMs7NT2ALl62svqPA6W
MlBQIiPI5LmkQBNR/X/qJee3+otHmT1+SDe7opGEl+lS4yqSw14f+T2b5AgRbmcs
lGD1gc18+J3Fi+DQmWxjYC1qHA153ca8wj4cslLg+YxrEEfixKZXOSHiT1uJmDiC
O6LmZeF8xTQwO0j3qh4gYIZ+pie9CnYiRrgjTa7zRL0cSZg0eX2p0inMOE2rTck=
=viRS
-----END PGP SIGNATURE-----

--WBsA/oQW3eTA3LlM--

--===============4181625803411380465==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4181625803411380465==--
