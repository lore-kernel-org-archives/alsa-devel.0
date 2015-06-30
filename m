From: Nik Nyby <nikolas@gnu.org>
Subject: [PATCH] ASoC: codecs: max98088: fix typo in constant
Date: Tue, 30 Jun 2015 17:43:02 -0400
Message-ID: <1435700582-17286-1-git-send-email-nikolas@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eggs.gnu.org (eggs.gnu.org [208.118.235.92])
 by alsa0.perex.cz (Postfix) with ESMTP id 238662605B2
 for <alsa-devel@alsa-project.org>; Tue, 30 Jun 2015 23:43:19 +0200 (CEST)
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nikolas@gnu.org>) id 1ZA3JF-0001jJ-1O
 for alsa-devel@alsa-project.org; Tue, 30 Jun 2015 17:43:18 -0400
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, alsa-devel@alsa-project.org, trivial@kernel.org
Cc: Nik Nyby <nikolas@gnu.org>
List-Id: alsa-devel@alsa-project.org

This fixes a typo in the M98088_REG_02_JACK_STATUS constant.

Signed-off-by: Nik Nyby <nikolas@gnu.org>
---
 sound/soc/codecs/max98088.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98088.h b/sound/soc/codecs/max98088.h
index be89a4f..efa39bf 100644
--- a/sound/soc/codecs/max98088.h
+++ b/sound/soc/codecs/max98088.h
@@ -16,7 +16,7 @@
  */
 #define M98088_REG_00_IRQ_STATUS            0x00
 #define M98088_REG_01_MIC_STATUS            0x01
-#define M98088_REG_02_JACK_STAUS            0x02
+#define M98088_REG_02_JACK_STATUS           0x02
 #define M98088_REG_03_BATTERY_VOLTAGE       0x03
 #define M98088_REG_0F_IRQ_ENABLE            0x0F
 #define M98088_REG_10_SYS_CLK               0x10
-- 
2.1.4
