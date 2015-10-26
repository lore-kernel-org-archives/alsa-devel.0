From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: topology: Reenable use from userspace
Date: Mon, 26 Oct 2015 12:41:40 +0900
Message-ID: <1445830900-1752-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DB84260471
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2015 04:41:56 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, Vinod Koul <vinod.koul@intel.com>, Mendong Lin <mengdong.lin@intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

We had inserted a #error into the topology UAPI code to ensure that the
ABI was not adopted by userspace while final review and testing was
ongoing.  Since we are now comfortable that the ABI is suitable for
production remove the #error, future changes will include provision for
backwards compatibility.

Signed-off-by: Mark Brown <broonie@kernel.org>
---

Are we OK with this?  Looking for some acks and reviews...

 include/uapi/sound/asoc.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index 247c50b..51b8066 100644
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
2.6.1
