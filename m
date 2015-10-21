From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 1/2] ASoC: rt5640: Revise the input pin name of
	IN1 and IN2 in document of the devicetree
Date: Wed, 21 Oct 2015 09:46:05 +0800
Message-ID: <1445391966-24849-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id DE05B2604D5
 for <alsa-devel@alsa-project.org>; Wed, 21 Oct 2015 03:46:23 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, john.lin@realtek.com, bardliao@realtek.com, flove@realtek.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 Documentation/devicetree/bindings/sound/rt5640.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/rt5640.txt b/Documentation/devicetree/bindings/sound/rt5640.txt
index bac4d9a..5d062a5 100644
--- a/Documentation/devicetree/bindings/sound/rt5640.txt
+++ b/Documentation/devicetree/bindings/sound/rt5640.txt
@@ -24,9 +24,9 @@ Pins on the device (for linking into audio routes) for RT5639/RT5640:
   * DMIC2
   * MICBIAS1
   * IN1P
-  * IN1R
+  * IN1N
   * IN2P
-  * IN2R
+  * IN2N
   * HPOL
   * HPOR
   * LOUTL
-- 
1.8.1.1.439.g50a6b54
