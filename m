From: Pankaj DEV <pankaj.dev@st.com>
Subject: Compilation error for static build of alsa-lib
Date: Fri, 7 Dec 2012 14:31:10 +0800
Message-ID: <7C5AEAE2DCC6B24D92612A29E172F04A2476A26888@EAPEX1MAIL2.st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog117.obsmtp.com (eu1sys200aog117.obsmtp.com
 [207.126.144.143])
 by alsa0.perex.cz (Postfix) with ESMTP id 84E4D2625D5
 for <alsa-devel@alsa-project.org>; Fri,  7 Dec 2012 07:31:14 +0100 (CET)
Received: from zeta.dmz-ap.st.com (ns6.st.com [138.198.234.13])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 89BFCF0
 for <alsa-devel@alsa-project.org>; Fri,  7 Dec 2012 06:22:58 +0000 (GMT)
Received: from Webmail-ap.st.com (eapex1hubcas3.st.com [10.80.176.67])
 by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id CBB25D30
 for <alsa-devel@alsa-project.org>; Fri,  7 Dec 2012 06:31:09 +0000 (GMT)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

When building alsa (using buildroot) for static build, compilation errors occur.
Don't know how to report bug, since the "bug tracker" link on web-page doesn't open

The following patch solves the issue :
--- a/modules/mixer/simple/sbasedl.c
+++ b/modules/mixer/simple/sbasedl.c
@@ -27,7 +27,11 @@
#include <fcntl.h>
#include <sys/ioctl.h>
#include <math.h>
+#ifdef HAVE_LIBDL
#include <dlfcn.h>
+#else
+#define RTLD_NOW  0
+#endif
#include "config.h"
#include "asoundlib.h"
#include "mixer_abst.h"
diff --git a/src/mixer/simple_abst.c b/src/mixer/simple_abst.c
index 9e9aaf5..03070e0 100644
--- a/src/mixer/simple_abst.c
+++ b/src/mixer/simple_abst.c
@@ -34,7 +34,12 @@
#include <fcntl.h>
#include <sys/ioctl.h>
#include <math.h>
+#ifdef HAVE_LIBDL
#include <dlfcn.h>
+#else
+#define RTLD_NOW  0
+#define RTLD_GLOBAL             8
+#endif
 #include "config.h"
#include "asoundlib.h"
#include "mixer_simple.h"
