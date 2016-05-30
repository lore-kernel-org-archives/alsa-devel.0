From: Jose Abreu <Jose.Abreu@synopsys.com>
Subject: [PATCH 2/2 v8] ASoC: dwc: Add irq parameter to DOCUMENTATION
Date: Mon, 30 May 2016 10:53:16 +0100
Message-ID: <7788db367a1ebc5734ac20ee5c6218e754cf76a4.1464601439.git.joabreu@synopsys.com>
References: <cover.1464601439.git.joabreu@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1464601439.git.joabreu@synopsys.com>
In-Reply-To: <cover.1464601439.git.joabreu@synopsys.com>
References: <cover.1464601439.git.joabreu@synopsys.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: alsa-devel@alsa-project.org
Cc: Jose Abreu <Jose.Abreu@synopsys.com>, Rob Herring <robh@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>, Carlos Palminha <CARLOS.PALMINHA@synopsys.com>, linux-snps-arc@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

A parameter description for the interruptions of the
I2S controller was added.

Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Acked-by: Rob Herring <robh@kernel.org>
Cc: Carlos Palminha <palminha@synopsys.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Alexey Brodkin <abrodkin@synopsys.com>
Cc: linux-snps-arc@lists.infradead.org
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
---

No changes v7 -> v8.

Changes v6 -> v7:
* interrupts is now optional property

No changes v5 -> v6.

Changes v4 -> v5:
* interrupts is now required property
* Drop 'snps-use-dmaengine' property

This patch was only introduced in v4.

 Documentation/devicetree/bindings/sound/designware-i2s.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/designware-i2s.txt b/Documentation/devicetree/bindings/sound/designware-i2s.txt
index 7bb5424..6a536d5 100644
--- a/Documentation/devicetree/bindings/sound/designware-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/designware-i2s.txt
@@ -12,6 +12,10 @@ Required properties:
    one for receive.
  - dma-names : "tx" for the transmit channel, "rx" for the receive channel.
 
+Optional properties:
+ - interrupts: The interrupt line number for the I2S controller. Add this
+   parameter if the I2S controller that you are using does not support DMA.
+
 For more details on the 'dma', 'dma-names', 'clock' and 'clock-names'
 properties please check:
 	* resource-names.txt
-- 
1.9.1
