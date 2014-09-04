From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 4/4] hda-emu/tester: Fix calculation of machines
Date: Thu,  4 Sep 2014 16:21:26 +0200
Message-ID: <1409840486-14961-5-git-send-email-david.henningsson@canonical.com>
References: <1409840486-14961-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id ABFB0265645
 for <alsa-devel@alsa-project.org>; Thu,  4 Sep 2014 16:21:25 +0200 (CEST)
In-Reply-To: <1409840486-14961-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Previously, if a machine had a modem codec, it was not included
in the total count of machines.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 tester/summary.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tester/summary.py b/tester/summary.py
index 640d1c1..4bf53b6 100755
--- a/tester/summary.py
+++ b/tester/summary.py
@@ -90,7 +90,9 @@ def main():
                         if line.find("is a modem codec, aborting"):
                             skip_this = True
 
-                if (not skip_this) and (r.errors > 0 or r.warnings > 0):
+                if skip_this:
+                    skip_this = False
+                elif (r.errors > 0 or r.warnings > 0):
                     fail_this = True
                     errors += r.errors
                     warnings += r.warnings
-- 
1.9.1
