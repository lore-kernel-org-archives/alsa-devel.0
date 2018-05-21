From: Yisheng Xie <xieyisheng1@huawei.com>
Subject: [PATCH 28/33] ALSA: dice use match_string() helper
Date: Mon, 21 May 2018 19:58:05 +0800
Message-ID: <1526903890-35761-29-git-send-email-xieyisheng1@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by alsa0.perex.cz (Postfix) with ESMTP id F2BE126762F
 for <alsa-devel@alsa-project.org>; Mon, 21 May 2018 14:09:30 +0200 (CEST)
In-Reply-To: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: Yisheng Xie <xieyisheng1@huawei.com>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

match_string() returns the index of an array for a matching string,
which can be used intead of open coded variant.

Cc: Clemens Ladisch <clemens@ladisch.de>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 sound/firewire/dice/dice.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/sound/firewire/dice/dice.c b/sound/firewire/dice/dice.c
index 96bb01b..0639074 100644
--- a/sound/firewire/dice/dice.c
+++ b/sound/firewire/dice/dice.c
@@ -35,19 +35,13 @@ static bool force_two_pcm_support(struct fw_unit *unit)
 		"SAFFIRE_PRO_40_1",
 	};
 	char model[32];
-	unsigned int i;
 	int err;
 
 	err = fw_csr_string(unit->directory, CSR_MODEL, model, sizeof(model));
 	if (err < 0)
 		return false;
 
-	for (i = 0; i < ARRAY_SIZE(models); i++) {
-		if (strcmp(models[i], model) == 0)
-			break;
-	}
-
-	return i < ARRAY_SIZE(models);
+	return match_string(models, ARRAY_SIZE(models), model) >= 0;
 }
 
 static int check_dice_category(struct fw_unit *unit)
-- 
1.7.12.4
