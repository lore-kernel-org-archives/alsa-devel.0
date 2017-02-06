From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: bcm2835: Increase channels_max to 8
Date: Mon, 6 Feb 2017 16:43:59 +0000
Message-ID: <20170206164359.vnyxa5iumtslxisy@sirena.org.uk>
References: <1485992264-9058-1-git-send-email-flatmax@flatmax.org>
 <20170204154944.timxhmmibc4kngly@sirena.org.uk>
 <a7f5de09-b07b-638d-466f-525e68ebf0f9@flatmax.org>
 <20170205163451.4x3svwbqdqlfc7t4@sirena.org.uk>
 <aa6b9cbd-e033-eee6-d7f8-8ba8c8e611ab@flatmax.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2584172491886472054=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B256A2654AD
 for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2017 17:44:13 +0100 (CET)
In-Reply-To: <aa6b9cbd-e033-eee6-d7f8-8ba8c8e611ab@flatmax.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Flax <flatmax@flatmax.org>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, phil@raspberrypi.org, Eric Anholt <eric@anholt.net>, Florian Meier <florian.meier@koalo.de>, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============2584172491886472054==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3urez7kboob6lfxd"
Content-Disposition: inline


--3urez7kboob6lfxd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 06, 2017 at 07:37:03AM +1100, Matt Flax wrote:
> On 06/02/17 03:34, Mark Brown wrote:

> > Looking at the driver it may be possible for the hardware to do DSP
> > modes at which point this gets much easier but right now it only has I2S
> > support, I've got a feeling that the other end of the link may actually
> > be running in a DSP mode.

> You've got it !

If you're actually using the device in DSP mode you need to be showing
that in the driver, not claiming that it's I2S.

> I haven't looked into why, but I am getting the correct channel mapping
> under the hood. To me that is a concern of the higher up levels of the ALSA
> driver - it was a pleasant surprise when it worked nicely, because to me it
> indicated a robustly coded system.

If the external device is running in DSP mode it'll work fine.

> My next patch is to allow DSP modes in this I2S driver. I wanted to make
> sure that this got through first however.

This is the wrong way round.

> The majority of these other concerns you mention are controlled at the
> machine driver level.

The driver should be checking for errors, it shouldn't be silently
accepting incorrect configurations - we shouldn't be forcing all the
machine drivers to replicate code for this, or requiring modifications
to machine drivers because a new feature has been added to one of the
drivers it uses.

--3urez7kboob6lfxd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliYp8sACgkQJNaLcl1U
h9AQVAf/WGKGFeKIMsYDqMneMGg8IdDwLYsXm4lnvcsyfisz2Nz+xIknFtodwvUn
ofySJfTLzHsFfr6NmTSK0K5sMlnwwlWZsWNPgwumnhS6asGPtInGgLSBpya1QQI9
Vz5HB1WBChKvQ+nkMJSnB3zDLwLV+0oeX/oQXlSg8z271Pe6vFToCBDmZ+MXNTv3
g+tD1EF4nU/i1snUlw++jZo1rchHJ/X5caVsb8xmv9RnA+XlNo08Pq8BZxUvMmeM
JBVIW/f3vaYM28pKp8hz4ZsoupnLVR19sFNHiyOSEO6C7+Avt6pg2hS9swKNjPUj
lyBlJQXIByk58ue3nVmM/wcBtwWS9A==
=+T/s
-----END PGP SIGNATURE-----

--3urez7kboob6lfxd--

--===============2584172491886472054==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2584172491886472054==--
