From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH RFT] ASoC: da7219: Fix da7219->alc_en state
	when enabling ALC
Date: Wed, 21 Oct 2015 08:34:37 +0800
Message-ID: <1445387677.5319.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
 [209.85.220.52])
 by alsa0.perex.cz (Postfix) with ESMTP id CCA212604D5
 for <alsa-devel@alsa-project.org>; Wed, 21 Oct 2015 02:34:45 +0200 (CEST)
Received: by pacfv9 with SMTP id fv9so37724775pac.3
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2015 17:34:44 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Support Opensource <support.opensource@diasemi.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/da7219.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 86c528a..e36a7b7 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -402,7 +402,7 @@ static int da7219_alc_sw_put(struct snd_kcontrol *kcontrol,
 	/* Force ALC offset calibration if enabling ALC */
 	if ((ucontrol->value.integer.value[0]) && (!da7219->alc_en)) {
 		da7219_alc_calib(codec);
-		da7219->alc_en = false;
+		da7219->alc_en = true;
 	} else {
 		da7219->alc_en = false;
 	}
-- 
2.1.4
