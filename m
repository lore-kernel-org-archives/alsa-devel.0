From: mirq-linux@rere.qmqm.pl
Subject: Re: [PATCH 1/5] ASoC: atmel: enable SSC_PCM_DMA in Kconfig
Date: Tue, 23 Jul 2019 18:43:12 +0200
Message-ID: <20190723164312.GA4772@qmqm.qmqm.pl>
References: <cover.1563819483.git.mirq-linux@rere.qmqm.pl>
 <ee65cc7b889b2a8d1139d1d25977842c956d1cf4.1563819483.git.mirq-linux@rere.qmqm.pl>
 <1f3a4256-58de-27a4-8095-54fc6baa6d89@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1f3a4256-58de-27a4-8095-54fc6baa6d89@microchip.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Codrin.Ciubotariu@microchip.com
Cc: alsa-devel@alsa-project.org, alexandre.belloni@bootlin.com, lgirdwood@gmail.com, tiwai@suse.com, Ludovic.Desroches@microchip.com, broonie@kernel.org, perex@perex.cz, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 23, 2019 at 01:36:37PM +0000, Codrin.Ciubotariu@microchip.com w=
rote:
> On 22.07.2019 21:27, Micha=B3 Miros=B3aw wrote:
> > Allow SSC to be used on platforms described using audio-graph-card
> > in Device Tree.
> > =

> > Signed-off-by: Micha=B3 Miros=B3aw <mirq-linux@rere.qmqm.pl>
> > ---
> >   sound/soc/atmel/Kconfig | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > =

> > diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
> > index 06c1d5ce642c..9ef9d25bb517 100644
> > --- a/sound/soc/atmel/Kconfig
> > +++ b/sound/soc/atmel/Kconfig
> > @@ -25,7 +25,7 @@ config SND_ATMEL_SOC_DMA
> >   	default y if SND_ATMEL_SOC_SSC_DMA=3Dy || (SND_ATMEL_SOC_SSC_DMA=3Dm=
 && SND_ATMEL_SOC_SSC=3Dy)
> >   =

> >   config SND_ATMEL_SOC_SSC_DMA
> > -	tristate
> > +	tristate "SoC PCM DAI support for AT91 SSC controller using DMA"
> =

> Could you please make something similar for SND_ATMEL_SOC_SSC_PDC? Also, =

> I think that it should select ATMEL_SSC, to be able to use =

> simple/graph-card with SSC.

Hmm. The Kconfig dependencies seems overly complicated, do you mind if I
get rid of most of the entries in the process?

Best Regards,
Micha=B3=A0Miros=B3aw
