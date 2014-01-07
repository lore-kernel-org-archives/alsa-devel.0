From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 04/11] ASoC: fsl: Don't set unused
 struct snd_pcm_hardware fields
Date: Tue, 7 Jan 2014 11:40:41 +0000
Message-ID: <20140107114041.GB31886@sirena.org.uk>
References: <1389014356-7014-1-git-send-email-lars@metafoo.de>
 <1389014356-7014-4-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3744162704785567778=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 650A12616CB
 for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2014 12:40:53 +0100 (CET)
In-Reply-To: <1389014356-7014-4-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Nicolin Chen <b42378@freescale.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============3744162704785567778==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uG/WnAUw/ikUnuWp"
Content-Disposition: inline


--uG/WnAUw/ikUnuWp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 06, 2014 at 02:19:09PM +0100, Lars-Peter Clausen wrote:
> The ASoC core assumes that the PCM component of the ASoC card transparently
> moves data around and does not impose any restrictions on the memory layout or
> the transfer speed. It ignores all fields from the snd_pcm_hardware struct for
> the PCM driver that are related to this. Setting these fields in the PCM driver
> might suggest otherwise though, so rather not set them.

Applied, thanks.

--uG/WnAUw/ikUnuWp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSy+e1AAoJELSic+t+oim949EP/jUOqLSW/hoqsCkycxITHbvF
TJiGQieZdhYziYt1Xu/d3u02A14P02ngqz0ng9kjOh2rVbQX45eYTqFMRXEgmnbB
BUlb027uA/7X39n4mgruveDCM2qtWUqBqTgRRTHmDrHbRrOpiUoDCOWLBQHautqq
efFHsRxJ6fK1sXYQQZdLfdrXMbnlkPeFgwO81WSc5EMCpgDOaYW4Qi52Vv/l6+1I
sYhbAkANtq1Jhwamf5rPIOnmV85zikliMRPNdf7Gve9u6FXT7TLq1gIIiATKKkJb
mGd8cnd1wJRgooYx6j62zvgukBfQbv0ka06KGO1fSn+elDzlSWGMuu6gKz5B4g0H
HWSkDP34cIpdyzDdp70GfJBGQurMS+yt4p8zZ2J4j+oU+Z7cwL0MdraZrltmv5l/
Pxhn1vohJeRDJJzS7iDNVeH/YmzsvuxsIWu4KmxsvdSZzk9q11xIjQjS2Ho/kr28
+WcluomOxBy9e09N7CF5XR2+p9vmDj6RdS2iw2BQ+IO6SQb1cCgkJvITNNwKb10z
JuA5whiFlL0LWVaE+hOXiwWziC0ftVa8Q3bL2dNi3PP8ipHEgM9EF0ImHuzZ9HE8
p8gK0Qui7Sc+hRdylS8cERILeVM7uDYEFWrSdd1g0Jj3TJ6jcs6Owu+9DS+wTotr
JdXGSRkB7DJ0XbMVFeGB
=Qnu4
-----END PGP SIGNATURE-----

--uG/WnAUw/ikUnuWp--

--===============3744162704785567778==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3744162704785567778==--
