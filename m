From: Andrew Jackson <andrew.jackson@arm.com>
Subject: [PATCH v4 1/5] ASoC: dwc: Prepare clock before use
Date: Tue, 23 Dec 2014 13:56:23 +0000
Message-ID: <63becb5f356c25b226b9dbc5825357e894d0f08b.1419342218.git.Andrew.Jackson@arm.com>
References: <cover.1419342218.git.Andrew.Jackson@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1419342218.git.Andrew.Jackson@arm.com>
In-Reply-To: <cover.1419342218.git.Andrew.Jackson@arm.com>
References: <cover.1419342218.git.Andrew.Jackson@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, pawel.moll@arm.com, Arnd Bergmann <arnd@arndb.de>, ijc+devicetree@hellion.org.uk, linux-kernel@vger.kernel.org, Andrew Jackson <Andrew.Jackson@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Rajeev Kumar <rajeevkumar.linux@gmail.com>, robh+dt@kernel.org, galak@codeaurora.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

From: Andrew Jackson <Andrew.Jackson@arm.com>

Some I2S clocks may require some time to get the clock ready
for operation and so need to be prepared before they are enabled.
So, prepare the clock as well as enabling it, but combine the
two through clk_prepare_enable.

Signed-off-by: Andrew Jackson <Andrew.Jackson@arm.com>
---
 sound/soc/dwc/designware_i2s.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
index 06d3a34..9573ec7 100644
--- a/sound/soc/dwc/designware_i2s.c
+++ b/sound/soc/dwc/designware_i2s.c
@@ -411,7 +411,7 @@ static int dw_i2s_probe(struct platform_device *pdev)
 	if (IS_ERR(dev->clk))
 		return  PTR_ERR(dev->clk);
 
-	ret = clk_enable(dev->clk);
+	ret = clk_prepare_enable(dev->clk);
 	if (ret < 0)
 		goto err_clk_put;
 
-- 
1.7.1
