From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ALSA: Fix uninintialized error return
Date: Mon, 29 Jun 2015 17:10:22 +0100
Message-ID: <1435594222-17690-1-git-send-email-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id A7429265342
 for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2015 18:10:32 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Jie Yang <yang.jie@intel.com>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

Static analysis with cppcheck found the following error:
  [sound/core/init.c:118]: (error) Uninitialized variable: err

..this was introduced by commit 2471b6c80a70e80de69f5ff4c37187c3912e5874
("ALSA: info: Register proc entries recursively, too") where the call
to snd_info_card_register was removed and no longer setting the error
return in err.  When snd_info_create_card_entry fails to allocate a
an entry, the error path exits with garbage in err.  Fix is to return
-ENOMEM if entry fails to be allocated.

Author: Takashi Iwai <tiwai@suse.de>
Date:   Mon May 18 09:20:24 2015 +0200

Fixes: 2471b6c80a ("ALSA: info: Register proc entries recursively, too")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/core/init.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/core/init.c b/sound/core/init.c
index 3e0ceba..20f37fb 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -109,13 +109,12 @@ static void snd_card_id_read(struct snd_info_entry *entry,
 
 static int init_info_for_card(struct snd_card *card)
 {
-	int err;
 	struct snd_info_entry *entry;
 
 	entry = snd_info_create_card_entry(card, "id", card->proc_root);
 	if (!entry) {
 		dev_dbg(card->dev, "unable to create card entry\n");
-		return err;
+		return -ENOMEM;
 	}
 	entry->c.text.read = snd_card_id_read;
 	card->proc_id = entry;
-- 
2.1.4
