From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/4] ASoC: Add support for the Analog
	Devices AXI-I2S core
Date: Fri, 29 Nov 2013 11:58:30 +0000
Message-ID: <20131129115830.GT27568@sirena.org.uk>
References: <1385665372-29477-1-git-send-email-lars@metafoo.de>
 <1385665372-29477-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2194594215252388613=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id F094A26556D
 for <alsa-devel@alsa-project.org>; Fri, 29 Nov 2013 12:58:33 +0100 (CET)
In-Reply-To: <1385665372-29477-2-git-send-email-lars@metafoo.de>
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


--===============2194594215252388613==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fberPwKQctZF/fXp"
Content-Disposition: inline


--fberPwKQctZF/fXp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 28, 2013 at 08:02:50PM +0100, Lars-Peter Clausen wrote:

A few really minor things below.

> The patch also adds a simple ASoC PCM driver for the PL330 DMA controller using
> the generic dmaengine PCM driver. This driver is only temporary can be removed
> once we have all the infrastructure in place to query information like maximum
> transfer size directly from the dmaengine driver.

It's not really a driver as such, it's just specifying some extra
parameters - I'd expect you're going to need to keep the addresses at
least.  It's probably more accurate to say that at the minute there's
some assumptions in the driver about the DMA controller configuration
that will be required which should be removable in future?

> +config SND_SOC_ADI
> +	tristate "Audio support for Analog Devices reference designs"
> +	depends on SND_SOC && (MICROBLAZE || ARCH_ZYNQ || COMPILE_TEST)
> +	help
> +	  Audio support for various reference designs by Analog Devices.
> +

Given that this is a FPGA IP I'd also expect it to be available on
SOCFPGA and probably other things.  For the Designware I2S controller we
just don't have any platform dependency at all.

There's no need for the SND_SOC dependency, all the subdirectory
Kconfigs are only included in an if SND_SOC block.

> +	frame_size = AXI_I2S_BITS_PER_FRAME / 2 - 1;

This isn't obvious - usually the frame size is the number of bits per
frame.  Looking at the code I guess the hardware is more flexible than
the driver allows at the minute?

> +	regmap_write(i2s->regmap, AXI_I2S_REG_CLK_CTRL, (frame_size << 16) |
> +		bclk_div);

update_bits() would be more obvious, though for a memory mapped device
it really makes no difference.

--fberPwKQctZF/fXp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSmIFjAAoJELSic+t+oim9YLQP/Ar7nve6/cmN2i7kZd8nCDgE
r5+tZ7kse+xQ3asMciK0K8ykstQ4S2ZZbroyHsNb+7EwCmQl75Q/wCR0ZE7z7pIe
zRdHVMYQ9MGEdP/pcbv7DN6Y6QEY9Kj/UJHTRUrtF2md8NzzsMnKwIu3EKBGZeQC
YPvtm/oXAlbODhWtqFKy3sMMHB3baC/9B0ATgg9y4OWm2umoFAvqK+c2knXCXxFQ
ikfNNmDI4ed+Mk59kcrLaT6O0wUwmRQwIoCcYx8QfC3kYpLSvxbM9sVS/BmH7odf
IpfqGd3YARMrL9JPgsjvKBRz6bsOt2SFa3+s6nCoqWcP8FIkVspbZSoc7qpk7JGO
Vauzsh0UGHewpCjrej+sJfVqzsRH1Q6obxpdBWZV2pYS9IHPwyh19Zx/EgoVHYNs
TnbgtIZs8IED8UR9el6wT1VujVO4xjeC/4pHd0RUpls7a6tAVMcGiKsli36ptMD3
dJpdrgyg6Hfc4xPNz3dxI389ODYDEnq0ivw7mOoXQpoyRyzhsOVA4waV2nmADHhl
qLZYtrF6hrKw5LFgeENV27iMWsfj3h+66kyK30Lh0quelTGrv8I7gdlgzNVnQS5s
Z+JgH389ELuV9VfLCI6F7Y4QICaBu3GcVoRPhR+FI2BnlI6qsWdp3gPmMObrQ3Ju
tCJTsZLwH4zqN3odcMfH
=c8xD
-----END PGP SIGNATURE-----

--fberPwKQctZF/fXp--

--===============2194594215252388613==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2194594215252388613==--
