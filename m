From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: bcm2835: Increase channels_max to 8
Date: Sun, 5 Feb 2017 17:34:51 +0100
Message-ID: <20170205163451.4x3svwbqdqlfc7t4@sirena.org.uk>
References: <1485992264-9058-1-git-send-email-flatmax@flatmax.org>
 <20170204154944.timxhmmibc4kngly@sirena.org.uk>
 <a7f5de09-b07b-638d-466f-525e68ebf0f9@flatmax.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7590406053490894047=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 272C72669BF
 for <alsa-devel@alsa-project.org>; Sun,  5 Feb 2017 17:35:47 +0100 (CET)
In-Reply-To: <a7f5de09-b07b-638d-466f-525e68ebf0f9@flatmax.org>
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


--===============7590406053490894047==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hiorppe4vfvbif75"
Content-Disposition: inline


--hiorppe4vfvbif75
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 05, 2017 at 12:26:31PM +1100, Matt Flax wrote:
> On 05/02/17 02:49, Mark Brown wrote:
> > On Thu, Feb 02, 2017 at 10:37:44AM +1100, Matt Flax wrote:

> > I can't understand how this works.  We're programming the hardware in an
> > identical fashion for both channel counts, that means that what we're

> I am not surprised it is confusing, to my knowledge this is the first time
> that someone has demonstrated this type of I2S signalling.

More than stereo I2S?  That is actually a thing, while most people use
DSP modes for higher channel counts it's fairly common to have the
support especially in CODECs that also support DSP mode since the
hardware implementation is fairly straightforward if you abstracted in
the bus interface.

> In this case BCM2835 is a clock slave and not concerned with generating the
> I2S clocks, only receiving - think of all clocks and synchrony being
> generated/managed in hardware on the sound card.

> In short the BCM2835 silicon is only concerned with shifting bits into two
> hardware registers which (after DMA) are interpreted by ALSA according to
> the specified channel count.

Sure, that's what all audio controllers do.  But there's a few problems.
One is that nothing in your code that prevents this running in master
mode.  Another is that if this *is* for I2S mode then when doing
multichannel I2S you usually still respect the left/right indication in
LRCLK so you will end up with the data in the in memory format:

  L1 R1 L2 R2 L3 R3 L4 R4

but multi channel I2S would usually be rendered with all the left
channels and all the right channels grouped together so you get:

  L1 L2 L3 L4 R1 R2 R3 R4

It'll also require exact clocking with no spare bits in order to sync
the right channels with the LRCLK switch but that's not so unusual.
Looking at the driver it may be possible for the hardware to do DSP
modes at which point this gets much easier but right now it only has I2S
support, I've got a feeling that the other end of the link may actually
be running in a DSP mode.

--hiorppe4vfvbif75
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliXVCsACgkQJNaLcl1U
h9A0Tgf8Db3+D5PLNDhkdDhR8gjR3wIp8Qxm3R17BZLZ/pREXo5eVpwkn2IBMu6a
gDT12bHZcb9CxHLlBYlaR9Cltmfb0Si993cYOtKSdvWE18p5VEn7HAaW7g/Aj+MZ
LsDdEfgr69rwgm+0a84q4faDAT8EG6lc3+f0pie0VKgcSc7GLCXs5hn2hThPP+oX
t86eDqnLO2ACaDHgJCcCDC3h8grutUQl/GqnuHR5nyi8xQIgjIEH3d8hMvdQQ4cu
m3Kvhyo7/5W0CiRpflq7pWnHyr9qlkrugxmIcBsLz7UfWUmFPVvR8Ip2Z7cGw5G/
9PRkGDwfGykX+W+NzNk3CLtSoPGDfA==
=kHKY
-----END PGP SIGNATURE-----

--hiorppe4vfvbif75--

--===============7590406053490894047==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7590406053490894047==--
