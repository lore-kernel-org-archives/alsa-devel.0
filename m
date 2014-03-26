From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: tas5086: add regulator consumer
 support
Date: Wed, 26 Mar 2014 16:38:31 +0000
Message-ID: <20140326163831.GA14287@sirena.org.uk>
References: <1395829378-13055-1-git-send-email-zonque@gmail.com>
 <1395829378-13055-3-git-send-email-zonque@gmail.com>
 <533300D6.3030107@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2082596887307632057=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 69B032610CF
 for <alsa-devel@alsa-project.org>; Wed, 26 Mar 2014 17:38:58 +0100 (CET)
In-Reply-To: <533300D6.3030107@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2082596887307632057==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 26, 2014 at 05:31:18PM +0100, Daniel Mack wrote:
> On 03/26/2014 11:22 AM, Daniel Mack wrote:
> > The TAS5086 has two power domains, DVDD and AVDD. Add support for
> > regulators to the TAS5086 codec driver.

> Meh, this one needs more tweaking as well. Please ignore all patches in
> this series; I'll resend once things work as expected. Sorry for the noise.

No problem.

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTMwJ+AAoJELSic+t+oim9BykP/jPAKH1jfXvuDHuxRr+eJRS7
z35tEdlW05TI7o+e/UZmVJOKlbcmwmW8Ga2gkaU0EM84Efm0zyObm/mK9GgFXrEL
MxXEnxIzdZG6x0hzsvCHyOgPc4ZCZIe5zUeG6pTjK+vVpdUW1a+G90ks15imXn7L
AjL5DGNW/43/WrIxkAoUHM0oSwRG3LRT2PK4W5ZNIlQNs6qa5WvKSzqnBV+Rjkj/
z83PXerXMTlfti5O66FjA+aYPa4r81o3d90LVh1tgY5scdwktpBYCCRJe3cPkzvJ
vgJ8Vu9kYM1jYPtaH+LR0WCxBN+lnb0tEtlPDo9SH0cOiarozZRab6x/fYjMxQJ7
WvA+xaAGk3Lv0+SMwRoFRwqrCWdQQUtLbpy+beGPnRNyvLIwlsEANabzEHGfaE8O
dQx4F3dM34MSHCEJYsaDrOnMpNAzilCgn9fdmGYmDrMY3VaOylIQ7i9a5QWke8gY
zOaM//P1sqYJmb9mUUUnIrVCU4nofBLdXQgoR87gLoxAC1a5y2MTb8HGlacdnSRh
JMf8TrCo35ypvMby8pAzBAuzzQMGiu+lJ366BEK67YPdPynAG1CSfOSiLa+cXNZu
pQA0DWLXLUG63H550t5rAPbyDePh+rxbs2B1NUVeAk4hnKET6rFf0xmdzWIp2jG9
K9b8JlAzFDq1Sx2Q6YJl
=wQdy
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--

--===============2082596887307632057==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2082596887307632057==--
