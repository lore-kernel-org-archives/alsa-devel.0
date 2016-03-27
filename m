From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/4] ALSA: bebob: remove needless argument from
	local function
Date: Sun, 27 Mar 2016 16:09:06 +0900
Message-ID: <1459062549-18721-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1459062549-18721-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C2F62608EA
 for <alsa-devel@alsa-project.org>; Sun, 27 Mar 2016 09:09:14 +0200 (CEST)
In-Reply-To: <1459062549-18721-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

The 'vendor_id' argument is not used in the local function. Let's remove
it.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
index 3e4e075..932901d 100644
--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -67,7 +67,7 @@ static DECLARE_BITMAP(devices_used, SNDRV_CARDS);
 #define MODEL_MAUDIO_PROJECTMIX		0x00010091
 
 static int
-name_device(struct snd_bebob *bebob, unsigned int vendor_id)
+name_device(struct snd_bebob *bebob)
 {
 	struct fw_device *fw_dev = fw_parent_device(bebob->unit);
 	char vendor[24] = {0};
@@ -232,7 +232,7 @@ bebob_probe(struct fw_unit *unit,
 	spin_lock_init(&bebob->lock);
 	init_waitqueue_head(&bebob->hwdep_wait);
 
-	err = name_device(bebob, entry->vendor_id);
+	err = name_device(bebob);
 	if (err < 0)
 		goto error;
 
-- 
2.7.3
