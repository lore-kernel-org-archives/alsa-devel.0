From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH 2/2] ASoC: fsl-ssi: Fix stats compile warning
Date: Thu,  9 Jan 2014 11:16:11 +0100
Message-ID: <1389262571-12489-3-git-send-email-mpa@pengutronix.de>
References: <20140108172144.GP31886@sirena.org.uk>
 <1389262571-12489-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1389262571-12489-1-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>
Cc: alsa-devel@alsa-project.org, Nicolin Chen <b42378@freescale.com>, kernel@pengutronix.de, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

single_open requires a function with signature
'int (*)(struct seq_file *, void *)'. This patch fixes the warning by
fixing the wrong return type of fsl_ssi_stats_show.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index e40bce1..cb4c2e0 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -391,7 +391,7 @@ static irqreturn_t fsl_ssi_isr(int irq, void *dev_id)
  * Display the statistics for the current SSI device.  To avoid confusion,
  * we only show those counts that are enabled.
  */
-static ssize_t fsl_ssi_stats_show(struct seq_file *s, void *unused)
+static int fsl_ssi_stats_show(struct seq_file *s, void *unused)
 {
 	struct fsl_ssi_private *ssi_private = s->private;
 
-- 
1.8.5.2
