From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH] patch_nvhdmi.c: Fix supported sample rate list.
Date: Tue, 14 Sep 2010 10:48:59 -0600
Message-ID: <1284482939-7215-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id AD82B103899
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Sep 2010 18:49:06 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: wni@nvidia.com, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

22050 isn't a valid HDMI sample rate. 32000 is.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
Acked-By: Wei Ni <wni@nvidia.com>
---
 sound/pci/hda/patch_nvhdmi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/pci/hda/patch_nvhdmi.c b/sound/pci/hda/patch_nvhdmi.c
index 69b950d..baa108b 100644
--- a/sound/pci/hda/patch_nvhdmi.c
+++ b/sound/pci/hda/patch_nvhdmi.c
@@ -84,7 +84,7 @@ static struct hda_verb nvhdmi_basic_init_7x[] = {
 #else
 /* support all rates and formats */
 #define SUPPORTED_RATES \
-	(SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |\
+	(SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |\
 	SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_176400 |\
 	 SNDRV_PCM_RATE_192000)
 #define SUPPORTED_MAXBPS	24
-- 
1.7.0.4
nvpublic
