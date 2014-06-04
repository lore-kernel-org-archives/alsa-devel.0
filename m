From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/6] fireworks: Use safer way to arrange ring
	buffer pointer
Date: Wed,  4 Jun 2014 15:25:33 +0900
Message-ID: <1401863137-15103-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1401863137-15103-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 356C6264F0A
 for <alsa-devel@alsa-project.org>; Wed,  4 Jun 2014 08:25:53 +0200 (CEST)
In-Reply-To: <1401863137-15103-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

To reverse a pointer for the ring buffer, subtraction by buffer
size is better than assignment to the beginning of the buffer.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireworks/fireworks_hwdep.c       | 2 +-
 sound/firewire/fireworks/fireworks_transaction.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/firewire/fireworks/fireworks_hwdep.c b/sound/firewire/fireworks/fireworks_hwdep.c
index 4f8216f..33df865 100644
--- a/sound/firewire/fireworks/fireworks_hwdep.c
+++ b/sound/firewire/fireworks/fireworks_hwdep.c
@@ -58,7 +58,7 @@ hwdep_read_resp_buf(struct snd_efw *efw, char __user *buf, long remained,
 			efw->pull_ptr += till_end;
 			if (efw->pull_ptr >= efw->resp_buf +
 					     snd_efw_resp_buf_size)
-				efw->pull_ptr = efw->resp_buf;
+				efw->pull_ptr -= snd_efw_resp_buf_size;
 
 			length -= till_end;
 			buf += till_end;
diff --git a/sound/firewire/fireworks/fireworks_transaction.c b/sound/firewire/fireworks/fireworks_transaction.c
index aa56b8a..a6a9e9f 100644
--- a/sound/firewire/fireworks/fireworks_transaction.c
+++ b/sound/firewire/fireworks/fireworks_transaction.c
@@ -148,7 +148,7 @@ copy_resp_to_buf(struct snd_efw *efw, void *data, size_t length, int *rcode)
 
 		efw->push_ptr += till_end;
 		if (efw->push_ptr >= efw->resp_buf + snd_efw_resp_buf_size)
-			efw->push_ptr = efw->resp_buf;
+			efw->push_ptr -= snd_efw_resp_buf_size;
 
 		length -= till_end;
 		data += till_end;
-- 
1.8.3.2
