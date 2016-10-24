From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 1/2] ASoC: core: Print one-time messages if missing
 resources when binding DAIs
Date: Mon, 24 Oct 2016 18:21:21 +0100
Message-ID: <20161024172121.GF17252@sirena.org.uk>
References: <1476897666-13974-1-git-send-email-javier@osg.samsung.com>
 <1476897666-13974-2-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="y2zxS2PfCDLh6JVG"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1476897666-13974-2-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--y2zxS2PfCDLh6JVG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 19, 2016 at 02:21:05PM -0300, Javier Martinez Canillas wrote:
> If snd_soc_find_dai() doesn't find a DAI in soc_bind_dai_link(), a
> error message is printed and an -EPROBE_DEFER errno code returned to
> the caller.

> But since many probe retries can happen before a resource is available,
> the printed messages can spam the kernel log buffer and slow the boot.

> The information is useful to know that a dependency was not meet and a
> defer happened, but isn't necessary to print it on each probe deferral.

This then turns any subsequent failure into a silent one which isn't
great for diagnostics.  It'd be better to look into trying to avoid the
retries in the first place, Raphael's dependency graph stuff looks very
promising here.

--y2zxS2PfCDLh6JVG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYDkMQAAoJECTWi3JdVIfQZW0H+gI/O+UDAK0uR/QhdOn+UwU1
pZkyOzU6wcm8Veh1rrCnPMRGa6o7we1e4aBLVMfyCxhcha7XPKDwAOPyQA0lzISj
tJk6cl7DvXoipGSiMcTpXbgXg/bCy1XZhM7xjgtyCws9BaeGgmPNPWEalgbmtBWz
zbzpOYaJ60Oj2fQ3eYBjeAteGQUztZFn3TSNNpgPN2fbA9e6/vOUqFFKksj2xBtO
FTsUUDR0KRrkgeha9xeGosak4b9IH+Lh0NofhkqGj0Tt3AAojRy+9LgTldULVaN4
2ZaAOGVJRq1PtFLFWMgGls6uPtVpP3QqZP399DX23VVt557ychKU5z6oWELoqdE=
=Sy9B
-----END PGP SIGNATURE-----

--y2zxS2PfCDLh6JVG--
