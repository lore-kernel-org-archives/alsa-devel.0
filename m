From: Nicolin Chen <b42378@freescale.com>
Subject: Re: [RFC] ASoC: fsl-ssi: Missing DMA-Request workaround
Date: Tue, 12 Nov 2013 18:42:59 +0800
Message-ID: <20131112104258.GB23243@MrMyself>
References: <1384185816-7730-1-git-send-email-mpa@pengutronix.de>
 <20131112014913.GE11083@S2101-09.ap.freescale.net>
 <20131112023033.GA23243@MrMyself>
 <20131112105738.GF30263@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe001.messaging.microsoft.com [216.32.180.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C1AD2616F3
 for <alsa-devel@alsa-project.org>; Tue, 12 Nov 2013 12:00:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20131112105738.GF30263@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 12, 2013 at 11:57:38AM +0100, Markus Pargmann wrote:
> Hi,
> =

> On Tue, Nov 12, 2013 at 10:30:34AM +0800, Nicolin Chen wrote:
> > Hi Markus,
> > =

> > On Tue, Nov 12, 2013 at 09:49:16AM +0800, Shawn Guo wrote:
> > > Copy Nicolin.
> > > =

> > > Shawn
> > > =

> > > On Mon, Nov 11, 2013 at 05:03:36PM +0100, Markus Pargmann wrote:
> > > > There is a hardware issue when using capture and playback at the sa=
me
> > > > time. In the tested scenario, the capture stream was started slight=
ly
> > > > before the playback stream. The first time the application starts a=
fter
> > > > a powerup, there is a high probability that the SSI unit does not s=
end a
> > > > request to the SDMA unit. The playback does not work. I tested this=
 on
> > > > i.MX53 with SSI unit 2 kernel 3.10.10.
> > =

> > I've been tested SSI with WM8962 on i.MX6 series for a while, and never=
 met
> > this issue, well, not with 3.10.10 original code and i.MX53 though.
> > =

> > Could you please provide me a reproducible flow? =

> > =

> > If playback first and capture later, would this also reproduce the issu=
e?
> > =

> > Is there any command must be executed before the arecord | aplay, or ju=
st
> > run it after system boot-up?
> > =

> > By trying to reproduce it on i.MX6, we can confirm if it's a common iss=
ue
> > to the IP or its driver, or just a hardware defect within i.MX53.
> =

> I just tested a patch from J=FCrgen Beisert "fix SDMA starvation" [1]. It
> solves exactly this issue but was not applied. I will rebase the patch
> onto the latest sound tree and resend it.

Great news!

Thank you
Nicolin Chen

---

> =

> Thanks,
> =

> Markus Pargmann
> =

> [1] http://thread.gmane.org/gmane.linux.sound/1724
> =

> > =

> > Thank you,
> > Nicolin Chen
> > =

> > ---
> > =

> > > > =

> > > > Here is a register dump of the situation:
> > > > SDMA
> > > > 0x63fb0000
> > > > 00000000: c0040000 00000000 0000001e 00000000
> > > > 00000010: 00000001 ffffffff 00000000 e03efa41
> > > > 00000020: 00000000 00000000 00000000 00000000
> > > > 00000030: 00000064 00000000 00000003 00000000
> > > > 00000040: 00000000 00000000 00000000 00006000
> > > > 00000050: 00000000 00000000 00000001 00004050
> > > > 00000060: 01208000 00000000 00000000 00000000 /* 0x60: EVT_MIRROR s=
howing all received DMA requests */
> > > >            ^ This should be a 3 instead. Bits 24 and 25 are the DMA=
 requests for
> > > >              RX and TX. Bit 25 is not set, DMA request 25 is missin=
g.
> > > > =

> > > > SSI
> > > > 0x50014000
> > > > 00000000: 00000000 00000000 0000005f 00000000
> > > > 00000010: 00000457 000050c1 01f80f00 0000028d /* 0x14: ISR Interrup=
t status register */
> > > >                           ^
> > > > 	     At 0x14 we can clearly see the last bit is set (0x1) which
> > > > 	     is TFE0, Transmit FIFO 0 empty. So it should automatically
> > > > 	     request data from the DMA engine, but it doesn't.
> > > > =

> > > > 00000020: 0000028d 0004e000 00040000 000010dd
> > > > 00000030: 00001f1f 00000000 00000000 00000000
> > > > 00000040: 00000000 00000000 00000000 00000000
> > > > 00000050: 00000000 00000000 ........
> > > > STATS (/sys/bus/platform/devices/50014000.ssi/statistics)
> > > > rfrc=3D0
> > > > tfrc=3D0
> > > > roe1=3D0
> > > > roe0=3D0
> > > > tue1=3D0
> > > > tue0=3D1094475
> > > > =

> > > > I could solve this issue by filling the transmit FIFO with data. Af=
ter
> > > > that, the SDMA unit receives DMA request 25 again and audio playback
> > > > works.
> > > > =

> > > > This patch adds TUE0 interrupt handler which fills FIFO0 with arbit=
rary data.
> > > > =

> > > > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > > > ---
> > > > =

> > > > Hi,
> > > > =

> > > > does anyone have an idea why the SSI unit does not request DMA by i=
ts own at
> > > > the beginning? Or is it a hardware errata that is not listed yet?
> > > > =

> > > > Regards,
> > > > =

> > > > Markus Pargmann
> > > > =

> > > > =

> > > >  sound/soc/fsl/fsl_ssi.c | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > > =

> > > > diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> > > > index 6b81d0c..8faf2b5 100644
> > > > --- a/sound/soc/fsl/fsl_ssi.c
> > > > +++ b/sound/soc/fsl/fsl_ssi.c
> > > > @@ -269,9 +269,14 @@ static irqreturn_t fsl_ssi_isr(int irq, void *=
dev_id)
> > > >  	}
> > > >  =

> > > >  	if (sisr & CCSR_SSI_SISR_TUE0) {
> > > > +		int i;
> > > > +
> > > >  		ssi_private->stats.tue0++;
> > > >  		sisr2 |=3D CCSR_SSI_SISR_TUE0;
> > > >  		ret =3D IRQ_HANDLED;
> > > > +
> > > > +		for (i =3D 0; i !=3D ssi_private->fifo_depth; ++i)
> > > > +			write_ssi(0x0, &ssi->stx0);
> > > >  	}
> > > >  =

> > > >  	if (sisr & CCSR_SSI_SISR_TFS) {
> > > > -- =

> > > > 1.8.4.2
> > > > =

> > =

> > =

> > =

> =

> -- =

> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> =
