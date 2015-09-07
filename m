From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 1/2] hda-emu: Fix hda_i915 build failure
Date: Mon,  7 Sep 2015 10:58:49 +0200
Message-ID: <1441616330-6635-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id E08BC26062B
 for <alsa-devel@alsa-project.org>; Mon,  7 Sep 2015 10:58:55 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

This allows building hda-emu even after recent i915 -> hda patches.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 include/drm/i915_component.h | 1 +
 include/sound/hda_i915.h     | 1 +
 2 files changed, 2 insertions(+)
 create mode 100644 include/sound/hda_i915.h

diff --git a/include/drm/i915_component.h b/include/drm/i915_component.h
index e69de29..545c915 100644
--- a/include/drm/i915_component.h
+++ b/include/drm/i915_component.h
@@ -0,0 +1 @@
+#include "../../dist/include/drm/i915_component.h"
diff --git a/include/sound/hda_i915.h b/include/sound/hda_i915.h
new file mode 100644
index 0000000..1579430
--- /dev/null
+++ b/include/sound/hda_i915.h
@@ -0,0 +1 @@
+#include "../../dist/include/sound/hda_i915.h"
-- 
1.9.1
