From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [PATCH V5 1/3] ASoC: Alchemy AC97C/I2SC audio
	support
Date: Tue, 26 Jul 2011 16:43:16 +0200
Message-ID: <CAOLZvyFzHFGFvFrWigLi_oHpdQBp1ZCsRBEU8tF-62X8VaCd_Q@mail.gmail.com>
References: <1311594287-31576-1-git-send-email-manuel.lauss@googlemail.com>
	<1311594287-31576-2-git-send-email-manuel.lauss@googlemail.com>
	<20110726143112.GF7285@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20110726143112.GF7285@opensource.wolfsonmicro.com>
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
Cc: Linux-MIPS <linux-mips@linux-mips.org>, alsa-devel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 26, 2011 at 4:31 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Jul 25, 2011 at 01:44:45PM +0200, Manuel Lauss wrote:
>
> Looks good, I'll apply this but a few minor comments you might want to
> look at incrementally.
>
>> +#define ALCHEMY_PCM_FMTS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>> + =A0 =A0 (SNDRV_PCM_FMTBIT_S8 =A0 =A0 | SNDRV_PCM_FMTBIT_U8 | =A0 =A0 =
=A0 =A0\
>> + =A0 =A0 =A0SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S16_BE | =A0 =A0\
>> + =A0 =A0 =A0SNDRV_PCM_FMTBIT_U16_LE | SNDRV_PCM_FMTBIT_U16_BE | =A0 =A0\
>> + =A0 =A0 =A0SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S32_BE | =A0 =A0\
>> + =A0 =A0 =A0SNDRV_PCM_FMTBIT_U32_LE | SNDRV_PCM_FMTBIT_U32_BE | =A0 =A0\
>> + =A0 =A0 =A00)
>
> Why the | 0? =A0Same for the other one.

Old habit in case I need to insert other format bits in the future (then
the second-to-last line need not be changed in a patch).


>> + =A0 =A0 case (DMA_D0 | DMA_D1):
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("DMA %d missed interrupt.\n", stream-=
>dma);
>> + =A0 =A0 =A0 =A0 =A0 =A0 au1000_dma_stop(stream);
>> + =A0 =A0 =A0 =A0 =A0 =A0 au1000_dma_start(stream);
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case (~DMA_D0 & ~DMA_D1):
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("DMA %d empty irq.\n", stream->dma);
>
> This case should return IRQ_NONE really since it didn't handle an
> interrupt...

If that last case ever happens the DMA engine is broken, as it shouldn't
issue interrupts when no transfer is in progress.  The errata sheets don't
mention anything (yet).

Thanks!
        Manuel Lauss
