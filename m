From: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH] ASoC: fix documentation in soc-jack
Date: Tue,  2 Oct 2012 14:08:19 +0200
Message-ID: <1349179699-8737-1-git-send-email-pmeerw@pmeerw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pmeerw.net (ns.pmeerw.net [87.118.82.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 03F60261600
 for <alsa-devel@alsa-project.org>; Tue,  2 Oct 2012 14:09:07 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@ti.com, Peter Meerwald <pmeerw@pmeerw.net>
List-Id: alsa-devel@alsa-project.org

From: Peter Meerwald <p.meerwald@bct-electronic.com>

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 sound/soc/soc-jack.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index 0c17293..b24cd53 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -22,7 +22,7 @@
 
 /**
  * snd_soc_jack_new - Create a new jack
- * @card:  ASoC card
+ * @codec: ASoC codec
  * @id:    an identifying string for this jack
  * @type:  a bitmask of enum snd_jack_type values that can be detected by
  *         this jack
@@ -139,12 +139,13 @@ EXPORT_SYMBOL_GPL(snd_soc_jack_add_zones);
 
 /**
  * snd_soc_jack_get_type - Based on the mic bias value, this function returns
- * the type of jack from the zones delcared in the jack type
+ * the type of jack from the zones declared in the jack type
  *
+ * @jack:  ASoC jack
  * @micbias_voltage:  mic bias voltage at adc channel when jack is plugged in
  *
  * Based on the mic bias value passed, this function helps identify
- * the type of jack from the already delcared jack zones
+ * the type of jack from the already declared jack zones
  */
 int snd_soc_jack_get_type(struct snd_soc_jack *jack, int micbias_voltage)
 {
-- 
1.7.9.5
