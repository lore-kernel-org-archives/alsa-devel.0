From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dapm: Handle SND_SOC_DAPM_REG()
	generically
Date: Mon, 12 May 2014 21:50:13 +0100
Message-ID: <20140512205013.GP12304@sirena.org.uk>
References: <1399829267-18755-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6368492390048117862=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 720C52650FE
 for <alsa-devel@alsa-project.org>; Mon, 12 May 2014 22:50:28 +0200 (CEST)
In-Reply-To: <1399829267-18755-1-git-send-email-lars@metafoo.de>
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


--===============6368492390048117862==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WSVS5tLVcAHorA6z"
Content-Disposition: inline


--WSVS5tLVcAHorA6z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 11, 2014 at 07:27:47PM +0200, Lars-Peter Clausen wrote:
> Commit commit de9ba98b6d ("ASoC: dapm: Make widget power register settings more
> flexible") added generic support for on_val/off_val in the DAPM core. With this
> in place there is no need anymore for having a special event callback for
> SND_SOC_DAPM_REG() widgets.

Applied, thanks.

--WSVS5tLVcAHorA6z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTcTQCAAoJELSic+t+oim96XEQAIl72SCEVPGDiiyKNr1UVKse
9Hd8B93SwJqgi1cfVV5Rd4MYK23PJScPrrziI7Vcj/qu3EGDml4pymJNwChjlYAd
m92J4PGipAPQu9XocLZcz7aptTmn66BTStTvNAIGN+X4Ys3DkTVX/EJ4dJPo20nd
XSBn/NsjUN2BIg7dPIIC28eOIa/1loYuuFIlq04nTax6N3C+5zqBmZ6o+jafjwqY
9/t6Jbmcks5Xeqmgo33A5SofQ1lx51lmpG1usS2DuYm+D/+bxhFsyeuUZhgYRfUo
TUyVXKixGSSSUHWFowyoOG5H3y9Kd0SEqYE/xa2GMgkwCBUcnrlFbFBQyOLpwLxQ
xqTpT+wHjpNN2tm3/Gd3vGIxGqNOjbXncUMh8ap7V2poQDALUqWBYLTJmnHCwTW6
7kwXKE7vAyz7c8GU0qb2kaUsetchHigVtO1qciO7k9+URWCMFsqyNFOk7Zvur5M+
fcDpSi+ZQ3OrsAagQDtpMprgLdCk4GfY3zUSpByHFETwNvSpavaotiN1GFN0/MIL
yZXDz10Kp2eZ88lbNoQM4WcacGqHvPDR2ekDJ1ytIT7JS7oKrS6Crl7oTOObjKR9
QzBnvz8qEBzV+x9/fTc+OjZ8KRbiSeP5KrZxY2CN3yMLQneZUEkqXJNySedezzF7
tjfaObH/Sp5ZHt3JN4te
=OqP8
-----END PGP SIGNATURE-----

--WSVS5tLVcAHorA6z--

--===============6368492390048117862==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6368492390048117862==--
