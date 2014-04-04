From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 6/7] ASoC: davinci-mcasp: Support for LEFT_J
	format
Date: Fri, 4 Apr 2014 14:31:46 +0300
Message-ID: <1396611107-30765-7-git-send-email-peter.ujfalusi@ti.com>
References: <1396611107-30765-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id CAA992657DD
 for <alsa-devel@alsa-project.org>; Fri,  4 Apr 2014 13:32:03 +0200 (CEST)
In-Reply-To: <1396611107-30765-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, jsarha@ti.com, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

Configuration for LEFT_J format.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index af6cca3e61e4..da9533b8e2dd 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -295,6 +295,13 @@ static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		/* FS need to be inverted */
 		inv_fs = true;
 		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		/* configure a full-word SYNC pulse (LRCLK) */
+		mcasp_set_bits(mcasp, DAVINCI_MCASP_TXFMCTL_REG, FSXDUR);
+		mcasp_set_bits(mcasp, DAVINCI_MCASP_RXFMCTL_REG, FSRDUR);
+		/* No delay after FS */
+		data_delay = 0;
+		break;
 	default:
 		ret = -EINVAL;
 		goto out;
-- 
1.9.1
