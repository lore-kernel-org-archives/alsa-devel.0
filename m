From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: arizona: Fix type of clock rate
	pointer in arizona_set_sysclk
Date: Thu, 3 Dec 2015 18:15:07 +0000
Message-ID: <1449166507-3096-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1449166507-3096-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B407260525
 for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2015 19:15:11 +0100 (CET)
In-Reply-To: <1449166507-3096-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Both the sysclk and asyncclk members of arizona_priv are signed by we
refer to them through an unsigned pointer. This patch fixes this small
harmless error.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index d2731cf..d90b3c5 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1214,7 +1214,7 @@ int arizona_set_sysclk(struct snd_soc_codec *codec, int clk_id,
 	unsigned int reg;
 	unsigned int mask = ARIZONA_SYSCLK_FREQ_MASK | ARIZONA_SYSCLK_SRC_MASK;
 	unsigned int val = source << ARIZONA_SYSCLK_SRC_SHIFT;
-	unsigned int *clk;
+	int *clk;
 
 	switch (clk_id) {
 	case ARIZONA_CLK_SYSCLK:
-- 
2.1.4
