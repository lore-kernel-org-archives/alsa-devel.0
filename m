From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2 1/2] ASoC: sgtl5000: Fix the spelling of
	'exceed'
Date: Sun, 22 Apr 2018 21:02:10 -0300
Message-ID: <1524441731-13585-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f193.google.com (mail-qt0-f193.google.com
 [209.85.216.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9BA3E267284
 for <alsa-devel@alsa-project.org>; Mon, 23 Apr 2018 02:04:18 +0200 (CEST)
Received: by mail-qt0-f193.google.com with SMTP id l11-v6so15803848qtj.10
 for <alsa-devel@alsa-project.org>; Sun, 22 Apr 2018 17:04:18 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Fix the spelling of 'exceed' in two comments.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes since v1:
- None

 sound/soc/codecs/sgtl5000.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 7c1d658..ce0d0d7 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -457,7 +457,7 @@ static int dac_put_volsw(struct snd_kcontrol *kcontrol,
  * avc_put_threshold function: register_value = 10^(dB/20) * 0.636 * 2^15 ==>
  * dB = ( fls(register_value) - 14.347 ) * 6.02
  *
- * As this calculation is expensive and the threshold dB values may not exeed
+ * As this calculation is expensive and the threshold dB values may not exceed
  * 0 to 96 we use pre-calculated values.
  */
 static int avc_get_threshold(struct snd_kcontrol *kcontrol,
@@ -490,7 +490,7 @@ static int avc_get_threshold(struct snd_kcontrol *kcontrol,
  *
  * The register value is calculated by following formula:
  *                                    register_value = 10^(dB/20) * 0.636 * 2^15
- * As this calculation is expensive and the threshold dB values may not exeed
+ * As this calculation is expensive and the threshold dB values may not exceed
  * 0 to 96 we use pre-calculated values.
  */
 static int avc_put_threshold(struct snd_kcontrol *kcontrol,
-- 
2.7.4
