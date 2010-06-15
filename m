From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH RFC 3/3] sound: asoc: au1x: implement AC97 GPIO
	access
Date: Tue, 15 Jun 2010 17:55:47 +0200
Message-ID: <1276617347-3522-4-git-send-email-manuel.lauss__39362.0473718785$1276617404$gmane$org@googlemail.com>
References: <1276617347-3522-1-git-send-email-manuel.lauss@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1276617347-3522-1-git-send-email-manuel.lauss@googlemail.com>
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
Cc: Manuel Lauss <manuel.lauss@googlemail.com>, linux-input@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The Alchemy PSC AC97 controller can receive/transmit AC97 Slot 12 data
(Codec GPIO) through 2 registers.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 sound/soc/au1x/psc-ac97.c |   39 +++++++++++++++++++++++++++++++++++++--
 sound/soc/au1x/psc.h      |    2 ++
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/sound/soc/au1x/psc-ac97.c b/sound/soc/au1x/psc-ac97.c
index a61ccd2..1da2949 100644
--- a/sound/soc/au1x/psc-ac97.c
+++ b/sound/soc/au1x/psc-ac97.c
@@ -56,6 +56,31 @@
 /* instance data. There can be only one, MacLeod!!!! */
 static struct au1xpsc_audio_data *au1xpsc_ac97_workdata;
 
+static void au1xpsc_ac97_setgpio(struct snd_ac97 *ac97, unsigned short gpio)
+{
+	/* FIXME */
+	struct au1xpsc_audio_data *pscdata = au1xpsc_ac97_workdata;
+	au_writel(gpio, AC97_GPO(pscdata));
+	au_sync();
+}
+
+static unsigned short au1xpsc_ac97_getgpio(struct snd_ac97 *ac97)
+{
+	/* FIXME */
+	struct au1xpsc_audio_data *pscdata = au1xpsc_ac97_workdata;
+	unsigned long data;
+
+	while (!(au_readl(AC97_EVNT(pscdata)) & PSC_AC97EVNT_GR))
+		cpu_relax();
+	au_writel(PSC_AC97EVNT_GR, AC97_EVNT(pscdata));
+	au_sync();
+
+	data = au_readl(AC97_GPI(pscdata));
+	data = (data >> 4) & 0xffff;
+
+	return data;
+}
+
 /* AC97 controller reads codec register */
 static unsigned short au1xpsc_ac97_read(struct snd_ac97 *ac97,
 					unsigned short reg)
@@ -195,6 +220,8 @@ struct snd_ac97_bus_ops soc_ac97_ops = {
 	.write		= au1xpsc_ac97_write,
 	.reset		= au1xpsc_ac97_cold_reset,
 	.warm_reset	= au1xpsc_ac97_warm_reset,
+	.setgpio	= au1xpsc_ac97_setgpio,
+	.getgpio	= au1xpsc_ac97_getgpio,
 };
 EXPORT_SYMBOL_GPL(soc_ac97_ops);
 
@@ -229,10 +256,12 @@ static int au1xpsc_ac97_hw_params(struct snd_pcm_substream *substream,
 			r &= ~PSC_AC97CFG_TXSLOT_MASK;
 			r |= PSC_AC97CFG_TXSLOT_ENA(3);
 			r |= PSC_AC97CFG_TXSLOT_ENA(4);
+			r |= PSC_AC97CFG_TXSLOT_ENA(12);  /* GPIO */
 		} else {
 			r &= ~PSC_AC97CFG_RXSLOT_MASK;
 			r |= PSC_AC97CFG_RXSLOT_ENA(3);
 			r |= PSC_AC97CFG_RXSLOT_ENA(4);
+			r |= PSC_AC97CFG_RXSLOT_ENA(12);  /* GPIO */
 		}
 
 		/* do we need to poke the hardware? */
@@ -384,9 +413,15 @@ static int __devinit au1xpsc_ac97_drvprobe(struct platform_device *pdev)
 	if (!wd->mmio)
 		goto out1;
 
-	/* configuration: max dma trigger threshold, enable ac97 */
+	/* configuration: max dma trigger threshold, enable ac97,
+	 * enable GPIO regs, enable GPIO slots, 16bit len default
+	 * so it clocks out all GPIO info.
+	 */
 	wd->cfg = PSC_AC97CFG_RT_FIFO8 | PSC_AC97CFG_TT_FIFO8 |
-		  PSC_AC97CFG_DE_ENABLE;
+		  PSC_AC97CFG_DE_ENABLE | PSC_AC97CFG_GE_ENABLE |
+		  PSC_AC97CFG_TXSLOT_ENA(12) |
+		  PSC_AC97CFG_RXSLOT_ENA(12) |
+		  PSC_AC97CFG_SET_LEN(16);
 
 	/* preserve PSC clock source set up by platform	 */
 	sel = au_readl(PSC_SEL(wd)) & PSC_SEL_CLK_MASK;
diff --git a/sound/soc/au1x/psc.h b/sound/soc/au1x/psc.h
index 32d3807..915c3de 100644
--- a/sound/soc/au1x/psc.h
+++ b/sound/soc/au1x/psc.h
@@ -55,5 +55,7 @@ struct au1xpsc_audio_data {
 #define AC97_PCR(x)	((unsigned long)((x)->mmio) + PSC_AC97PCR_OFFSET)
 #define AC97_RST(x)	((unsigned long)((x)->mmio) + PSC_AC97RST_OFFSET)
 #define AC97_STAT(x)	((unsigned long)((x)->mmio) + PSC_AC97STAT_OFFSET)
+#define AC97_GPO(x)	((unsigned long)((x)->mmio) + PSC_AC97GPO_OFFSET)
+#define AC97_GPI(x)	((unsigned long)((x)->mmio) + PSC_AC97GPI_OFFSET)
 
 #endif
-- 
1.7.1

