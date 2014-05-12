From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/5] ASoC: Remove runtime field from DAI
Date: Mon, 12 May 2014 22:08:58 +0100
Message-ID: <20140512210858.GW12304@sirena.org.uk>
References: <1399361981-18518-1-git-send-email-lars@metafoo.de>
 <1399361981-18518-6-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5092261169143467986=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 50498265114
 for <alsa-devel@alsa-project.org>; Mon, 12 May 2014 23:09:05 +0200 (CEST)
In-Reply-To: <1399361981-18518-6-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Bo Shen <voice.shen@atmel.com>
List-Id: alsa-devel@alsa-project.org


--===============5092261169143467986==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c+EycNg3D4rJIzhb"
Content-Disposition: inline


--c+EycNg3D4rJIzhb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 06, 2014 at 09:39:41AM +0200, Lars-Peter Clausen wrote:
> This was initially removed in commit 6423c1875 ("ASoC: Remove runtime field from
> DAI"), but was, presumably by accident, brought back in commit f0fba2ad1 ("ASoC:
> multi-component - ASoC Multi-Component Support"). But has never been
> initialized to anything but NULL ever since. This commit removes it again.

Applied, thanks.

--c+EycNg3D4rJIzhb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTcThnAAoJELSic+t+oim9DWgP/2QMyzLcsCXbo4TP1hBUT+fl
4FDA7M5hCqUDbG/GANmdMG9+Pc4M6/ueNG66lxkoFLvUVf4KdUstCFJ797MQuCuq
mXhl9h9Pr5VJlPMlF8PKhgS3hK3BJE8yMKu1Vsgkxn7QY18Go8j2WB6VRiIAgk4G
6MTHFjrIReBNP1Ob7006KhhXwy/tj7ltvwVa9nUmqwdQv4XpUTtM9QqnpGk4U0tK
omVp+opp1bihIAjL9914MpkgqIscqU8oI2II6mTA6JShitnMXzt1f37qZTB9c9te
Re/GN5sfsuKBti2Exg1fMThHlkzbbTZ3IFkK1T0Ogyx4iZYIMKPIJgXQ3UPsOPRy
kM5YuLW64PHXNth9xaMgu0KG2dgPNO0TT6pW3sp8ZMG6qC/ovwLX9rJLNND6tdAQ
lRko9txvsnvdDqnfq3+DxBwQdaUDZ6bH8qqgQEVkfsh5AsprZHPilGECV3btaS+P
SnLvWQtQSMNxyDporebw/zMA+Ot+q9EIGh9gORHe12mqEp/QePG6/P1QFtjTIi6R
rSoV0LtNep7DOlk5j/3Z5jx60KHtQncpOXfo+wC3JgOGTT02eEXUAF2f5Qzo7MHj
FBMvSdxZD0MQ0662dULSmJukuF/Cx3854q7UHOcccuC4k3YBgvvYJtuMoG/hQ8Up
a24QEhDKpE5FhcmZs3GF
=orrq
-----END PGP SIGNATURE-----

--c+EycNg3D4rJIzhb--

--===============5092261169143467986==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5092261169143467986==--
