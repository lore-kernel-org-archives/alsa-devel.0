From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V5 1/3] ASoC: Alchemy AC97C/I2SC audio
	support
Date: Tue, 26 Jul 2011 15:47:18 +0100
Message-ID: <20110726144718.GJ7285@opensource.wolfsonmicro.com>
References: <1311594287-31576-1-git-send-email-manuel.lauss@googlemail.com>
	<1311594287-31576-2-git-send-email-manuel.lauss@googlemail.com>
	<20110726143112.GF7285@opensource.wolfsonmicro.com>
	<CAOLZvyFzHFGFvFrWigLi_oHpdQBp1ZCsRBEU8tF-62X8VaCd_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <CAOLZvyFzHFGFvFrWigLi_oHpdQBp1ZCsRBEU8tF-62X8VaCd_Q@mail.gmail.com>
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

On Tue, Jul 26, 2011 at 04:43:16PM +0200, Manuel Lauss wrote:
> On Tue, Jul 26, 2011 at 4:31 PM, Mark Brown

> >> + =A0 =A0 case (~DMA_D0 & ~DMA_D1):
> >> + =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("DMA %d empty irq.\n", stream->dma);

> > This case should return IRQ_NONE really since it didn't handle an
> > interrupt...

> If that last case ever happens the DMA engine is broken, as it shouldn't
> issue interrupts when no transfer is in progress.  The errata sheets don't
> mention anything (yet).

In that case this should be an error rather than debug level print and
I'd say the IRQ_NONE thing definitely applies.
