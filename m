From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 03/17] firewire-lib: Add 'direction' member to
	'amdtp_stream' structure
Date: Sat, 23 Nov 2013 15:07:50 +0900
Message-ID: <1385186884-8259-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1385186884-8259-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A5492619E3
 for <alsa-devel@alsa-project.org>; Sat, 23 Nov 2013 07:08:10 +0100 (CET)
In-Reply-To: <1385186884-8259-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This patch adds 'direction' member to amdtp_stream structure to indicate its
direction. This patch also adds 'direction' argument to amdtp_stream_init()
function to determine its direction.

The amdtp_stream_init() function is exported and used by firewire-speakers and
dice so this patch also affects them.

This patch just add them. Actual implementation will be done by followed
patches.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c    | 4 +++-
 sound/firewire/amdtp.h    | 7 +++++++
 sound/firewire/dice.c     | 2 +-
 sound/firewire/speakers.c | 3 ++-
 4 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index fbd24db..5d94252 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -53,12 +53,14 @@ static void pcm_period_tasklet(unsigned long data);
  * amdtp_stream_init - initialize an AMDTP stream structure
  * @s: the AMDTP stream to initialize
  * @unit: the target of the stream
+ * @dir: the direction of stream
  * @flags: the packet transmission method to use
  */
 int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
-		      enum cip_flags flags)
+		      enum amdtp_stream_direction dir, enum cip_flags flags)
 {
 	s->unit = fw_unit_get(unit);
+	s->direction = dir;
 	s->flags = flags;
 	s->context = ERR_PTR(-1);
 	mutex_init(&s->mutex);
diff --git a/sound/firewire/amdtp.h b/sound/firewire/amdtp.h
index 757ea6c..6d7aa36 100644
--- a/sound/firewire/amdtp.h
+++ b/sound/firewire/amdtp.h
@@ -48,9 +48,15 @@ struct fw_unit;
 struct fw_iso_context;
 struct snd_pcm_substream;
 
+enum amdtp_stream_direction {
+	AMDTP_RECEIVE_STREAM = 0,
+	AMDTP_TRANSMIT_STREAM
+};
+
 struct amdtp_stream {
 	struct fw_unit *unit;
 	enum cip_flags flags;
+	enum amdtp_stream_direction direction;
 	struct fw_iso_context *context;
 	struct mutex mutex;
 
@@ -85,6 +91,7 @@ struct amdtp_stream {
 };
 
 int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
+		      enum amdtp_stream_direction dir,
 		      enum cip_flags flags);
 void amdtp_stream_destroy(struct amdtp_stream *s);
 
diff --git a/sound/firewire/dice.c b/sound/firewire/dice.c
index c76c519..d5b01e2 100644
--- a/sound/firewire/dice.c
+++ b/sound/firewire/dice.c
@@ -1360,7 +1360,7 @@ static int dice_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
 		goto err_owner;
 	dice->resources.channels_mask = 0x00000000ffffffffuLL;
 
-	err = amdtp_stream_init(&dice->stream, unit,
+	err = amdtp_stream_init(&dice->stream, unit, AMDTP_RECEIVE_STREAM,
 				CIP_BLOCKING | CIP_HI_DUALWIRE);
 	if (err < 0)
 		goto err_resources;
diff --git a/sound/firewire/speakers.c b/sound/firewire/speakers.c
index fc11c0f..8f0257e 100644
--- a/sound/firewire/speakers.c
+++ b/sound/firewire/speakers.c
@@ -684,7 +684,8 @@ static int fwspk_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto err_unit;
 
-	err = amdtp_stream_init(&fwspk->stream, unit, CIP_NONBLOCKING);
+	err = amdtp_stream_init(&fwspk->stream, unit, AMDTP_RECEIVE_STREAM,
+				CIP_NONBLOCKING);
 	if (err < 0)
 		goto err_connection;
 
-- 
1.8.3.2
