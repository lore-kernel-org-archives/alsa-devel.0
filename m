From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] ASoC: samsung: add explicit i2c/spi
	dependencies
Date: Mon, 14 Jul 2014 19:51:26 +0100
Message-ID: <20140714185126.GB6800@sirena.org.uk>
References: <1405086308-1461192-1-git-send-email-arnd@arndb.de>
 <1405086308-1461192-3-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4201993954821336775=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2EC7E261B02
 for <alsa-devel@alsa-project.org>; Mon, 14 Jul 2014 20:51:39 +0200 (CEST)
In-Reply-To: <1405086308-1461192-3-git-send-email-arnd@arndb.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: t.figa@samsung.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============4201993954821336775==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/w6WUUxYkubDgwa5"
Content-Disposition: inline


--/w6WUUxYkubDgwa5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 11, 2014 at 03:45:04PM +0200, Arnd Bergmann wrote:
> I got another build error from SND_SOC_SMARTQ selecting
> SND_SOC_WM8750 without ensuring that I2C is enabled,
> in this example, i2c is a loadable module:

Applied, thanks.

--/w6WUUxYkubDgwa5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTxCarAAoJELSic+t+oim9p/sP/iG4pNFZtcM9fqzRRSmSbEal
KlFKEFYyt6uhl00ilhhx/xvfyWRTUBNidlPPdsSsrjSihVOqPHatK5SI0NiiCsfT
pcOXgvFBRmEY7ZSt9epziUiZ41RVNUadpCt2V2AKGd9igrp8mdt+ry97FjndK7Nx
TupkWNVnhwYUmy/RufMzvdro7l2j2bfXoTz8b0L1k9g4WInZxW+/8QIDm/VAe12s
AdrFK8KGZq83+IdKP/1gcA7keEOd1Z6VmE2/2Vw8aNqWJSPWKP/fqK6/Oz+tqm9y
eExEXboH7s/uL2bQWv0AcW1FDxDhUTxIawcDgnsmT3y95+CzPZgHX4s+Rt6lLlaI
CttIb2gzJi86ov/2ShuyDnYb972rAyV28CYsFtKk0ycgxvLVAmsfW0sRRvKj22bB
NIGWAhs+QzYDzJW6qKWIlwbSn07Nuy8mnfEIiJPhlGZ9oIxzwU2rQhPY2neo1lnZ
uWu785/rwo//dVtsxzW4um3W0+u8vQH8PhJl9mR/4h8enAtbF2eYS4VGuWWmRy1Z
fatsYteaJjchPXUeXxyX8l1Ujmhk2Aq/Gol85DIJ+a58zfBcHpSmk7nru+MjRfVJ
QpI5/8qeoFWajKMA4Wb8a/b3zg+WNt7vhR2rODmdJcInvWV7TwkCW35TK4ZyOfaC
LtTYhGSgiZ9WGlDZgSX/
=Mceo
-----END PGP SIGNATURE-----

--/w6WUUxYkubDgwa5--

--===============4201993954821336775==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4201993954821336775==--
