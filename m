From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH 1/2] alsa/soc: Fix typo in MPC5200 PSC AC97
	driver Kconfig
Date: Sun, 28 Jun 2009 14:06:32 -0400
Message-ID: <9e4733910906281106o6d61a6a6uef9023068415ec5e@mail.gmail.com>
References: <20090628074109.26905.9927.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.150])
	by alsa0.perex.cz (Postfix) with ESMTP id CD957245A5
	for <alsa-devel@alsa-project.org>;
	Sun, 28 Jun 2009 20:06:33 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 5so1607770qwf.56
	for <alsa-devel@alsa-project.org>; Sun, 28 Jun 2009 11:06:32 -0700 (PDT)
In-Reply-To: <20090628074109.26905.9927.stgit@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk, timur@freescale.com
List-Id: alsa-devel@alsa-project.org

On Sun, Jun 28, 2009 at 3:41 AM, Grant Likely<grant.likely@secretlab.ca> wr=
ote:
> From: Grant Likely <grant.likely@secretlab.ca>
>
> ALSA SoC drivers should be specify SND_SOC_AC97_BUS instead, not AC97_BUS.
> Without SND_SOC_AC97_BUS defined, an AC97 device will not get correctly
> registered on the AC97 bus, which prevents thinks like the WM9712
> touchscreen driver from getting probed.
>
> Tested against 2.6.31-rc1.
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Acked-by: Jon Smirl <jonsmirl@gmail.com>

> ---
>
> =A0sound/soc/fsl/Kconfig | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
>
> diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
> index 5dbebf8..5661876 100644
> --- a/sound/soc/fsl/Kconfig
> +++ b/sound/soc/fsl/Kconfig
> @@ -33,7 +33,7 @@ config SND_SOC_MPC5200_I2S
> =A0config SND_SOC_MPC5200_AC97
> =A0 =A0 =A0 =A0tristate "Freescale MPC5200 PSC in AC97 mode driver"
> =A0 =A0 =A0 =A0depends on PPC_MPC52xx && PPC_BESTCOMM
> - =A0 =A0 =A0 select AC97_BUS
> + =A0 =A0 =A0 select SND_SOC_AC97_BUS
> =A0 =A0 =A0 =A0select SND_MPC52xx_DMA
> =A0 =A0 =A0 =A0select PPC_BESTCOMM_GEN_BD
> =A0 =A0 =A0 =A0help
>
>



-- =

Jon Smirl
jonsmirl@gmail.com
