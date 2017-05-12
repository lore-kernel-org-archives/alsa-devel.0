From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 15/36] docs-rst: add sound book to pdf output
Date: Fri, 12 May 2017 10:59:58 -0300
Message-ID: <f51999a8fef46ac85d41ba523a73cde7c169e588.1494596071.git.mchehab@s-opensource.com>
References: <cover.1494596071.git.mchehab@s-opensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from osg.samsung.com
 (ec2-52-27-115-49.us-west-2.compute.amazonaws.com [52.27.115.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E6CB26719A
 for <alsa-devel@alsa-project.org>; Fri, 12 May 2017 16:00:29 +0200 (CEST)
In-Reply-To: <cover.1494596071.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1494596071.git.mchehab@s-opensource.com>
References: <cover.1494596071.git.mchehab@s-opensource.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org, Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: alsa-devel@alsa-project.org, Jonathan Corbet <corbet@lwn.net>, Takashi Iwai <tiwai@suse.com>, Mauro Carvalho Chehab <mchehab@s-opensource.com>, Mauro Carvalho Chehab <mchehab@infradead.org>
List-Id: alsa-devel@alsa-project.org

The sound subsystem book was added without the bits required to
generate PDF output. Add them.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 Documentation/conf.py       |  2 ++
 Documentation/sound/conf.py | 10 ++++++++++
 2 files changed, 12 insertions(+)
 create mode 100644 Documentation/sound/conf.py

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 1d461f0c1cd0..bca751960dec 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -371,6 +371,8 @@ latex_documents = [
      'The kernel development community', 'manual'),
     ('security/index', 'security.tex', 'The kernel security subsystem manual',
      'The kernel development community', 'manual'),
+    ('sound/index', 'sound.tex', 'Linux Sound Subsystem Documentation',
+     'The kernel development community', 'manual'),
 ]
 
 # The name of an image file (relative to this directory) to place at the top of
diff --git a/Documentation/sound/conf.py b/Documentation/sound/conf.py
new file mode 100644
index 000000000000..3f1fc5e74e7b
--- /dev/null
+++ b/Documentation/sound/conf.py
@@ -0,0 +1,10 @@
+# -*- coding: utf-8; mode: python -*-
+
+project = "Linux Sound Subsystem Documentation"
+
+tags.add("subproject")
+
+latex_documents = [
+    ('index', 'sound.tex', project,
+     'The kernel development community', 'manual'),
+]
-- 
2.9.3
