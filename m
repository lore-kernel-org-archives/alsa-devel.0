From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt286: Fix the runtime error in the
	booting
Date: Fri, 2 Oct 2015 13:30:29 +0800
Message-ID: <1443763829-9359-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 3987F2667F3
 for <alsa-devel@alsa-project.org>; Fri,  2 Oct 2015 07:30:38 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, john.lin@realtek.com, bardliao@realtek.com, flubba86@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The struct rt286_index_def was used by the cache function, so it cannot be
declared as const.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt286.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index 1fbdb4f..79107dc 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -49,7 +49,7 @@ struct rt286_priv {
 	int clk_id;
 };
 
-static const struct reg_default rt286_index_def[] = {
+static struct reg_default rt286_index_def[] = {
 	{ 0x01, 0xaaaa },
 	{ 0x02, 0x8aaa },
 	{ 0x03, 0x0002 },
-- 
1.8.1.1.439.g50a6b54
