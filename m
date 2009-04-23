From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [RFC PATCH 5/5] ASoC: simplify the SSP DMA
	parameters settings by run-time generation
Date: Thu, 23 Apr 2009 17:28:26 +0800
Message-ID: <f17812d70904230228j394713cbj4f99803d6031387d@mail.gmail.com>
References: <f17812d70904222208i79604f3evb9950d6351377a83@mail.gmail.com>
	<74d0deb30904230153l5ec490eck211d6ef456869f36@mail.gmail.com>
	<f17812d70904230202t5dc459bbud36c13b11c6d5725@mail.gmail.com>
	<20090423090810.GD30105@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.149])
	by alsa0.perex.cz (Postfix) with ESMTP id 85CF0103865
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Apr 2009 11:28:27 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 4so384322qwk.56
	for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2009 02:28:26 -0700 (PDT)
In-Reply-To: <20090423090810.GD30105@sirena.org.uk>
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

On Thu, Apr 23, 2009 at 5:08 PM, Mark Brown <broonie@sirena.org.uk> wrote:
> On Thu, Apr 23, 2009 at 05:02:14PM +0800, Eric Miao wrote:
>> >> + ?? ?? ?? snprintf(dma->name, 20, "SSP%d PCM %s %s", ssp->port_id,
>> >> + ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? stereo ? "Stereo" : "Mono", out ? "out" : "in");
>
>> > Should we change Stereo/Mono to 32-bit/16-bit here?
>
>> Depends on Mark, the dma->name and the comments below doesn't
>> actually match very well ...
>
> The change seems reasonable - the text has bitrotted with respect to
> what actually happens.
>

So that's going to change the dma->name as something below:

"SSP3 PCM 32-bit out"

Looks sane?

With the code:

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
