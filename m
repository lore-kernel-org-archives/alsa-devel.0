From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: intel: Don't print FW version
	repeatedly
Date: Mon, 27 Mar 2017 11:13:54 +0100
Message-ID: <20170327101354.fgvu2s6ewdccha67@sirena.org.uk>
References: <20170327083958.18020-1-tiwai@suse.de>
 <20170327100658.GI9308@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3402997078607398703=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 77AFF26583C
 for <alsa-devel@alsa-project.org>; Mon, 27 Mar 2017 12:14:07 +0200 (CEST)
In-Reply-To: <20170327100658.GI9308@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============3402997078607398703==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nuxipb2eo745z4si"
Content-Disposition: inline


--nuxipb2eo745z4si
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 27, 2017 at 03:36:58PM +0530, Vinod Koul wrote:
> On Mon, Mar 27, 2017 at 10:39:58AM +0200, Takashi Iwai wrote:

> > -	dev_info(sst_drv_ctx->dev, "FW Version %02x.%02x.%02x.%02x\n",
> > +	if (memcmp(&sst_drv_ctx->fw_version, &init->fw_version,
> > +		   sizeof(init->fw_version)))

> wont dev_info_once be better here? We are really not expecting a new version
> after suspend :)

You are if someone upgrades their userspace.

--nuxipb2eo745z4si
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljY5eEACgkQJNaLcl1U
h9CTOgf9FXEAnphKR8yHG153qrY1Wtm9UzIoKYjj4t7PB0uM3uEH3+CfQFGn81Bd
l+Pk9TCUpc9UjQwE1bgsei7+yjSIBk9btfC9VfxzgLR2B6U49VOfwMtNCkaDFt01
ckUCX57u3tDIyhqInKi2TmSmerHBguxXC2AeH470rbxT/jmpJ3kLbdxko7GbZj+C
g3m/RtvkuFE8A3s8A9UQThUbgUZNSL+LmzeT4ALTl957FZVHrgxT+CWihMNr3tPT
4bJBjllV0AWb/vK763xARz4Sn9RyBH44ULeEKTx2H+YKRMv2Ia5t4FK+UmJMhYfJ
yHQZvOZtkqS8Bh1jHUXmTARgsHep6g==
=N1aG
-----END PGP SIGNATURE-----

--nuxipb2eo745z4si--

--===============3402997078607398703==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3402997078607398703==--
