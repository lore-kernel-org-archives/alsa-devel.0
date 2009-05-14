From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH V1 00/13] mpc5200 audio rework for AC97
Date: Wed, 13 May 2009 21:34:18 -0600
Message-ID: <fa686aa40905132034k2e45a06cibc2ac1b4c2bd4cd5@mail.gmail.com>
References: <20090514015729.28145.30483.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.157])
	by alsa0.perex.cz (Postfix) with ESMTP id 1BEEE24403
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 05:34:39 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 4so747918ywq.2
	for <alsa-devel@alsa-project.org>; Wed, 13 May 2009 20:34:38 -0700 (PDT)
In-Reply-To: <20090514015729.28145.30483.stgit@terra>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@sirena.org.uk
List-Id: alsa-devel@alsa-project.org

On Wed, May 13, 2009 at 7:58 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
> The following series implements audio support for the
> mpc5200. It adds an AC97 driver and STAC9766 codec
> driver. Board support for the Efika and Phytec pcm030
> are also included. I'm sure everyone will have some
> edits on this first version.

BTW, please also cc: the linuxppc-dev mailing list for the next issue
of this series.

Thanks,
g.

>
> ---
>
> Jon Smirl (13):
> =A0 =A0 =A0Support for AC97 on Phytec pmc030 base board.
> =A0 =A0 =A0Fabric bindings for STAC9766 on the Efika
> =A0 =A0 =A0AC97 driver for mpc5200
> =A0 =A0 =A0Codec for STAC9766 used on the Efika
> =A0 =A0 =A0Main rewite of the mpc5200 audio DMA code
> =A0 =A0 =A0Have the WM9712 driver self register itself
> =A0 =A0 =A0Add SNDRV_PCM_FMTBIT_S32_BE as a valid AC97 format
> =A0 =A0 =A0Allow a custom ASOC fabric driver with soc-of-simple
> =A0 =A0 =A0Add a few more mpc5200 PSC defines
> =A0 =A0 =A0redo 2008f137e92220b98120c4803499cdddb2b0fb06
> =A0 =A0 =A0Rename the PSC functions to DMA
> =A0 =A0 =A0Basic split of mpc5200 DMA code out from mpc5200_psc_i2s
> =A0 =A0 =A0Temporarily undo 2008f137e92220b98120c4803499cdddb2b0fb06
>
>
> =A0arch/powerpc/boot/dts/pcm030.dts =A0 =A0 =A0 | =A0 =A08
> =A0arch/powerpc/include/asm/mpc52xx_psc.h | =A0 10
> =A0arch/powerpc/platforms/52xx/efika.c =A0 =A0| =A0 =A08
> =A0include/sound/soc-dai.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A03
> =A0include/sound/soc-of-simple.h =A0 =A0 =A0 =A0 =A0| =A0 16 +
> =A0sound/last.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A06
> =A0sound/soc/codecs/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A04
> =A0sound/soc/codecs/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02
> =A0sound/soc/codecs/stac9766.c =A0 =A0 =A0 =A0 =A0 =A0| =A0491 ++++++++++=
++++++++++++
> =A0sound/soc/codecs/stac9766.h =A0 =A0 =A0 =A0 =A0 =A0| =A0 21 +
> =A0sound/soc/codecs/tlv320aic26.c =A0 =A0 =A0 =A0 | =A0 =A02
> =A0sound/soc/codecs/wm9712.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 34 ++
> =A0sound/soc/fsl/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 30 +
> =A0sound/soc/fsl/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A06
> =A0sound/soc/fsl/efika-audio-fabric.c =A0 =A0 | =A0 95 ++++
> =A0sound/soc/fsl/mpc5200_dma.c =A0 =A0 =A0 =A0 =A0 =A0| =A0693 ++++++++++=
+++++++++++++++++++++
> =A0sound/soc/fsl/mpc5200_dma.h =A0 =A0 =A0 =A0 =A0 =A0| =A0 83 ++++
> =A0sound/soc/fsl/mpc5200_psc_ac97.c =A0 =A0 =A0 | =A0379 +++++++++++++++++
> =A0sound/soc/fsl/mpc5200_psc_ac97.h =A0 =A0 =A0 | =A0 13 +
> =A0sound/soc/fsl/mpc5200_psc_i2s.c =A0 =A0 =A0 =A0| =A0707 +-------------=
------------------
> =A0sound/soc/fsl/soc-of-simple.c =A0 =A0 =A0 =A0 =A0| =A0160 ++++++-
> =A021 files changed, 2053 insertions(+), 718 deletions(-)
> =A0create mode 100644 sound/soc/codecs/stac9766.c
> =A0create mode 100644 sound/soc/codecs/stac9766.h
> =A0create mode 100644 sound/soc/fsl/efika-audio-fabric.c
> =A0create mode 100644 sound/soc/fsl/mpc5200_dma.c
> =A0create mode 100644 sound/soc/fsl/mpc5200_dma.h
> =A0create mode 100644 sound/soc/fsl/mpc5200_psc_ac97.c
> =A0create mode 100644 sound/soc/fsl/mpc5200_psc_ac97.h
>
> --
> Jon Smirl
> jonsmirl@gmail.com
>



-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
