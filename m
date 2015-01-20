From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: fireworks/bebob: fix refering to
	released resources at unplugging
Date: Wed, 21 Jan 2015 08:07:30 +0900
Message-ID: <1421795250-7528-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id B7B21260705
 for <alsa-devel@alsa-project.org>; Wed, 21 Jan 2015 00:07:37 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Unplugging devices can cause disorder by releasing streaming resources
before stopping playbacking/capturing substreams. This commit forces
the state of ALSA character devices into disconnect before releasing
the resources.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob.c         | 3 ++-
 sound/firewire/fireworks/fireworks.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
index fc19c99..41eb1ce 100644
--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -306,10 +306,11 @@ static void bebob_remove(struct fw_unit *unit)
 	if (bebob == NULL)
 		return;
 
+	snd_card_disconnect(bebob->card);
+
 	kfree(bebob->maudio_special_quirk);
 
 	snd_bebob_stream_destroy_duplex(bebob);
-	snd_card_disconnect(bebob->card);
 	snd_card_free_when_closed(bebob->card);
 }
 
diff --git a/sound/firewire/fireworks/fireworks.c b/sound/firewire/fireworks/fireworks.c
index 3e2ed8e..21fb50f 100644
--- a/sound/firewire/fireworks/fireworks.c
+++ b/sound/firewire/fireworks/fireworks.c
@@ -289,10 +289,11 @@ static void efw_remove(struct fw_unit *unit)
 {
 	struct snd_efw *efw = dev_get_drvdata(&unit->device);
 
+	snd_card_disconnect(efw->card);
+
 	snd_efw_stream_destroy_duplex(efw);
 	snd_efw_transaction_remove_instance(efw);
 
-	snd_card_disconnect(efw->card);
 	snd_card_free_when_closed(efw->card);
 }
 
-- 
2.1.0
