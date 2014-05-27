From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 09/12] bebob: Use different names for
	identifiers in the same file
Date: Wed, 28 May 2014 00:14:44 +0900
Message-ID: <1401203687-4189-10-git-send-email-o-takashi@sakamocchi.jp>
References: <1401203687-4189-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id D6FE726584A
 for <alsa-devel@alsa-project.org>; Tue, 27 May 2014 17:15:16 +0200 (CEST)
In-Reply-To: <1401203687-4189-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, dan.carpenter@oracle.com, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

To suppress 'sparse' warning.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
index 31b96b7..b5e8f99 100644
--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -69,7 +69,7 @@ name_device(struct snd_bebob *bebob, unsigned int vendor_id)
 	struct fw_device *fw_dev = fw_parent_device(bebob->unit);
 	char vendor[24] = {0};
 	char model[32] = {0};
-	u32 id;
+	u32 hw_id;
 	u32 data[2] = {0};
 	u32 revision;
 	int err;
@@ -88,7 +88,7 @@ name_device(struct snd_bebob *bebob, unsigned int vendor_id)
 
 	/* get hardware id */
 	err = snd_bebob_read_quad(bebob->unit, INFO_OFFSET_HW_MODEL_ID,
-				  &id);
+				  &hw_id);
 	if (err < 0)
 		goto end;
 
@@ -109,7 +109,7 @@ name_device(struct snd_bebob *bebob, unsigned int vendor_id)
 	strcpy(bebob->card->mixername, model);
 	snprintf(bebob->card->longname, sizeof(bebob->card->longname),
 		 "%s %s (id:%d, rev:%d), GUID %08x%08x at %s, S%d",
-		 vendor, model, id, revision,
+		 vendor, model, hw_id, revision,
 		 data[0], data[1], dev_name(&bebob->unit->device),
 		 100 << fw_dev->max_speed);
 end:
-- 
1.8.3.2
