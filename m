From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 03/19] ALSA: firewire-lib: add a kernel API to
	add AMDTP stream into AMDTP domain
Date: Sun,  4 Aug 2019 15:21:22 +0900
Message-ID: <20190804062138.1217-4-o-takashi@sakamocchi.jp>
References: <20190804062138.1217-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DB899F800F4
 for <alsa-devel@alsa-project.org>; Sun,  4 Aug 2019 08:21:48 +0200 (CEST)
In-Reply-To: <20190804062138.1217-1-o-takashi@sakamocchi.jp>
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

This commit adds a kernel API to insert AMDTP stream to list in AMDTP
domain.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 26 ++++++++++++++++++++++++++
 sound/firewire/amdtp-stream.h |  5 +++++
 2 files changed, 31 insertions(+)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 31fc90f76443..fa7989ee4769 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -1159,6 +1159,32 @@ void amdtp_domain_destroy(struct amdtp_domain *d)
 }
 EXPORT_SYMBOL_GPL(amdtp_domain_destroy);
 
+/**
+ * amdtp_domain_add_stream - register isoc context into the domain.
+ * @d: the AMDTP domain.
+ * @s: the AMDTP stream.
+ * @channel: the isochronous channel on the bus.
+ * @speed: firewire speed code.
+ */
+int amdtp_domain_add_stream(struct amdtp_domain *d, struct amdtp_stream *s,
+			    int channel, int speed)
+{
+	struct amdtp_stream *tmp;
+
+	list_for_each_entry(tmp, &d->streams, list) {
+		if (s == tmp)
+			return -EBUSY;
+	}
+
+	list_add(&s->list, &d->streams);
+
+	s->channel = channel;
+	s->speed = speed;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(amdtp_domain_add_stream);
+
 /**
  * amdtp_domain_stop - stop sending packets for isoc context in the same domain.
  * @d: the AMDTP domain to which the isoc contexts belong.
diff --git a/sound/firewire/amdtp-stream.h b/sound/firewire/amdtp-stream.h
index ab2a69180240..4b102fd7529d 100644
--- a/sound/firewire/amdtp-stream.h
+++ b/sound/firewire/amdtp-stream.h
@@ -172,6 +172,8 @@ struct amdtp_stream {
 	amdtp_stream_process_ctx_payloads_t process_ctx_payloads;
 
 	// For domain.
+	int channel;
+	int speed;
 	struct list_head list;
 };
 
@@ -277,6 +279,9 @@ struct amdtp_domain {
 int amdtp_domain_init(struct amdtp_domain *d);
 void amdtp_domain_destroy(struct amdtp_domain *d);
 
+int amdtp_domain_add_stream(struct amdtp_domain *d, struct amdtp_stream *s,
+			    int channel, int speed);
+
 void amdtp_domain_stop(struct amdtp_domain *d);
 
 #endif
-- 
2.20.1
