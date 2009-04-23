From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [RFC PATCH 5/5] ASoC: simplify the SSP DMA
	parameters settings by run-time generation
Date: Thu, 23 Apr 2009 17:41:55 +0800
Message-ID: <f17812d70904230241y31291230j85646ac09a72a3cd@mail.gmail.com>
References: <f17812d70904222208i79604f3evb9950d6351377a83@mail.gmail.com>
	<74d0deb30904230153l5ec490eck211d6ef456869f36@mail.gmail.com>
	<f17812d70904230202t5dc459bbud36c13b11c6d5725@mail.gmail.com>
	<20090423090810.GD30105@sirena.org.uk>
	<f17812d70904230228j394713cbj4f99803d6031387d@mail.gmail.com>
	<20090423093435.GH30105@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016364eef74c9234b046835b0db
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 53F441037F4
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Apr 2009 11:41:56 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 4so387216qwk.56
	for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2009 02:41:55 -0700 (PDT)
In-Reply-To: <20090423093435.GH30105@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, Paul Shen <bshen9@marvell.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, pHilipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

--0016364eef74c9234b046835b0db
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Thu, Apr 23, 2009 at 5:34 PM, Mark Brown <broonie@sirena.org.uk> wrote:
> On Thu, Apr 23, 2009 at 05:28:26PM +0800, Eric Miao wrote:
>
>> So that's going to change the dma->name as something below:
>
>> "SSP3 PCM 32-bit out"
>
>> Looks sane?
>
>> With the code:
>
> Yup, looks sensible - please submit an incremental patch for this.
>

I'd prefer this being added to the original one, provided that you haven't
merged and pushed to public. Patch below:

>From 3deaf3ce439790668fd3f04142326cf84cb71b39 Mon Sep 17 00:00:00 2001
From: Eric Miao <eric.miao@marvell.com>
Date: Thu, 23 Apr 2009 10:58:34 +0800
Subject: [PATCH] ASoC: simplify the SSP DMA parameters settings by
run-time generation

The SSP DMA parameters can actually be easily generated at run-time since
they are almost similar except for the FIFO width and direction. Another
benefit is the re-use of information from 'struct ssp_device', like SSDR
physical FIFO address and DRCMR register index for both directions.

In addition, the name of the DMA parameter has been changed to something
like:

  "SSP3 PCM 16-bit out" or "SSP3 PCM 32-bit in"

instead of the original "Stereo" and "Mono". This is more consistent with
the code.

Signed-off-by: Eric Miao <eric.miao@marvell.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Reviewed-by: pHilipp Zabel <philipp.zabel@gmail.com>
---
 sound/soc/pxa/pxa-ssp.c |  203 ++++++++++-------------------------------------
 1 files changed, 43 insertions(+), 160 deletions(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index b9b61dd..6fc7876 100644
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
+ssp_get_dma_params(struct ssp_device *ssp, int width4, int out)
+{
+	struct pxa2xx_pcm_dma_data *dma;
+
+	dma = kzalloc(sizeof(struct pxa2xx_pcm_dma_data), GFP_KERNEL);
+	if (dma == NULL)
+		return NULL;
+
+	snprintf(dma->name, 20, "SSP%d PCM %s %s", ssp->port_id,
+			width4 ? "32-bit" : "16-bit", out ? "out" : "in");
+
+	dma->params.name = dma->name;
+	dma->params.drcmr = &DRCMR(out ? ssp->drcmr_tx : ssp->drcmr_rx);
+	dma->params.dcmd = (out ? (DCMD_INCSRCADDR | DCMD_FLOWTRG) :
+				  (DCMD_INCTRGADDR | DCMD_FLOWSRC)) |
+			(width4 ? DCMD_WIDTH4 : DCMD_WIDTH2) | DCMD_BURST16;
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

--0016364eef74c9234b046835b0db
Content-Type: text/x-diff; charset=US-ASCII;
	name="0001-ASoC-simplify-the-SSP-DMA-parameters-settings-by-ru.patch"
Content-Disposition: attachment;
	filename="0001-ASoC-simplify-the-SSP-DMA-parameters-settings-by-ru.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ftv9ixzn0

RnJvbSAzZGVhZjNjZTQzOTc5MDY2OGZkM2YwNDE0MjMyNmNmODRjYjcxYjM5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFcmljIE1pYW8gPGVyaWMubWlhb0BtYXJ2ZWxsLmNvbT4KRGF0
ZTogVGh1LCAyMyBBcHIgMjAwOSAxMDo1ODozNCArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIEFTb0M6
IHNpbXBsaWZ5IHRoZSBTU1AgRE1BIHBhcmFtZXRlcnMgc2V0dGluZ3MgYnkgcnVuLXRpbWUgZ2Vu
ZXJhdGlvbgoKVGhlIFNTUCBETUEgcGFyYW1ldGVycyBjYW4gYWN0dWFsbHkgYmUgZWFzaWx5IGdl
bmVyYXRlZCBhdCBydW4tdGltZSBzaW5jZQp0aGV5IGFyZSBhbG1vc3Qgc2ltaWxhciBleGNlcHQg
Zm9yIHRoZSBGSUZPIHdpZHRoIGFuZCBkaXJlY3Rpb24uIEFub3RoZXIKYmVuZWZpdCBpcyB0aGUg
cmUtdXNlIG9mIGluZm9ybWF0aW9uIGZyb20gJ3N0cnVjdCBzc3BfZGV2aWNlJywgbGlrZSBTU0RS
CnBoeXNpY2FsIEZJRk8gYWRkcmVzcyBhbmQgRFJDTVIgcmVnaXN0ZXIgaW5kZXggZm9yIGJvdGgg
ZGlyZWN0aW9ucy4KCkluIGFkZGl0aW9uLCB0aGUgbmFtZSBvZiB0aGUgRE1BIHBhcmFtZXRlciBo
YXMgYmVlbiBjaGFuZ2VkIHRvIHNvbWV0aGluZwpsaWtlOgoKICAiU1NQMyBQQ00gMTYtYml0IG91
dCIgb3IgIlNTUDMgUENNIDMyLWJpdCBpbiIKCmluc3RlYWQgb2YgdGhlIG9yaWdpbmFsICJTdGVy
ZW8iIGFuZCAiTW9ubyIuIFRoaXMgaXMgbW9yZSBjb25zaXN0ZW50IHdpdGgKdGhlIGNvZGUuCgpT
aWduZWQtb2ZmLWJ5OiBFcmljIE1pYW8gPGVyaWMubWlhb0BtYXJ2ZWxsLmNvbT4KU2lnbmVkLW9m
Zi1ieTogTWFyayBCcm93biA8YnJvb25pZUBvcGVuc291cmNlLndvbGZzb25taWNyby5jb20+ClJl
dmlld2VkLWJ5OiBwSGlsaXBwIFphYmVsIDxwaGlsaXBwLnphYmVsQGdtYWlsLmNvbT4KLS0tCiBz
b3VuZC9zb2MvcHhhL3B4YS1zc3AuYyB8ICAyMDMgKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZXMgY2hhbmdlZCwgNDMgaW5zZXJ0aW9ucygrKSwg
MTYwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9weGEvcHhhLXNzcC5jIGIv
c291bmQvc29jL3B4YS9weGEtc3NwLmMKaW5kZXggYjliNjFkZC4uNmZjNzg3NiAxMDA2NDQKLS0t
IGEvc291bmQvc29jL3B4YS9weGEtc3NwLmMKKysrIGIvc291bmQvc29jL3B4YS9weGEtc3NwLmMK
QEAgLTUwLDEzOSArNTAsNiBAQCBzdHJ1Y3Qgc3NwX3ByaXYgewogI2VuZGlmCiB9OwogCi0jZGVm
aW5lIFBYQTJ4eF9TU1AxX0JBU0UJMHg0MTAwMDAwMAotI2RlZmluZSBQWEEyN3hfU1NQMl9CQVNF
CTB4NDE3MDAwMDAKLSNkZWZpbmUgUFhBMjd4X1NTUDNfQkFTRQkweDQxOTAwMDAwCi0jZGVmaW5l
IFBYQTN4eF9TU1A0X0JBU0UJMHg0MWEwMDAwMAotCi1zdGF0aWMgc3RydWN0IHB4YTJ4eF9wY21f
ZG1hX3BhcmFtcyBweGFfc3NwMV9wY21fbW9ub19vdXQgPSB7Ci0JLm5hbWUJCQk9ICJTU1AxIFBD
TSBNb25vIG91dCIsCi0JLmRldl9hZGRyCQk9IFBYQTJ4eF9TU1AxX0JBU0UgKyBTU0RSLAotCS5k
cmNtcgkJCT0gJkRSQ01SKDE0KSwKLQkuZGNtZAkJCT0gRENNRF9JTkNTUkNBRERSIHwgRENNRF9G
TE9XVFJHIHwKLQkJCQkgIERDTURfQlVSU1QxNiB8IERDTURfV0lEVEgyLAotfTsKLQotc3RhdGlj
IHN0cnVjdCBweGEyeHhfcGNtX2RtYV9wYXJhbXMgcHhhX3NzcDFfcGNtX21vbm9faW4gPSB7Ci0J
Lm5hbWUJCQk9ICJTU1AxIFBDTSBNb25vIGluIiwKLQkuZGV2X2FkZHIJCT0gUFhBMnh4X1NTUDFf
QkFTRSArIFNTRFIsCi0JLmRyY21yCQkJPSAmRFJDTVIoMTMpLAotCS5kY21kCQkJPSBEQ01EX0lO
Q1RSR0FERFIgfCBEQ01EX0ZMT1dTUkMgfAotCQkJCSAgRENNRF9CVVJTVDE2IHwgRENNRF9XSURU
SDIsCi19OwotCi1zdGF0aWMgc3RydWN0IHB4YTJ4eF9wY21fZG1hX3BhcmFtcyBweGFfc3NwMV9w
Y21fc3RlcmVvX291dCA9IHsKLQkubmFtZQkJCT0gIlNTUDEgUENNIFN0ZXJlbyBvdXQiLAotCS5k
ZXZfYWRkcgkJPSBQWEEyeHhfU1NQMV9CQVNFICsgU1NEUiwKLQkuZHJjbXIJCQk9ICZEUkNNUigx
NCksCi0JLmRjbWQJCQk9IERDTURfSU5DU1JDQUREUiB8IERDTURfRkxPV1RSRyB8Ci0JCQkJICBE
Q01EX0JVUlNUMTYgfCBEQ01EX1dJRFRINCwKLX07Ci0KLXN0YXRpYyBzdHJ1Y3QgcHhhMnh4X3Bj
bV9kbWFfcGFyYW1zIHB4YV9zc3AxX3BjbV9zdGVyZW9faW4gPSB7Ci0JLm5hbWUJCQk9ICJTU1Ax
IFBDTSBTdGVyZW8gaW4iLAotCS5kZXZfYWRkcgkJPSBQWEEyeHhfU1NQMV9CQVNFICsgU1NEUiwK
LQkuZHJjbXIJCQk9ICZEUkNNUigxMyksCi0JLmRjbWQJCQk9IERDTURfSU5DVFJHQUREUiB8IERD
TURfRkxPV1NSQyB8Ci0JCQkJICBEQ01EX0JVUlNUMTYgfCBEQ01EX1dJRFRINCwKLX07Ci0KLXN0
YXRpYyBzdHJ1Y3QgcHhhMnh4X3BjbV9kbWFfcGFyYW1zIHB4YV9zc3AyX3BjbV9tb25vX291dCA9
IHsKLQkubmFtZQkJCT0gIlNTUDIgUENNIE1vbm8gb3V0IiwKLQkuZGV2X2FkZHIJCT0gUFhBMjd4
X1NTUDJfQkFTRSArIFNTRFIsCi0JLmRyY21yCQkJPSAmRFJDTVIoMTYpLAotCS5kY21kCQkJPSBE
Q01EX0lOQ1NSQ0FERFIgfCBEQ01EX0ZMT1dUUkcgfAotCQkJCSAgRENNRF9CVVJTVDE2IHwgRENN
RF9XSURUSDIsCi19OwotCi1zdGF0aWMgc3RydWN0IHB4YTJ4eF9wY21fZG1hX3BhcmFtcyBweGFf
c3NwMl9wY21fbW9ub19pbiA9IHsKLQkubmFtZQkJCT0gIlNTUDIgUENNIE1vbm8gaW4iLAotCS5k
ZXZfYWRkcgkJPSBQWEEyN3hfU1NQMl9CQVNFICsgU1NEUiwKLQkuZHJjbXIJCQk9ICZEUkNNUigx
NSksCi0JLmRjbWQJCQk9IERDTURfSU5DVFJHQUREUiB8IERDTURfRkxPV1NSQyB8Ci0JCQkJICBE
Q01EX0JVUlNUMTYgfCBEQ01EX1dJRFRIMiwKLX07Ci0KLXN0YXRpYyBzdHJ1Y3QgcHhhMnh4X3Bj
bV9kbWFfcGFyYW1zIHB4YV9zc3AyX3BjbV9zdGVyZW9fb3V0ID0gewotCS5uYW1lCQkJPSAiU1NQ
MiBQQ00gU3RlcmVvIG91dCIsCi0JLmRldl9hZGRyCQk9IFBYQTI3eF9TU1AyX0JBU0UgKyBTU0RS
LAotCS5kcmNtcgkJCT0gJkRSQ01SKDE2KSwKLQkuZGNtZAkJCT0gRENNRF9JTkNTUkNBRERSIHwg
RENNRF9GTE9XVFJHIHwKLQkJCQkgIERDTURfQlVSU1QxNiB8IERDTURfV0lEVEg0LAotfTsKLQot
c3RhdGljIHN0cnVjdCBweGEyeHhfcGNtX2RtYV9wYXJhbXMgcHhhX3NzcDJfcGNtX3N0ZXJlb19p
biA9IHsKLQkubmFtZQkJCT0gIlNTUDIgUENNIFN0ZXJlbyBpbiIsCi0JLmRldl9hZGRyCQk9IFBY
QTI3eF9TU1AyX0JBU0UgKyBTU0RSLAotCS5kcmNtcgkJCT0gJkRSQ01SKDE1KSwKLQkuZGNtZAkJ
CT0gRENNRF9JTkNUUkdBRERSIHwgRENNRF9GTE9XU1JDIHwKLQkJCQkgIERDTURfQlVSU1QxNiB8
IERDTURfV0lEVEg0LAotfTsKLQotc3RhdGljIHN0cnVjdCBweGEyeHhfcGNtX2RtYV9wYXJhbXMg
cHhhX3NzcDNfcGNtX21vbm9fb3V0ID0gewotCS5uYW1lCQkJPSAiU1NQMyBQQ00gTW9ubyBvdXQi
LAotCS5kZXZfYWRkcgkJPSBQWEEyN3hfU1NQM19CQVNFICsgU1NEUiwKLQkuZHJjbXIJCQk9ICZE
UkNNUig2NyksCi0JLmRjbWQJCQk9IERDTURfSU5DU1JDQUREUiB8IERDTURfRkxPV1RSRyB8Ci0J
CQkJICBEQ01EX0JVUlNUMTYgfCBEQ01EX1dJRFRIMiwKLX07Ci0KLXN0YXRpYyBzdHJ1Y3QgcHhh
Mnh4X3BjbV9kbWFfcGFyYW1zIHB4YV9zc3AzX3BjbV9tb25vX2luID0gewotCS5uYW1lCQkJPSAi
U1NQMyBQQ00gTW9ubyBpbiIsCi0JLmRldl9hZGRyCQk9IFBYQTI3eF9TU1AzX0JBU0UgKyBTU0RS
LAotCS5kcmNtcgkJCT0gJkRSQ01SKDY2KSwKLQkuZGNtZAkJCT0gRENNRF9JTkNUUkdBRERSIHwg
RENNRF9GTE9XU1JDIHwKLQkJCQkgIERDTURfQlVSU1QxNiB8IERDTURfV0lEVEgyLAotfTsKLQot
c3RhdGljIHN0cnVjdCBweGEyeHhfcGNtX2RtYV9wYXJhbXMgcHhhX3NzcDNfcGNtX3N0ZXJlb19v
dXQgPSB7Ci0JLm5hbWUJCQk9ICJTU1AzIFBDTSBTdGVyZW8gb3V0IiwKLQkuZGV2X2FkZHIJCT0g
UFhBMjd4X1NTUDNfQkFTRSArIFNTRFIsCi0JLmRyY21yCQkJPSAmRFJDTVIoNjcpLAotCS5kY21k
CQkJPSBEQ01EX0lOQ1NSQ0FERFIgfCBEQ01EX0ZMT1dUUkcgfAotCQkJCSAgRENNRF9CVVJTVDE2
IHwgRENNRF9XSURUSDQsCi19OwotCi1zdGF0aWMgc3RydWN0IHB4YTJ4eF9wY21fZG1hX3BhcmFt
cyBweGFfc3NwM19wY21fc3RlcmVvX2luID0gewotCS5uYW1lCQkJPSAiU1NQMyBQQ00gU3RlcmVv
IGluIiwKLQkuZGV2X2FkZHIJCT0gUFhBMjd4X1NTUDNfQkFTRSArIFNTRFIsCi0JLmRyY21yCQkJ
PSAmRFJDTVIoNjYpLAotCS5kY21kCQkJPSBEQ01EX0lOQ1RSR0FERFIgfCBEQ01EX0ZMT1dTUkMg
fAotCQkJCSAgRENNRF9CVVJTVDE2IHwgRENNRF9XSURUSDQsCi19OwotCi1zdGF0aWMgc3RydWN0
IHB4YTJ4eF9wY21fZG1hX3BhcmFtcyBweGFfc3NwNF9wY21fbW9ub19vdXQgPSB7Ci0JLm5hbWUJ
CQk9ICJTU1A0IFBDTSBNb25vIG91dCIsCi0JLmRldl9hZGRyCQk9IFBYQTN4eF9TU1A0X0JBU0Ug
KyBTU0RSLAotCS5kcmNtcgkJCT0gJkRSQ01SKDY3KSwKLQkuZGNtZAkJCT0gRENNRF9JTkNTUkNB
RERSIHwgRENNRF9GTE9XVFJHIHwKLQkJCQkgIERDTURfQlVSU1QxNiB8IERDTURfV0lEVEgyLAot
fTsKLQotc3RhdGljIHN0cnVjdCBweGEyeHhfcGNtX2RtYV9wYXJhbXMgcHhhX3NzcDRfcGNtX21v
bm9faW4gPSB7Ci0JLm5hbWUJCQk9ICJTU1A0IFBDTSBNb25vIGluIiwKLQkuZGV2X2FkZHIJCT0g
UFhBM3h4X1NTUDRfQkFTRSArIFNTRFIsCi0JLmRyY21yCQkJPSAmRFJDTVIoNjYpLAotCS5kY21k
CQkJPSBEQ01EX0lOQ1RSR0FERFIgfCBEQ01EX0ZMT1dTUkMgfAotCQkJCSAgRENNRF9CVVJTVDE2
IHwgRENNRF9XSURUSDIsCi19OwotCi1zdGF0aWMgc3RydWN0IHB4YTJ4eF9wY21fZG1hX3BhcmFt
cyBweGFfc3NwNF9wY21fc3RlcmVvX291dCA9IHsKLQkubmFtZQkJCT0gIlNTUDQgUENNIFN0ZXJl
byBvdXQiLAotCS5kZXZfYWRkcgkJPSBQWEEzeHhfU1NQNF9CQVNFICsgU1NEUiwKLQkuZHJjbXIJ
CQk9ICZEUkNNUig2NyksCi0JLmRjbWQJCQk9IERDTURfSU5DU1JDQUREUiB8IERDTURfRkxPV1RS
RyB8Ci0JCQkJICBEQ01EX0JVUlNUMTYgfCBEQ01EX1dJRFRINCwKLX07Ci0KLXN0YXRpYyBzdHJ1
Y3QgcHhhMnh4X3BjbV9kbWFfcGFyYW1zIHB4YV9zc3A0X3BjbV9zdGVyZW9faW4gPSB7Ci0JLm5h
bWUJCQk9ICJTU1A0IFBDTSBTdGVyZW8gaW4iLAotCS5kZXZfYWRkcgkJPSBQWEEzeHhfU1NQNF9C
QVNFICsgU1NEUiwKLQkuZHJjbXIJCQk9ICZEUkNNUig2NiksCi0JLmRjbWQJCQk9IERDTURfSU5D
VFJHQUREUiB8IERDTURfRkxPV1NSQyB8Ci0JCQkJICBEQ01EX0JVUlNUMTYgfCBEQ01EX1dJRFRI
NCwKLX07Ci0KIHN0YXRpYyB2b2lkIGR1bXBfcmVnaXN0ZXJzKHN0cnVjdCBzc3BfZGV2aWNlICpz
c3ApCiB7CiAJZGV2X2RiZygmc3NwLT5wZGV2LT5kZXYsICJTU0NSMCAweCUwOHggU1NDUjEgMHgl
MDh4IFNTVE8gMHglMDh4XG4iLApAQCAtMTk0LDI1ICs2MSwzMyBAQCBzdGF0aWMgdm9pZCBkdW1w
X3JlZ2lzdGVycyhzdHJ1Y3Qgc3NwX2RldmljZSAqc3NwKQogCQkgc3NwX3JlYWRfcmVnKHNzcCwg
U1NBQ0QpKTsKIH0KIAotc3RhdGljIHN0cnVjdCBweGEyeHhfcGNtX2RtYV9wYXJhbXMgKnNzcF9k
bWFfcGFyYW1zWzRdWzRdID0gewotCXsKLQkJJnB4YV9zc3AxX3BjbV9tb25vX291dCwgJnB4YV9z
c3AxX3BjbV9tb25vX2luLAotCQkmcHhhX3NzcDFfcGNtX3N0ZXJlb19vdXQsICZweGFfc3NwMV9w
Y21fc3RlcmVvX2luLAotCX0sCi0JewotCQkmcHhhX3NzcDJfcGNtX21vbm9fb3V0LCAmcHhhX3Nz
cDJfcGNtX21vbm9faW4sCi0JCSZweGFfc3NwMl9wY21fc3RlcmVvX291dCwgJnB4YV9zc3AyX3Bj
bV9zdGVyZW9faW4sCi0JfSwKLQl7Ci0JCSZweGFfc3NwM19wY21fbW9ub19vdXQsICZweGFfc3Nw
M19wY21fbW9ub19pbiwKLQkJJnB4YV9zc3AzX3BjbV9zdGVyZW9fb3V0LCAmcHhhX3NzcDNfcGNt
X3N0ZXJlb19pbiwKLQl9LAotCXsKLQkJJnB4YV9zc3A0X3BjbV9tb25vX291dCwgJnB4YV9zc3A0
X3BjbV9tb25vX2luLAotCQkmcHhhX3NzcDRfcGNtX3N0ZXJlb19vdXQsICZweGFfc3NwNF9wY21f
c3RlcmVvX2luLAotCX0sCitzdHJ1Y3QgcHhhMnh4X3BjbV9kbWFfZGF0YSB7CisJc3RydWN0IHB4
YTJ4eF9wY21fZG1hX3BhcmFtcyBwYXJhbXM7CisJY2hhciBuYW1lWzIwXTsKIH07CiAKK3N0YXRp
YyBzdHJ1Y3QgcHhhMnh4X3BjbV9kbWFfcGFyYW1zICoKK3NzcF9nZXRfZG1hX3BhcmFtcyhzdHJ1
Y3Qgc3NwX2RldmljZSAqc3NwLCBpbnQgd2lkdGg0LCBpbnQgb3V0KQoreworCXN0cnVjdCBweGEy
eHhfcGNtX2RtYV9kYXRhICpkbWE7CisKKwlkbWEgPSBremFsbG9jKHNpemVvZihzdHJ1Y3QgcHhh
Mnh4X3BjbV9kbWFfZGF0YSksIEdGUF9LRVJORUwpOworCWlmIChkbWEgPT0gTlVMTCkKKwkJcmV0
dXJuIE5VTEw7CisKKwlzbnByaW50ZihkbWEtPm5hbWUsIDIwLCAiU1NQJWQgUENNICVzICVzIiwg
c3NwLT5wb3J0X2lkLAorCQkJd2lkdGg0ID8gIjMyLWJpdCIgOiAiMTYtYml0Iiwgb3V0ID8gIm91
dCIgOiAiaW4iKTsKKworCWRtYS0+cGFyYW1zLm5hbWUgPSBkbWEtPm5hbWU7CisJZG1hLT5wYXJh
bXMuZHJjbXIgPSAmRFJDTVIob3V0ID8gc3NwLT5kcmNtcl90eCA6IHNzcC0+ZHJjbXJfcngpOwor
CWRtYS0+cGFyYW1zLmRjbWQgPSAob3V0ID8gKERDTURfSU5DU1JDQUREUiB8IERDTURfRkxPV1RS
RykgOgorCQkJCSAgKERDTURfSU5DVFJHQUREUiB8IERDTURfRkxPV1NSQykpIHwKKwkJCSh3aWR0
aDQgPyBEQ01EX1dJRFRINCA6IERDTURfV0lEVEgyKSB8IERDTURfQlVSU1QxNjsKKwlkbWEtPnBh
cmFtcy5kZXZfYWRkciA9IHNzcC0+cGh5c19iYXNlICsgU1NEUjsKKworCXJldHVybiAmZG1hLT5w
YXJhbXM7Cit9CisKIHN0YXRpYyBpbnQgcHhhX3NzcF9zdGFydHVwKHN0cnVjdCBzbmRfcGNtX3N1
YnN0cmVhbSAqc3Vic3RyZWFtLAogCQkJICAgc3RydWN0IHNuZF9zb2NfZGFpICpkYWkpCiB7CkBA
IC0yMjcsNiArMTAyLDExIEBAIHN0YXRpYyBpbnQgcHhhX3NzcF9zdGFydHVwKHN0cnVjdCBzbmRf
cGNtX3N1YnN0cmVhbSAqc3Vic3RyZWFtLAogCQljbGtfZW5hYmxlKHByaXYtPmRldi5zc3AtPmNs
ayk7CiAJCXNzcF9kaXNhYmxlKCZwcml2LT5kZXYpOwogCX0KKworCWlmIChjcHVfZGFpLT5kbWFf
ZGF0YSkgeworCQlrZnJlZShjcHVfZGFpLT5kbWFfZGF0YSk7CisJCWNwdV9kYWktPmRtYV9kYXRh
ID0gTlVMTDsKKwl9CiAJcmV0dXJuIHJldDsKIH0KIApAQCAtMjQxLDYgKzEyMSwxMSBAQCBzdGF0
aWMgdm9pZCBweGFfc3NwX3NodXRkb3duKHN0cnVjdCBzbmRfcGNtX3N1YnN0cmVhbSAqc3Vic3Ry
ZWFtLAogCQlzc3BfZGlzYWJsZSgmcHJpdi0+ZGV2KTsKIAkJY2xrX2Rpc2FibGUocHJpdi0+ZGV2
LnNzcC0+Y2xrKTsKIAl9CisKKwlpZiAoY3B1X2RhaS0+ZG1hX2RhdGEpIHsKKwkJa2ZyZWUoY3B1
X2RhaS0+ZG1hX2RhdGEpOworCQljcHVfZGFpLT5kbWFfZGF0YSA9IE5VTEw7CisJfQogfQogCiAj
aWZkZWYgQ09ORklHX1BNCkBAIC02NTMsMjUgKzUzOCwyMyBAQCBzdGF0aWMgaW50IHB4YV9zc3Bf
aHdfcGFyYW1zKHN0cnVjdCBzbmRfcGNtX3N1YnN0cmVhbSAqc3Vic3RyZWFtLAogCXN0cnVjdCBz
bmRfc29jX2RhaSAqY3B1X2RhaSA9IHJ0ZC0+ZGFpLT5jcHVfZGFpOwogCXN0cnVjdCBzc3BfcHJp
diAqcHJpdiA9IGNwdV9kYWktPnByaXZhdGVfZGF0YTsKIAlzdHJ1Y3Qgc3NwX2RldmljZSAqc3Nw
ID0gcHJpdi0+ZGV2LnNzcDsKLQlpbnQgZG1hID0gMCwgY2huID0gcGFyYW1zX2NoYW5uZWxzKHBh
cmFtcyk7CisJaW50IGNobiA9IHBhcmFtc19jaGFubmVscyhwYXJhbXMpOwogCXUzMiBzc2NyMDsK
IAl1MzIgc3Nwc3A7CiAJaW50IHdpZHRoID0gc25kX3BjbV9mb3JtYXRfcGh5c2ljYWxfd2lkdGgo
cGFyYW1zX2Zvcm1hdChwYXJhbXMpKTsKIAlpbnQgdHRzYSA9IHNzcF9yZWFkX3JlZyhzc3AsIFNT
VFNBKSAmIDB4ZjsKIAotCS8qIHNlbGVjdCBjb3JyZWN0IERNQSBwYXJhbXMgKi8KLQlpZiAoc3Vi
c3RyZWFtLT5zdHJlYW0gIT0gU05EUlZfUENNX1NUUkVBTV9QTEFZQkFDSykKLQkJZG1hID0gMTsg
LyogY2FwdHVyZSBETUEgb2Zmc2V0IGlzIDEsMyAqLworCS8qIGdlbmVyYXRlIGNvcnJlY3QgRE1B
IHBhcmFtcyAqLworCWlmIChjcHVfZGFpLT5kbWFfZGF0YSkKKwkJa2ZyZWUoY3B1X2RhaS0+ZG1h
X2RhdGEpOworCiAJLyogTmV0d29yayBtb2RlIHdpdGggb25lIGFjdGl2ZSBzbG90ICh0dHNhID09
IDEpIGNhbiBiZSB1c2VkCiAJICogdG8gZm9yY2UgMTYtYml0IGZyYW1lIHdpZHRoIG9uIHRoZSB3
aXJlIChmb3IgUzE2X0xFKSwgZXZlbgogCSAqIHdpdGggdHdvIGNoYW5uZWxzLiBVc2UgMTYtYml0
IERNQSB0cmFuc2ZlcnMgZm9yIHRoaXMgY2FzZS4KIAkgKi8KLQlpZiAoKChjaG4gPT0gMikgJiYg
KHR0c2EgIT0gMSkpIHx8ICh3aWR0aCA9PSAzMikpCi0JCWRtYSArPSAyOyAvKiAzMi1iaXQgRE1B
IG9mZnNldCBpcyAyLCAxNi1iaXQgaXMgMCAqLwotCi0JY3B1X2RhaS0+ZG1hX2RhdGEgPSBzc3Bf
ZG1hX3BhcmFtc1tjcHVfZGFpLT5pZF1bZG1hXTsKLQotCWRldl9kYmcoJnNzcC0+cGRldi0+ZGV2
LCAicHhhX3NzcF9od19wYXJhbXM6IGRtYSAlZFxuIiwgZG1hKTsKKwljcHVfZGFpLT5kbWFfZGF0
YSA9IHNzcF9nZXRfZG1hX3BhcmFtcyhzc3AsCisJCQkoKGNobiA9PSAyKSAmJiAodHRzYSAhPSAx
KSkgfHwgKHdpZHRoID09IDMyKSwKKwkJCXN1YnN0cmVhbS0+c3RyZWFtID09IFNORFJWX1BDTV9T
VFJFQU1fUExBWUJBQ0spOwogCiAJLyogd2UgY2FuIG9ubHkgY2hhbmdlIHRoZSBzZXR0aW5ncyBp
ZiB0aGUgcG9ydCBpcyBub3QgaW4gdXNlICovCiAJaWYgKHNzcF9yZWFkX3JlZyhzc3AsIFNTQ1Iw
KSAmIFNTQ1IwX1NTRSkKLS0gCjEuNi4wLjQKCg==
--0016364eef74c9234b046835b0db
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0016364eef74c9234b046835b0db--
