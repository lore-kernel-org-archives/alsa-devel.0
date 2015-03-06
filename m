From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6/8] ASoC: Intel: add function to set
 parameter to sound effect module waves
Date: Fri, 6 Mar 2015 11:33:26 +0000
Message-ID: <20150306113326.GJ21293@sirena.org.uk>
References: <1425281778-17513-1-git-send-email-han.lu@intel.com>
 <1425281778-17513-6-git-send-email-han.lu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0795285018149474346=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2284A2605B0
 for <alsa-devel@alsa-project.org>; Fri,  6 Mar 2015 12:33:32 +0100 (CET)
In-Reply-To: <1425281778-17513-6-git-send-email-han.lu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: han.lu@intel.com
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============0795285018149474346==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aY8BuQ/AtRsvoRhf"
Content-Disposition: inline


--aY8BuQ/AtRsvoRhf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 02, 2015 at 03:36:16PM +0800, han.lu@intel.com wrote:

> +	if (ret < 0)
> +		dev_err(dev, "ipc: module set parameter failed - %d\n", ret);
> +	else
> +		dev_info(dev, "ipc: module set parameter success\n");

Logging on error is good but logging every time someone sets a control
is going to get too noisy, please remove the print there.

--aY8BuQ/AtRsvoRhf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU+ZCGAAoJECTWi3JdVIfQafYH/0cqNNvEC0nBSMxvfqvHwwgD
yaToTptPW0EuIudMigPwGP2kPfMkqGVyg9EWfaC9YUJZVYwCMJ0GeEgaZYtJYP6v
1eNsh/Tc7GwnYJquQL9zp3E1EeIbTfuRtoowNB7/iqA+OKrafxhqZ8EPJ8RdT5Yx
Gw9vuvd28m6H/A9nZAkqAbLwy4mX0A/LFeVpACQEWJC+SFa9w35opfJZMj+Lyl68
R5WZl/s8FABOxhYtxDijuVBTz5WYzTlMuOl8M0N8cDwB83VOoOyN6aOlFL855qF4
JdUWoRVoashSIJX94Wa4xLpgrYa0KXn/98rw0Uy+e/ETVXmoyL2UXTc8sYl6V7Y=
=ZIjl
-----END PGP SIGNATURE-----

--aY8BuQ/AtRsvoRhf--

--===============0795285018149474346==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0795285018149474346==--
