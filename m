From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v3 04/13] ALSA: hdac: couple the hda DMA stream
	in cleanup
Date: Mon, 14 Dec 2015 09:57:20 +0530
Message-ID: <1450067249-7151-5-git-send-email-vinod.koul@intel.com>
References: <1450067249-7151-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id E30E9260578
 for <alsa-devel@alsa-project.org>; Mon, 14 Dec 2015 05:24:31 +0100 (CET)
In-Reply-To: <1450067249-7151-1-git-send-email-vinod.koul@intel.com>
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

A stream is by default in coupled mode, in DSP operation we move
it to decoupled mode. On cleanup HW expects that we leave it back
to default state so couple the DMA on cleanup.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/hda/ext/hdac_ext_stream.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/ext/hdac_ext_stream.c b/sound/hda/ext/hdac_ext_stream.c
index 8f30e8836818..023cc4cad5c1 100644
--- a/sound/hda/ext/hdac_ext_stream.c
+++ b/sound/hda/ext/hdac_ext_stream.c
@@ -111,6 +111,7 @@ void snd_hdac_stream_free_all(struct hdac_ext_bus *ebus)
 	while (!list_empty(&bus->stream_list)) {
 		s = list_first_entry(&bus->stream_list, struct hdac_stream, list);
 		stream = stream_to_hdac_ext_stream(s);
+		snd_hdac_ext_stream_decouple(ebus, stream, false);
 		list_del(&s->list);
 		kfree(stream);
 	}
-- 
1.9.1
