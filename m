From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH 2/2] sound/soc: remove BROKEN from Efika
	and pcm030 fabric drivers
Date: Sun, 28 Jun 2009 14:06:50 -0400
Message-ID: <9e4733910906281106s5ecdfd4fl7a54de3a605823ec@mail.gmail.com>
References: <20090628074109.26905.9927.stgit@localhost.localdomain>
	<20090628074158.26905.36950.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.150])
	by alsa0.perex.cz (Postfix) with ESMTP id A1618245B7
	for <alsa-devel@alsa-project.org>;
	Sun, 28 Jun 2009 20:06:50 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 5so1607770qwf.56
	for <alsa-devel@alsa-project.org>; Sun, 28 Jun 2009 11:06:50 -0700 (PDT)
In-Reply-To: <20090628074158.26905.36950.stgit@localhost.localdomain>
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

On Sun, Jun 28, 2009 at 3:42 AM, Grant Likely<grant.likely@secretlab.ca> wr=
ote:
> From: Grant Likely <grant.likely@secretlab.ca>
>
> The needed spin_event_timeout() macro is now merged in from the
> powerpc tree, so these drivers are no longer broken. =A0This reverts
> commit 0c0e09e21a9e7bc6ca54e06ef3d497255ca26383 (ASoC: Mark MPC5200
> AC97 as BROKEN until PowerPC merge issues are resolved)
>
> Tested against 2.6.31-rc1.
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Acked-by: Jon Smirl <jonsmirl@gmail.com>

> ---
>
> =A0sound/soc/fsl/Kconfig | =A0 =A04 ++--
> =A01 files changed, 2 insertions(+), 2 deletions(-)
>
>
> diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
> index 5661876..8cb65cc 100644
> --- a/sound/soc/fsl/Kconfig
> +++ b/sound/soc/fsl/Kconfig
> @@ -41,7 +41,7 @@ config SND_SOC_MPC5200_AC97
>
> =A0config SND_MPC52xx_SOC_PCM030
> =A0 =A0 =A0 =A0tristate "SoC AC97 Audio support for Phytec pcm030 and WM9=
712"
> - =A0 =A0 =A0 depends on PPC_MPC5200_SIMPLE && BROKEN
> + =A0 =A0 =A0 depends on PPC_MPC5200_SIMPLE
> =A0 =A0 =A0 =A0select SND_SOC_MPC5200_AC97
> =A0 =A0 =A0 =A0select SND_SOC_WM9712
> =A0 =A0 =A0 =A0help
> @@ -50,7 +50,7 @@ config SND_MPC52xx_SOC_PCM030
>
> =A0config SND_MPC52xx_SOC_EFIKA
> =A0 =A0 =A0 =A0tristate "SoC AC97 Audio support for bbplan Efika and STAC=
9766"
> - =A0 =A0 =A0 depends on PPC_EFIKA && BROKEN
> + =A0 =A0 =A0 depends on PPC_EFIKA
> =A0 =A0 =A0 =A0select SND_SOC_MPC5200_AC97
> =A0 =A0 =A0 =A0select SND_SOC_STAC9766
> =A0 =A0 =A0 =A0help
>
>



-- =

Jon Smirl
jonsmirl@gmail.com
