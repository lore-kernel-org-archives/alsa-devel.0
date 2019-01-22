From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/6] ALSA: fireface: change prototype of
	handler for async transaction with MIDI messages
Date: Tue, 22 Jan 2019 22:17:00 +0900
Message-ID: <20190122131705.23213-2-o-takashi@sakamocchi.jp>
References: <20190122131705.23213-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com
 [209.85.215.196])
 by alsa0.perex.cz (Postfix) with ESMTP id A89DA2674A8
 for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2019 14:17:16 +0100 (CET)
Received: by mail-pg1-f196.google.com with SMTP id j10so11081865pga.1
 for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2019 05:17:15 -0800 (PST)
In-Reply-To: <20190122131705.23213-1-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

In a series of Fireface, devices transfer asynchronous transaction with
MIDI messages. In the transaction, content is different depending on
models. ALSA fireface driver has protocol-dependent handler to pick up
MIDI messages from the content.

In latter models of the series, the transaction is transferred to range
of address sequentially. This seems to check continuity of transferred
messages.

This commit changes prototype of the handler to receive offset of
address for received transactions.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireface/ff-protocol-former.c | 6 ++++--
 sound/firewire/fireface/ff-transaction.c     | 4 +++-
 sound/firewire/fireface/ff.h                 | 3 ++-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/sound/firewire/fireface/ff-protocol-former.c b/sound/firewire/fireface/ff-protocol-former.c
index 9c0ae50e88d1..266e4892a818 100644
--- a/sound/firewire/fireface/ff-protocol-former.c
+++ b/sound/firewire/fireface/ff-protocol-former.c
@@ -375,7 +375,8 @@ static void ff800_finish_session(struct snd_ff *ff)
 			   FF800_ISOC_COMM_STOP, &reg, sizeof(reg), 0);
 }
 
-static void ff800_handle_midi_msg(struct snd_ff *ff, __le32 *buf, size_t length)
+static void ff800_handle_midi_msg(struct snd_ff *ff, unsigned int offset,
+				  __le32 *buf, size_t length)
 {
 	int i;
 
@@ -502,7 +503,8 @@ static void ff400_finish_session(struct snd_ff *ff)
 			   FF400_ISOC_COMM_STOP, &reg, sizeof(reg), 0);
 }
 
-static void ff400_handle_midi_msg(struct snd_ff *ff, __le32 *buf, size_t length)
+static void ff400_handle_midi_msg(struct snd_ff *ff, unsigned int offset,
+				  __le32 *buf, size_t length)
 {
 	int i;
 
diff --git a/sound/firewire/fireface/ff-transaction.c b/sound/firewire/fireface/ff-transaction.c
index 065e045d3fb5..d3fde813ce17 100644
--- a/sound/firewire/fireface/ff-transaction.c
+++ b/sound/firewire/fireface/ff-transaction.c
@@ -146,7 +146,9 @@ static void handle_midi_msg(struct fw_card *card, struct fw_request *request,
 
 	fw_send_response(card, request, RCODE_COMPLETE);
 
-	ff->spec->protocol->handle_midi_msg(ff, buf, length);
+	offset -= ff->async_handler.offset;
+	ff->spec->protocol->handle_midi_msg(ff, (unsigned int)offset, buf,
+					    length);
 }
 
 static int allocate_own_address(struct snd_ff *ff, int i)
diff --git a/sound/firewire/fireface/ff.h b/sound/firewire/fireface/ff.h
index 8aea7920b57f..ddcffb8d85c6 100644
--- a/sound/firewire/fireface/ff.h
+++ b/sound/firewire/fireface/ff.h
@@ -103,7 +103,8 @@ enum snd_ff_clock_src {
 };
 
 struct snd_ff_protocol {
-	void (*handle_midi_msg)(struct snd_ff *ff, __le32 *buf, size_t length);
+	void (*handle_midi_msg)(struct snd_ff *ff, unsigned int offset,
+				__le32 *buf, size_t length);
 	int (*get_clock)(struct snd_ff *ff, unsigned int *rate,
 			 enum snd_ff_clock_src *src);
 	int (*switch_fetching_mode)(struct snd_ff *ff, bool enable);
-- 
2.19.1
