From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 02/19] ALSA: firewire-lib: add a kernel API to
	stop a couple of AMDTP streams in AMDTP domain
Date: Sun,  4 Aug 2019 15:21:21 +0900
Message-ID: <20190804062138.1217-3-o-takashi@sakamocchi.jp>
References: <20190804062138.1217-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8257FF804CB
 for <alsa-devel@alsa-project.org>; Sun,  4 Aug 2019 08:21:47 +0200 (CEST)
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

This commit adds a kernel API to stop a couple of isochronous contexts
for AMDTP streams. The API is not protected with any lock primitive.
Callers should use this with enough lock against concurrent access.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 16 ++++++++++++++++
 sound/firewire/amdtp-stream.h |  5 +++++
 2 files changed, 21 insertions(+)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 02077696fa77..31fc90f76443 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -1158,3 +1158,19 @@ void amdtp_domain_destroy(struct amdtp_domain *d)
 	WARN_ON(!list_empty(&d->streams));
 }
 EXPORT_SYMBOL_GPL(amdtp_domain_destroy);
+
+/**
+ * amdtp_domain_stop - stop sending packets for isoc context in the same domain.
+ * @d: the AMDTP domain to which the isoc contexts belong.
+ */
+void amdtp_domain_stop(struct amdtp_domain *d)
+{
+	struct amdtp_stream *s, *next;
+
+	list_for_each_entry_safe(s, next, &d->streams, list) {
+		list_del(&s->list);
+
+		amdtp_stream_stop(s);
+	}
+}
+EXPORT_SYMBOL_GPL(amdtp_domain_stop);
diff --git a/sound/firewire/amdtp-stream.h b/sound/firewire/amdtp-stream.h
index 2378db4b4195..ab2a69180240 100644
--- a/sound/firewire/amdtp-stream.h
+++ b/sound/firewire/amdtp-stream.h
@@ -170,6 +170,9 @@ struct amdtp_stream {
 	/* For backends to process data blocks. */
 	void *protocol;
 	amdtp_stream_process_ctx_payloads_t process_ctx_payloads;
+
+	// For domain.
+	struct list_head list;
 };
 
 int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
@@ -274,4 +277,6 @@ struct amdtp_domain {
 int amdtp_domain_init(struct amdtp_domain *d);
 void amdtp_domain_destroy(struct amdtp_domain *d);
 
+void amdtp_domain_stop(struct amdtp_domain *d);
+
 #endif
-- 
2.20.1
