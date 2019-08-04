From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 01/19] ALSA: firewire-lib: add AMDTP domain
	structure to handle several isoc contexts
Date: Sun,  4 Aug 2019 15:21:20 +0900
Message-ID: <20190804062138.1217-2-o-takashi@sakamocchi.jp>
References: <20190804062138.1217-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0D458F804CA
 for <alsa-devel@alsa-project.org>; Sun,  4 Aug 2019 08:21:45 +0200 (CEST)
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

This commit adds 'struct amdtp_domain' structure. This structure
has list of instance of AMDTP stream to handle a couple of
isochronous contexts.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 22 ++++++++++++++++++++++
 sound/firewire/amdtp-stream.h |  7 +++++++
 2 files changed, 29 insertions(+)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 369e75e33120..02077696fa77 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -1136,3 +1136,25 @@ void amdtp_stream_pcm_abort(struct amdtp_stream *s)
 		snd_pcm_stop_xrun(pcm);
 }
 EXPORT_SYMBOL(amdtp_stream_pcm_abort);
+
+/**
+ * amdtp_domain_init - initialize an AMDTP domain structure
+ * @d: the AMDTP domain to initialize.
+ */
+int amdtp_domain_init(struct amdtp_domain *d)
+{
+	INIT_LIST_HEAD(&d->streams);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(amdtp_domain_init);
+
+/**
+ * amdtp_domain_destroy - destroy an AMDTP domain structure
+ * @d: the AMDTP domain to destroy.
+ */
+void amdtp_domain_destroy(struct amdtp_domain *d)
+{
+	WARN_ON(!list_empty(&d->streams));
+}
+EXPORT_SYMBOL_GPL(amdtp_domain_destroy);
diff --git a/sound/firewire/amdtp-stream.h b/sound/firewire/amdtp-stream.h
index 50041fa884d9..2378db4b4195 100644
--- a/sound/firewire/amdtp-stream.h
+++ b/sound/firewire/amdtp-stream.h
@@ -267,4 +267,11 @@ static inline bool amdtp_stream_wait_callback(struct amdtp_stream *s,
 				  msecs_to_jiffies(timeout)) > 0;
 }
 
+struct amdtp_domain {
+	struct list_head streams;
+};
+
+int amdtp_domain_init(struct amdtp_domain *d);
+void amdtp_domain_destroy(struct amdtp_domain *d);
+
 #endif
-- 
2.20.1
