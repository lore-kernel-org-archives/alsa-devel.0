From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH] ASoC: twl6040: fix spelling mistake
Date: Fri,  6 Jul 2012 17:04:17 +0100
Message-ID: <1341590657-20959-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog103.obsmtp.com (na3sys009aog103.obsmtp.com
	[74.125.149.71])
	by alsa0.perex.cz (Postfix) with ESMTP id C7EAD104582
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Jul 2012 18:04:30 +0200 (CEST)
Received: by wgbds11 with SMTP id ds11so10625196wgb.19
	for <alsa-devel@alsa-project.org>; Fri, 06 Jul 2012 09:04:27 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, Simon Wilson <simonwilson@google.com>
List-Id: alsa-devel@alsa-project.org

From: Simon Wilson <simonwilson@google.com>

Fix spelling mistake in "High-Performance" option of twl6040 power mode.

Signed-off-by: Simon Wilson <simonwilson@google.com>
---
 sound/soc/codecs/twl6040.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index a36e9fc..0ff1e70 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -553,7 +553,7 @@ static const struct snd_kcontrol_new vibrar_mux_controls =
 
 /* Headset power mode */
 static const char *twl6040_power_mode_texts[] = {
-	"Low-Power", "High-Perfomance",
+	"Low-Power", "High-Performance",
 };
 
 static const struct soc_enum twl6040_power_mode_enum =
-- 
1.7.9.5
