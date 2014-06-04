From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/6] fireworks/bebob: Shorten critical section
	for stream_stop_duplex()
Date: Wed,  4 Jun 2014 15:25:32 +0900
Message-ID: <1401863137-15103-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1401863137-15103-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 248672625FE
 for <alsa-devel@alsa-project.org>; Wed,  4 Jun 2014 08:25:51 +0200 (CEST)
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

All assignment for local variables in these functions are not related to
critical section.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob_stream.c         | 4 ++--
 sound/firewire/fireworks/fireworks_stream.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index bc4f827..ef4d0c9 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -655,8 +655,6 @@ void snd_bebob_stream_stop_duplex(struct snd_bebob *bebob)
 	struct amdtp_stream *master, *slave;
 	atomic_t *master_substreams, *slave_substreams;
 
-	mutex_lock(&bebob->mutex);
-
 	if (bebob->master == &bebob->rx_stream) {
 		slave  = &bebob->tx_stream;
 		master = &bebob->rx_stream;
@@ -669,6 +667,8 @@ void snd_bebob_stream_stop_duplex(struct snd_bebob *bebob)
 		master_substreams = &bebob->capture_substreams;
 	}
 
+	mutex_lock(&bebob->mutex);
+
 	if (atomic_read(slave_substreams) == 0) {
 		amdtp_stream_pcm_abort(slave);
 		amdtp_stream_stop(slave);
diff --git a/sound/firewire/fireworks/fireworks_stream.c b/sound/firewire/fireworks/fireworks_stream.c
index 5415690..b985fc5 100644
--- a/sound/firewire/fireworks/fireworks_stream.c
+++ b/sound/firewire/fireworks/fireworks_stream.c
@@ -284,8 +284,6 @@ void snd_efw_stream_stop_duplex(struct snd_efw *efw)
 	struct amdtp_stream *master, *slave;
 	atomic_t *master_substreams, *slave_substreams;
 
-	mutex_lock(&efw->mutex);
-
 	if (efw->master == &efw->rx_stream) {
 		slave  = &efw->tx_stream;
 		master = &efw->rx_stream;
@@ -298,6 +296,8 @@ void snd_efw_stream_stop_duplex(struct snd_efw *efw)
 		master_substreams = &efw->capture_substreams;
 	}
 
+	mutex_lock(&efw->mutex);
+
 	if (atomic_read(slave_substreams) == 0) {
 		stop_stream(efw, slave);
 
-- 
1.8.3.2
