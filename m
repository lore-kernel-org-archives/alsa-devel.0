From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 06/20] ALSA: firewire-lib: add syt_override
	member for some protocols
Date: Mon, 22 Jul 2019 12:36:56 +0900
Message-ID: <20190722033710.28107-7-o-takashi@sakamocchi.jp>
References: <20190722033710.28107-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 09D19F803D1
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2019 05:37:26 +0200 (CEST)
In-Reply-To: <20190722033710.28107-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Some protocols don't use syt field of CIP header to represent
presentation timestamp. For such protocol, ALSA IEC 61883-1/6
packet streaming engine uses a pointer into local variable for
the value of syt to call data block processing layer. However,
it can decide the value when initializing packet streaming
layer.

This commit adds 'syt_override' member for packet streaming
layer.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c        | 6 ++++++
 sound/firewire/amdtp-stream.h        | 1 +
 sound/firewire/motu/amdtp-motu.c     | 8 +++++++-
 sound/firewire/tascam/amdtp-tascam.c | 8 ++++++--
 4 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 3435bef97a8b..6242240cd8ee 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -104,6 +104,9 @@ int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
 	s->fmt = fmt;
 	s->process_data_blocks = process_data_blocks;
 
+	if (dir == AMDTP_OUT_STREAM)
+		s->ctx_data.rx.syt_override = -1;
+
 	return 0;
 }
 EXPORT_SYMBOL(amdtp_stream_init);
@@ -717,6 +720,9 @@ static void out_stream_callback(struct fw_iso_context *context, u32 tstamp,
 		if (s->flags & CIP_DBC_IS_END_EVENT)
 			dbc = (dbc + data_blocks) & 0xff;
 
+		if (s->ctx_data.rx.syt_override >= 0)
+			syt = s->ctx_data.rx.syt_override;
+
 		build_it_pkt_header(s, cycle, &template.params, data_blocks,
 				    dbc, syt, i);
 
diff --git a/sound/firewire/amdtp-stream.h b/sound/firewire/amdtp-stream.h
index 762ac3c7e902..5b9d4212e202 100644
--- a/sound/firewire/amdtp-stream.h
+++ b/sound/firewire/amdtp-stream.h
@@ -133,6 +133,7 @@ struct amdtp_stream {
 
 			// To generate CIP header.
 			unsigned int fdf;
+			int syt_override;
 		} rx;
 	} ctx_data;
 
diff --git a/sound/firewire/motu/amdtp-motu.c b/sound/firewire/motu/amdtp-motu.c
index 9693f37a0032..683873699885 100644
--- a/sound/firewire/motu/amdtp-motu.c
+++ b/sound/firewire/motu/amdtp-motu.c
@@ -428,7 +428,13 @@ int amdtp_motu_init(struct amdtp_stream *s, struct fw_unit *unit,
 		return err;
 
 	s->sph = 1;
-	s->ctx_data.rx.fdf = MOTU_FDF_AM824;
+
+	if (dir == AMDTP_OUT_STREAM) {
+		// Use fixed value for FDF field.
+		s->ctx_data.rx.fdf = MOTU_FDF_AM824;
+		// Not used.
+		s->ctx_data.rx.syt_override = 0xffff;
+	}
 
 	return 0;
 }
diff --git a/sound/firewire/tascam/amdtp-tascam.c b/sound/firewire/tascam/amdtp-tascam.c
index 3a4d1f855f79..8fba6fb8ba8a 100644
--- a/sound/firewire/tascam/amdtp-tascam.c
+++ b/sound/firewire/tascam/amdtp-tascam.c
@@ -220,8 +220,12 @@ int amdtp_tscm_init(struct amdtp_stream *s, struct fw_unit *unit,
 	if (err < 0)
 		return 0;
 
-	/* Use fixed value for FDF field. */
-	s->ctx_data.rx.fdf = 0x00;
+	if (dir == AMDTP_OUT_STREAM) {
+		// Use fixed value for FDF field.
+		s->ctx_data.rx.fdf = 0x00;
+		// Not used.
+		s->ctx_data.rx.syt_override = 0x0000;
+	}
 
 	/* This protocol uses fixed number of data channels for PCM samples. */
 	p = s->protocol;
-- 
2.20.1
