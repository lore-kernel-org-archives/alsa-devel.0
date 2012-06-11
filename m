From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASOC: utils: Update dummy codec DAI
 settings to allow stream creation
Date: Mon, 11 Jun 2012 17:33:10 +0800
Message-ID: <20120611093309.GF11439@opensource.wolfsonmicro.com>
References: <1339058158.1927.15.camel@vkoul-udesk3>
	<1339063721-15193-1-git-send-email-selma.bensaid@intel.com>
	<20120607213057.GA19485@sirena.org.uk> <4FD1B19E.1030808@intel.com>
	<20120611031331.GG28211@opensource.wolfsonmicro.com>
	<4FD5A0CF.4040606@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6638005942414060977=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id CAB9C104238
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jun 2012 11:33:29 +0200 (CEST)
In-Reply-To: <4FD5A0CF.4040606@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Selma Bensaid <selma.bensaid@intel.com>
Cc: vinod.koul@intel.com, sylvain.centelles@intel.com, alsa-devel@alsa-project.org, louis.le.gall@intel.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============6638005942414060977==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R6sEYoIZpp9JErk7"
Content-Disposition: inline


--R6sEYoIZpp9JErk7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 11, 2012 at 09:39:59AM +0200, Selma Bensaid wrote:

> are done @AP side. But I really do not understand why ASoC provides the
> soc-utils dummy codec? The current version of the dummy codec is
> useless since it blocks the stream creation: please refer to soc_new_pcm.

The commit log refers to usage in conjunction with soc-pcm, I presume
it's going to be substituted in as a placeholder in cases where there's
loopback or otherwise nothing connected.  Like I say it shouldn't be
used for real devices since we should at least specify constraints.

--R6sEYoIZpp9JErk7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP1bpkAAoJEBus8iNuMP3dgnkQAIVygc5XWhpfDj4ZcEGZYi6m
xMNZ4NX/KtcAUSuvQH8hndEWuh00ObK6uIy76HBaoU8szdoi0Rlyvupt4Fp+8H0U
C4TbuUaNFG+TTtiX2Et1ifhOqOE6ID9xc688ixrXbhwpMwt5xsyASaaI9Ms4QKcD
B2vmt0CcAd/2aLajljTvSQdKlqm4U7nqzAQmdJURyFBrKjRZo8n7JZJQj/Udk7In
d6bP16DMSWO5je+VTv15MOrH1k6QDmPdLaM2l2BV7tlImseIpzNz0vloqLFUa0Uv
++HG/o6mq6Ngxc341B9tF7JUncCYnKtMBrZTiX09MbXRUYJXlZKsAEqqz3xPc69o
NW56P5vhM7rLU+XYkPW05Mx32t6TalQFyft98QsS+CUXxvzPkhaZ3AKl86nKq/B2
q1V8cA9InpEblCmDn2mHJsP7WJBD7kcpU2V25xMgYmUJw9HkHfWSTlZqU+9Cj+Z1
DhibIVWv1dSAk0z2tUcuEKNzc47PswMBaJRj//2bLUOddKy2jgS+0fYy8680WOdf
PSsOMQ7mPxM8mflZyrsY4QIK8zkAp+sHQ2VSsLWnG5BrfM/vSU8v+7dXqqTmBH5T
0SYKkWK96DWmgojorS8dMqAaeDALbtHeFsv6+74BGM5OyGuHR5/pJz+Dx8vv0y0Z
v0Ri2JCkiBxrRPAqrgKO
=vmNJ
-----END PGP SIGNATURE-----

--R6sEYoIZpp9JErk7--

--===============6638005942414060977==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6638005942414060977==--
