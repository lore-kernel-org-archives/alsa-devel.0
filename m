From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/3] mfd: mc13xxx: Move SPI erratum workaround into SPI
 I/O function
Date: Wed, 25 Sep 2013 12:19:54 +0100
Message-ID: <20130925111954.GG5132@lee--X1>
References: <1379960073-23245-1-git-send-email-broonie@kernel.org>
 <1379960073-23245-2-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1379960073-23245-2-git-send-email-broonie@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 23 Sep 2013, Mark Brown wrote:

> From: Mark Brown <broonie@linaro.org>
>=20
> Move the workaround for double sending AUDIO_CODEC and AUDIO_DAC writ=
es
> into the SPI core, aiding refactoring to eliminate the ASoC custom I/=
O
> functions and avoiding the extra writes for I2C.
>=20
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  drivers/mfd/mc13xxx-spi.c   | 5 +++++
>  include/linux/mfd/mc13xxx.h | 7 +++++++
>  sound/soc/codecs/mc13783.c  | 4 ----
>  3 files changed, 12 insertions(+), 4 deletions(-)

I assume this is okay to go in via the MFD tree.

I've applied it until you say otherwise.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
