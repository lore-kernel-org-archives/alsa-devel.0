From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH] ASoC: TWL4030: Use codec defaults for Headset
	initial configuration
Date: Wed, 17 Feb 2010 09:49:54 +0200
Message-ID: <1266392994-29551-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 98725103862
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 08:50:25 +0100 (CET)
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
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Disable the amplifiers for the headset outputs, and do not select
routings by default to the headset outputs.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---

The obvious side effect of this patch is that on boards which are using the
headset output the playback will not work 'out of box'.
The user need to specifically enable the routings for the boards.
Board that came to my mind is the Beagle, and probably it's clones as well.

 sound/soc/codecs/twl4030.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 277862e..6f5d4af 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -75,8 +75,8 @@ static const u8 twl4030_reg[TWL4030_CACHEREGNUM] = {
 	0x00, /* REG_BTPGA		(0x1F)	*/
 	0x00, /* REG_BTSTPGA		(0x20)	*/
 	0x00, /* REG_EAR_CTL		(0x21)	*/
-	0x24, /* REG_HS_SEL		(0x22)	*/
-	0x0a, /* REG_HS_GAIN_SET	(0x23)	*/
+	0x00, /* REG_HS_SEL		(0x22)	*/
+	0x00, /* REG_HS_GAIN_SET	(0x23)	*/
 	0x00, /* REG_HS_POPN_SET	(0x24)	*/
 	0x00, /* REG_PREDL_CTL		(0x25)	*/
 	0x00, /* REG_PREDR_CTL		(0x26)	*/
--
1.7.0
