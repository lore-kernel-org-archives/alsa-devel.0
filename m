From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 5/5] ALSA: hdac: Remove the usage of key for
	host stream
Date: Fri, 21 Aug 2015 21:36:21 +0530
Message-ID: <1440173181-3150-6-git-send-email-vinod.koul@intel.com>
References: <1440173181-3150-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id B1EA7265848
 for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2015 18:04:35 +0200 (CEST)
In-Reply-To: <1440173181-3150-1-git-send-email-vinod.koul@intel.com>
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

hdac_ext_stream assign doesn't require key mapping as in case of
hdac_stream. So for host stream, the key to device mapping needs
to be removed.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/hda/ext/hdac_ext_stream.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/hda/ext/hdac_ext_stream.c b/sound/hda/ext/hdac_ext_stream.c
index a4f6bbe5da8f..c978a9bb1db8 100644
--- a/sound/hda/ext/hdac_ext_stream.c
+++ b/sound/hda/ext/hdac_ext_stream.c
@@ -291,17 +291,12 @@ hdac_ext_host_stream_assign(struct hdac_ext_bus *ebus,
 	struct hdac_ext_stream *res = NULL;
 	struct hdac_stream *stream = NULL;
 	struct hdac_bus *hbus = &ebus->bus;
-	int key;
 
 	if (!ebus->ppcap) {
 		dev_err(hbus->dev, "stream type not supported\n");
 		return NULL;
 	}
 
-	/* make a non-zero unique key for the substream */
-	key = (substream->pcm->device << 16) | (substream->number << 2) |
-			(substream->stream + 1);
-
 	list_for_each_entry(stream, &hbus->stream_list, list) {
 		struct hdac_ext_stream *hstream = container_of(stream,
 						struct hdac_ext_stream,
@@ -320,7 +315,6 @@ hdac_ext_host_stream_assign(struct hdac_ext_bus *ebus,
 		spin_lock_irq(&hbus->reg_lock);
 		res->hstream.opened = 1;
 		res->hstream.running = 0;
-		res->hstream.assigned_key = key;
 		res->hstream.substream = substream;
 		spin_unlock_irq(&hbus->reg_lock);
 	}
-- 
1.9.1
