From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH] alsa-lib: mixer/simple_none: fix softfloat
	compilation
Date: Tue, 15 Sep 2009 10:37:41 +0200
Message-ID: <4AAF5255.3050004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f207.google.com (mail-fx0-f207.google.com
	[209.85.220.207])
	by alsa0.perex.cz (Postfix) with ESMTP id 03CBE24498
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Sep 2009 10:37:47 +0200 (CEST)
Received: by fxm3 with SMTP id 3so2736525fxm.32
	for <alsa-devel@alsa-project.org>; Tue, 15 Sep 2009 01:37:47 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

mixer/simple_none.c uses HAVE_SOFT_FLOAT tests to work around sqrt() uses
but the definition in config.h is never picked up, leading to link errors
in libasound.so when built with --with-softfloat.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
Tested on MIPS.  The pcm_ladspa plugin still calls 'sqrt()' and
 should be excluded from the build if --with-softfloat is specified.

 src/mixer/mixer_simple.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/src/mixer/mixer_simple.h b/src/mixer/mixer_simple.h
index e88b007..bc9d20c 100644
--- a/src/mixer/mixer_simple.h
+++ b/src/mixer/mixer_simple.h
@@ -19,6 +19,7 @@
  *
  */

+#include <config.h>
 #include "mixer_abst.h"

 /* make local functions really local */
--
1.6.5.rc1
