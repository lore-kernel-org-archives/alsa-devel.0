From: Dmitry Voytik <voytikd@gmail.com>
Subject: [PATCH] doc: fix cross-compiling example
Date: Fri, 22 Aug 2014 14:17:10 +0400
Message-ID: <1408702630-29406-1-git-send-email-voytikd@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f43.google.com (mail-qg0-f43.google.com
 [209.85.192.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 12D5B262631
 for <alsa-devel@alsa-project.org>; Fri, 22 Aug 2014 12:17:08 +0200 (CEST)
Received: by mail-qg0-f43.google.com with SMTP id a108so9993408qge.2
 for <alsa-devel@alsa-project.org>; Fri, 22 Aug 2014 03:17:07 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Dmitry Voytik <voytikd@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Simplest way to configure cross-compilation with configure
script is to pass '--host' option.
Passing just '--target' doesn't work.

Signed-off-by: Dmitry Voytik <voytikd@gmail.com>
---
 INSTALL |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/INSTALL b/INSTALL
index 91a8648..47086e3 100644
--- a/INSTALL
+++ b/INSTALL
@@ -78,16 +78,13 @@ When you would like to cross-compile ALSA library (e.g. compile on
 i686 host but for arm architecture) you will need to call ./configure
 script with additional parameters:
 
-CC=arm-linux-gcc ./configure --target=arm-linux
+CC=arm-linux-gcc ./configure --host=arm-linux
 
-In this example host where the library is build is guessed (should be
-given with --host=platform) and target for which is the library build is
-Linux on ARM architecture.  You should omit setting 'CC' variable and
-cross-compiler will be guessed too.
+You can omit setting 'CC' variable and cross-compiler will be guessed too.
 
 So simplest version would be:
 
-./configure --target=arm-linux
+./configure --host=arm-linux
 
 For platform names in the form cpu-vendor-os (or aliases for this)
 you should look in 'config.guess' script. Target and all paths
-- 
1.7.9.5
