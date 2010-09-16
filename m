From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH] ALSA: core: Allow card id change to the same
	string
Date: Thu, 16 Sep 2010 10:26:54 +0300
Message-ID: <1284622014-1341-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 85EDD24694
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Sep 2010 09:27:05 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

When user want to change the card id to the same string
on the card via /sys/class/sound/cardX/id, do not
report error. Instead return with success without
doing anything.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/core/init.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/core/init.c b/sound/core/init.c
index ec4a50c..2de45fb 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -607,11 +607,16 @@ card_id_store_attr(struct device *dev, struct device_attribute *attr,
 		return -EEXIST;
 	}
 	for (idx = 0; idx < snd_ecards_limit; idx++) {
-		if (snd_cards[idx] && !strcmp(snd_cards[idx]->id, buf1))
-			goto __exist;
+		if (snd_cards[idx] && !strcmp(snd_cards[idx]->id, buf1)) {
+			if (card == snd_cards[idx])
+				goto __ok;
+			else
+				goto __exist;
+		}
 	}
 	strcpy(card->id, buf1);
 	snd_info_card_id_change(card);
+__ok:
 	mutex_unlock(&snd_card_mutex);
 
 	return count;
-- 
1.7.2.2
