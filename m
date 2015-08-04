From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/3] ALSA: HDA: Fix stream assignment for host
	in decoupled mode
Date: Tue,  4 Aug 2015 09:28:38 +0530
Message-ID: <1438660720-30033-2-git-send-email-vinod.koul@intel.com>
References: <1438660720-30033-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id EF1AE26549B
 for <alsa-devel@alsa-project.org>; Tue,  4 Aug 2015 05:57:02 +0200 (CEST)
In-Reply-To: <1438660720-30033-1-git-send-email-vinod.koul@intel.com>
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

This fixes issue in assigning host stream in case of
decoupled mode. The check to verify if the stream is already
in use was wrong so fix that

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/hda/ext/hdac_ext_stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/hda/ext/hdac_ext_stream.c b/sound/hda/ext/hdac_ext_stream.c
index f8ffbdbb450d..3de47dd1a76d 100644
--- a/sound/hda/ext/hdac_ext_stream.c
+++ b/sound/hda/ext/hdac_ext_stream.c
@@ -299,7 +299,7 @@ hdac_ext_host_stream_assign(struct hdac_ext_bus *ebus,
 		if (stream->direction != substream->stream)
 			continue;
 
-		if (stream->opened) {
+		if (!stream->opened) {
 			if (!hstream->decoupled)
 				snd_hdac_ext_stream_decouple(ebus, hstream, true);
 			res = hstream;
-- 
1.9.1
