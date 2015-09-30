From: Rick Mann <rmann@latencyzero.com>
Subject: [PATCH] Prevent writing reserved registers on
	tlv320aic3104 CODECs
Date: Wed, 30 Sep 2015 16:24:53 -0700
Message-ID: <1443655493-5554-1-git-send-email-rmann@latencyzero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 908F926644E
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2015 01:24:56 +0200 (CEST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id D421220451
 for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2015 19:24:55 -0400 (EDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com, peter.ujfalusi@ti.com, rmann@latencyzero.com, jarkko.nikula@bitmer.com
List-Id: alsa-devel@alsa-project.org

The current code writes a set of registers that are reserved on the tlc320aic3104. The change skips those registers for that IC.

Signed-off-by: Rick Mann <rmann@latencyzero.com>
---
 sound/soc/codecs/tlv320aic3x.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index f1c9fffcd3a6..8d893e94e78d 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1531,14 +1531,17 @@ static int aic3x_init(struct snd_soc_codec *codec)
 	snd_soc_write(codec, PGAL_2_LLOPM_VOL, DEFAULT_VOL);
 	snd_soc_write(codec, PGAR_2_RLOPM_VOL, DEFAULT_VOL);
 
-	/* Line2 to HP Bypass default volume, disconnect from Output Mixer */
-	snd_soc_write(codec, LINE2L_2_HPLOUT_VOL, DEFAULT_VOL);
-	snd_soc_write(codec, LINE2R_2_HPROUT_VOL, DEFAULT_VOL);
-	snd_soc_write(codec, LINE2L_2_HPLCOM_VOL, DEFAULT_VOL);
-	snd_soc_write(codec, LINE2R_2_HPRCOM_VOL, DEFAULT_VOL);
-	/* Line2 Line Out default volume, disconnect from Output Mixer */
-	snd_soc_write(codec, LINE2L_2_LLOPM_VOL, DEFAULT_VOL);
-	snd_soc_write(codec, LINE2R_2_RLOPM_VOL, DEFAULT_VOL);
+	/* On tlv320aic3104, these registers are reserved and must not be written */
+	if (aic3x->model != AIC3X_MODEL_3104) {
+		/* Line2 to HP Bypass default volume, disconnect from Output Mixer */
+		snd_soc_write(codec, LINE2L_2_HPLOUT_VOL, DEFAULT_VOL);
+		snd_soc_write(codec, LINE2R_2_HPROUT_VOL, DEFAULT_VOL);
+		snd_soc_write(codec, LINE2L_2_HPLCOM_VOL, DEFAULT_VOL);
+		snd_soc_write(codec, LINE2R_2_HPRCOM_VOL, DEFAULT_VOL);
+		/* Line2 Line Out default volume, disconnect from Output Mixer */
+		snd_soc_write(codec, LINE2L_2_LLOPM_VOL, DEFAULT_VOL);
+		snd_soc_write(codec, LINE2R_2_RLOPM_VOL, DEFAULT_VOL);
+	}
 
 	switch (aic3x->model) {
 	case AIC3X_MODEL_3X:
-- 
1.9.1
