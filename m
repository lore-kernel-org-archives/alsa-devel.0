From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH - try2] ASoC: TPA6130A2: Make tpa6130a2_power
	as static
Date: Mon, 12 Oct 2009 14:48:59 +0300
Message-ID: <1255348139-13609-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1255348139-13609-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 6C589103814
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Oct 2009 13:49:11 +0200 (CEST)
In-Reply-To: <1255348139-13609-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

The power for the amplifier should be handled internally
by the tpa6130a2 driver.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tpa6130a2.c |    2 +-
 sound/soc/codecs/tpa6130a2.h |    1 -
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index 0a6e7b4..6b650c1 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -106,7 +106,7 @@ static void tpa6130a2_initialize(void)
 		tpa6130a2_i2c_write(i, data->regs[i]);
 }

-void tpa6130a2_power(int power)
+static void tpa6130a2_power(int power)
 {
 	struct	tpa6130a2_data *data;
 	u8	val;
diff --git a/sound/soc/codecs/tpa6130a2.h b/sound/soc/codecs/tpa6130a2.h
index 6a794f1..57e867f 100644
--- a/sound/soc/codecs/tpa6130a2.h
+++ b/sound/soc/codecs/tpa6130a2.h
@@ -57,6 +57,5 @@
 #define TPA6130A2_VERSION_MASK		(0x0f)

 extern int tpa6130a2_add_controls(struct snd_soc_codec *codec);
-extern void tpa6130a2_power(int power);

 #endif /* __TPA6130A2_H__ */
--
1.6.5.rc2
