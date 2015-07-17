From: Nicolas Boichat <drinkcat@chromium.org>
Subject: [PATCH v4] ASoC: rt5645: Check if codec is initialized
	in workqueue handler
Date: Fri, 17 Jul 2015 10:36:57 +0800
Message-ID: <1437100617-37845-1-git-send-email-drinkcat@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f175.google.com (mail-pd0-f175.google.com
 [209.85.192.175])
 by alsa0.perex.cz (Postfix) with ESMTP id D9840260635
 for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2015 04:37:08 +0200 (CEST)
Received: by pdjr16 with SMTP id r16so54325650pdj.3
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 19:37:07 -0700 (PDT)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, drinkcat@chromium.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

This fixes kernel panic on boot, if rt5645->codec is NULL when
rt5645_jack_detect_work is first called.

rt5645_jack_detect_work needs rt5645->codec to be initialized to setup
dapm pins. Also, reporting jack events is useless, as the jacks cannot
be set before the codec is ready.

Since we manually call the interrupt handler in
rt5645_set_jack_detect, the initial jack state will be reported
correctly, and dapm pins will be setup at that time.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
This replaces 3c2234569cfff83718792f810a9bb855b78c2473, and applies on top of
Linux 4.2-rc1, so that this patch can be applied in its own branch, without
triggering a compile warning.

Also, reworded the message to make it more obvious this can cause a kernel
panic.

Thanks!

 sound/soc/codecs/rt5645.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 9ce311e..e9cc3aa 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -2943,6 +2943,9 @@ static int rt5645_irq_detection(struct rt5645_priv *rt5645)
 {
 	int val, btn_type, gpio_state = 0, report = 0;
 
+	if (!rt5645->codec)
+		return -EINVAL;
+
 	switch (rt5645->pdata.jd_mode) {
 	case 0: /* Not using rt5645 JD */
 		if (rt5645->gpiod_hp_det) {
-- 
2.4.3.573.g4eafbef
