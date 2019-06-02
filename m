From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 08/15] ALSA: fireface: add protocol-specific
	operation to allocate isochronous resources
Date: Sun,  2 Jun 2019 16:12:52 +0900
Message-ID: <20190602071259.21622-9-o-takashi@sakamocchi.jp>
References: <20190602071259.21622-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1B9DFF89735
 for <alsa-devel@alsa-project.org>; Sun,  2 Jun 2019 09:13:18 +0200 (CEST)
In-Reply-To: <20190602071259.21622-1-o-takashi@sakamocchi.jp>
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

This commit is a part of preparation to perform allocation/release
of isochronous channels in pcm.hw_params/hw_free callbacks.

In ALSA fireface driver, the allocation of isochronous resources is
programmed in each implementation of protocol. This commit adds
protocol-specific operation for the allocation separated from
the operation to begin session.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireface/ff-stream.c | 4 ++++
 sound/firewire/fireface/ff.h        | 1 +
 2 files changed, 5 insertions(+)

diff --git a/sound/firewire/fireface/ff-stream.c b/sound/firewire/fireface/ff-stream.c
index a8a90f1ae09e..740963e4e1c9 100644
--- a/sound/firewire/fireface/ff-stream.c
+++ b/sound/firewire/fireface/ff-stream.c
@@ -156,6 +156,10 @@ int snd_ff_stream_start_duplex(struct snd_ff *ff, unsigned int rate)
 		if (err < 0)
 			return err;
 
+		err = ff->spec->protocol->allocate_resources(ff, rate);
+		if (err < 0)
+			goto error;
+
 		err = ff->spec->protocol->begin_session(ff, rate);
 		if (err < 0)
 			goto error;
diff --git a/sound/firewire/fireface/ff.h b/sound/firewire/fireface/ff.h
index ed8fea0ff5e1..c478103388a2 100644
--- a/sound/firewire/fireface/ff.h
+++ b/sound/firewire/fireface/ff.h
@@ -113,6 +113,7 @@ struct snd_ff_protocol {
 	int (*get_clock)(struct snd_ff *ff, unsigned int *rate,
 			 enum snd_ff_clock_src *src);
 	int (*switch_fetching_mode)(struct snd_ff *ff, bool enable);
+	int (*allocate_resources)(struct snd_ff *ff, unsigned int rate);
 	int (*begin_session)(struct snd_ff *ff, unsigned int rate);
 	void (*finish_session)(struct snd_ff *ff);
 	void (*dump_status)(struct snd_ff *ff, struct snd_info_buffer *buffer);
-- 
2.20.1
