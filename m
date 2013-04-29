From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/4] Add "direction" member to amdtp_stream structure for AMDTP
Date: Mon, 29 Apr 2013 18:47:20 +0900
Message-ID: <1367228841-8526-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1367125334-446-1-git-send-email-o-takashi@sakamocchi.jp>
	<1367228841-8526-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1367228841-8526-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

To indicate the direction of amdtp stream, this patch adds "direction" member
to amdtp_stream structure. To determine the direction, this patch also adds
"direction" argument to amdtp_stream_init() function. The amdtp_stream_init()
function is exported and used by snd-firewire-speakers so this patch also
affects it.

This patch just add them. Actual implementation will be done by followed
patches.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c    |    2 +-
 sound/firewire/amdtp.h    |    8 +++++++-
 sound/firewire/speakers.c |    3 ++-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index e3947ad..59fd34c 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -50,7 +50,7 @@ static void pcm_period_tasklet(unsigned long data);
  * @flags: the packet transmission method to use
  */
 int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
-		      enum cip_flags flags)
+		enum amdtp_stream_direction direction, enum cip_flags flags)
 {
 	if (flags != CIP_NONBLOCKING)
 		return -EINVAL;
diff --git a/sound/firewire/amdtp.h b/sound/firewire/amdtp.h
index 482d57e..f3b9403 100644
--- a/sound/firewire/amdtp.h
+++ b/sound/firewire/amdtp.h
@@ -37,9 +37,15 @@ struct fw_unit;
 struct fw_iso_context;
 struct snd_pcm_substream;
 
+enum amdtp_stream_direction {
+	AMDTP_STREAM_RECEIVE = 0,
+	AMDTP_STREAM_TRANSMIT
+};
+
 struct amdtp_stream {
 	struct fw_unit *unit;
 	enum cip_flags flags;
+	enum amdtp_stream_direction direction;
 	struct fw_iso_context *context;
 	struct mutex mutex;
 
@@ -72,7 +78,7 @@ struct amdtp_stream {
 };
 
 int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
-		      enum cip_flags flags);
+		enum amdtp_stream_direction direction, enum cip_flags flags);
 void amdtp_stream_destroy(struct amdtp_stream *s);
 
 void amdtp_stream_set_rate(struct amdtp_stream *s, unsigned int rate);
diff --git a/sound/firewire/speakers.c b/sound/firewire/speakers.c
index 7df20ac..4164163 100644
--- a/sound/firewire/speakers.c
+++ b/sound/firewire/speakers.c
@@ -727,7 +727,8 @@ static int fwspk_probe(struct device *unit_dev)
 	if (err < 0)
 		goto err_unit;
 
-	err = amdtp_stream_init(&fwspk->stream, unit, CIP_NONBLOCKING);
+	err = amdtp_stream_init(&fwspk->stream, unit,
+				AMDTP_STREAM_TRANSMIT, CIP_NONBLOCKING);
 	if (err < 0)
 		goto err_connection;
 
-- 
1.7.10.4


------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_apr
