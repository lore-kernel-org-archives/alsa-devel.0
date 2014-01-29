From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 03/52] firewire-lib: Add 'direction' member to 'amdtp_stream'
	structure
Date: Wed, 29 Jan 2014 22:44:10 +0900
Message-ID: <1391003099-7109-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1391003099-7109-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1391003099-7109-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
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
index 38013f9..95c5a15 100644
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
index 60028c7..019134e 100644
--- a/sound/firewire/amdtp.h
+++ b/sound/firewire/amdtp.h
@@ -48,9 +48,15 @@ struct fw_unit;
 struct fw_iso_context;
 struct snd_pcm_substream;
 
+enum amdtp_stream_direction {
+	AMDTP_OUT_STREAM = 0,
+	AMDTP_IN_STREAM
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
index 88814cc..b4d50b0 100644
--- a/sound/firewire/dice.c
+++ b/sound/firewire/dice.c
@@ -1360,7 +1360,7 @@ static int dice_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
 		goto err_owner;
 	dice->resources.channels_mask = 0x00000000ffffffffuLL;
 
-	err = amdtp_stream_init(&dice->stream, unit,
+	err = amdtp_stream_init(&dice->stream, unit, AMDTP_OUT_STREAM,
 				CIP_BLOCKING | CIP_HI_DUALWIRE);
 	if (err < 0)
 		goto err_resources;
diff --git a/sound/firewire/speakers.c b/sound/firewire/speakers.c
index 554818e..f5d0bf3 100644
--- a/sound/firewire/speakers.c
+++ b/sound/firewire/speakers.c
@@ -683,7 +683,8 @@ static int fwspk_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto err_unit;
 
-	err = amdtp_stream_init(&fwspk->stream, unit, CIP_NONBLOCKING);
+	err = amdtp_stream_init(&fwspk->stream, unit, AMDTP_OUT_STREAM,
+				CIP_NONBLOCKING);
 	if (err < 0)
 		goto err_connection;
 
-- 
1.8.3.2


------------------------------------------------------------------------------
WatchGuard Dimension instantly turns raw network data into actionable 
security intelligence. It gives you real-time visual feedback on key
security issues and trends.  Skip the complicated setup - simply import
a virtual appliance and go from zero to informed in seconds.
http://pubads.g.doubleclick.net/gampad/clk?id=123612991&iu=/4140/ostg.clktrk
