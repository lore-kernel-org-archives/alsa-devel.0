From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH v2 2/2] ASoC: rt5645: patch reg-0x8a
Date: Fri, 1 Jul 2016 09:49:06 +0800
Message-ID: <1467337746-3900-2-git-send-email-bardliao@realtek.com>
References: <1467337746-3900-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 9923A2651DB
 for <alsa-devel@alsa-project.org>; Fri,  1 Jul 2016 03:49:29 +0200 (CEST)
In-Reply-To: <1467337746-3900-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, koro.chen@mediatek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

reg-8a assign the tracking source for each ASRC tracker. The default
value is 0x0000 which means all ASRC trackers will track LRCK1. But
in most cases, we wish each ASRC tracker track the corresponding LRCK.
i.e. ASRC1 tracks LRCK1, ASRC2 tracks LRCK2 and so on. So, we rewrite
reg-8a as 0x0120.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5645.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)
---
Mark,

This patch was based on wrong code base. So, resend it.

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index d70847c..97bf96e 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -63,6 +63,7 @@ static const struct reg_sequence init_list[] = {
 	{RT5645_PR_BASE + 0x20,	0x611f},
 	{RT5645_PR_BASE + 0x21,	0x4040},
 	{RT5645_PR_BASE + 0x23,	0x0004},
+	{RT5645_ASRC_4, 0x0120},
 };
 
 static const struct reg_sequence rt5650_init_list[] = {
@@ -157,7 +158,7 @@ static const struct reg_default rt5645_reg[] = {
 	{ 0x83, 0x0000 },
 	{ 0x84, 0x0000 },
 	{ 0x85, 0x0000 },
-	{ 0x8a, 0x0000 },
+	{ 0x8a, 0x0120 },
 	{ 0x8e, 0x0004 },
 	{ 0x8f, 0x1100 },
 	{ 0x90, 0x0646 },
@@ -314,7 +315,7 @@ static const struct reg_default rt5650_reg[] = {
 	{ 0x83, 0x0000 },
 	{ 0x84, 0x0000 },
 	{ 0x85, 0x0000 },
-	{ 0x8a, 0x0000 },
+	{ 0x8a, 0x0120 },
 	{ 0x8e, 0x0004 },
 	{ 0x8f, 0x1100 },
 	{ 0x90, 0x0646 },
-- 
1.8.1.1.439.g50a6b54
