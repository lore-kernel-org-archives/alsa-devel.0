From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH RFC v2 01/13] drm: imx/dw_hdmi: move phy
	comments
Date: Thu, 02 Apr 2015 10:21:20 +0100
Message-ID: <E1YdbJQ-00084m-GC@rmk-PC.arm.linux.org.uk>
References: <20150402092050.GH24899@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pandora.arm.linux.org.uk (pandora.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id C9071265568
 for <alsa-devel@alsa-project.org>; Thu,  2 Apr 2015 11:21:23 +0200 (CEST)
In-Reply-To: <20150402092050.GH24899@n2100.arm.linux.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, David Airlie <airlied@linux.ie>, Mark Brown <broonie@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Yakir Yang <ykk@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

The phy comments in dw_hdmi.c applied to the iMX6 version.  Move these
comments to the iMX6 dw_hdmi-imx data along side the data.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/drm/bridge/dw_hdmi.c  | 3 ---
 drivers/gpu/drm/imx/dw_hdmi-imx.c | 5 +++++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
index 49cafb61d290..3494391e4199 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi.c
@@ -834,11 +834,8 @@ static int hdmi_phy_configure(struct dw_hdmi *hdmi, unsigned char prep,
 		    phy_config[i].mpixelclock)
 			break;
 
-	/* RESISTANCE TERM 133Ohm Cfg */
 	hdmi_phy_i2c_write(hdmi, phy_config[i].term, 0x19);  /* TXTERM */
-	/* PREEMP Cgf 0.00 */
 	hdmi_phy_i2c_write(hdmi, phy_config[i].sym_ctr, 0x09); /* CKSYMTXCTRL */
-	/* TX/CK LVL 10 */
 	hdmi_phy_i2c_write(hdmi, phy_config[i].vlev_ctr, 0x0E); /* VLEVCTRL */
 
 	/* REMOVE CLK TERM */
diff --git a/drivers/gpu/drm/imx/dw_hdmi-imx.c b/drivers/gpu/drm/imx/dw_hdmi-imx.c
index 1032c07773e3..2b2368f50c39 100644
--- a/drivers/gpu/drm/imx/dw_hdmi-imx.c
+++ b/drivers/gpu/drm/imx/dw_hdmi-imx.c
@@ -73,6 +73,11 @@ static const struct dw_hdmi_curr_ctrl imx_cur_ctr[] = {
 	}
 };
 
+/*
+ * Resistance term 133Ohm Cfg
+ * PREEMP config 0.00
+ * TX/CK level 10
+ */
 static const struct dw_hdmi_phy_config imx_phy_config[] = {
 	/*pixelclk   symbol   term   vlev */
 	{ 148500000, 0x800d, 0x0005, 0x01ad},
-- 
1.8.3.1
