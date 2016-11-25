From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v2 1/8] mfd: sun6i-prcm: Add codec analog controls sub-device
 for Allwinner A23
Date: Fri, 25 Nov 2016 20:34:35 +0800
Message-ID: <20161125123442.28410-2-wens@csie.org>
References: <20161125123442.28410-1-wens@csie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161125123442.28410-1-wens@csie.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Lee Jones <lee.jones@linaro.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, Mylene Josserand <mylene.josserand@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The PRCM block on the A23 contains a message box like interface to
the registers for the analog path controls of the internal codec.

Add a sub-device for it.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/mfd/sun6i-prcm.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mfd/sun6i-prcm.c b/drivers/mfd/sun6i-prcm.c
index 011fcc555945..2b658bed47db 100644
--- a/drivers/mfd/sun6i-prcm.c
+++ b/drivers/mfd/sun6i-prcm.c
@@ -12,6 +12,9 @@
 #include <linux/init.h>
 #include <linux/of.h>
 
+#define SUN8I_CODEC_ANALOG_BASE	0x1c0
+#define SUN8I_CODEC_ANALOG_SIZE	0x4
+
 struct prcm_data {
 	int nsubdevs;
 	const struct mfd_cell *subdevs;
@@ -57,6 +60,10 @@ static const struct resource sun6i_a31_apb0_rstc_res[] = {
 	},
 };
 
+static const struct resource sun8i_codec_analog_res[] = {
+	DEFINE_RES_MEM(SUN8I_CODEC_ANALOG_BASE, SUN8I_CODEC_ANALOG_SIZE),
+};
+
 static const struct mfd_cell sun6i_a31_prcm_subdevs[] = {
 	{
 		.name = "sun6i-a31-ar100-clk",
@@ -109,6 +116,12 @@ static const struct mfd_cell sun8i_a23_prcm_subdevs[] = {
 		.num_resources = ARRAY_SIZE(sun6i_a31_apb0_rstc_res),
 		.resources = sun6i_a31_apb0_rstc_res,
 	},
+	{
+		.name		= "sun8i-codec-analog",
+		.of_compatible	= "allwinner,sun8i-a23-codec-analog",
+		.num_resources	= ARRAY_SIZE(sun8i_codec_analog_res),
+		.resources	= sun8i_codec_analog_res,
+	},
 };
 
 static const struct prcm_data sun6i_a31_prcm_data = {
-- 
2.10.2
