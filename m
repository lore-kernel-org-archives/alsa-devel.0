From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/4] firewire-lib: add helper function to set data block size
Date: Wed, 17 Jul 2013 20:50:45 +0900
Message-ID: <1374061848-5851-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1374061848-5851-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1374061848-5851-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de
Cc: robert.chamier@googlemail.com, damien@zamaudio.com, linux1394-devel@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: sakamocchi <o-takashi@sakamocchi.jp>

For each driver this commit adds helper function to set the size of data block
in AMDTP packet (quadlet unit) without setting the number of channels for PCM,
without the number of ports for MIDI.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 amdtp.c |    5 +----
 amdtp.h |   14 ++++++++++++++
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/amdtp.c b/amdtp.c
index ea995af..19b8a81 100644
--- a/amdtp.c
+++ b/amdtp.c
@@ -125,9 +125,6 @@ unsigned int amdtp_out_stream_get_max_payload(struct amdtp_out_stream *s)
 		[CIP_SFC_192000] = 24,
 	};
 
-	s->data_block_quadlets = s->pcm_channels;
-	s->data_block_quadlets += DIV_ROUND_UP(s->midi_ports, 8);
-
 	return 8 + max_data_blocks[s->sfc] * 4 * s->data_block_quadlets;
 }
 EXPORT_SYMBOL(amdtp_out_stream_get_max_payload);
@@ -478,7 +475,7 @@ int amdtp_out_stream_start(struct amdtp_out_stream *s, int channel, int speed)
 	mutex_lock(&s->mutex);
 
 	if (WARN_ON(!IS_ERR(s->context) ||
-		    (!s->pcm_channels && !s->midi_ports))) {
+		    (s->data_block_quadlets == 0))) {
 		err = -EBADFD;
 		goto err_unlock;
 	}
diff --git a/amdtp.h b/amdtp.h
index f6103d6..977205b 100644
--- a/amdtp.h
+++ b/amdtp.h
@@ -88,6 +88,20 @@ unsigned long amdtp_out_stream_pcm_pointer(struct amdtp_out_stream *s);
 void amdtp_out_stream_pcm_abort(struct amdtp_out_stream *s);
 
 /**
+ * amdtp_out_stream_set_data_block_quadlets  configure the size of a data block
+ * @s: the AMDTP output stream to be configured
+ * @data_block_quadlets: the number of quadlets in a data block for AMDTP packets
+ *
+ * This function must not be called while the stream is running.
+ */
+static inline void
+amdtp_out_stream_set_data_block_quadlets(struct amdtp_out_stream *s,
+					 unsigned int data_block_quadlets)
+{
+	s->data_block_quadlets = data_block_quadlets;
+}
+
+/**
  * amdtp_out_stream_set_pcm - configure format of PCM samples
  * @s: the AMDTP output stream to be configured
  * @pcm_channels: the number of PCM samples in each data block, to be encoded
-- 
1.7.10.4


------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
