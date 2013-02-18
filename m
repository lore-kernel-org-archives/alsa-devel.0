From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/5] ASoC: max98090: Remove unneeded version.h
	header include
Date: Mon, 18 Feb 2013 17:02:10 +0530
Message-ID: <1361187134-7525-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f50.google.com (mail-pa0-f50.google.com
 [209.85.220.50])
 by alsa0.perex.cz (Postfix) with ESMTP id C0EBB264F07
 for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2013 12:42:09 +0100 (CET)
Received: by mail-pa0-f50.google.com with SMTP id fa11so2831346pad.9
 for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2013 03:42:08 -0800 (PST)
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
Cc: tiwai@suse.de, sachin.kamat@linaro.org, broonie@opensource.wolfsonmicro.com, jerry.wong@maximintegrated.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

version.h header file inclusion is not required as detected by versioncheck.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
All patches in this series are build tested and based on for-next branch of
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tree.
---
 sound/soc/codecs/max98090.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index fc17604..9ea73aa 100755
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -23,8 +23,6 @@
 #include <sound/max98090.h>
 #include "max98090.h"
 
-#include <linux/version.h>
-
 #define DEBUG
 #define EXTMIC_METHOD
 #define EXTMIC_METHOD_TEST
-- 
1.7.4.1
