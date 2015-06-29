From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] ASoC: topology: fix typos in topology header
Date: Mon, 29 Jun 2015 17:36:45 +0100
Message-ID: <1435595806-7000-3-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1435595806-7000-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id D16B0265755
 for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2015 18:37:10 +0200 (CEST)
In-Reply-To: <1435595806-7000-1-git-send-email-liam.r.girdwood@linux.intel.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Vinod Koul <vinod.koul@intel.com>

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/uapi/sound/asoc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index 7ae13fb..a584d91 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -110,7 +110,7 @@
 
 /*
  * Block Header.
- * This header preceeds all object and object arrays below.
+ * This header precedes all object and object arrays below.
  */
 struct snd_soc_tplg_hdr {
 	__le32 magic;		/* magic number */
@@ -222,7 +222,7 @@ struct snd_soc_tplg_stream_config {
 /*
  * Manifest. List totals for each payload type. Not used in parsing, but will
  * be passed to the component driver before any other objects in order for any
- * global componnent resource allocations.
+ * global component resource allocations.
  *
  * File block representation for manifest :-
  * +-----------------------------------+----+
-- 
2.1.4
