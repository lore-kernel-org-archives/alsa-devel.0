From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 5/5] ASoC: max98090: Remove unused byte access
	macros
Date: Fri, 19 Sep 2014 14:48:21 +0300
Message-ID: <1411127301-366-5-git-send-email-jarkko.nikula@linux.intel.com>
References: <1411127301-366-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 30EC22625EA
 for <alsa-devel@alsa-project.org>; Fri, 19 Sep 2014 13:48:44 +0200 (CEST)
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
 sound/soc/codecs/max98090.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/codecs/max98090.h b/sound/soc/codecs/max98090.h
index 2613fdbb66d8..a5f6bada06da 100644
--- a/sound/soc/codecs/max98090.h
+++ b/sound/soc/codecs/max98090.h
@@ -1497,9 +1497,6 @@
 #define M98090_REVID_WIDTH		8
 #define M98090_REVID_NUM		(1<<M98090_REVID_WIDTH)
 
-#define M98090_BYTE1(w) ((w >> 8) & 0xff)
-#define M98090_BYTE0(w) (w & 0xff)
-
 /* Silicon revision number */
 #define M98090_REVA			0x40
 #define M98091_REVA			0x50
-- 
2.1.0
