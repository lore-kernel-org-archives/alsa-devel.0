From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ASoC: nau8824: fix spelling mistake:
	"semaphone" -> "semaphore"
Date: Tue,  8 May 2018 23:41:55 +0100
Message-ID: <20180508224155.26486-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 487212676AA
 for <alsa-devel@alsa-project.org>; Wed,  9 May 2018 00:42:05 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, John Hsu <KCHSU0@nuvoton.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in dev_warn messages

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/codecs/nau8824.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/nau8824.c b/sound/soc/codecs/nau8824.c
index 76502c090654..6bd14453f06e 100644
--- a/sound/soc/codecs/nau8824.c
+++ b/sound/soc/codecs/nau8824.c
@@ -205,11 +205,11 @@ static int nau8824_sema_acquire(struct nau8824 *nau8824, long timeout)
 	if (timeout) {
 		ret = down_timeout(&nau8824->jd_sem, timeout);
 		if (ret < 0)
-			dev_warn(nau8824->dev, "Acquire semaphone timeout\n");
+			dev_warn(nau8824->dev, "Acquire semaphore timeout\n");
 	} else {
 		ret = down_interruptible(&nau8824->jd_sem);
 		if (ret < 0)
-			dev_warn(nau8824->dev, "Acquire semaphone fail\n");
+			dev_warn(nau8824->dev, "Acquire semaphore fail\n");
 	}
 
 	return ret;
-- 
2.17.0
