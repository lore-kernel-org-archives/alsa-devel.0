From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2] ASoC: sgtl5000: remove useless register
 write clearing CHRGPUMP_POWERUP
Date: Fri, 6 Mar 2015 20:19:27 +0000
Message-ID: <20150306201927.GD21293@sirena.org.uk>
References: <1424991540-10206-1-git-send-email-eric.nelson@boundarydevices.com>
 <1425049605-5473-1-git-send-email-eric.nelson@boundarydevices.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8399577956430207529=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D396265FF1
 for <alsa-devel@alsa-project.org>; Fri,  6 Mar 2015 21:19:34 +0100 (CET)
In-Reply-To: <1425049605-5473-1-git-send-email-eric.nelson@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eric Nelson <eric.nelson@boundarydevices.com>
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, lars@metafoo.de, tiwai@suse.de, lgirdwood@gmail.com, rmk+kernel@arm.linux.org.uk, jean-michel.hautbois@vodalys.com, troy.kisky@boundarydevices.com
List-Id: alsa-devel@alsa-project.org


--===============8399577956430207529==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yv+5+Va/rRS6MwXk"
Content-Disposition: inline


--yv+5+Va/rRS6MwXk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 27, 2015 at 08:06:45AM -0700, Eric Nelson wrote:
> The SGTL5000_CHIP_ANA_POWER register is cached. Update the cached
> value instead of writing it directly.

Applied, thanks.

--yv+5+Va/rRS6MwXk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU+gvOAAoJECTWi3JdVIfQ5ToH/2eBLBiLyVnyebOV4WYRk/Rn
cCKm/TR3mMnyhAAP0BjWhxufBS7E3hUeuS0rpw+jVx428gF5eFJ7/JsGgiGfYfwp
iDdd7DVRdYtzl2m6fsX7gv49PKV9w75yqjCZVxpSuS3x07Zz7mGVW1XhE6672Kms
f1rZ3zKwwuiM+iNUz06rwM6BpUrXjNF/3+p87TuyQIb5R4d00pkT9/o7LcEs4jyX
VVGfDmVY5icSAO6N1kNc+0ADf6U1PiuHyuMj5J6NmE5ki+oFRM7+WCInVSJu85Tc
xXcU/LKMdd1C7hxhlaj/Loa23oaZqRaRfqabOmOQww+0sAnIu2u7PogZ7QTfYtI=
=LFoy
-----END PGP SIGNATURE-----

--yv+5+Va/rRS6MwXk--

--===============8399577956430207529==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8399577956430207529==--
