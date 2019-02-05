From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/3] ALSA: opl4: Remove superfluous
	snd_info_register() calls
Date: Tue,  5 Feb 2019 17:05:26 +0100
Message-ID: <20190205160527.8815-3-tiwai@suse.de>
References: <20190205160527.8815-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BF0A1267488
 for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2019 17:05:32 +0100 (CET)
In-Reply-To: <20190205160527.8815-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The calls of snd_info_register() are superfluous and should be avoided
at the procfs creation time.  They are called at the end of the whole
initialization via snd_card_register().  This patch drops such
superfluous calls.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/opl4/opl4_proc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/drivers/opl4/opl4_proc.c b/sound/drivers/opl4/opl4_proc.c
index 16b24091d799..f1b839a0e7b7 100644
--- a/sound/drivers/opl4/opl4_proc.c
+++ b/sound/drivers/opl4/opl4_proc.c
@@ -114,10 +114,6 @@ int snd_opl4_create_proc(struct snd_opl4 *opl4)
 		entry->c.ops = &snd_opl4_mem_proc_ops;
 		entry->module = THIS_MODULE;
 		entry->private_data = opl4;
-		if (snd_info_register(entry) < 0) {
-			snd_info_free_entry(entry);
-			entry = NULL;
-		}
 	}
 	opl4->proc_entry = entry;
 	return 0;
-- 
2.16.4
