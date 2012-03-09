From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: [PATCH] ASoC: da7210: Remove extra registers from
 defaults list
Date: Fri, 9 Mar 2012 13:51:30 +0530
Message-ID: <1331281290.30539.15.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
	by alsa0.perex.cz (Postfix) with ESMTP id 7545E10BBC5
	for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2012 09:09:41 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, lrg <lrg@ti.com>, alsa-devel <alsa-devel@alsa-project.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org

This patch removes following registers from reg map defaults,

- Registers which are currently not used by driver
- Non existing registers
- Volatile registers

Signed-off-by: Ashish Chavan <ashish.chavan@kpitcummins.com>
Signed-off-by: David Dajun Chen <dchen@diasemi.com>
---
 sound/soc/codecs/da7210.c |   88 ---------------------------------------------
 1 files changed, 0 insertions(+), 88 deletions(-)

diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index 0c23f19..7843711 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -631,9 +631,7 @@ struct da7210_priv {
 };
 
 static struct reg_default da7210_reg_defaults[] = {
-	{ 0x00, 0x00 },
 	{ 0x01, 0x11 },
-	{ 0x02, 0x00 },
 	{ 0x03, 0x00 },
 	{ 0x04, 0x00 },
 	{ 0x05, 0x00 },
@@ -676,92 +674,6 @@ static struct reg_default da7210_reg_defaults[] = {
 	{ 0x2a, 0x00 },
 	{ 0x2b, 0x30 },
 	{ 0x2c, 0x2A },
-	{ 0x2d, 0x00 },
-	{ 0x2e, 0x40 },
-	{ 0x2f, 0x00 },
-	{ 0x30, 0x40 },
-	{ 0x31, 0x00 },
-	{ 0x32, 0x40 },
-	{ 0x33, 0x00 },
-	{ 0x34, 0x40 },
-	{ 0x35, 0x00 },
-	{ 0x36, 0x40 },
-	{ 0x37, 0x00 },
-	{ 0x38, 0x40 },
-	{ 0x39, 0x00 },
-	{ 0x3a, 0x40 },
-	{ 0x3b, 0x00 },
-	{ 0x3c, 0x40 },
-	{ 0x3d, 0x00 },
-	{ 0x3e, 0x00 },
-	{ 0x3f, 0x00 },
-	{ 0x40, 0x00 },
-	{ 0x41, 0x00 },
-	{ 0x42, 0x00 },
-	{ 0x43, 0x00 },
-	{ 0x44, 0x00 },
-	{ 0x45, 0x00 },
-	{ 0x46, 0x00 },
-	{ 0x47, 0x00 },
-	{ 0x48, 0x00 },
-	{ 0x49, 0x00 },
-	{ 0x4a, 0x00 },
-	{ 0x4b, 0x00 },
-	{ 0x4c, 0x00 },
-	{ 0x4d, 0x00 },
-	{ 0x4e, 0x00 },
-	{ 0x4f, 0x00 },
-	{ 0x50, 0x00 },
-	{ 0x51, 0x00 },
-	{ 0x52, 0x00 },
-	{ 0x53, 0x00 },
-	{ 0x54, 0x00 },
-	{ 0x55, 0x00 },
-	{ 0x56, 0x00 },
-	{ 0x57, 0x00 },
-	{ 0x58, 0x00 },
-	{ 0x59, 0x00 },
-	{ 0x5a, 0x00 },
-	{ 0x5b, 0x00 },
-	{ 0x5c, 0x00 },
-	{ 0x5d, 0x00 },
-	{ 0x5e, 0x00 },
-	{ 0x5f, 0x00 },
-	{ 0x60, 0x00 },
-	{ 0x61, 0x00 },
-	{ 0x62, 0x00 },
-	{ 0x63, 0x00 },
-	{ 0x64, 0x00 },
-	{ 0x65, 0x00 },
-	{ 0x66, 0x00 },
-	{ 0x67, 0x00 },
-	{ 0x68, 0x00 },
-	{ 0x69, 0x00 },
-	{ 0x6a, 0x00 },
-	{ 0x6b, 0x00 },
-	{ 0x6c, 0x00 },
-	{ 0x6d, 0x00 },
-	{ 0x6e, 0x00 },
-	{ 0x6f, 0x00 },
-	{ 0x70, 0x00 },
-	{ 0x71, 0x00 },
-	{ 0x72, 0x00 },
-	{ 0x73, 0x00 },
-	{ 0x74, 0x00 },
-	{ 0x75, 0x00 },
-	{ 0x76, 0x00 },
-	{ 0x77, 0x00 },
-	{ 0x78, 0x00 },
-	{ 0x79, 0x00 },
-	{ 0x7a, 0x00 },
-	{ 0x7b, 0x00 },
-	{ 0x7c, 0x00 },
-	{ 0x7d, 0x54 },
-	{ 0x7e, 0x54 },
-	{ 0x7f, 0x00 },
-	{ 0x80, 0x00 },
-	{ 0x81, 0x00 },
-	{ 0x82, 0x2c },
 	{ 0x83, 0x00 },
 	{ 0x84, 0x00 },
 	{ 0x85, 0x00 },

-- 
1.7.1
