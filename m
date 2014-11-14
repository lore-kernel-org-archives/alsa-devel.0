From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: sgtl5000: Fix SMALL_POP bit definition
Date: Fri, 14 Nov 2014 02:14:47 -0200
Message-ID: <1415938487-20196-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f52.google.com (mail-qg0-f52.google.com
 [209.85.192.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 140772604E8
 for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2014 05:15:10 +0100 (CET)
Received: by mail-qg0-f52.google.com with SMTP id z60so585742qgd.25
 for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2014 20:15:09 -0800 (PST)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, craig.mcqueen@beamcommunications.com, michael@amarulasolutions.com
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

On a mx28evk with a sgtl5000 codec we notice a loud 'click' sound  to happen
5 seconds after the end of a playback.

The SMALL_POP bit should fix this, but its definition is incorrect:
according to the sgtl5000 manual it is bit 0 of CHIP_REF_CTRL register, not
bit 1.

Fix the definition accordingly and enable the bit as intended per the code 
comment.

After applying this change, no loud 'click' sound is heard after playback

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/codecs/sgtl5000.c | 3 +--
 sound/soc/codecs/sgtl5000.h | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 6bb77d7..dab9b15 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1299,8 +1299,7 @@ static int sgtl5000_probe(struct snd_soc_codec *codec)
 
 	/* enable small pop, introduce 400ms delay in turning off */
 	snd_soc_update_bits(codec, SGTL5000_CHIP_REF_CTRL,
-				SGTL5000_SMALL_POP,
-				SGTL5000_SMALL_POP);
+				SGTL5000_SMALL_POP, 1);
 
 	/* disable short cut detector */
 	snd_soc_write(codec, SGTL5000_CHIP_SHORT_CTRL, 0);
diff --git a/sound/soc/codecs/sgtl5000.h b/sound/soc/codecs/sgtl5000.h
index 2f8c889..bd7a344 100644
--- a/sound/soc/codecs/sgtl5000.h
+++ b/sound/soc/codecs/sgtl5000.h
@@ -275,7 +275,7 @@
 #define SGTL5000_BIAS_CTRL_MASK			0x000e
 #define SGTL5000_BIAS_CTRL_SHIFT		1
 #define SGTL5000_BIAS_CTRL_WIDTH		3
-#define SGTL5000_SMALL_POP			0x0001
+#define SGTL5000_SMALL_POP			0
 
 /*
  * SGTL5000_CHIP_MIC_CTRL
-- 
1.9.1
