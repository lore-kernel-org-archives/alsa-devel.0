From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH] ASoC: twl6040 - According to TWL6040
	specification, gain start at 6dB and not -6dB.
Date: Tue, 7 Jun 2011 16:23:44 +0100
Message-ID: <1307460224-5135-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 50CA62451F
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jun 2011 17:23:58 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Ricardo Neri <ricardo.neri@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 sound/soc/codecs/twl6040.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 4c33663..cd63bba 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -954,9 +954,9 @@ static DECLARE_TLV_DB_SCALE(mic_preamp_tlv, -600, 600, 0);
 
 /*
  * MICGAIN volume control:
- * from -6 to 30 dB in 6 dB steps
+ * from 6 to 30 dB in 6 dB steps
  */
-static DECLARE_TLV_DB_SCALE(mic_amp_tlv, -600, 600, 0);
+static DECLARE_TLV_DB_SCALE(mic_amp_tlv, 600, 600, 0);
 
 /*
  * AFMGAIN volume control:
-- 
1.7.4.1
