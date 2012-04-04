From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: fsl: remove redundant Kconfig
 option SND_SOC_FSL_SSI
Date: Wed, 4 Apr 2012 12:34:33 +0100
Message-ID: <20120404113432.GB9693@opensource.wolfsonmicro.com>
References: <1333081892-8808-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6618098542536928457=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4B07F103E68
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Apr 2012 13:34:41 +0200 (CEST)
In-Reply-To: <1333081892-8808-1-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org


--===============6618098542536928457==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="24zk1gE8NUlDmwG9"
Content-Disposition: inline


--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 30, 2012 at 12:31:31PM +0800, Shawn Guo wrote:
> While commit 606d620 (ASoC: imx: merge sound/soc/imx into sound/soc/fsl)
> adds SND_SOC_FSL_SSI outside "menuconfig SND_POWERPC_SOC" to make it
> visible for both PowerPC and ARM/IMX, it forgot removing the one inside
> "menuconfig SND_POWERPC_SOC".

Applied both, thanks.

--24zk1gE8NUlDmwG9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPfDG7AAoJEBus8iNuMP3dnxoP/1/ODhfR2dMU6sv0XcaabK4E
FshhmiMoswlRgHLQPz35GltySzyhqS/nljPw9EaSydFfx7xzWbvggTuSwuwgRXd0
ojVYOrNHSAtoVKpkhn70K/9PSV7O+9ATrOLM1KiiS8D+9enDHmxN5Qls8/xCBdfv
aOA8Txb+GIG+6tzaT8qK5pdn1XRL+v1qzHTrDg7hxQDV2lbva8HTVYTFFzZeQ/1f
4Ha36nulXJv/NJRvXlwe9wN7lYMvcJPLoyt2dofYu1C0ZWkSMSNcLGOsMF1Wj0eN
1c9I04UjKgQypGTEwqcNpLy3/JxNszWVakTxWxbtaXxRPkH+jeKNLJYCcUJ1j/no
9TzQZoJO1nO5RYJGPqfhayrjBJURjmHyf/JNwx2oRzeCNBLOGHdmnG7vC4xAYWcO
+z3CudXGB/OAhd5aS4uYwhPcFgBXwxHUlvo9nkrvcsuz9+dP1FAnsekwFZW39lgI
kavWG90ScRkAMYljRielna+YohS+m5PhUOuICCB33/860rJfcFGSk3Tagrfomboc
Kr1BExKinjHRLz5O9S30gHjTGSwKCl5XSWK97ejMHDltO1dhoQwc3k/Cj39i11AA
crwJIvigzLRh1FK4MgTIEXvwWi4yFvG+gjks2WFK2TW7FbrOaa32/Yc2oeQI2vnm
kryAuhzARY/GJ4qX0rik
=LNx2
-----END PGP SIGNATURE-----

--24zk1gE8NUlDmwG9--

--===============6618098542536928457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6618098542536928457==--
