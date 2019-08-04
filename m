From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 04/19] ALSA: firewire-lib: add a kernel API to
	start AMDTP streams in AMDTP domain
Date: Sun,  4 Aug 2019 15:21:23 +0900
Message-ID: <20190804062138.1217-5-o-takashi@sakamocchi.jp>
References: <20190804062138.1217-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C43DEF804CA
 for <alsa-devel@alsa-project.org>; Sun,  4 Aug 2019 08:21:49 +0200 (CEST)
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

This commit adds a kernel API to start a couple of isochronous contexts
for some AMDTP streams.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 24 ++++++++++++++++++++++++
 sound/firewire/amdtp-stream.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index fa7989ee4769..158d210caea7 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -1185,6 +1185,30 @@ int amdtp_domain_add_stream(struct amdtp_domain *d, struct amdtp_stream *s,
 }
 EXPORT_SYMBOL_GPL(amdtp_domain_add_stream);
 
+/**
+ * amdtp_domain_start - start sending packets for isoc context in the domain.
+ * @d: the AMDTP domain.
+ */
+int amdtp_domain_start(struct amdtp_domain *d)
+{
+	struct amdtp_stream *s;
+	int err = 0;
+
+	list_for_each_entry(s, &d->streams, list) {
+		err = amdtp_stream_start(s, s->channel, s->speed);
+		if (err < 0)
+			break;
+	}
+
+	if (err < 0) {
+		list_for_each_entry(s, &d->streams, list)
+			amdtp_stream_stop(s);
+	}
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(amdtp_domain_start);
+
 /**
  * amdtp_domain_stop - stop sending packets for isoc context in the same domain.
  * @d: the AMDTP domain to which the isoc contexts belong.
diff --git a/sound/firewire/amdtp-stream.h b/sound/firewire/amdtp-stream.h
index 4b102fd7529d..15d471660a43 100644
--- a/sound/firewire/amdtp-stream.h
+++ b/sound/firewire/amdtp-stream.h
@@ -282,6 +282,7 @@ void amdtp_domain_destroy(struct amdtp_domain *d);
 int amdtp_domain_add_stream(struct amdtp_domain *d, struct amdtp_stream *s,
 			    int channel, int speed);
 
+int amdtp_domain_start(struct amdtp_domain *d);
 void amdtp_domain_stop(struct amdtp_domain *d);
 
 #endif
-- 
2.20.1
