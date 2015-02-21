From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/4] ALSA: firewire-lib: remove reference counting
Date: Sat, 21 Feb 2015 23:54:58 +0900
Message-ID: <1424530500-9116-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1424530500-9116-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1424530500-9116-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

AMDTP helper functions increment/decrement reference counter for an
instance of FireWire unit, while it's complicated for each driver to
process error state.

In previous commit, each driver has the role of reference counting. This
commit removes this role from the helper function.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index 0d58018..911341b 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -78,7 +78,7 @@ static void pcm_period_tasklet(unsigned long data);
 int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
 		      enum amdtp_stream_direction dir, enum cip_flags flags)
 {
-	s->unit = fw_unit_get(unit);
+	s->unit = unit;
 	s->direction = dir;
 	s->flags = flags;
 	s->context = ERR_PTR(-1);
@@ -102,7 +102,6 @@ void amdtp_stream_destroy(struct amdtp_stream *s)
 {
 	WARN_ON(amdtp_stream_running(s));
 	mutex_destroy(&s->mutex);
-	fw_unit_put(s->unit);
 }
 EXPORT_SYMBOL(amdtp_stream_destroy);
 
-- 
2.1.0


------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=190641631&iu=/4140/ostg.clktrk
