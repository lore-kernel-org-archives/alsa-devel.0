From: Nicolas Boichat <drinkcat@chromium.org>
Subject: [PATCH v3] ASoC: rt5645: Check if codec is initialized
	in workqueue handler
Date: Thu, 16 Jul 2015 11:30:58 +0800
Message-ID: <1437017458-19476-1-git-send-email-drinkcat@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f172.google.com (mail-pd0-f172.google.com
 [209.85.192.172])
 by alsa0.perex.cz (Postfix) with ESMTP id A3FF5265E05
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 05:31:17 +0200 (CEST)
Received: by pdbqm3 with SMTP id qm3so36215380pdb.0
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2015 20:31:16 -0700 (PDT)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Koro Chen <koro.chen@mediatek.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

rt5645_jack_detect_work needs rt5645->codec to be initialized to
setup dapm pins. Also, reporting jack events is useless, as the
jacks cannot be set before the codec is ready.

Since we manually call the interrupt handler in
rt5645_set_jack_detect, the initial jack state will be reported
correctly, and dapm pins will be setup at that time.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
 sound/soc/codecs/rt5645.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 093a41d..ff75d04 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -2918,6 +2918,9 @@ static void rt5645_jack_detect_work(struct work_struct *work)
 		container_of(work, struct rt5645_priv, jack_detect_work.work);
 	int val, btn_type, gpio_state = 0, report = 0;
 
+	if (!rt5645->codec)
+		return;
+
 	switch (rt5645->pdata.jd_mode) {
 	case 0: /* Not using rt5645 JD */
 		if (rt5645->gpiod_hp_det) {
-- 
2.4.3.573.g4eafbef
