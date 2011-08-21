From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH 2/2] ASoC: mxs-sgtl5000: add record function
Date: Mon, 22 Aug 2011 00:02:46 +0800
Message-ID: <1313942566-21433-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: alsa-devel@alsa-project.org
Cc: s.hauer@pengutronix.de, broonie@opensource.wolfsonmicro.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org, w.sang@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Dong Aisheng <b29396@freescale.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Wolfram Sang <w.sang@pengutronix.de>
---
 sound/soc/mxs/mxs-sgtl5000.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/sound/soc/mxs/mxs-sgtl5000.c b/sound/soc/mxs/mxs-sgtl5000.c
index a0d89c9..7fbeaec 100644
--- a/sound/soc/mxs/mxs-sgtl5000.c
+++ b/sound/soc/mxs/mxs-sgtl5000.c
@@ -85,13 +85,21 @@ static struct snd_soc_ops mxs_sgtl5000_hifi_ops = {
 
 static struct snd_soc_dai_link mxs_sgtl5000_dai[] = {
 	{
-		.name		= "HiFi",
+		.name		= "HiFi Tx",
 		.stream_name	= "HiFi Playback",
 		.codec_dai_name	= "sgtl5000",
 		.codec_name	= "sgtl5000.0-000a",
 		.cpu_dai_name	= "mxs-saif.0",
 		.platform_name	= "mxs-pcm-audio.0",
 		.ops		= &mxs_sgtl5000_hifi_ops,
+	}, {
+		.name		= "HiFi Rx",
+		.stream_name	= "HiFi Capture",
+		.codec_dai_name	= "sgtl5000",
+		.codec_name	= "sgtl5000.0-000a",
+		.cpu_dai_name	= "mxs-saif.1",
+		.platform_name	= "mxs-pcm-audio.1",
+		.ops		= &mxs_sgtl5000_hifi_ops,
 	},
 };
 
-- 
1.7.0.4
