From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 14/14] ASoC: wm9712/wm9713: Use shared
	controls
Date: Fri, 31 Oct 2014 17:40:56 +0000
Message-ID: <20141031174056.GM18557@sirena.org.uk>
References: <1414699271-22797-1-git-send-email-lars@metafoo.de>
 <1414699271-22797-15-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8668400305101144055=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B66D2606E2
 for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2014 18:41:32 +0100 (CET)
In-Reply-To: <1414699271-22797-15-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8668400305101144055==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CX5+52/sCRHY3fIm"
Content-Disposition: inline


--CX5+52/sCRHY3fIm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 30, 2014 at 09:01:11PM +0100, Lars-Peter Clausen wrote:

> Note: This changes the exposed controls, instead of having one "Left HP
> Mixer ..." and one "Right HP Mixer ..." control for each input there will
> only be a single "HP Mixer ..." control.

This change would be a win except for the above - these devices were
very widely deployed in fairly popular devices like the Sharp Zaurus
devices so there's quite a bit of deployed distro config in things like
Angstrom which would get broken if we updated, and some user community
remaining too.  On balance I'd say that the cleanup to use the new
feature isn't worth the disruption it'd cause to userspace.

--CX5+52/sCRHY3fIm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUU8mnAAoJECTWi3JdVIfQLRIH/0ViY5ZoD3JanXlxoBVSr49L
/ZKeYjcQ1jHTpOcbj6NHUb1UkCpY6FAaks60u1Nrc157myYrBPUosdDn6FxzXDRz
BCxkeAX58xqgy/aPqUACqPNRZ+SJ/Ypzqlxe8VM5efXsZfEx57TXU/Xfg5xGatpD
6bk6CZMl6+7PUMAH9pgaD4lz2A60N0Ndz9p6ybPOYFS3AWJk+SAkZFRmh4jlLlwW
4IlOTcua3+0DI5Ubyejtn57cM9Qo5OoOZJLDUVkFpzke+VvPMsniiISjYrEVvdoS
A8vCSFxBRB+jJjZvAvAL3z81JtepzvmkjccGh/Xi9hnvqtyLp/Hfd/wCiHIvEj8=
=kRQ3
-----END PGP SIGNATURE-----

--CX5+52/sCRHY3fIm--

--===============8668400305101144055==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8668400305101144055==--
