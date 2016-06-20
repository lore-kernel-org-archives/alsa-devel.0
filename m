From: Helen Koike <helen.koike@collabora.co.uk>
Subject: [PATCH] ASoC: max9877: Remove unused function
	declaration
Date: Mon, 20 Jun 2016 16:29:26 -0300
Message-ID: <1466450966-30768-1-git-send-email-helen.koike@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D521266631
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2016 21:29:53 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, broonie@kernel.org, broonie@linaro.org, trivial@kernel.org
Cc: Helen Koike <helen.koike@collabora.co.uk>
List-Id: alsa-devel@alsa-project.org

Remove unused function declaration from header

Signed-off-by: Helen Koike <helen.koike@collabora.co.uk>
---
 sound/soc/codecs/max9877.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/max9877.h b/sound/soc/codecs/max9877.h
index 6da7229..368343f 100644
--- a/sound/soc/codecs/max9877.h
+++ b/sound/soc/codecs/max9877.h
@@ -32,6 +32,4 @@
 #define MAX9877_BYPASS			(1 << 6)
 #define MAX9877_SHDN			(1 << 7)
 
-extern int max9877_add_controls(struct snd_soc_codec *codec);
-
 #endif
-- 
1.9.1
