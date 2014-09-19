From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 4/5] ASoC: max98090: Remove unused version
	define
Date: Fri, 19 Sep 2014 14:48:20 +0300
Message-ID: <1411127301-366-4-git-send-email-jarkko.nikula@linux.intel.com>
References: <1411127301-366-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 5780F261B01
 for <alsa-devel@alsa-project.org>; Fri, 19 Sep 2014 13:48:41 +0200 (CEST)
In-Reply-To: <1411127301-366-1-git-send-email-jarkko.nikula@linux.intel.com>
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
Cc: Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/codecs/max98090.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/codecs/max98090.h b/sound/soc/codecs/max98090.h
index 84ca3f4f4403..2613fdbb66d8 100644
--- a/sound/soc/codecs/max98090.h
+++ b/sound/soc/codecs/max98090.h
@@ -11,11 +11,6 @@
 #ifndef _MAX98090_H
 #define _MAX98090_H
 
-#include <linux/version.h>
-
-/* One can override the Linux version here with an explicit version number */
-#define M98090_LINUX_VERSION LINUX_VERSION_CODE
-
 /*
  * MAX98090 Register Definitions
  */
-- 
2.1.0
