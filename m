From: Puneeth Prabhu <puneethx.prabhu@intel.com>
Subject: [PATCH] topology: ABI: Increase SND_SOC_TPLG_NUM_TEXTS
	to 32
Date: Fri, 20 Jul 2018 15:57:07 +0530
Message-ID: <1532082427-4912-2-git-send-email-puneethx.prabhu@intel.com>
References: <1532082427-4912-1-git-send-email-puneethx.prabhu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 75597267757
 for <alsa-devel@alsa-project.org>; Fri, 20 Jul 2018 12:24:40 +0200 (CEST)
In-Reply-To: <1532082427-4912-1-git-send-email-puneethx.prabhu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA ML <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Cc: cezary.rojewski@intel.com, Takashi Iwai <tiwai@suse.de>, pardha.saradhi.kesapragada@intel.com, Puneeth Prabhu <puneethx.prabhu@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, gustaw.lewandowski@intel.com
List-Id: alsa-devel@alsa-project.org

Topology supports upto 32 configs for a path whereas
alsatplg can parse a maximum of 16 configs of a path
from the topology conf file.
So, increase SND_SOC_TPLG_NUM_TEXTS to 32 to support
parsing upto 32 configs of a path.

Signed-off-by: Puneeth Prabhu <puneethx.prabhu@intel.com>
Signed-off-by: Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>
---
 include/sound/asoc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sound/asoc.h b/include/sound/asoc.h
index bb8aec7..eb61483 100644
--- a/include/sound/asoc.h
+++ b/include/sound/asoc.h
@@ -84,7 +84,7 @@
 #define SND_SOC_TPLG_MAGIC		0x41536F43 /* ASoC */
 
 /* string sizes */
-#define SND_SOC_TPLG_NUM_TEXTS		16
+#define SND_SOC_TPLG_NUM_TEXTS		32
 
 /* ABI version */
 #define SND_SOC_TPLG_ABI_VERSION	0x5	/* current version */
-- 
2.1.4
