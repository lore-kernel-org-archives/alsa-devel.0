From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 03/21] ASoC: Remove unused AUDIO_NAME define
	from WM8960
Date: Sat,  3 Dec 2011 21:33:11 +0000
Message-ID: <1322948009-27658-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1322948009-27658-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6256B243D0
	for <alsa-devel@alsa-project.org>; Sat,  3 Dec 2011 22:33:38 +0100 (CET)
In-Reply-To: <1322948009-27658-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8960.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 1d057b6..57aed7c 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -25,8 +25,6 @@
 
 #include "wm8960.h"
 
-#define AUDIO_NAME "wm8960"
-
 /* R25 - Power 1 */
 #define WM8960_VMID_MASK 0x180
 #define WM8960_VREF      0x40
-- 
1.7.7.3
