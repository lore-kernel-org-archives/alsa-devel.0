From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] hda-analyzer: Ignore unknown lines in proc file
Date: Wed, 17 Oct 2012 09:36:09 +0200
Message-ID: <1350459369-3596-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id DFBE42651A0
 for <alsa-devel@alsa-project.org>; Wed, 17 Oct 2012 09:36:11 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

With newer kernels, the proc file sometimes add more information.
This makes hda-analyzer ignore such new additions by default,
instead of the current behaviour (which is to crash with a stack
trace). This way you can run an older hda-analyzer with a newer
kernel.

A recent example is the addition of "IEC Coding type" to all HDMI
codecs.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 hda-analyzer/hda_proc.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hda-analyzer/hda_proc.py b/hda-analyzer/hda_proc.py
index a6dd3dc..7424365 100644
--- a/hda-analyzer/hda_proc.py
+++ b/hda-analyzer/hda_proc.py
@@ -721,7 +721,7 @@ class HDACodecProc(HDACodec, HDABaseProc):
         elif line.startswith('  Volume-Knob: '):
           node.add_volknob(line[15:])
         else:
-          self.wrongfile(line)
+          print 'Unknown line, ignored: (%s)' % line
         idx += 1
         if idx < len(lines):
           line = lines[idx]
-- 
1.7.9.5
