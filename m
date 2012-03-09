From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: core: Rename card mutex subclass
 to better align with usage.
Date: Fri, 9 Mar 2012 12:48:37 +0000
Message-ID: <20120309124836.GX3273@opensource.wolfsonmicro.com>
References: <1331294528-27350-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1980861041586700657=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EE07410BC81
	for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2012 13:48:38 +0100 (CET)
In-Reply-To: <1331294528-27350-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1980861041586700657==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="je0mZywpqEo4t1RU"
Content-Disposition: inline


--je0mZywpqEo4t1RU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 09, 2012 at 12:02:07PM +0000, Liam Girdwood wrote:
> Change SND_SOC_CARD_CLASS_PCM to SND_SOC_CARD_CLASS_RUNTIME to better
> describe all uses for this mutex subclass and align with DAPM too.

Applied both, thanks.

--je0mZywpqEo4t1RU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPWfv+AAoJEBus8iNuMP3dEZYP/RalcIfZA2VFKbOP3RrlJ2x9
5DWlFj7oFmNGSbpJZ6An2F9ma1rumM9F9YYl3A3ZUmxH7iWnFfl8EC05n+vtlBS4
Iu4dcz1j7mutaW/rR+KMoNDjDE2eWvliXc7f2E0hII+/LmSlIPwMTbJho7IOlmVY
WcTdSB95oKIAKVD47Iim1mXzp2V3N3R3F00Rwltzf9TKRX3r+izs1jInY5tWu1hv
r0gF4QhqOYNqmqqV7wRSkEqvfqkQKQ0FsbWTg9IqIKSyNbgn9DJHtSFbSWq4UiUZ
jVUJ+VyA2dnqikTmYJ7LZdc+RnNPaNmO9NUj55oUJZey4WHX3P6zwbxBb/uTJFaT
m5A3Xf0ulCeJNFWFAD85L83klNu+nL/ei4+yKld1icSMdz/DT8eJCgXXhn9hejrG
HQPLCA7k9l+DIjgPOj4+5xeAZ+WEIFXd+ygSLI2YRSMMCewgy4MSe0GoKYo9J9N1
7hxEHW2rYygUgxPUxLSd1w3pNtRPOUlH834FW0clQIRxqTFCYSMxp4r084EIiZOr
mjBq2q57RoAy9S2ednKOli4NLLEOO0B3H07qGdtVoCUZZ0wB3wAcz1wBh5Koa2c0
zDL/vlMz/ELV0uQ8evO3vVMn0WCtYOGQvnnHtpQST3GXRN7tNM/cI+RgRhhCb9vM
jFbNxaNVJ66zeERnwfwQ
=USBw
-----END PGP SIGNATURE-----

--je0mZywpqEo4t1RU--

--===============1980861041586700657==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1980861041586700657==--
