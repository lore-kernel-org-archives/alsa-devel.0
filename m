From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/3] ALSA: firewire-lib: change structure
	member with proper type
Date: Tue,  3 Jan 2017 11:58:34 +0900
Message-ID: <20170103025834.17159-4-o-takashi@sakamocchi.jp>
References: <20170103025834.17159-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id C3945266CBD
 for <alsa-devel@alsa-project.org>; Tue,  3 Jan 2017 03:58:40 +0100 (CET)
In-Reply-To: <20170103025834.17159-1-o-takashi@sakamocchi.jp>
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

The 'amdtp_stream' structure is initialized by a call of
'amdtp_stream_init()'. Although a parameter of this function is for bit
flags of packet attributes, its type is enumerator.

This commit changes the type so that it's proper for a bit flags.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 2 +-
 sound/firewire/amdtp-stream.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 00060c4..8ce93cd 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -69,7 +69,7 @@ static void pcm_period_tasklet(unsigned long data);
  * @protocol_size: the size to allocate newly for protocol
  */
 int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
-		      enum amdtp_stream_direction dir, enum cip_flags flags,
+		      enum amdtp_stream_direction dir, int flags,
 		      unsigned int fmt,
 		      amdtp_stream_process_data_blocks_t process_data_blocks,
 		      unsigned int protocol_size)
diff --git a/sound/firewire/amdtp-stream.h b/sound/firewire/amdtp-stream.h
index c1bc7fa..7be2142 100644
--- a/sound/firewire/amdtp-stream.h
+++ b/sound/firewire/amdtp-stream.h
@@ -93,7 +93,7 @@ typedef unsigned int (*amdtp_stream_process_data_blocks_t)(
 						unsigned int *syt);
 struct amdtp_stream {
 	struct fw_unit *unit;
-	enum cip_flags flags;
+	int flags;
 	enum amdtp_stream_direction direction;
 	struct mutex mutex;
 
@@ -137,7 +137,7 @@ struct amdtp_stream {
 };
 
 int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
-		      enum amdtp_stream_direction dir, enum cip_flags flags,
+		      enum amdtp_stream_direction dir, int flags,
 		      unsigned int fmt,
 		      amdtp_stream_process_data_blocks_t process_data_blocks,
 		      unsigned int protocol_size);
-- 
2.9.3
