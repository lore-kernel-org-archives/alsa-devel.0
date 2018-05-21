From: Yisheng Xie <xieyisheng1@huawei.com>
Subject: [PATCH 30/33] ALSA: oxygen: use match_string() helper
Date: Mon, 21 May 2018 19:58:07 +0800
Message-ID: <1526903890-35761-31-git-send-email-xieyisheng1@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by alsa0.perex.cz (Postfix) with ESMTP id 032A226738C
 for <alsa-devel@alsa-project.org>; Mon, 21 May 2018 14:09:25 +0200 (CEST)
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
Cc: Yisheng Xie <xieyisheng1@huawei.com>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

match_string() returns the index of an array for a matching string,
which can be used intead of open coded variant.

Cc: Clemens Ladisch <clemens@ladisch.de>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 sound/pci/oxygen/oxygen_mixer.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/sound/pci/oxygen/oxygen_mixer.c b/sound/pci/oxygen/oxygen_mixer.c
index 4ca1266..fbd8f5e 100644
--- a/sound/pci/oxygen/oxygen_mixer.c
+++ b/sound/pci/oxygen/oxygen_mixer.c
@@ -1052,10 +1052,9 @@ static int add_controls(struct oxygen *chip,
 		[CONTROL_CD_CAPTURE_SWITCH] = "CD Capture Switch",
 		[CONTROL_AUX_CAPTURE_SWITCH] = "Aux Capture Switch",
 	};
-	unsigned int i, j;
 	struct snd_kcontrol_new template;
 	struct snd_kcontrol *ctl;
-	int err;
+	int i, j, err;
 
 	for (i = 0; i < count; ++i) {
 		template = controls[i];
@@ -1086,11 +1085,11 @@ static int add_controls(struct oxygen *chip,
 		err = snd_ctl_add(chip->card, ctl);
 		if (err < 0)
 			return err;
-		for (j = 0; j < CONTROL_COUNT; ++j)
-			if (!strcmp(ctl->id.name, known_ctl_names[j])) {
-				chip->controls[j] = ctl;
-				ctl->private_free = oxygen_any_ctl_free;
-			}
+		j = match_string(known_ctl_names, CONTROL_COUNT, ctl->id.name);
+		if (j >= 0) {
+			chip->controls[j] = ctl;
+			ctl->private_free = oxygen_any_ctl_free;
+		}
 	}
 	return 0;
 }
-- 
1.7.12.4
