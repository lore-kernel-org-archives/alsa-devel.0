From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 5/7] ALSA: hda: add default value for
	max_inflight_bytes
Date: Fri, 30 Sep 2016 18:13:28 +0530
Message-ID: <1475239410-16548-6-git-send-email-subhransu.s.prusty@intel.com>
References: <1475239410-16548-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 12492260083
 for <alsa-devel@alsa-project.org>; Fri, 30 Sep 2016 14:50:18 +0200 (CEST)
In-Reply-To: <1475239410-16548-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

set value to 128 bytes for legacy HDAudio, can be overridden
as needed (on a per-stream basis) for enhanced hardware with
more buffering capabilities

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 sound/pci/hda/hda_controller.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 2ad3b44..922d7b9 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -587,6 +587,7 @@ static struct snd_pcm_hardware azx_pcm_hw = {
 	.periods_min =		2,
 	.periods_max =		AZX_MAX_FRAG,
 	.fifo_size =		0,
+	.max_inflight_bytes = 128 /* default value for all legacy HDAudio controllers, override as needed */
 };
 
 static int azx_pcm_open(struct snd_pcm_substream *substream)
-- 
1.9.1
