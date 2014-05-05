From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: snd_soc_dapm_put_volsw: Make
 sure to always update the DAPM graph
Date: Mon, 5 May 2014 12:31:11 -0700
Message-ID: <20140505193111.GS22111@sirena.org.uk>
References: <1399223826-28522-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4432473738766294271=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 32EDD264F19
 for <alsa-devel@alsa-project.org>; Tue,  6 May 2014 02:58:43 +0200 (CEST)
In-Reply-To: <1399223826-28522-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4432473738766294271==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R+WA+n3pAWWgNWUs"
Content-Disposition: inline


--R+WA+n3pAWWgNWUs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 04, 2014 at 07:17:05PM +0200, Lars-Peter Clausen wrote:
> When using auto-muted controls it may happen that the register value will not
> change when changing a control from enabled to disabled (since the control might
> be physically disabled due to the auto-muting). We have to make sure to still
> update the DAPM graph and disconnect the mixer input.

Applied, thanks.

--R+WA+n3pAWWgNWUs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTZ+b8AAoJELSic+t+oim9aUAP/3eq6RHBnNRsGUmzMcO+n+XG
vIeSg09kXQ+FigqYwxbtinHdoRyFtx2/TE9u4aeCXkvTg8Au4KFd59kNQyQ3AaKi
mnf51bC2X99YcQuqJ02yA18pGd1/1vEWkZaDL982dHRByNQ/ZPPbb8NfGca6qrhW
gvXIYqt3PuwhvoqatUjlYt+WihP+T/GJ02nCO8ymmlljd7IKa+68Bj06B+k11+ib
dWHSOO7fhG9xvehhcFYMqDWXjlyR6c9ASSNinG+rS9cnxWUPNjeI+T8vPiDO5Vi6
/DRyZoZlZYI8bSZWSL1HwsYwngbcST3AwA4GvXkIJQI5qn+WROl9iqJLi/I0NlNL
jy+AhQS5zSmGCl3G/QshFS1nwjSmR0bHT7RyPgcga09IWYSrXriOIxG66hyva0/l
TPcMYhs1Adlc4+qs9uvQWDgKlS25QkRg36VUsq/7Brm50KDg6N/gu0pd4Q154dV8
xdOffhX3NCdOqrT0VaDWWUVmJ7CpCD3BmnlaxdgNDQne33qTdw4mUx0m37C4Eode
LvLJyjMg6DQVhu0r6sKqHQ1kC+bthBYLBNPe9kAIP9Q0V0eRly1yE+/Q9A1JLOH6
1iSR64F3USyR1MMxD5wxzb7SjVkarmXnPzedo39OGHGTP7BJ4/rv1czsxOFBvspc
Vrq5JzC7k9vhmEAYcwj1
=42ey
-----END PGP SIGNATURE-----

--R+WA+n3pAWWgNWUs--

--===============4432473738766294271==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4432473738766294271==--
