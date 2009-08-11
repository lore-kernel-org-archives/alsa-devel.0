From: Chaithrika U S <chaithrika@ti.com>
Subject: [PATCH v2 2/2] ASoC: DaVinci: Add a DAI format to
	McASP driver
Date: Tue, 11 Aug 2009 16:59:12 -0400
Message-ID: <1250024352-26896-1-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id BE7E924B9F
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Aug 2009 13:30:17 +0200 (CEST)
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
Cc: khilman@deeprootsystems.com, Chaithrika U S <chaithrika@ti.com>, davinci-linux-open-source@linux.davincidsp.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

The patch adds a DAI format: Codec bit clock master and frame sync slave,
to the driver.

Signed-off-by: Chaithrika U S <chaithrika@ti.com>
---
This patch has been separated out from the first patch of this series.
In the previous version, this was part of the McASP driver FIFO support patch.

Applies to ALSA GIT tree on branch topic/asoc at
http://git.kernel.org/?p=linux/kernel/git/tiwai/sound-2.6.git;a=shortlog;
h=topic/asoc

 sound/soc/davinci/davinci-mcasp.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index e672f43..eca22d7 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -443,6 +443,16 @@ static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 
 		mcasp_set_bits(base + DAVINCI_MCASP_PDIR_REG, (0x7 << 26));
 		break;
+	case SND_SOC_DAIFMT_CBM_CFS:
+		/* codec is clock master and frame slave */
+		mcasp_set_bits(base + DAVINCI_MCASP_ACLKXCTL_REG, ACLKXE);
+		mcasp_set_bits(base + DAVINCI_MCASP_TXFMCTL_REG, AFSXE);
+
+		mcasp_set_bits(base + DAVINCI_MCASP_ACLKRCTL_REG, ACLKRE);
+		mcasp_set_bits(base + DAVINCI_MCASP_RXFMCTL_REG, AFSRE);
+
+		mcasp_set_bits(base + DAVINCI_MCASP_PDIR_REG, (0x2d << 26));
+		break;
 	case SND_SOC_DAIFMT_CBM_CFM:
 		/* codec is clock and frame master */
 		mcasp_clr_bits(base + DAVINCI_MCASP_ACLKXCTL_REG, ACLKXE);
-- 
1.5.6
