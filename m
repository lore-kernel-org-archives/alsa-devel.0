From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/3] ALSA: info - Remove BKL
Date: Wed, 14 Apr 2010 10:14:21 +0200
Message-ID: <1271232862-16183-3-git-send-email-tiwai@suse.de>
References: <1271232862-16183-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 6FF2F24479
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Apr 2010 10:14:44 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id F38D68655F
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Apr 2010 10:14:43 +0200 (CEST)
In-Reply-To: <1271232862-16183-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Use the fine-grained mutex for the assigned info object, instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/info.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/info.c b/sound/core/info.c
index d749a0d..fe83661 100644
--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -167,7 +167,7 @@ static loff_t snd_info_entry_llseek(struct file *file, loff_t offset, int orig)
 
 	data = file->private_data;
 	entry = data->entry;
-	lock_kernel();
+	mutex_lock(&entry->access);
 	switch (entry->content) {
 	case SNDRV_INFO_CONTENT_TEXT:
 		switch (orig) {
@@ -196,7 +196,7 @@ static loff_t snd_info_entry_llseek(struct file *file, loff_t offset, int orig)
 	}
 	ret = -ENXIO;
 out:
-	unlock_kernel();
+	mutex_unlock(&entry->access);
 	return ret;
 }
 
-- 
1.7.0.4
