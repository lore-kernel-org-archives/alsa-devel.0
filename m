From: pHilipp Zabel <philipp.zabel@gmail.com>
Subject: Re: [RFC PATCH 5/5] ASoC: simplify the SSP DMA
	parameters settings by run-time generation
Date: Thu, 23 Apr 2009 10:53:58 +0200
Message-ID: <74d0deb30904230153l5ec490eck211d6ef456869f36@mail.gmail.com>
References: <f17812d70904222208i79604f3evb9950d6351377a83@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f166.google.com (mail-ew0-f166.google.com
	[209.85.219.166])
	by alsa0.perex.cz (Postfix) with ESMTP id E0D6E103845
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Apr 2009 10:53:58 +0200 (CEST)
Received: by ewy10 with SMTP id 10so405474ewy.32
	for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2009 01:53:58 -0700 (PDT)
In-Reply-To: <f17812d70904222208i79604f3evb9950d6351377a83@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: alsa-devel@alsa-project.org, Paul Shen <bshen9@marvell.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 23, 2009 at 7:08 AM, Eric Miao <eric.y.miao@gmail.com> wrote:
> The SSP DMA parameters can actually be easily generated at run-time since
> they are almost similar except for the FIFO width and direction. Another
> benefit is the re-use of information from 'struct ssp_device', like SSDR
> physical FIFO address and DRCMR register index for both directions.

Yes, that does look a lot better.

> Signed-off-by: Eric Miao <eric.miao@marvell.com>
> ---
> =A0sound/soc/pxa/pxa-ssp.c | =A0206 ++++++++++---------------------------=
----------
> =A01 files changed, 43 insertions(+), 163 deletions(-)
>
> diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
> index 2ce4fb6..fb7235b 100644
> --- a/sound/soc/pxa/pxa-ssp.c
> +++ b/sound/soc/pxa/pxa-ssp.c
> @@ -50,139 +50,6 @@ struct ssp_priv {
> =A0#endif
> =A0};
>
> -#define PXA2xx_SSP1_BASE =A0 =A0 =A0 0x41000000
> -#define PXA27x_SSP2_BASE =A0 =A0 =A0 0x41700000
> -#define PXA27x_SSP3_BASE =A0 =A0 =A0 0x41900000
> -#define PXA3xx_SSP4_BASE =A0 =A0 =A0 0x41a00000
> -
> -static struct pxa2xx_pcm_dma_params pxa_ssp1_pcm_mono_out =3D {
> - =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D "SSP1 PCM Mon=
o out",
> - =A0 =A0 =A0 .dev_addr =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D PXA2xx_SSP1_BASE =
+ SSDR,
> - =A0 =A0 =A0 .drcmr =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D &DRCMR(14),
> - =A0 =A0 =A0 .dcmd =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D DCMD_INCSRCAD=
DR | DCMD_FLOWTRG |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DCMD_BU=
RST16 | DCMD_WIDTH2,
> -};
> -
> -static struct pxa2xx_pcm_dma_params pxa_ssp1_pcm_mono_in =3D {
> - =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D "SSP1 PCM Mon=
o in",
> - =A0 =A0 =A0 .dev_addr =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D PXA2xx_SSP1_BASE =
+ SSDR,
> - =A0 =A0 =A0 .drcmr =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D &DRCMR(13),
> - =A0 =A0 =A0 .dcmd =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D DCMD_INCTRGAD=
DR | DCMD_FLOWSRC |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DCMD_BU=
RST16 | DCMD_WIDTH2,
> -};
> -
> -static struct pxa2xx_pcm_dma_params pxa_ssp1_pcm_stereo_out =3D {
> - =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D "SSP1 PCM Ste=
reo out",
> - =A0 =A0 =A0 .dev_addr =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D PXA2xx_SSP1_BASE =
+ SSDR,
> - =A0 =A0 =A0 .drcmr =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D &DRCMR(14),
> - =A0 =A0 =A0 .dcmd =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D DCMD_INCSRCAD=
DR | DCMD_FLOWTRG |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DCMD_BU=
RST16 | DCMD_WIDTH4,
> -};
> -
> -static struct pxa2xx_pcm_dma_params pxa_ssp1_pcm_stereo_in =3D {
> - =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D "SSP1 PCM Ste=
reo in",
> - =A0 =A0 =A0 .dev_addr =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D PXA2xx_SSP1_BASE =
+ SSDR,
> - =A0 =A0 =A0 .drcmr =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D &DRCMR(13),
> - =A0 =A0 =A0 .dcmd =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D DCMD_INCTRGAD=
DR | DCMD_FLOWSRC |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DCMD_BU=
RST16 | DCMD_WIDTH4,
> -};
> -
> -static struct pxa2xx_pcm_dma_params pxa_ssp2_pcm_mono_out =3D {
> - =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D "SSP2 PCM Mon=
o out",
> - =A0 =A0 =A0 .dev_addr =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D PXA27x_SSP2_BASE =
+ SSDR,
> - =A0 =A0 =A0 .drcmr =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D &DRCMR(16),
> - =A0 =A0 =A0 .dcmd =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D DCMD_INCSRCAD=
DR | DCMD_FLOWTRG |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DCMD_BU=
RST16 | DCMD_WIDTH2,
> -};
> -
> -static struct pxa2xx_pcm_dma_params pxa_ssp2_pcm_mono_in =3D {
> - =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D "SSP2 PCM Mon=
o in",
> - =A0 =A0 =A0 .dev_addr =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D PXA27x_SSP2_BASE =
+ SSDR,
> - =A0 =A0 =A0 .drcmr =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D &DRCMR(15),
> - =A0 =A0 =A0 .dcmd =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D DCMD_INCTRGAD=
DR | DCMD_FLOWSRC |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DCMD_BU=
RST16 | DCMD_WIDTH2,
> -};
> -
> -static struct pxa2xx_pcm_dma_params pxa_ssp2_pcm_stereo_out =3D {
> - =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D "SSP2 PCM Ste=
reo out",
> - =A0 =A0 =A0 .dev_addr =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D PXA27x_SSP2_BASE =
+ SSDR,
> - =A0 =A0 =A0 .drcmr =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D &DRCMR(16),
> - =A0 =A0 =A0 .dcmd =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D DCMD_INCSRCAD=
DR | DCMD_FLOWTRG |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DCMD_BU=
RST16 | DCMD_WIDTH4,
> -};
> -
> -static struct pxa2xx_pcm_dma_params pxa_ssp2_pcm_stereo_in =3D {
> - =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D "SSP2 PCM Ste=
reo in",
> - =A0 =A0 =A0 .dev_addr =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D PXA27x_SSP2_BASE =
+ SSDR,
> - =A0 =A0 =A0 .drcmr =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D &DRCMR(15),
> - =A0 =A0 =A0 .dcmd =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D DCMD_INCTRGAD=
DR | DCMD_FLOWSRC |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DCMD_BU=
RST16 | DCMD_WIDTH4,
> -};
> -
> -static struct pxa2xx_pcm_dma_params pxa_ssp3_pcm_mono_out =3D {
> - =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D "SSP3 PCM Mon=
o out",
> - =A0 =A0 =A0 .dev_addr =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D PXA27x_SSP3_BASE =
+ SSDR,
> - =A0 =A0 =A0 .drcmr =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D &DRCMR(67),
> - =A0 =A0 =A0 .dcmd =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D DCMD_INCSRCAD=
DR | DCMD_FLOWTRG |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DCMD_BU=
RST16 | DCMD_WIDTH2,
> -};
> -
> -static struct pxa2xx_pcm_dma_params pxa_ssp3_pcm_mono_in =3D {
> - =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D "SSP3 PCM Mon=
o in",
> - =A0 =A0 =A0 .dev_addr =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D PXA27x_SSP3_BASE =
+ SSDR,
> - =A0 =A0 =A0 .drcmr =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D &DRCMR(66),
> - =A0 =A0 =A0 .dcmd =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D DCMD_INCTRGAD=
DR | DCMD_FLOWSRC |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DCMD_BU=
RST16 | DCMD_WIDTH2,
> -};
> -
> -static struct pxa2xx_pcm_dma_params pxa_ssp3_pcm_stereo_out =3D {
> - =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D "SSP3 PCM Ste=
reo out",
> - =A0 =A0 =A0 .dev_addr =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D PXA27x_SSP3_BASE =
+ SSDR,
> - =A0 =A0 =A0 .drcmr =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D &DRCMR(67),
> - =A0 =A0 =A0 .dcmd =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D DCMD_INCSRCAD=
DR | DCMD_FLOWTRG |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DCMD_BU=
RST16 | DCMD_WIDTH4,
> -};
> -
> -static struct pxa2xx_pcm_dma_params pxa_ssp3_pcm_stereo_in =3D {
> - =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D "SSP3 PCM Ste=
reo in",
> - =A0 =A0 =A0 .dev_addr =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D PXA27x_SSP3_BASE =
+ SSDR,
> - =A0 =A0 =A0 .drcmr =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D &DRCMR(66),
> - =A0 =A0 =A0 .dcmd =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D DCMD_INCTRGAD=
DR | DCMD_FLOWSRC |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DCMD_BU=
RST16 | DCMD_WIDTH4,
> -};
> -
> -static struct pxa2xx_pcm_dma_params pxa_ssp4_pcm_mono_out =3D {
> - =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D "SSP4 PCM Mon=
o out",
> - =A0 =A0 =A0 .dev_addr =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D PXA3xx_SSP4_BASE =
+ SSDR,
> - =A0 =A0 =A0 .drcmr =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D &DRCMR(67),
> - =A0 =A0 =A0 .dcmd =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D DCMD_INCSRCAD=
DR | DCMD_FLOWTRG |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DCMD_BU=
RST16 | DCMD_WIDTH2,
> -};
> -
> -static struct pxa2xx_pcm_dma_params pxa_ssp4_pcm_mono_in =3D {
> - =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D "SSP4 PCM Mon=
o in",
> - =A0 =A0 =A0 .dev_addr =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D PXA3xx_SSP4_BASE =
+ SSDR,
> - =A0 =A0 =A0 .drcmr =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D &DRCMR(66),
> - =A0 =A0 =A0 .dcmd =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D DCMD_INCTRGAD=
DR | DCMD_FLOWSRC |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DCMD_BU=
RST16 | DCMD_WIDTH2,
> -};
> -
> -static struct pxa2xx_pcm_dma_params pxa_ssp4_pcm_stereo_out =3D {
> - =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D "SSP4 PCM Ste=
reo out",
> - =A0 =A0 =A0 .dev_addr =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D PXA3xx_SSP4_BASE =
+ SSDR,
> - =A0 =A0 =A0 .drcmr =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D &DRCMR(67),
> - =A0 =A0 =A0 .dcmd =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D DCMD_INCSRCAD=
DR | DCMD_FLOWTRG |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DCMD_BU=
RST16 | DCMD_WIDTH4,
> -};
> -
> -static struct pxa2xx_pcm_dma_params pxa_ssp4_pcm_stereo_in =3D {
> - =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D "SSP4 PCM Ste=
reo in",
> - =A0 =A0 =A0 .dev_addr =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D PXA3xx_SSP4_BASE =
+ SSDR,
> - =A0 =A0 =A0 .drcmr =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D &DRCMR(66),
> - =A0 =A0 =A0 .dcmd =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D DCMD_INCTRGAD=
DR | DCMD_FLOWSRC |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DCMD_BU=
RST16 | DCMD_WIDTH4,
> -};
> -
> =A0static void dump_registers(struct ssp_device *ssp)
> =A0{
> =A0 =A0 =A0 =A0dev_dbg(&ssp->pdev->dev, "SSCR0 0x%08x SSCR1 0x%08x SSTO 0=
x%08x\n",
> @@ -194,25 +61,33 @@ static void dump_registers(struct ssp_device *ssp)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ssp_read_reg(ssp, SSACD));
> =A0}
>
> -static struct pxa2xx_pcm_dma_params *ssp_dma_params[4][4] =3D {
> - =A0 =A0 =A0 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 &pxa_ssp1_pcm_mono_out, &pxa_ssp1_pcm_mono_=
in,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 &pxa_ssp1_pcm_stereo_out, &pxa_ssp1_pcm_ste=
reo_in,
> - =A0 =A0 =A0 },
> - =A0 =A0 =A0 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 &pxa_ssp2_pcm_mono_out, &pxa_ssp2_pcm_mono_=
in,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 &pxa_ssp2_pcm_stereo_out, &pxa_ssp2_pcm_ste=
reo_in,
> - =A0 =A0 =A0 },
> - =A0 =A0 =A0 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 &pxa_ssp3_pcm_mono_out, &pxa_ssp3_pcm_mono_=
in,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 &pxa_ssp3_pcm_stereo_out, &pxa_ssp3_pcm_ste=
reo_in,
> - =A0 =A0 =A0 },
> - =A0 =A0 =A0 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 &pxa_ssp4_pcm_mono_out, &pxa_ssp4_pcm_mono_=
in,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 &pxa_ssp4_pcm_stereo_out, &pxa_ssp4_pcm_ste=
reo_in,
> - =A0 =A0 =A0 },
> +struct pxa2xx_pcm_dma_data {
> + =A0 =A0 =A0 struct pxa2xx_pcm_dma_params params;
> + =A0 =A0 =A0 char name[20];
> =A0};
>
> +static struct pxa2xx_pcm_dma_params *
> +ssp_get_dma_params(struct ssp_device *ssp, int stereo, int out)
> +{
> + =A0 =A0 =A0 struct pxa2xx_pcm_dma_data *dma;
> +
> + =A0 =A0 =A0 dma =3D kzalloc(sizeof(struct pxa2xx_pcm_dma_data), GFP_KER=
NEL);
> + =A0 =A0 =A0 if (dma =3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> +
> + =A0 =A0 =A0 snprintf(dma->name, 20, "SSP%d PCM %s %s", ssp->port_id,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 stereo ? "Stereo" : "Mono",=
 out ? "out" : "in");

Should we change Stereo/Mono to 32-bit/16-bit here?

> +
> + =A0 =A0 =A0 dma->params.name =3D dma->name;
> + =A0 =A0 =A0 dma->params.drcmr =3D &DRCMR(out ? ssp->drcmr_tx : ssp->drc=
mr_rx);
> + =A0 =A0 =A0 dma->params.dcmd =3D (out ? (DCMD_INCSRCADDR | DCMD_FLOWTRG=
) :
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (DCMD_I=
NCTRGADDR | DCMD_FLOWSRC)) |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (stereo ? DCMD_WIDTH4 : DCM=
D_WIDTH2) | DCMD_BURST16;
> + =A0 =A0 =A0 dma->params.dev_addr =3D ssp->phys_base + SSDR;
> +
> + =A0 =A0 =A0 return &dma->params;
> +}
> +
> =A0static int pxa_ssp_startup(struct snd_pcm_substream *substream,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct snd_soc_dai *d=
ai)
> =A0{
> @@ -225,6 +100,11 @@ static int pxa_ssp_startup(struct
> snd_pcm_substream *substream,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clk_enable(priv->ssp->clk);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ssp_disable(priv->ssp);
> =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 if (cpu_dai->dma_data) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(cpu_dai->dma_data);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_dai->dma_data =3D NULL;
> + =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0return ret;
> =A0}
>
> @@ -239,6 +119,11 @@ static void pxa_ssp_shutdown(struct
> snd_pcm_substream *substream,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ssp_disable(priv->ssp);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clk_disable(priv->ssp->clk);
> =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 if (cpu_dai->dma_data) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(cpu_dai->dma_data);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_dai->dma_data =3D NULL;
> + =A0 =A0 =A0 }
> =A0}
>
> =A0#ifdef CONFIG_PM
> @@ -611,25 +496,20 @@ static int pxa_ssp_hw_params(struct
> snd_pcm_substream *substream,
> =A0 =A0 =A0 =A0struct snd_soc_dai *cpu_dai =3D rtd->dai->cpu_dai;
> =A0 =A0 =A0 =A0struct ssp_priv *priv =3D cpu_dai->private_data;
> =A0 =A0 =A0 =A0struct ssp_device *ssp =3D priv->ssp;
> - =A0 =A0 =A0 int dma =3D 0, chn =3D params_channels(params);
> + =A0 =A0 =A0 int chn =3D params_channels(params);
> =A0 =A0 =A0 =A0u32 sscr0;
> =A0 =A0 =A0 =A0u32 sspsp;
> =A0 =A0 =A0 =A0int width =3D snd_pcm_format_physical_width(params_format(=
params));
> =A0 =A0 =A0 =A0int ttsa =3D ssp_read_reg(ssp, SSTSA) & 0xf;
>
> - =A0 =A0 =A0 /* select correct DMA params */
> - =A0 =A0 =A0 if (substream->stream !=3D SNDRV_PCM_STREAM_PLAYBACK)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma =3D 1; /* capture DMA offset is 1,3 */
> - =A0 =A0 =A0 /* Network mode with one active slot (ttsa =3D=3D 1) can be=
 used
> - =A0 =A0 =A0 =A0* to force 16-bit frame width on the wire (for S16_LE), =
even
> - =A0 =A0 =A0 =A0* with two channels. Use 16-bit DMA transfers for this c=
ase.
> - =A0 =A0 =A0 =A0*/

Do you think the ttsa bit below is obvious enough to warrant removal
of the above comment?

> - =A0 =A0 =A0 if (((chn =3D=3D 2) && (ttsa !=3D 1)) || (width =3D=3D 32))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma +=3D 2; /* 32-bit DMA offset is 2, 16-b=
it is 0 */
> -
> - =A0 =A0 =A0 cpu_dai->dma_data =3D ssp_dma_params[cpu_dai->id][dma];
> + =A0 =A0 =A0 printk("%s\n", __func__);
> + =A0 =A0 =A0 /* generate correct DMA params */
> + =A0 =A0 =A0 if (cpu_dai->dma_data)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(cpu_dai->dma_data);
>
> - =A0 =A0 =A0 dev_dbg(&ssp->pdev->dev, "pxa_ssp_hw_params: dma %d\n", dma=
);
> + =A0 =A0 =A0 cpu_dai->dma_data =3D ssp_get_dma_params(ssp,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((chn =3D=3D 2) && (ttsa !=
=3D 1)) || (width =3D=3D 32),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 substream->stream =3D=3D SN=
DRV_PCM_STREAM_PLAYBACK);
>
> =A0 =A0 =A0 =A0/* we can only change the settings if the port is not in u=
se */
> =A0 =A0 =A0 =A0if (ssp_read_reg(ssp, SSCR0) & SSCR0_SSE)
> --
> 1.6.0.4
>

regards
Philipp
