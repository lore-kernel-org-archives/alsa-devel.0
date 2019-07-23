From: mirq-linux@rere.qmqm.pl
Subject: Re: [PATCH 1/5] ASoC: atmel: enable SSC_PCM_DMA in Kconfig
Date: Wed, 24 Jul 2019 01:25:05 +0200
Message-ID: <20190723232505.GA21811@qmqm.qmqm.pl>
References: <cover.1563819483.git.mirq-linux@rere.qmqm.pl>
 <ee65cc7b889b2a8d1139d1d25977842c956d1cf4.1563819483.git.mirq-linux@rere.qmqm.pl>
 <1f3a4256-58de-27a4-8095-54fc6baa6d89@microchip.com>
 <20190723164312.GA4772@qmqm.qmqm.pl>
 <20190723183915.GJ24911@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190723183915.GJ24911@piout.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz, Ludovic.Desroches@microchip.com, broonie@kernel.org, Codrin.Ciubotariu@microchip.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 23, 2019 at 08:39:15PM +0200, Alexandre Belloni wrote:
> On 23/07/2019 18:43:12+0200, mirq-linux@rere.qmqm.pl wrote:
> > On Tue, Jul 23, 2019 at 01:36:37PM +0000, Codrin.Ciubotariu@microchip.c=
om wrote:
> > > On 22.07.2019 21:27, Micha=B3 Miros=B3aw wrote:
> > > > Allow SSC to be used on platforms described using audio-graph-card
> > > > in Device Tree.
> > > > =

> > > > Signed-off-by: Micha=B3 Miros=B3aw <mirq-linux@rere.qmqm.pl>
> > > > ---
> > > >   sound/soc/atmel/Kconfig | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > =

> > > > diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
> > > > index 06c1d5ce642c..9ef9d25bb517 100644
> > > > --- a/sound/soc/atmel/Kconfig
> > > > +++ b/sound/soc/atmel/Kconfig
> > > > @@ -25,7 +25,7 @@ config SND_ATMEL_SOC_DMA
> > > >   	default y if SND_ATMEL_SOC_SSC_DMA=3Dy || (SND_ATMEL_SOC_SSC_DMA=
=3Dm && SND_ATMEL_SOC_SSC=3Dy)
> > > >   =

> > > >   config SND_ATMEL_SOC_SSC_DMA
> > > > -	tristate
> > > > +	tristate "SoC PCM DAI support for AT91 SSC controller using DMA"
> > > =

> > > Could you please make something similar for SND_ATMEL_SOC_SSC_PDC? Al=
so, =

> > > I think that it should select ATMEL_SSC, to be able to use =

> > > simple/graph-card with SSC.
> > =

> > Hmm. The Kconfig dependencies seems overly complicated, do you mind if I
> > get rid of most of the entries in the process?
> > =

> =

> Unfortunately, it is just complicated enough. This is done to support
> all the possible configurations. Removing them will lead to linking
> errors.
> =

> After having that discussion back in March, I had a very quick look and
> didn't send a patch because I still had linking issues. It is not
> impossible but it required more time than I had.

Can you try patch below if it covers the configurations you mention?
This uses Kconfig's m/y resolution instead of open-coded defaults.

Best Regards,
Micha=B3 Miros=B3aw


diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
index 06c1d5ce642c..f118c229ed82 100644
--- a/sound/soc/atmel/Kconfig
+++ b/sound/soc/atmel/Kconfig
@@ -12,25 +12,31 @@ if SND_ATMEL_SOC
 config SND_ATMEL_SOC_PDC
 	tristate
 	depends on HAS_DMA
-	default m if SND_ATMEL_SOC_SSC_PDC=3Dm && SND_ATMEL_SOC_SSC=3Dm
-	default y if SND_ATMEL_SOC_SSC_PDC=3Dy || (SND_ATMEL_SOC_SSC_PDC=3Dm && S=
ND_ATMEL_SOC_SSC=3Dy)
-
-config SND_ATMEL_SOC_SSC_PDC
-	tristate
 =

 config SND_ATMEL_SOC_DMA
 	tristate
 	select SND_SOC_GENERIC_DMAENGINE_PCM
-	default m if SND_ATMEL_SOC_SSC_DMA=3Dm && SND_ATMEL_SOC_SSC=3Dm
-	default y if SND_ATMEL_SOC_SSC_DMA=3Dy || (SND_ATMEL_SOC_SSC_DMA=3Dm && S=
ND_ATMEL_SOC_SSC=3Dy)
-
-config SND_ATMEL_SOC_SSC_DMA
-	tristate
 =

 config SND_ATMEL_SOC_SSC
 	tristate
-	default y if SND_ATMEL_SOC_SSC_DMA=3Dy || SND_ATMEL_SOC_SSC_PDC=3Dy
-	default m if SND_ATMEL_SOC_SSC_DMA=3Dm || SND_ATMEL_SOC_SSC_PDC=3Dm
+
+config SND_ATMEL_SOC_SSC_PDC
+	tristate "SoC PCM DAI support for AT91 SSC controller using PDC"
+	depends on ATMEL_SSC
+	select SND_ATMEL_SOC_PDC
+	select SND_ATMEL_SOC_SSC
+	help
+	  Say Y or M if you want to add support for Atmel SSC interface
+	  in PDC mode configured using audio-graph-card in device-tree.
+
+config SND_ATMEL_SOC_SSC_DMA
+	tristate "SoC PCM DAI support for AT91 SSC controller using DMA"
+	depends on ATMEL_SSC
+	select SND_ATMEL_SOC_DMA
+	select SND_ATMEL_SOC_SSC
+	help
+	  Say Y or M if you want to add support for Atmel SSC interface
+	  in DMA mode configured using audio-graph-card in device-tree.
 =

 config SND_AT91_SOC_SAM9G20_WM8731
 	tristate "SoC Audio support for WM8731-based At91sam9g20 evaluation board"
-- =

2.20.1
