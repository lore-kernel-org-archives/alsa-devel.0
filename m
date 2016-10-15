From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/3] ASoC: ak4641: Remove unused
	AK4641_CACHEREGNUM define
Date: Sat, 15 Oct 2016 21:32:40 +0200
Message-ID: <1476559961-23134-2-git-send-email-lars@metafoo.de>
References: <1476559961-23134-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 466092668B1
 for <alsa-devel@alsa-project.org>; Sat, 15 Oct 2016 21:32:47 +0200 (CEST)
In-Reply-To: <1476559961-23134-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The last user was removed in commit 4f534777c130 ("ASoC: ak4641: Convert to
direct regmap API usage").

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/ak4641.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/ak4641.h b/sound/soc/codecs/ak4641.h
index 38b9e93..e00af5c 100644
--- a/sound/soc/codecs/ak4641.h
+++ b/sound/soc/codecs/ak4641.h
@@ -36,6 +36,4 @@
 #define AK4641_EQHI		0x12
 #define AK4641_BTIF		0x13
 
-#define AK4641_CACHEREGNUM	0x14
-
 #endif
-- 
2.1.4
