From: Nicolas Boichat <drinkcat@chromium.org>
Subject: [PATCH] ASoC: rt5645: Remove return value in jack
	detect work
Date: Mon, 20 Jul 2015 09:32:05 +0800
Message-ID: <1437355925-20498-1-git-send-email-drinkcat@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f170.google.com (mail-pd0-f170.google.com
 [209.85.192.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 524CD260633
 for <alsa-devel@alsa-project.org>; Mon, 20 Jul 2015 03:32:33 +0200 (CEST)
Received: by pdbbh15 with SMTP id bh15so48569197pdb.1
 for <alsa-devel@alsa-project.org>; Sun, 19 Jul 2015 18:32:31 -0700 (PDT)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

"ASoC: rt5645: Check if codec is initialized in workqueue handler"
adds a check if codec is NULL in rt5645_irq_detection, which
returns an int. However, "ASoC: rt5645: Remove irq_jack_detection
function" removes that function, and moves the code in
jack_detect_work, which returns void.

Remove the return value to fix compilation warning.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---

Mark,

Thanks for replacing "ASoC: rt5645: Check if codec is initialized
in workqueue handler" in fix/rt5645, that makes this a bit easier.

This patch applies on top of broonie/sound.git/for-next, and should
be applied in topic/rt5645, after merging fix/rt5645 into topic/rt5645.

 sound/soc/codecs/rt5645.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 3a6756d..9d54b34 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -2928,7 +2928,7 @@ static void rt5645_jack_detect_work(struct work_struct *work)
 	int val, btn_type, gpio_state = 0, report = 0;
 
 	if (!rt5645->codec)
-		return -EINVAL;
+		return;
 
 	switch (rt5645->pdata.jd_mode) {
 	case 0: /* Not using rt5645 JD */
-- 
2.4.3.573.g4eafbef
