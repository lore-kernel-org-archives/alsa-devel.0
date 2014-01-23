From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: codecs: Make OF supported CODECs
 visible	in Kconfig
Date: Thu, 23 Jan 2014 13:22:40 +0000
Message-ID: <20140123132240.GM17314@sirena.org.uk>
References: <1390481947-4325-1-git-send-email-broonie@kernel.org>
 <s5hmwimu9dt.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1324234387004339534=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8882D2625D4
 for <alsa-devel@alsa-project.org>; Thu, 23 Jan 2014 14:22:51 +0100 (CET)
In-Reply-To: <s5hmwimu9dt.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1324234387004339534==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FcSIktkEp0oIiTkb"
Content-Disposition: inline


--FcSIktkEp0oIiTkb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 23, 2014 at 02:15:42PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > It may also be desirable to hide these if OF is not enabled to reduce
> > noise.

> IIRC, you can write like:

> config SND_SOC_ADAU1701
> 	tristate "Analog Devices ADAU1701 CODEC" if OF
> 	depends on I2C

> so that it's visible only when CONFIG_OF is set.

Yes, or use a proxy symbol so we can add ACPI easily as well in due
course without having to go through and update every device again - that
was the main thing really.

--FcSIktkEp0oIiTkb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS4RedAAoJELSic+t+oim98qkP+gNd7LIyJ2Mtucme0MFBazzI
QIIWOH3Y9DRUSmAjGbaPwahFf61062mHYi9TU4bTcwm4CO8ocfJsqh3yP4VNl+Jh
jDM6l6sD4glM0gdoVoDsbKGOzewAH1GlrHsfMNq2uym6NjvP4FmkuaNrmRJarRzU
mIOs9otmSMrG3mmb6vUv0PWCJXmXwWRTn+v1r2nusEINtkz/EcYsgoI/odWdEviz
UEf0D7AUwZO3sjjeve5spJOKTulzEqfsyHW3Uq+C2v1euKeKQqMbNNWLAdPZ8uzG
g0rYxkFWgFB1cPJFrAST1YLfSVdTMp6qMNJVrj0tcHxMbB3JLX0F3kmQILE1qKxK
yTsDKQo6c2PBQEccQjMmMWPtQsNGA5c/wzWY+quC6yrUL/FZEfWx5QpP9W/oyW6Z
drsR0AssJg1EKh0G9p6X4YX+l5S+doKjm0FXngiGUzKkwiUNzkbmuRoB5yb4TPjA
UoVb0k1655P8yPIhngvyuw+pa7DPtqst6UIJPFc6TfDW8phlI/zwZFBRHrCeDdHy
vwFRS069m0KTyBPmfuaNtQYyXn18otK3wtoVeJQljaYFXqn3dvnZ9XIMyrG5PBl7
d75DjSevgP6BUvNvPnJvSiEn7czzMjJu1dmimI9/HJq3Eb9m6l+q8tmrYhYpklx5
uRqNglDO31lGqbWHaTMS
=YTWw
-----END PGP SIGNATURE-----

--FcSIktkEp0oIiTkb--

--===============1324234387004339534==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1324234387004339534==--
