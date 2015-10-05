From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/4] ALSA: hdac: Fix to check if stream not in
	use in release
Date: Mon,  5 Oct 2015 15:09:49 +0100
Message-ID: <1444054191-17030-3-git-send-email-vinod.koul@intel.com>
References: <1444054191-17030-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 2556426065F
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2015 16:10:26 +0200 (CEST)
In-Reply-To: <1444054191-17030-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

if the stream is decoupled and both link and host are used, while
releasing the stream, need to check if link and host stream are
not in use. This patch adds fix to check if the host/link stream
is in used before coupling it back when releasing the stream.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/hda/ext/hdac_ext_stream.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/hda/ext/hdac_ext_stream.c b/sound/hda/ext/hdac_ext_stream.c
index 4bcebc8cde26..cb89ec7c8147 100644
--- a/sound/hda/ext/hdac_ext_stream.c
+++ b/sound/hda/ext/hdac_ext_stream.c
@@ -385,14 +385,13 @@ void snd_hdac_ext_stream_release(struct hdac_ext_stream *stream, int type)
 		break;
 
 	case HDAC_EXT_STREAM_TYPE_HOST:
-		if (stream->decoupled) {
+		if (stream->decoupled && !stream->link_locked)
 			snd_hdac_ext_stream_decouple(ebus, stream, false);
-			snd_hdac_stream_release(&stream->hstream);
-		}
+		snd_hdac_stream_release(&stream->hstream);
 		break;
 
 	case HDAC_EXT_STREAM_TYPE_LINK:
-		if (stream->decoupled)
+		if (stream->decoupled && !stream->hstream.opened)
 			snd_hdac_ext_stream_decouple(ebus, stream, false);
 		spin_lock_irq(&bus->reg_lock);
 		stream->link_locked = 0;
-- 
2.4.3
