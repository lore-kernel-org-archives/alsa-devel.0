From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: topology: Disable use from userspace
Date: Mon, 17 Aug 2015 23:03:48 -0700
Message-ID: <1439877828-4206-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from p2012.superclick.com (unknown [216.4.250.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 321752612BC
 for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2015 08:03:54 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mengdong Lin <mengdong.lin@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Since the topology API is still in sufficient flux for changes to be
identified disable the use of the userspace ABI by adding #error
statements to the code, ensuring that nobody relies on the headers as
currently defined.  It is expected that this change will be reverted for
v4.3.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/uapi/sound/asoc.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index 51b8066..247c50b 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -18,6 +18,12 @@
 #include <linux/types.h>
 #include <sound/asound.h>
 
+#ifndef __KERNEL__
+#error This API is an early revision and not enabled in the current
+#error kernel release, it will be enabled in a future kernel version
+#error with incompatible changes to what is here.
+#endif
+
 /*
  * Maximum number of channels topology kcontrol can represent.
  */
-- 
2.5.0
