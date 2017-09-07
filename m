From: Russell Treleaven <rtreleaven@bunnykick.ca>
Subject: autopoint should be required for bootstrap.sh
Date: Thu, 7 Sep 2017 13:14:51 -0400
Message-ID: <CAHzfiZ7L88DTgopcjdF6xp4-2JxE+CBfd7U9Kp_5pLKjOaKDag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f193.google.com (mail-qk0-f193.google.com
 [209.85.220.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A4A026750B
 for <alsa-devel@alsa-project.org>; Thu,  7 Sep 2017 19:14:53 +0200 (CEST)
Received: by mail-qk0-f193.google.com with SMTP id g128so186618qke.0
 for <alsa-devel@alsa-project.org>; Thu, 07 Sep 2017 10:14:53 -0700 (PDT)
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
List-Id: alsa-devel@alsa-project.org

I attempted to bootstrap pulseaudio and got a non obvious error.

log is here https://pastebin.com/CctNdLwD

installing autopoint fixed the problem

the following patch makes bootstrap.sh fail if autopoint is not available.

diff --git a/bootstrap.sh b/bootstrap.sh
index 57494fc..0a05a3e 100755
--- a/bootstrap.sh
+++ b/bootstrap.sh
@@ -32,13 +32,17 @@ fi
 # configure file faulty.
 if ! pkg-config --version &>/dev/null; then
     echo "pkg-config is required to bootstrap this program"
-    DIE=1
+    exit 1
 fi
-
 # Other necessary programs
-intltoolize --version >/dev/null || DIE=1
-test "$DIE" = 1 && exit 1
-
+if ! autopoint --version &>/dev/null ; then
+    echo "autopoint is required to bootstrap this program"
+    exit 1
+fi
+if ! intltoolize --version >/dev/null ; then
+    echo "intltoolize is required to bootstrap this program"
+    exit 1
+fi
 autopoint --force
 AUTOPOINT='intltoolize --automake --copy' autoreconf --force --install
--verbose



-- 
Sincerely,

Russell Treleaven
sip:rtreleaven@sip.bunnykick.ca
