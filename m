From: erwin <nebelbank@posteo.de>
Subject: [PATCH - alsa-utils 1/1] aplay: Fix wav file not being
	split on 32 bit platforms
Date: Tue, 13 Mar 2018 19:51:24 +0100
Message-ID: <20180313185124.5352-1-nebelbank@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
 by alsa0.perex.cz (Postfix) with ESMTP id C495B266E77
 for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2018 19:51:39 +0100 (CET)
Received: from submission (posteo.de [89.146.220.130])
 by mout01.posteo.de (Postfix) with ESMTPS id 041C2210B2
 for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2018 19:51:39 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, erwin <nebelbank@posteo.de>
List-Id: alsa-devel@alsa-project.org

On my 32 bit armhf board arecord exits because of write() returning EFBIG
when the output file size reaches 2147483647 bytes.

To fix this, include generated header file before system header files
so that _FILE_OFFSET_BITS=64 is used properly, as required in documentation
"man feature_test_macros".

Signed-off-by: erwin <nebelbank@posteo.de>

diff --git a/aplay/aplay.c b/aplay/aplay.c
index 6b740c2..bbd7fff 100644
--- a/aplay/aplay.c
+++ b/aplay/aplay.c
@@ -27,6 +27,7 @@
  */
 
 #define _GNU_SOURCE
+#include "aconfig.h"
 #include <stdio.h>
 #include <malloc.h>
 #include <unistd.h>
@@ -49,7 +50,6 @@
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <endian.h>
-#include "aconfig.h"
 #include "gettext.h"
 #include "formats.h"
 #include "version.h"
-- 
2.14.1
