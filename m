From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/2] ASoC: imx-audmux: Check for NULL pointer
Date: Thu,  5 Apr 2012 09:45:52 -0300
Message-ID: <1333629952-18243-2-git-send-email-festevam@gmail.com>
References: <1333629952-18243-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 2A65D247CC
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Apr 2012 14:46:06 +0200 (CEST)
Received: by yenl1 with SMTP id l1so661588yen.38
	for <alsa-devel@alsa-project.org>; Thu, 05 Apr 2012 05:46:05 -0700 (PDT)
In-Reply-To: <1333629952-18243-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: joancarles@fqingenieria.es, Fabio Estevam <fabio.estevam@freescale.com>, broonie@opensource.wolfsonmicro.com, Fabio Estevam <festevam@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Check for NULL pointer before accessing it.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/imx-audmux.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/soc/fsl/imx-audmux.c b/sound/soc/fsl/imx-audmux.c
index d467a1b..21d67bb 100644
--- a/sound/soc/fsl/imx-audmux.c
+++ b/sound/soc/fsl/imx-audmux.c
@@ -76,6 +76,9 @@ static ssize_t audmux_read_file(struct file *file, char __user *user_buf,
 	if (audmux_clk)
 		clk_prepare_enable(audmux_clk);
 
+	if (!audmux_base)
+		return -ENOSYS;
+
 	ptcr = readl(audmux_base + IMX_AUDMUX_V2_PTCR(port));
 	pdcr = readl(audmux_base + IMX_AUDMUX_V2_PDCR(port));
 
-- 
1.7.1
