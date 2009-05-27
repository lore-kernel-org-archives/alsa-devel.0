From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: Please help in adding ams-delta support to ASoC
Date: Wed, 27 May 2009 18:19:21 +0300
Message-ID: <20090527181921.083e3825.jhnikula__39062.0536673397$1243437577$gmane$org@gmail.com>
References: <4A1BEBE3.8010306@tis.icnet.pl>
	<20090527095949.51ed4b83.jhnikula@gmail.com>
	<4A1D4F32.5060002@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <4A1D4F32.5060002@tis.icnet.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: linux-omap@vger.kernel.org, alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, 27 May 2009 16:33:22 +0200
Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:

> >> -	.srgr2 = GSYNC | CLKSP | FSGM | FPER(DEFAULT_BITPERSAMPLE
> >> * 2 - 1),
> >> +       .srgr2 = GSYNC,
> >>
> >> -	.pcr0 = CLKXP | CLKRP,  /* mcbsp: slave */
> >>
...
> > I wonder why the frame sync period (FWID) wasn't set in that
> > original patch but probably McBSP is able to work without :-)
> 
> from linux-2.6.29/sound/soc/omap/omap-mcbsp.c:
>          switch (mcbsp_data->fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
>          case SND_SOC_DAIFMT_I2S:
>                  regs->srgr2     |= FPER(wlen * 2 - 1);
>                  regs->srgr1     |= FWID(wlen - 1);
>                  break;
>          case SND_SOC_DAIFMT_DSP_B:
>                  regs->srgr2     |= FPER(wlen * channels - 1);
>                  regs->srgr1     |= FWID(0);
>                  break;
>          }
> 
> So it looks like in case of SND_SOC_DAIFMT_DSP_B, FWID is not set,
> only FPER. However, in the original patch, FPER was not set either.
> 
Sorry, my short above. Obviously I was wondering missing FPER setting
in original patch which defines the length of frame sync period. FWID
defines the length of frame sync pulse (n.o. bit clock pulses - 1).

Frame sync pulse length is half of the period in I2S and 1-bit clock
cycle in DSP_B. WM9713 has nice drawings about different formats. Look
pages 29 and 30.

http://www.wolfsonmicro.com/uploads/documents/en/WM9713.pdf

> I hope DMA chaining is not an issue here. If I remove the DMA
> chaining workaround from the original patch, I get signle DMA
> interrupts, so that is better than none that I get with my patch.
> 
I think chaining is not issue if you are not getting any interrupt.
Basically if DMA transfer is working but DMA restarting is not then
there should be one completed buffer transfer and >= 2 interrupts from
completed periods.


-- 
Jarkko
