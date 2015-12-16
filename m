From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/4] ALSA: oxfw: enable to keep memory block
	for model-specific structure
Date: Wed, 16 Dec 2015 20:37:54 +0900
Message-ID: <1450265877-14390-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1450265877-14390-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 383FE2657F9
 for <alsa-devel@alsa-project.org>; Wed, 16 Dec 2015 12:38:01 +0100 (CET)
In-Reply-To: <1450265877-14390-1-git-send-email-o-takashi@sakamocchi.jp>
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

ALSA oxfw driver should have backward compatibility to old
firewire-speakers driver. Additionally, in future commit, scs1x driver
will be merged. It's nice to add a pointer to have a memory block for
model-specific structures.

This commit adds a member to 'struct snd_oxfw' for this aim. Deallocation
is done at freeing ALSA card structure.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw.c | 1 +
 sound/firewire/oxfw/oxfw.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index d4fb3c1..7e50a4f 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -132,6 +132,7 @@ static void oxfw_card_free(struct snd_card *card)
 		kfree(oxfw->rx_stream_formats[i]);
 	}
 
+	kfree(oxfw->spec);
 	mutex_destroy(&oxfw->mutex);
 }
 
diff --git a/sound/firewire/oxfw/oxfw.h b/sound/firewire/oxfw/oxfw.h
index f3e14ff..9625661 100644
--- a/sound/firewire/oxfw/oxfw.h
+++ b/sound/firewire/oxfw/oxfw.h
@@ -74,6 +74,7 @@ struct snd_oxfw {
 	wait_queue_head_t hwdep_wait;
 
 	const struct ieee1394_device_id *entry;
+	void *spec;
 };
 
 /*
-- 
2.5.0
