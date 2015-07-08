From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 4/4] ALSA: hda: add default value for
	max_dma_burst
Date: Wed,  8 Jul 2015 05:10:36 -0500
Message-ID: <1436350236-17509-5-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1436350236-17509-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 925E62605A4
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2015 12:10:57 +0200 (CEST)
In-Reply-To: <1436350236-17509-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

set value to 128 bytes for legacy HDAudio, can be overridden
as needed (on a per-stream basis) for enhanced hardware with
more buffering capabilities

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/pci/hda/hda_controller.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 9444559..958c8f1 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -391,6 +391,7 @@ static struct snd_pcm_hardware azx_pcm_hw = {
 	.periods_min =		2,
 	.periods_max =		AZX_MAX_FRAG,
 	.fifo_size =		0,
+	.max_dma_burst = 128 /* default value for all legacy HDAudio controllers, override as needed */
 };
 
 static int azx_pcm_open(struct snd_pcm_substream *substream)
-- 
1.9.1
