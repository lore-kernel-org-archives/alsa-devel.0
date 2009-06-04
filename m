From: Paul Shen <boshen9@gmail.com>
Subject: Re: [PATCH 1/4] ASoC: pxa-ssp: enhance I2S and add
	Left_J support
Date: Thu, 4 Jun 2009 17:44:55 +0800
Message-ID: <1719ee7f0906040244t3890b069s5039c3f0c8bbe09a@mail.gmail.com>
References: <f17812d70906030533m49eb023bid19a80231921f59b@mail.gmail.com>
	<20090603131819.GQ26148@buzzloop.caiaq.de>
	<37b631400906040207o169abbc2ob33100879ac68911@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f223.google.com (mail-ew0-f223.google.com
	[209.85.219.223])
	by alsa0.perex.cz (Postfix) with ESMTP id 3ECBF10391F
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Jun 2009 11:44:56 +0200 (CEST)
Received: by ewy23 with SMTP id 23so877909ewy.32
	for <alsa-devel@alsa-project.org>; Thu, 04 Jun 2009 02:44:55 -0700 (PDT)
In-Reply-To: <37b631400906040207o169abbc2ob33100879ac68911@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: daniel@caiaq.de
Cc: alsa-devel@alsa-project.org, bshen9@marvell.com, eric.y.miao@gmail.com, linux-arm-kernel@lists.arm.linux.org.uk, broonie@sirena.org.uk
List-Id: alsa-devel@alsa-project.org

Hi Daniel,

This is Paul Shen , I will substitute boshen9@gmail.com  for
bshen9@marvell.com to answer open source mails.


> From: Daniel Mack <daniel@caiaq.de>
> Date: Wed, Jun 3, 2009 at 9:18 PM
> Subject: Re: [alsa-devel] [PATCH 1/4] ASoC: pxa-ssp: enhance I2S and add =
Left_J support
> To: Eric Miao <eric.y.miao@gmail.com>
> Cc: alsa-devel@alsa-project.org, linux-arm-kernel <linux-arm-kernel@lists=
.arm.linux.org.uk>, Mark Brown <broonie@sirena.org.uk>
>
>
> On Wed, Jun 03, 2009 at 08:33:42PM +0800, Eric Miao wrote:
> > Make the pxa I2S configuration generic, add support for Left_J, add
> > support for variable frame width like 32fs, 48fs, 64fs and 96fs
> >
> > Signed-off-by: Paul Shen <bshen9@marvell.com>
> > Signed-off-by: Eric Miao <eric.miao@marvell.com>
> > Cc: Daniel Mack <daniel@caiaq.de>
> > ---
> > =A0arch/arm/mach-pxa/include/mach/regs-ssp.h | =A0 14 +++---
> > =A0sound/soc/pxa/pxa-ssp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 62=
 ++++++++++++++--------------
> > =A0sound/soc/pxa/pxa-ssp.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
=A09 ++++
> > =A03 files changed, 47 insertions(+), 38 deletions(-)
>
> Ok, I tried that code on my board and this is what I had to change
> there:
>
> The tdm time slot configuration needs to be set again in my board support
> code just like in your example: snd_soc_set_tdm_slot(cpu_dai, 3, 2). And
> the PXA_SSP_DIV_SCR value needed to be doubled from 4 to 8.
>
I tested  with below  codes to set the cpu_dai  :

format =3D SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
                         SND_SOC_DAIFMT_CBS_CFS | PXA_SSP_FRM_64FS;

snd_soc_dai_set_fmt(cpu_dai, format);
snd_soc_dai_set_tdm_slot(cpu_dai, 3, 2);

snd_soc_dai_set_sysclk(cpu_dai, PXA_SSP_CLK_EXT, clk, 0);
snd_soc_dai_set_clkdiv(cpu_dai, PXA_SSP_DIV_SCR, 4);

It is no need to "snd_soc_dai_set_pll(cpu_dai, 0, 0, clk)" , for  your
case ,no ssp-on-chip pll configuration is needed.

On my littleton platform,it is ok, and  I did not modify the
PXA_SSP_DIV_SCR from 4 to 8.

I dumped the ssp register:
SSCR0 0xa10003ff
SSCR1 0x00e01d80
SSTO 0x00000000
SSPSP 0x31a00084
SSSR 0x0000f0fc
SSACD 0x00000000
SSACDD 0x00000000

How about your registers ?

> With that changes, LRCLK is 44100Hz when configured to 44100Hz. But the
> bitclk is not 64fs anymore but 32fs only (1.41Mhz). Is there any
> implementation details I miss? What does your codec clock config look
> like?
>
Do you mean it only down to 32fs when LRCLK is 44100HZ ?
And when LRCLK is 48000HZ, all is OK ?

> Another small thing:
>
> =A0CC =A0 =A0 =A0sound/soc/pxa/pxa-ssp.o
> =A0sound/soc/pxa/pxa-ssp.c:186: warning: 'ssp_get_scr' defined but not us=
ed
>
> Daniel
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>
