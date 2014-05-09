From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] mfd: mc13xxx: Do not use platform data with
 devicetree
Date: Fri, 9 May 2014 15:30:55 +0100
Message-ID: <20140509143054.GN12304@sirena.org.uk>
References: <1398926883-21778-1-git-send-email-shc_work@mail.ru>
 <20140509113030.GV5767@lee--X1>
 <1399643769.716496780@f345.i.mail.ru>
 <20140509141840.GZ5767@lee--X1>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9MgESfyIxxlgQ3EF"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140509141840.GZ5767@lee--X1>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Alexander Shiyan <shc_work@mail.ru>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Samuel Ortiz <sameo@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


--9MgESfyIxxlgQ3EF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 09, 2014 at 03:18:40PM +0100, Lee Jones wrote:

> You need to revert (or remove) the original one and apply:

>   "ASoC: mc13783: Add devicetree support"

> ... instead.

Why not just pull the tag instead?  I haven't looked at the patch but
don't they need to go in together anyway.

--9MgESfyIxxlgQ3EF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTbOabAAoJELSic+t+oim9b3gP/iOX9Td2a1G0bMO6eAlTJ5bf
+n5SZjqp3alHMniEon8L7pu4hOExAfj82GdsN8ZkFdIUGpGGkk8vDxkat/CkCBGV
ssVLUNOMlQkuaFxHq7/Hded7mYRbfGt6tQUqLitcA/LKt6PN+hoW/GPehB+q4SS8
8HDy/a/KrT1KvuhN6NQsM5FhlMxUxL1yBhKA/E9kTIyZaKujS6m7iJDQLpkYQf5X
FE+Ngb3qmcEFc3E/n2/0AAxOmdBMhGfE9RcSPNPR/STDaf9wAXZKVxSpn8jUXkmm
jnPwAppq/RkcfL0UN9amWuNoMhBwvpgOt2tlos+qFuDWdSZGl53QIruJml1gaH32
27QekKFMVHjU8GpiOybUVRtaw2pEdNYZ3Ef4ZByC7ayOSGW76y1laPMRs2kpL5wi
JMl5r0c0ZsET2w2ZUxpwEN3yA3mONwUOtMaCPX0neEkM8DEn0bG4xzRm8xPtbaKF
yw1Ju0CXQsDu+TAHw+Zxd2FzSa7XWqRwkqiTHxpo4oZkKcKvQve26caWJNMhDCDA
fRfK4yMU/9JNltDemAMWC3VHaE4dpGu3LrAIeTVTNCce3gEoR6riSQU+6si7LPD/
m1cGGCQIscQQcq2jb6C2/vjO4RKW4M4zL7JSamyZ3b6/HLA+BFQiYyuWT/hEVMIE
OTbKUXv6G9B004FsgALU
=iXl+
-----END PGP SIGNATURE-----

--9MgESfyIxxlgQ3EF--
