From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 4/4 v7] ASoC: dwc: Add irq parameter to DOCUMENTATION
Date: Mon, 23 May 2016 16:31:55 -0500
Message-ID: <20160523213155.GA9773@rob-hp-laptop>
References: <cover.1463996627.git.joabreu@synopsys.com>
 <49fab21a9c10576cb0c5d6a2bb0e19c7bcfb732f.1463996627.git.joabreu@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <49fab21a9c10576cb0c5d6a2bb0e19c7bcfb732f.1463996627.git.joabreu@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jose Abreu <Jose.Abreu@synopsys.com>
Cc: alsa-devel@alsa-project.org, Carlos Palminha <CARLOS.PALMINHA@synopsys.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, linux-snps-arc@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, May 23, 2016 at 11:02:25AM +0100, Jose Abreu wrote:
> A parameter description for the interruptions of the
> I2S controller was added. This interrupt parameter
> should only be set when I2S does not have DMA support.
> 
> Signed-off-by: Jose Abreu <joabreu@synopsys.com>
> Cc: Carlos Palminha <palminha@synopsys.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Alexey Brodkin <abrodkin@synopsys.com>
> Cc: linux-snps-arc@lists.infradead.org
> Cc: alsa-devel@alsa-project.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
> 
> Changes v6 -> v7:
> * interrupts is now optional property
> 
> No changes v5 -> v6.
> 
> Changes v4 -> v5:
> * interrupts is now required property
> * Drop 'snps-use-dmaengine' property
> 
> This patch was only introduced in v4.
> 
>  Documentation/devicetree/bindings/sound/designware-i2s.txt | 4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
