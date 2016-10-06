From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: topology: Reenable use from userspace
Date: Thu,  6 Oct 2016 16:30:12 +0200
Message-ID: <20161006143012.31438-1-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2DDB126690D
 for <alsa-devel@alsa-project.org>; Thu,  6 Oct 2016 17:14:40 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, mengdong.lin@linux.intel.com
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

We had inserted a #error into the topology UAPI code to ensure that the
ABI was not adopted by userspace while final review and testing was
ongoing.  The idea was that some finishing touches would be made to the
ABI before declaring it stable and suitable for use in production but
this has not yet happened as more than a year later revisions to the ABI
are still onging.

The reality however is that people are shipping topology files in
production and these ABI changes are causing practical issues for users
and we can't break userspace.  This makes this error pointless so we
should remove it.

Signed-off-by: Mark Brown <broonie@kernel.org>
Acked-by: Vinod Koul <vinod.koul@intel.com>
---
 include/uapi/sound/asoc.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index 33d00a4ce656..819d895edfdc 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -18,12 +18,6 @@
 #include <linux/types.h>
 #include <sound/asound.h>
 
-#ifndef __KERNEL__
-#error This API is an early revision and not enabled in the current
-#error kernel release, it will be enabled in a future kernel version
-#error with incompatible changes to what is here.
-#endif
-
 /*
  * Maximum number of channels topology kcontrol can represent.
  */
-- 
2.9.3
