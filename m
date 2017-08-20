From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: firewire-motu: destroy stream data
	surely at failure of card initialization
Date: Sun, 20 Aug 2017 15:55:02 +0900
Message-ID: <20170820065502.2555-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id EF6452673AE
 for <alsa-devel@alsa-project.org>; Sun, 20 Aug 2017 08:55:07 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, "# v4 . 12+" <stable@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

When failing sound card registration after initializing stream data, this
module leaves allocated data in stream data. This commit fixes the bug.

Fixes: 9b2bb4f2f4a2 ('ALSA: firewire-motu: add stream management functionality')
Cc: <stable@vger.kernel.org> # v4.12+
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/motu/motu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/firewire/motu/motu.c b/sound/firewire/motu/motu.c
index bf779cfeef0d..59a270406353 100644
--- a/sound/firewire/motu/motu.c
+++ b/sound/firewire/motu/motu.c
@@ -128,6 +128,7 @@ static void do_registration(struct work_struct *work)
 	return;
 error:
 	snd_motu_transaction_unregister(motu);
+	snd_motu_stream_destroy_duplex(motu);
 	snd_card_free(motu->card);
 	dev_info(&motu->unit->device,
 		 "Sound card registration failed: %d\n", err);
-- 
2.11.0
