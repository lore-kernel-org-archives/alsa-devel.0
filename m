From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/3] mfd: mc13xxx: Don't require lock for simple register
 I/O
Date: Wed, 25 Sep 2013 12:19:03 +0100
Message-ID: <20130925111903.GF5132@lee--X1>
References: <1379960073-23245-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1379960073-23245-1-git-send-email-broonie@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 23 Sep 2013, Mark Brown wrote:

> From: Mark Brown <broonie@linaro.org>
>=20
> Since the conversion to regmap there has been no need for device leve=
l
> locking for I/O as regmap provides locking so remove the locks.
>=20
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  drivers/mfd/mc13xxx-core.c | 5 -----
>  1 file changed, 5 deletions(-)

Applied, thanks.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
