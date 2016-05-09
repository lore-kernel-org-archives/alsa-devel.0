From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 7/7] ALSA: firewire-lib: enable the same
	feature as CIP_SKIP_INIT_DBC_CHECK flag
Date: Mon,  9 May 2016 23:15:56 +0900
Message-ID: <1462803356-6229-8-git-send-email-o-takashi@sakamocchi.jp>
References: <1462803356-6229-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id A5A5326583F
 for <alsa-devel@alsa-project.org>; Mon,  9 May 2016 16:16:03 +0200 (CEST)
In-Reply-To: <1462803356-6229-1-git-send-email-o-takashi@sakamocchi.jp>
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

In former commit, drivers in ALSA firewire stack always starts IT context
before IR context. If IR context starts after packets are transmitted by
peer unit, packet discontinuity may be detected because the context starts
in the middle of packet streaming. This situation is rare because IT
context usually starts immediately. However, it's better to solve this
issue. This is suppressed with CIP_SKIP_INIT_DBC_CHECK flag.

This commit enables the same feature as CIP_SKIP_INIT_DBC_CHECK.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c       | 3 +--
 sound/firewire/amdtp-stream.h       | 7 ++-----
 sound/firewire/bebob/bebob_stream.c | 2 --
 sound/firewire/digi00x/amdtp-dot.c  | 2 +-
 sound/firewire/oxfw/oxfw-stream.c   | 3 +--
 5 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 6db2a73..830a95c 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -723,8 +723,7 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
 		goto err_unlock;
 	}
 
-	if (s->direction == AMDTP_IN_STREAM &&
-	    s->flags & CIP_SKIP_INIT_DBC_CHECK)
+	if (s->direction == AMDTP_IN_STREAM)
 		s->data_block_counter = UINT_MAX;
 	else
 		s->data_block_counter = 0;
diff --git a/sound/firewire/amdtp-stream.h b/sound/firewire/amdtp-stream.h
index da028b0..349c405 100644
--- a/sound/firewire/amdtp-stream.h
+++ b/sound/firewire/amdtp-stream.h
@@ -24,8 +24,6 @@
  *	The value of data_block_quadlets is used instead of reported value.
  * @CIP_SKIP_DBC_ZERO_CHECK: Only for in-stream.  Packets with zero in dbc is
  *	skipped for detecting discontinuity.
- * @CIP_SKIP_INIT_DBC_CHECK: Only for in-stream. The value of dbc in first
- *	packet is not continuous from an initial value.
  * @CIP_EMPTY_HAS_WRONG_DBC: Only for in-stream. The value of dbc in empty
  *	packet is wrong but the others are correct.
  * @CIP_JUMBO_PAYLOAD: Only for in-stream. The number of data blocks in an
@@ -39,9 +37,8 @@ enum cip_flags {
 	CIP_DBC_IS_END_EVENT	= 0x04,
 	CIP_WRONG_DBS		= 0x08,
 	CIP_SKIP_DBC_ZERO_CHECK	= 0x10,
-	CIP_SKIP_INIT_DBC_CHECK	= 0x20,
-	CIP_EMPTY_HAS_WRONG_DBC	= 0x40,
-	CIP_JUMBO_PAYLOAD	= 0x80,
+	CIP_EMPTY_HAS_WRONG_DBC	= 0x20,
+	CIP_JUMBO_PAYLOAD	= 0x40,
 };
 
 /**
diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index 0141813..4d3034a 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -526,8 +526,6 @@ int snd_bebob_stream_init_duplex(struct snd_bebob *bebob)
 		goto end;
 	}
 
-	bebob->tx_stream.flags |= CIP_SKIP_INIT_DBC_CHECK;
-
 	/*
 	 * BeBoB v3 transfers packets with these qurks:
 	 *  - In the beginning of streaming, the value of dbc is incremented
diff --git a/sound/firewire/digi00x/amdtp-dot.c b/sound/firewire/digi00x/amdtp-dot.c
index 0ac92ab..b3cffd0 100644
--- a/sound/firewire/digi00x/amdtp-dot.c
+++ b/sound/firewire/digi00x/amdtp-dot.c
@@ -421,7 +421,7 @@ int amdtp_dot_init(struct amdtp_stream *s, struct fw_unit *unit,
 
 	/* Use different mode between incoming/outgoing. */
 	if (dir == AMDTP_IN_STREAM) {
-		flags = CIP_NONBLOCKING | CIP_SKIP_INIT_DBC_CHECK;
+		flags = CIP_NONBLOCKING;
 		process_data_blocks = process_tx_data_blocks;
 	} else {
 		flags = CIP_BLOCKING;
diff --git a/sound/firewire/oxfw/oxfw-stream.c b/sound/firewire/oxfw/oxfw-stream.c
index 7cb5743..d9361f3 100644
--- a/sound/firewire/oxfw/oxfw-stream.c
+++ b/sound/firewire/oxfw/oxfw-stream.c
@@ -242,8 +242,7 @@ int snd_oxfw_stream_init_simplex(struct snd_oxfw *oxfw,
 	 * blocks than IEC 61883-6 defines.
 	 */
 	if (stream == &oxfw->tx_stream) {
-		oxfw->tx_stream.flags |= CIP_SKIP_INIT_DBC_CHECK |
-					 CIP_JUMBO_PAYLOAD;
+		oxfw->tx_stream.flags |= CIP_JUMBO_PAYLOAD;
 		if (oxfw->wrong_dbs)
 			oxfw->tx_stream.flags |= CIP_WRONG_DBS;
 	}
-- 
2.7.4
