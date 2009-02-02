From: Timur Tabi <timur@freescale.com>
Subject: [PATCH 2.6.30] ASoC: fix build break in CS4270 codec
	driver
Date: Mon,  2 Feb 2009 14:50:45 -0600
Message-ID: <1233607845-7354-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 6815510380A
	for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2009 21:51:06 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Fix a oversight in the CS4270 codec driver that caused a build break.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 sound/soc/codecs/cs4270.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index e5f5afd..7962874 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -149,7 +149,7 @@ struct cs4270_mode_ratios {
 	u8 mclk;
 };
 
-static struct cs4270_mode_ratios[] = {
+static struct cs4270_mode_ratios cs4270_mode_ratios[] = {
 	{64, CS4270_MODE_4X, CS4270_MODE_DIV1},
 #ifndef CONFIG_SND_SOC_CS4270_VD33_ERRATA
 	{96, CS4270_MODE_4X, CS4270_MODE_DIV15},
-- 
1.5.5
