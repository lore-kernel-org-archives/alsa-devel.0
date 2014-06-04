From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 6/6] bebob: Remove unused function prototype
Date: Wed,  4 Jun 2014 15:25:37 +0900
Message-ID: <1401863137-15103-7-git-send-email-o-takashi@sakamocchi.jp>
References: <1401863137-15103-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 82C3D265329
 for <alsa-devel@alsa-project.org>; Wed,  4 Jun 2014 08:25:58 +0200 (CEST)
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

snd_bebob_stream_map() is not defined.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index d1c93a1..e13eef9 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -208,8 +208,6 @@ int snd_bebob_stream_set_rate(struct snd_bebob *bebob, unsigned int rate);
 int snd_bebob_stream_check_internal_clock(struct snd_bebob *bebob,
 					  bool *internal);
 int snd_bebob_stream_discover(struct snd_bebob *bebob);
-int snd_bebob_stream_map(struct snd_bebob *bebob,
-			 struct amdtp_stream *stream);
 int snd_bebob_stream_init_duplex(struct snd_bebob *bebob);
 int snd_bebob_stream_start_duplex(struct snd_bebob *bebob, unsigned int rate);
 void snd_bebob_stream_stop_duplex(struct snd_bebob *bebob);
-- 
1.8.3.2
