From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] alsa-lib: topology: fix DSP_B mode string
Date: Wed,  1 Nov 2017 12:26:24 +0000
Message-ID: <1509539184-16560-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 0713126709F
 for <alsa-devel@alsa-project.org>; Wed,  1 Nov 2017 13:27:20 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Use the correct string for DSP_B mode.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 src/topology/pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index 0f4deb4f..c5e8d465 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -997,7 +997,7 @@ static int get_audio_hw_format(const char *val)
 	if (!strcmp(val, "DSP_A"))
 		return SND_SOC_DAI_FORMAT_DSP_A;
 
-	if (!strcmp(val, "LEFT_B"))
+	if (!strcmp(val, "DSP_B"))
 		return SND_SOC_DAI_FORMAT_DSP_B;
 
 	if (!strcmp(val, "AC97"))
-- 
2.11.0
