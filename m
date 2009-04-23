From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [RFC PATCH 5/5] ASoC: simplify the SSP DMA
	parameters settings by run-time generation
Date: Thu, 23 Apr 2009 17:05:38 +0800
Message-ID: <f17812d70904230205n2c3080cejaaf2a54678dac687@mail.gmail.com>
References: <f17812d70904222208i79604f3evb9950d6351377a83@mail.gmail.com>
	<74d0deb30904230153l5ec490eck211d6ef456869f36@mail.gmail.com>
	<f17812d70904230202t5dc459bbud36c13b11c6d5725@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016364ee0220e5a4e0468352f08
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.146])
	by alsa0.perex.cz (Postfix) with ESMTP id E6CA7103858
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Apr 2009 11:05:39 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 4so378759qwk.56
	for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2009 02:05:38 -0700 (PDT)
In-Reply-To: <f17812d70904230202t5dc459bbud36c13b11c6d5725@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pHilipp Zabel <philipp.zabel@gmail.com>
Cc: alsa-devel@alsa-project.org, Paul Shen <bshen9@marvell.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

--0016364ee0220e5a4e0468352f08
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Patch updated, rebased on broonie/sound-2.6/for-2.6.31:

>From 655bad8e72e3aa13f0ddf910d5f4b9f066ec9cc3 Mon Sep 17 00:00:00 2001
From: Eric Miao <eric.miao@marvell.com>
Date: Thu, 23 Apr 2009 10:58:34 +0800
Subject: [PATCH] ASoC: simplify the SSP DMA parameters settings by
run-time generation

The SSP DMA parameters can actually be easily generated at run-time since
they are almost similar except for the FIFO width and direction. Another
benefit is the re-use of information from 'struct ssp_device', like SSDR
physical FIFO address and DRCMR register index for both directions.

Signed-off-by: Eric Miao <eric.miao@marvell.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Reviewed-by: pHilipp Zabel <philipp.zabel@gmail.com>
---
 sound/soc/pxa/pxa-ssp.c |  203 ++++++++++-------------------------------------
 1 files changed, 43 insertions(+), 160 deletions(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index b9b61dd..fb8cacc 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -50,139 +50,6 @@ struct ssp_priv {
 #endif
 };

-#define PXA2xx_SSP1_BASE	0x41000000
-#define PXA27x_SSP2_BASE	0x41700000
-#define PXA27x_SSP3_BASE	0x41900000
-#define PXA3xx_SSP4_BASE	0x41a00000
-
-static struct pxa2xx_pcm_dma_params pxa_ssp1_pcm_mono_out = {
-	.name			= "SSP1 PCM Mono out",
-	.dev_addr		= PXA2xx_SSP1_BASE + SSDR,
-	.drcmr			= &DRCMR(14),
-	.dcmd			= DCMD_INCSRCADDR | DCMD_FLOWTRG |
-				  DCMD_BURST16 | DCMD_WIDTH2,
-};
-
-static struct pxa2xx_pcm_dma_params pxa_ssp1_pcm_mono_in = {
-	.name			= "SSP1 PCM Mono in",
-	.dev_addr		= PXA2xx_SSP1_BASE + SSDR,
-	.drcmr			= &DRCMR(13),
-	.dcmd			= DCMD_INCTRGADDR | DCMD_FLOWSRC |
-				  DCMD_BURST16 | DCMD_WIDTH2,
-};
-
-static struct pxa2xx_pcm_dma_params pxa_ssp1_pcm_stereo_out = {
-	.name			= "SSP1 PCM Stereo out",
-	.dev_addr		= PXA2xx_SSP1_BASE + SSDR,
-	.drcmr			= &DRCMR(14),
-	.dcmd			= DCMD_INCSRCADDR | DCMD_FLOWTRG |
-				  DCMD_BURST16 | DCMD_WIDTH4,
-};
-
-static struct pxa2xx_pcm_dma_params pxa_ssp1_pcm_stereo_in = {
-	.name			= "SSP1 PCM Stereo in",
-	.dev_addr		= PXA2xx_SSP1_BASE + SSDR,
-	.drcmr			= &DRCMR(13),
-	.dcmd			= DCMD_INCTRGADDR | DCMD_FLOWSRC |
-				  DCMD_BURST16 | DCMD_WIDTH4,
-};
-
-static struct pxa2xx_pcm_dma_params pxa_ssp2_pcm_mono_out = {
-	.name			= "SSP2 PCM Mono out",
-	.dev_addr		= PXA27x_SSP2_BASE + SSDR,
-	.drcmr			= &DRCMR(16),
-	.dcmd			= DCMD_INCSRCADDR | DCMD_FLOWTRG |
-				  DCMD_BURST16 | DCMD_WIDTH2,
-};
-
-static struct pxa2xx_pcm_dma_params pxa_ssp2_pcm_mono_in = {
-	.name			= "SSP2 PCM Mono in",
-	.dev_addr		= PXA27x_SSP2_BASE + SSDR,
-	.drcmr			= &DRCMR(15),
-	.dcmd			= DCMD_INCTRGADDR | DCMD_FLOWSRC |
-				  DCMD_BURST16 | DCMD_WIDTH2,
-};
-
-static struct pxa2xx_pcm_dma_params pxa_ssp2_pcm_stereo_out = {
-	.name			= "SSP2 PCM Stereo out",
-	.dev_addr		= PXA27x_SSP2_BASE + SSDR,
-	.drcmr			= &DRCMR(16),
-	.dcmd			= DCMD_INCSRCADDR | DCMD_FLOWTRG |
-				  DCMD_BURST16 | DCMD_WIDTH4,
-};
-
-static struct pxa2xx_pcm_dma_params pxa_ssp2_pcm_stereo_in = {
-	.name			= "SSP2 PCM Stereo in",
-	.dev_addr		= PXA27x_SSP2_BASE + SSDR,
-	.drcmr			= &DRCMR(15),
-	.dcmd			= DCMD_INCTRGADDR | DCMD_FLOWSRC |
-				  DCMD_BURST16 | DCMD_WIDTH4,
-};
-
-static struct pxa2xx_pcm_dma_params pxa_ssp3_pcm_mono_out = {
-	.name			= "SSP3 PCM Mono out",
-	.dev_addr		= PXA27x_SSP3_BASE + SSDR,
-	.drcmr			= &DRCMR(67),
-	.dcmd			= DCMD_INCSRCADDR | DCMD_FLOWTRG |
-				  DCMD_BURST16 | DCMD_WIDTH2,
-};
-
-static struct pxa2xx_pcm_dma_params pxa_ssp3_pcm_mono_in = {
-	.name			= "SSP3 PCM Mono in",
-	.dev_addr		= PXA27x_SSP3_BASE + SSDR,
-	.drcmr			= &DRCMR(66),
-	.dcmd			= DCMD_INCTRGADDR | DCMD_FLOWSRC |
-				  DCMD_BURST16 | DCMD_WIDTH2,
-};
-
-static struct pxa2xx_pcm_dma_params pxa_ssp3_pcm_stereo_out = {
-	.name			= "SSP3 PCM Stereo out",
-	.dev_addr		= PXA27x_SSP3_BASE + SSDR,
-	.drcmr			= &DRCMR(67),
-	.dcmd			= DCMD_INCSRCADDR | DCMD_FLOWTRG |
-				  DCMD_BURST16 | DCMD_WIDTH4,
-};
-
-static struct pxa2xx_pcm_dma_params pxa_ssp3_pcm_stereo_in = {
-	.name			= "SSP3 PCM Stereo in",
-	.dev_addr		= PXA27x_SSP3_BASE + SSDR,
-	.drcmr			= &DRCMR(66),
-	.dcmd			= DCMD_INCTRGADDR | DCMD_FLOWSRC |
-				  DCMD_BURST16 | DCMD_WIDTH4,
-};
-
-static struct pxa2xx_pcm_dma_params pxa_ssp4_pcm_mono_out = {
-	.name			= "SSP4 PCM Mono out",
-	.dev_addr		= PXA3xx_SSP4_BASE + SSDR,
-	.drcmr			= &DRCMR(67),
-	.dcmd			= DCMD_INCSRCADDR | DCMD_FLOWTRG |
-				  DCMD_BURST16 | DCMD_WIDTH2,
-};
-
-static struct pxa2xx_pcm_dma_params pxa_ssp4_pcm_mono_in = {
-	.name			= "SSP4 PCM Mono in",
-	.dev_addr		= PXA3xx_SSP4_BASE + SSDR,
-	.drcmr			= &DRCMR(66),
-	.dcmd			= DCMD_INCTRGADDR | DCMD_FLOWSRC |
-				  DCMD_BURST16 | DCMD_WIDTH2,
-};
-
-static struct pxa2xx_pcm_dma_params pxa_ssp4_pcm_stereo_out = {
-	.name			= "SSP4 PCM Stereo out",
-	.dev_addr		= PXA3xx_SSP4_BASE + SSDR,
-	.drcmr			= &DRCMR(67),
-	.dcmd			= DCMD_INCSRCADDR | DCMD_FLOWTRG |
-				  DCMD_BURST16 | DCMD_WIDTH4,
-};
-
-static struct pxa2xx_pcm_dma_params pxa_ssp4_pcm_stereo_in = {
-	.name			= "SSP4 PCM Stereo in",
-	.dev_addr		= PXA3xx_SSP4_BASE + SSDR,
-	.drcmr			= &DRCMR(66),
-	.dcmd			= DCMD_INCTRGADDR | DCMD_FLOWSRC |
-				  DCMD_BURST16 | DCMD_WIDTH4,
-};
-
 static void dump_registers(struct ssp_device *ssp)
 {
 	dev_dbg(&ssp->pdev->dev, "SSCR0 0x%08x SSCR1 0x%08x SSTO 0x%08x\n",
@@ -194,25 +61,33 @@ static void dump_registers(struct ssp_device *ssp)
 		 ssp_read_reg(ssp, SSACD));
 }

-static struct pxa2xx_pcm_dma_params *ssp_dma_params[4][4] = {
-	{
-		&pxa_ssp1_pcm_mono_out, &pxa_ssp1_pcm_mono_in,
-		&pxa_ssp1_pcm_stereo_out, &pxa_ssp1_pcm_stereo_in,
-	},
-	{
-		&pxa_ssp2_pcm_mono_out, &pxa_ssp2_pcm_mono_in,
-		&pxa_ssp2_pcm_stereo_out, &pxa_ssp2_pcm_stereo_in,
-	},
-	{
-		&pxa_ssp3_pcm_mono_out, &pxa_ssp3_pcm_mono_in,
-		&pxa_ssp3_pcm_stereo_out, &pxa_ssp3_pcm_stereo_in,
-	},
-	{
-		&pxa_ssp4_pcm_mono_out, &pxa_ssp4_pcm_mono_in,
-		&pxa_ssp4_pcm_stereo_out, &pxa_ssp4_pcm_stereo_in,
-	},
+struct pxa2xx_pcm_dma_data {
+	struct pxa2xx_pcm_dma_params params;
+	char name[20];
 };

+static struct pxa2xx_pcm_dma_params *
+ssp_get_dma_params(struct ssp_device *ssp, int stereo, int out)
+{
+	struct pxa2xx_pcm_dma_data *dma;
+
+	dma = kzalloc(sizeof(struct pxa2xx_pcm_dma_data), GFP_KERNEL);
+	if (dma == NULL)
+		return NULL;
+
+	snprintf(dma->name, 20, "SSP%d PCM %s %s", ssp->port_id,
+			stereo ? "Stereo" : "Mono", out ? "out" : "in");
+
+	dma->params.name = dma->name;
+	dma->params.drcmr = &DRCMR(out ? ssp->drcmr_tx : ssp->drcmr_rx);
+	dma->params.dcmd = (out ? (DCMD_INCSRCADDR | DCMD_FLOWTRG) :
+				  (DCMD_INCTRGADDR | DCMD_FLOWSRC)) |
+			(stereo ? DCMD_WIDTH4 : DCMD_WIDTH2) | DCMD_BURST16;
+	dma->params.dev_addr = ssp->phys_base + SSDR;
+
+	return &dma->params;
+}
+
 static int pxa_ssp_startup(struct snd_pcm_substream *substream,
 			   struct snd_soc_dai *dai)
 {
@@ -227,6 +102,11 @@ static int pxa_ssp_startup(struct
snd_pcm_substream *substream,
 		clk_enable(priv->dev.ssp->clk);
 		ssp_disable(&priv->dev);
 	}
+
+	if (cpu_dai->dma_data) {
+		kfree(cpu_dai->dma_data);
+		cpu_dai->dma_data = NULL;
+	}
 	return ret;
 }

@@ -241,6 +121,11 @@ static void pxa_ssp_shutdown(struct
snd_pcm_substream *substream,
 		ssp_disable(&priv->dev);
 		clk_disable(priv->dev.ssp->clk);
 	}
+
+	if (cpu_dai->dma_data) {
+		kfree(cpu_dai->dma_data);
+		cpu_dai->dma_data = NULL;
+	}
 }

 #ifdef CONFIG_PM
@@ -653,25 +538,23 @@ static int pxa_ssp_hw_params(struct
snd_pcm_substream *substream,
 	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
 	struct ssp_priv *priv = cpu_dai->private_data;
 	struct ssp_device *ssp = priv->dev.ssp;
-	int dma = 0, chn = params_channels(params);
+	int chn = params_channels(params);
 	u32 sscr0;
 	u32 sspsp;
 	int width = snd_pcm_format_physical_width(params_format(params));
 	int ttsa = ssp_read_reg(ssp, SSTSA) & 0xf;

-	/* select correct DMA params */
-	if (substream->stream != SNDRV_PCM_STREAM_PLAYBACK)
-		dma = 1; /* capture DMA offset is 1,3 */
+	/* generate correct DMA params */
+	if (cpu_dai->dma_data)
+		kfree(cpu_dai->dma_data);
+
 	/* Network mode with one active slot (ttsa == 1) can be used
 	 * to force 16-bit frame width on the wire (for S16_LE), even
 	 * with two channels. Use 16-bit DMA transfers for this case.
 	 */
-	if (((chn == 2) && (ttsa != 1)) || (width == 32))
-		dma += 2; /* 32-bit DMA offset is 2, 16-bit is 0 */
-
-	cpu_dai->dma_data = ssp_dma_params[cpu_dai->id][dma];
-
-	dev_dbg(&ssp->pdev->dev, "pxa_ssp_hw_params: dma %d\n", dma);
+	cpu_dai->dma_data = ssp_get_dma_params(ssp,
+			((chn == 2) && (ttsa != 1)) || (width == 32),
+			substream->stream == SNDRV_PCM_STREAM_PLAYBACK);

 	/* we can only change the settings if the port is not in use */
 	if (ssp_read_reg(ssp, SSCR0) & SSCR0_SSE)
-- 
1.6.0.4

--0016364ee0220e5a4e0468352f08
Content-Type: text/x-diff; charset=US-ASCII;
	name="0001-ASoC-simplify-the-SSP-DMA-parameters-settings-by-ru.patch"
Content-Disposition: attachment;
	filename="0001-ASoC-simplify-the-SSP-DMA-parameters-settings-by-ru.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ftv880y00

RnJvbSA2NTViYWQ4ZTcyZTNhYTEzZjBkZGY5MTBkNWY0YjlmMDY2ZWM5Y2MzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFcmljIE1pYW8gPGVyaWMubWlhb0BtYXJ2ZWxsLmNvbT4KRGF0
ZTogVGh1LCAyMyBBcHIgMjAwOSAxMDo1ODozNCArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIEFTb0M6
IHNpbXBsaWZ5IHRoZSBTU1AgRE1BIHBhcmFtZXRlcnMgc2V0dGluZ3MgYnkgcnVuLXRpbWUgZ2Vu
ZXJhdGlvbgoKVGhlIFNTUCBETUEgcGFyYW1ldGVycyBjYW4gYWN0dWFsbHkgYmUgZWFzaWx5IGdl
bmVyYXRlZCBhdCBydW4tdGltZSBzaW5jZQp0aGV5IGFyZSBhbG1vc3Qgc2ltaWxhciBleGNlcHQg
Zm9yIHRoZSBGSUZPIHdpZHRoIGFuZCBkaXJlY3Rpb24uIEFub3RoZXIKYmVuZWZpdCBpcyB0aGUg
cmUtdXNlIG9mIGluZm9ybWF0aW9uIGZyb20gJ3N0cnVjdCBzc3BfZGV2aWNlJywgbGlrZSBTU0RS
CnBoeXNpY2FsIEZJRk8gYWRkcmVzcyBhbmQgRFJDTVIgcmVnaXN0ZXIgaW5kZXggZm9yIGJvdGgg
ZGlyZWN0aW9ucy4KClNpZ25lZC1vZmYtYnk6IEVyaWMgTWlhbyA8ZXJpYy5taWFvQG1hcnZlbGwu
Y29tPgpTaWduZWQtb2ZmLWJ5OiBNYXJrIEJyb3duIDxicm9vbmllQG9wZW5zb3VyY2Uud29sZnNv
bm1pY3JvLmNvbT4KUmV2aWV3ZWQtYnk6IHBIaWxpcHAgWmFiZWwgPHBoaWxpcHAuemFiZWxAZ21h
aWwuY29tPgotLS0KIHNvdW5kL3NvYy9weGEvcHhhLXNzcC5jIHwgIDIwMyArKysrKysrKysrLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlcyBjaGFuZ2VkLCA0MyBp
bnNlcnRpb25zKCspLCAxNjAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc291bmQvc29jL3B4
YS9weGEtc3NwLmMgYi9zb3VuZC9zb2MvcHhhL3B4YS1zc3AuYwppbmRleCBiOWI2MWRkLi5mYjhj
YWNjIDEwMDY0NAotLS0gYS9zb3VuZC9zb2MvcHhhL3B4YS1zc3AuYworKysgYi9zb3VuZC9zb2Mv
cHhhL3B4YS1zc3AuYwpAQCAtNTAsMTM5ICs1MCw2IEBAIHN0cnVjdCBzc3BfcHJpdiB7CiAjZW5k
aWYKIH07CiAKLSNkZWZpbmUgUFhBMnh4X1NTUDFfQkFTRQkweDQxMDAwMDAwCi0jZGVmaW5lIFBY
QTI3eF9TU1AyX0JBU0UJMHg0MTcwMDAwMAotI2RlZmluZSBQWEEyN3hfU1NQM19CQVNFCTB4NDE5
MDAwMDAKLSNkZWZpbmUgUFhBM3h4X1NTUDRfQkFTRQkweDQxYTAwMDAwCi0KLXN0YXRpYyBzdHJ1
Y3QgcHhhMnh4X3BjbV9kbWFfcGFyYW1zIHB4YV9zc3AxX3BjbV9tb25vX291dCA9IHsKLQkubmFt
ZQkJCT0gIlNTUDEgUENNIE1vbm8gb3V0IiwKLQkuZGV2X2FkZHIJCT0gUFhBMnh4X1NTUDFfQkFT
RSArIFNTRFIsCi0JLmRyY21yCQkJPSAmRFJDTVIoMTQpLAotCS5kY21kCQkJPSBEQ01EX0lOQ1NS
Q0FERFIgfCBEQ01EX0ZMT1dUUkcgfAotCQkJCSAgRENNRF9CVVJTVDE2IHwgRENNRF9XSURUSDIs
Ci19OwotCi1zdGF0aWMgc3RydWN0IHB4YTJ4eF9wY21fZG1hX3BhcmFtcyBweGFfc3NwMV9wY21f
bW9ub19pbiA9IHsKLQkubmFtZQkJCT0gIlNTUDEgUENNIE1vbm8gaW4iLAotCS5kZXZfYWRkcgkJ
PSBQWEEyeHhfU1NQMV9CQVNFICsgU1NEUiwKLQkuZHJjbXIJCQk9ICZEUkNNUigxMyksCi0JLmRj
bWQJCQk9IERDTURfSU5DVFJHQUREUiB8IERDTURfRkxPV1NSQyB8Ci0JCQkJICBEQ01EX0JVUlNU
MTYgfCBEQ01EX1dJRFRIMiwKLX07Ci0KLXN0YXRpYyBzdHJ1Y3QgcHhhMnh4X3BjbV9kbWFfcGFy
YW1zIHB4YV9zc3AxX3BjbV9zdGVyZW9fb3V0ID0gewotCS5uYW1lCQkJPSAiU1NQMSBQQ00gU3Rl
cmVvIG91dCIsCi0JLmRldl9hZGRyCQk9IFBYQTJ4eF9TU1AxX0JBU0UgKyBTU0RSLAotCS5kcmNt
cgkJCT0gJkRSQ01SKDE0KSwKLQkuZGNtZAkJCT0gRENNRF9JTkNTUkNBRERSIHwgRENNRF9GTE9X
VFJHIHwKLQkJCQkgIERDTURfQlVSU1QxNiB8IERDTURfV0lEVEg0LAotfTsKLQotc3RhdGljIHN0
cnVjdCBweGEyeHhfcGNtX2RtYV9wYXJhbXMgcHhhX3NzcDFfcGNtX3N0ZXJlb19pbiA9IHsKLQku
bmFtZQkJCT0gIlNTUDEgUENNIFN0ZXJlbyBpbiIsCi0JLmRldl9hZGRyCQk9IFBYQTJ4eF9TU1Ax
X0JBU0UgKyBTU0RSLAotCS5kcmNtcgkJCT0gJkRSQ01SKDEzKSwKLQkuZGNtZAkJCT0gRENNRF9J
TkNUUkdBRERSIHwgRENNRF9GTE9XU1JDIHwKLQkJCQkgIERDTURfQlVSU1QxNiB8IERDTURfV0lE
VEg0LAotfTsKLQotc3RhdGljIHN0cnVjdCBweGEyeHhfcGNtX2RtYV9wYXJhbXMgcHhhX3NzcDJf
cGNtX21vbm9fb3V0ID0gewotCS5uYW1lCQkJPSAiU1NQMiBQQ00gTW9ubyBvdXQiLAotCS5kZXZf
YWRkcgkJPSBQWEEyN3hfU1NQMl9CQVNFICsgU1NEUiwKLQkuZHJjbXIJCQk9ICZEUkNNUigxNiks
Ci0JLmRjbWQJCQk9IERDTURfSU5DU1JDQUREUiB8IERDTURfRkxPV1RSRyB8Ci0JCQkJICBEQ01E
X0JVUlNUMTYgfCBEQ01EX1dJRFRIMiwKLX07Ci0KLXN0YXRpYyBzdHJ1Y3QgcHhhMnh4X3BjbV9k
bWFfcGFyYW1zIHB4YV9zc3AyX3BjbV9tb25vX2luID0gewotCS5uYW1lCQkJPSAiU1NQMiBQQ00g
TW9ubyBpbiIsCi0JLmRldl9hZGRyCQk9IFBYQTI3eF9TU1AyX0JBU0UgKyBTU0RSLAotCS5kcmNt
cgkJCT0gJkRSQ01SKDE1KSwKLQkuZGNtZAkJCT0gRENNRF9JTkNUUkdBRERSIHwgRENNRF9GTE9X
U1JDIHwKLQkJCQkgIERDTURfQlVSU1QxNiB8IERDTURfV0lEVEgyLAotfTsKLQotc3RhdGljIHN0
cnVjdCBweGEyeHhfcGNtX2RtYV9wYXJhbXMgcHhhX3NzcDJfcGNtX3N0ZXJlb19vdXQgPSB7Ci0J
Lm5hbWUJCQk9ICJTU1AyIFBDTSBTdGVyZW8gb3V0IiwKLQkuZGV2X2FkZHIJCT0gUFhBMjd4X1NT
UDJfQkFTRSArIFNTRFIsCi0JLmRyY21yCQkJPSAmRFJDTVIoMTYpLAotCS5kY21kCQkJPSBEQ01E
X0lOQ1NSQ0FERFIgfCBEQ01EX0ZMT1dUUkcgfAotCQkJCSAgRENNRF9CVVJTVDE2IHwgRENNRF9X
SURUSDQsCi19OwotCi1zdGF0aWMgc3RydWN0IHB4YTJ4eF9wY21fZG1hX3BhcmFtcyBweGFfc3Nw
Ml9wY21fc3RlcmVvX2luID0gewotCS5uYW1lCQkJPSAiU1NQMiBQQ00gU3RlcmVvIGluIiwKLQku
ZGV2X2FkZHIJCT0gUFhBMjd4X1NTUDJfQkFTRSArIFNTRFIsCi0JLmRyY21yCQkJPSAmRFJDTVIo
MTUpLAotCS5kY21kCQkJPSBEQ01EX0lOQ1RSR0FERFIgfCBEQ01EX0ZMT1dTUkMgfAotCQkJCSAg
RENNRF9CVVJTVDE2IHwgRENNRF9XSURUSDQsCi19OwotCi1zdGF0aWMgc3RydWN0IHB4YTJ4eF9w
Y21fZG1hX3BhcmFtcyBweGFfc3NwM19wY21fbW9ub19vdXQgPSB7Ci0JLm5hbWUJCQk9ICJTU1Az
IFBDTSBNb25vIG91dCIsCi0JLmRldl9hZGRyCQk9IFBYQTI3eF9TU1AzX0JBU0UgKyBTU0RSLAot
CS5kcmNtcgkJCT0gJkRSQ01SKDY3KSwKLQkuZGNtZAkJCT0gRENNRF9JTkNTUkNBRERSIHwgRENN
RF9GTE9XVFJHIHwKLQkJCQkgIERDTURfQlVSU1QxNiB8IERDTURfV0lEVEgyLAotfTsKLQotc3Rh
dGljIHN0cnVjdCBweGEyeHhfcGNtX2RtYV9wYXJhbXMgcHhhX3NzcDNfcGNtX21vbm9faW4gPSB7
Ci0JLm5hbWUJCQk9ICJTU1AzIFBDTSBNb25vIGluIiwKLQkuZGV2X2FkZHIJCT0gUFhBMjd4X1NT
UDNfQkFTRSArIFNTRFIsCi0JLmRyY21yCQkJPSAmRFJDTVIoNjYpLAotCS5kY21kCQkJPSBEQ01E
X0lOQ1RSR0FERFIgfCBEQ01EX0ZMT1dTUkMgfAotCQkJCSAgRENNRF9CVVJTVDE2IHwgRENNRF9X
SURUSDIsCi19OwotCi1zdGF0aWMgc3RydWN0IHB4YTJ4eF9wY21fZG1hX3BhcmFtcyBweGFfc3Nw
M19wY21fc3RlcmVvX291dCA9IHsKLQkubmFtZQkJCT0gIlNTUDMgUENNIFN0ZXJlbyBvdXQiLAot
CS5kZXZfYWRkcgkJPSBQWEEyN3hfU1NQM19CQVNFICsgU1NEUiwKLQkuZHJjbXIJCQk9ICZEUkNN
Uig2NyksCi0JLmRjbWQJCQk9IERDTURfSU5DU1JDQUREUiB8IERDTURfRkxPV1RSRyB8Ci0JCQkJ
ICBEQ01EX0JVUlNUMTYgfCBEQ01EX1dJRFRINCwKLX07Ci0KLXN0YXRpYyBzdHJ1Y3QgcHhhMnh4
X3BjbV9kbWFfcGFyYW1zIHB4YV9zc3AzX3BjbV9zdGVyZW9faW4gPSB7Ci0JLm5hbWUJCQk9ICJT
U1AzIFBDTSBTdGVyZW8gaW4iLAotCS5kZXZfYWRkcgkJPSBQWEEyN3hfU1NQM19CQVNFICsgU1NE
UiwKLQkuZHJjbXIJCQk9ICZEUkNNUig2NiksCi0JLmRjbWQJCQk9IERDTURfSU5DVFJHQUREUiB8
IERDTURfRkxPV1NSQyB8Ci0JCQkJICBEQ01EX0JVUlNUMTYgfCBEQ01EX1dJRFRINCwKLX07Ci0K
LXN0YXRpYyBzdHJ1Y3QgcHhhMnh4X3BjbV9kbWFfcGFyYW1zIHB4YV9zc3A0X3BjbV9tb25vX291
dCA9IHsKLQkubmFtZQkJCT0gIlNTUDQgUENNIE1vbm8gb3V0IiwKLQkuZGV2X2FkZHIJCT0gUFhB
M3h4X1NTUDRfQkFTRSArIFNTRFIsCi0JLmRyY21yCQkJPSAmRFJDTVIoNjcpLAotCS5kY21kCQkJ
PSBEQ01EX0lOQ1NSQ0FERFIgfCBEQ01EX0ZMT1dUUkcgfAotCQkJCSAgRENNRF9CVVJTVDE2IHwg
RENNRF9XSURUSDIsCi19OwotCi1zdGF0aWMgc3RydWN0IHB4YTJ4eF9wY21fZG1hX3BhcmFtcyBw
eGFfc3NwNF9wY21fbW9ub19pbiA9IHsKLQkubmFtZQkJCT0gIlNTUDQgUENNIE1vbm8gaW4iLAot
CS5kZXZfYWRkcgkJPSBQWEEzeHhfU1NQNF9CQVNFICsgU1NEUiwKLQkuZHJjbXIJCQk9ICZEUkNN
Uig2NiksCi0JLmRjbWQJCQk9IERDTURfSU5DVFJHQUREUiB8IERDTURfRkxPV1NSQyB8Ci0JCQkJ
ICBEQ01EX0JVUlNUMTYgfCBEQ01EX1dJRFRIMiwKLX07Ci0KLXN0YXRpYyBzdHJ1Y3QgcHhhMnh4
X3BjbV9kbWFfcGFyYW1zIHB4YV9zc3A0X3BjbV9zdGVyZW9fb3V0ID0gewotCS5uYW1lCQkJPSAi
U1NQNCBQQ00gU3RlcmVvIG91dCIsCi0JLmRldl9hZGRyCQk9IFBYQTN4eF9TU1A0X0JBU0UgKyBT
U0RSLAotCS5kcmNtcgkJCT0gJkRSQ01SKDY3KSwKLQkuZGNtZAkJCT0gRENNRF9JTkNTUkNBRERS
IHwgRENNRF9GTE9XVFJHIHwKLQkJCQkgIERDTURfQlVSU1QxNiB8IERDTURfV0lEVEg0LAotfTsK
LQotc3RhdGljIHN0cnVjdCBweGEyeHhfcGNtX2RtYV9wYXJhbXMgcHhhX3NzcDRfcGNtX3N0ZXJl
b19pbiA9IHsKLQkubmFtZQkJCT0gIlNTUDQgUENNIFN0ZXJlbyBpbiIsCi0JLmRldl9hZGRyCQk9
IFBYQTN4eF9TU1A0X0JBU0UgKyBTU0RSLAotCS5kcmNtcgkJCT0gJkRSQ01SKDY2KSwKLQkuZGNt
ZAkJCT0gRENNRF9JTkNUUkdBRERSIHwgRENNRF9GTE9XU1JDIHwKLQkJCQkgIERDTURfQlVSU1Qx
NiB8IERDTURfV0lEVEg0LAotfTsKLQogc3RhdGljIHZvaWQgZHVtcF9yZWdpc3RlcnMoc3RydWN0
IHNzcF9kZXZpY2UgKnNzcCkKIHsKIAlkZXZfZGJnKCZzc3AtPnBkZXYtPmRldiwgIlNTQ1IwIDB4
JTA4eCBTU0NSMSAweCUwOHggU1NUTyAweCUwOHhcbiIsCkBAIC0xOTQsMjUgKzYxLDMzIEBAIHN0
YXRpYyB2b2lkIGR1bXBfcmVnaXN0ZXJzKHN0cnVjdCBzc3BfZGV2aWNlICpzc3ApCiAJCSBzc3Bf
cmVhZF9yZWcoc3NwLCBTU0FDRCkpOwogfQogCi1zdGF0aWMgc3RydWN0IHB4YTJ4eF9wY21fZG1h
X3BhcmFtcyAqc3NwX2RtYV9wYXJhbXNbNF1bNF0gPSB7Ci0JewotCQkmcHhhX3NzcDFfcGNtX21v
bm9fb3V0LCAmcHhhX3NzcDFfcGNtX21vbm9faW4sCi0JCSZweGFfc3NwMV9wY21fc3RlcmVvX291
dCwgJnB4YV9zc3AxX3BjbV9zdGVyZW9faW4sCi0JfSwKLQl7Ci0JCSZweGFfc3NwMl9wY21fbW9u
b19vdXQsICZweGFfc3NwMl9wY21fbW9ub19pbiwKLQkJJnB4YV9zc3AyX3BjbV9zdGVyZW9fb3V0
LCAmcHhhX3NzcDJfcGNtX3N0ZXJlb19pbiwKLQl9LAotCXsKLQkJJnB4YV9zc3AzX3BjbV9tb25v
X291dCwgJnB4YV9zc3AzX3BjbV9tb25vX2luLAotCQkmcHhhX3NzcDNfcGNtX3N0ZXJlb19vdXQs
ICZweGFfc3NwM19wY21fc3RlcmVvX2luLAotCX0sCi0JewotCQkmcHhhX3NzcDRfcGNtX21vbm9f
b3V0LCAmcHhhX3NzcDRfcGNtX21vbm9faW4sCi0JCSZweGFfc3NwNF9wY21fc3RlcmVvX291dCwg
JnB4YV9zc3A0X3BjbV9zdGVyZW9faW4sCi0JfSwKK3N0cnVjdCBweGEyeHhfcGNtX2RtYV9kYXRh
IHsKKwlzdHJ1Y3QgcHhhMnh4X3BjbV9kbWFfcGFyYW1zIHBhcmFtczsKKwljaGFyIG5hbWVbMjBd
OwogfTsKIAorc3RhdGljIHN0cnVjdCBweGEyeHhfcGNtX2RtYV9wYXJhbXMgKgorc3NwX2dldF9k
bWFfcGFyYW1zKHN0cnVjdCBzc3BfZGV2aWNlICpzc3AsIGludCBzdGVyZW8sIGludCBvdXQpCit7
CisJc3RydWN0IHB4YTJ4eF9wY21fZG1hX2RhdGEgKmRtYTsKKworCWRtYSA9IGt6YWxsb2Moc2l6
ZW9mKHN0cnVjdCBweGEyeHhfcGNtX2RtYV9kYXRhKSwgR0ZQX0tFUk5FTCk7CisJaWYgKGRtYSA9
PSBOVUxMKQorCQlyZXR1cm4gTlVMTDsKKworCXNucHJpbnRmKGRtYS0+bmFtZSwgMjAsICJTU1Al
ZCBQQ00gJXMgJXMiLCBzc3AtPnBvcnRfaWQsCisJCQlzdGVyZW8gPyAiU3RlcmVvIiA6ICJNb25v
Iiwgb3V0ID8gIm91dCIgOiAiaW4iKTsKKworCWRtYS0+cGFyYW1zLm5hbWUgPSBkbWEtPm5hbWU7
CisJZG1hLT5wYXJhbXMuZHJjbXIgPSAmRFJDTVIob3V0ID8gc3NwLT5kcmNtcl90eCA6IHNzcC0+
ZHJjbXJfcngpOworCWRtYS0+cGFyYW1zLmRjbWQgPSAob3V0ID8gKERDTURfSU5DU1JDQUREUiB8
IERDTURfRkxPV1RSRykgOgorCQkJCSAgKERDTURfSU5DVFJHQUREUiB8IERDTURfRkxPV1NSQykp
IHwKKwkJCShzdGVyZW8gPyBEQ01EX1dJRFRINCA6IERDTURfV0lEVEgyKSB8IERDTURfQlVSU1Qx
NjsKKwlkbWEtPnBhcmFtcy5kZXZfYWRkciA9IHNzcC0+cGh5c19iYXNlICsgU1NEUjsKKworCXJl
dHVybiAmZG1hLT5wYXJhbXM7Cit9CisKIHN0YXRpYyBpbnQgcHhhX3NzcF9zdGFydHVwKHN0cnVj
dCBzbmRfcGNtX3N1YnN0cmVhbSAqc3Vic3RyZWFtLAogCQkJICAgc3RydWN0IHNuZF9zb2NfZGFp
ICpkYWkpCiB7CkBAIC0yMjcsNiArMTAyLDExIEBAIHN0YXRpYyBpbnQgcHhhX3NzcF9zdGFydHVw
KHN0cnVjdCBzbmRfcGNtX3N1YnN0cmVhbSAqc3Vic3RyZWFtLAogCQljbGtfZW5hYmxlKHByaXYt
PmRldi5zc3AtPmNsayk7CiAJCXNzcF9kaXNhYmxlKCZwcml2LT5kZXYpOwogCX0KKworCWlmIChj
cHVfZGFpLT5kbWFfZGF0YSkgeworCQlrZnJlZShjcHVfZGFpLT5kbWFfZGF0YSk7CisJCWNwdV9k
YWktPmRtYV9kYXRhID0gTlVMTDsKKwl9CiAJcmV0dXJuIHJldDsKIH0KIApAQCAtMjQxLDYgKzEy
MSwxMSBAQCBzdGF0aWMgdm9pZCBweGFfc3NwX3NodXRkb3duKHN0cnVjdCBzbmRfcGNtX3N1YnN0
cmVhbSAqc3Vic3RyZWFtLAogCQlzc3BfZGlzYWJsZSgmcHJpdi0+ZGV2KTsKIAkJY2xrX2Rpc2Fi
bGUocHJpdi0+ZGV2LnNzcC0+Y2xrKTsKIAl9CisKKwlpZiAoY3B1X2RhaS0+ZG1hX2RhdGEpIHsK
KwkJa2ZyZWUoY3B1X2RhaS0+ZG1hX2RhdGEpOworCQljcHVfZGFpLT5kbWFfZGF0YSA9IE5VTEw7
CisJfQogfQogCiAjaWZkZWYgQ09ORklHX1BNCkBAIC02NTMsMjUgKzUzOCwyMyBAQCBzdGF0aWMg
aW50IHB4YV9zc3BfaHdfcGFyYW1zKHN0cnVjdCBzbmRfcGNtX3N1YnN0cmVhbSAqc3Vic3RyZWFt
LAogCXN0cnVjdCBzbmRfc29jX2RhaSAqY3B1X2RhaSA9IHJ0ZC0+ZGFpLT5jcHVfZGFpOwogCXN0
cnVjdCBzc3BfcHJpdiAqcHJpdiA9IGNwdV9kYWktPnByaXZhdGVfZGF0YTsKIAlzdHJ1Y3Qgc3Nw
X2RldmljZSAqc3NwID0gcHJpdi0+ZGV2LnNzcDsKLQlpbnQgZG1hID0gMCwgY2huID0gcGFyYW1z
X2NoYW5uZWxzKHBhcmFtcyk7CisJaW50IGNobiA9IHBhcmFtc19jaGFubmVscyhwYXJhbXMpOwog
CXUzMiBzc2NyMDsKIAl1MzIgc3Nwc3A7CiAJaW50IHdpZHRoID0gc25kX3BjbV9mb3JtYXRfcGh5
c2ljYWxfd2lkdGgocGFyYW1zX2Zvcm1hdChwYXJhbXMpKTsKIAlpbnQgdHRzYSA9IHNzcF9yZWFk
X3JlZyhzc3AsIFNTVFNBKSAmIDB4ZjsKIAotCS8qIHNlbGVjdCBjb3JyZWN0IERNQSBwYXJhbXMg
Ki8KLQlpZiAoc3Vic3RyZWFtLT5zdHJlYW0gIT0gU05EUlZfUENNX1NUUkVBTV9QTEFZQkFDSykK
LQkJZG1hID0gMTsgLyogY2FwdHVyZSBETUEgb2Zmc2V0IGlzIDEsMyAqLworCS8qIGdlbmVyYXRl
IGNvcnJlY3QgRE1BIHBhcmFtcyAqLworCWlmIChjcHVfZGFpLT5kbWFfZGF0YSkKKwkJa2ZyZWUo
Y3B1X2RhaS0+ZG1hX2RhdGEpOworCiAJLyogTmV0d29yayBtb2RlIHdpdGggb25lIGFjdGl2ZSBz
bG90ICh0dHNhID09IDEpIGNhbiBiZSB1c2VkCiAJICogdG8gZm9yY2UgMTYtYml0IGZyYW1lIHdp
ZHRoIG9uIHRoZSB3aXJlIChmb3IgUzE2X0xFKSwgZXZlbgogCSAqIHdpdGggdHdvIGNoYW5uZWxz
LiBVc2UgMTYtYml0IERNQSB0cmFuc2ZlcnMgZm9yIHRoaXMgY2FzZS4KIAkgKi8KLQlpZiAoKChj
aG4gPT0gMikgJiYgKHR0c2EgIT0gMSkpIHx8ICh3aWR0aCA9PSAzMikpCi0JCWRtYSArPSAyOyAv
KiAzMi1iaXQgRE1BIG9mZnNldCBpcyAyLCAxNi1iaXQgaXMgMCAqLwotCi0JY3B1X2RhaS0+ZG1h
X2RhdGEgPSBzc3BfZG1hX3BhcmFtc1tjcHVfZGFpLT5pZF1bZG1hXTsKLQotCWRldl9kYmcoJnNz
cC0+cGRldi0+ZGV2LCAicHhhX3NzcF9od19wYXJhbXM6IGRtYSAlZFxuIiwgZG1hKTsKKwljcHVf
ZGFpLT5kbWFfZGF0YSA9IHNzcF9nZXRfZG1hX3BhcmFtcyhzc3AsCisJCQkoKGNobiA9PSAyKSAm
JiAodHRzYSAhPSAxKSkgfHwgKHdpZHRoID09IDMyKSwKKwkJCXN1YnN0cmVhbS0+c3RyZWFtID09
IFNORFJWX1BDTV9TVFJFQU1fUExBWUJBQ0spOwogCiAJLyogd2UgY2FuIG9ubHkgY2hhbmdlIHRo
ZSBzZXR0aW5ncyBpZiB0aGUgcG9ydCBpcyBub3QgaW4gdXNlICovCiAJaWYgKHNzcF9yZWFkX3Jl
Zyhzc3AsIFNTQ1IwKSAmIFNTQ1IwX1NTRSkKLS0gCjEuNi4wLjQKCg==
--0016364ee0220e5a4e0468352f08
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0016364ee0220e5a4e0468352f08--
