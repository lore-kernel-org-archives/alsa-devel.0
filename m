From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/6] ARM: OMAP: 3430sdp: Enable extmute
	functionality for audio
Date: Mon, 31 Dec 2012 12:02:55 +0100
Message-ID: <1356951780-5412-2-git-send-email-peter.ujfalusi@ti.com>
References: <1356951780-5412-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D5A9261700
 for <alsa-devel@alsa-project.org>; Mon, 31 Dec 2012 12:03:04 +0100 (CET)
In-Reply-To: <1356951780-5412-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tony Lindgren <tony@atomide.com>
Cc: NeilBrown <neilb@suse.de>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Enable the use of extmute on the HS path.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index bb73afc..40c22a7 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -382,6 +382,9 @@ static int __init omap3430_i2c_init(void)
 	sdp3430_twldata.vpll2->constraints.apply_uV = true;
 	sdp3430_twldata.vpll2->constraints.name = "VDVI";
 
+	sdp3430_twldata.audio->codec->hs_extmute = 1;
+	sdp3430_twldata.audio->codec->hs_extmute_gpio = -EINVAL;
+
 	omap3_pmic_init("twl4030", &sdp3430_twldata);
 
 	/* i2c2 on camera connector (for sensor control) and optional isp1301 */
-- 
1.8.0.2
