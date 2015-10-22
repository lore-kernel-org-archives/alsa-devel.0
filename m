From: Caleb Crome <caleb@crome.org>
Subject: [PATCH] BAT: fix missing header
Date: Thu, 22 Oct 2015 15:07:32 -0700
Message-ID: <CAG5mAdw1dO85AkuXgA7UuGmCcehWPMijrdYB5_NECgP8uoHHQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f176.google.com (mail-wi0-f176.google.com
 [209.85.212.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 395802607E8
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 00:07:52 +0200 (CEST)
Received: by wijp11 with SMTP id p11so52365915wij.0
 for <alsa-devel@alsa-project.org>; Thu, 22 Oct 2015 15:07:52 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Lu,
 Han" <han.lu@intel.com>, "Gautier, Bernard" <bernard.gautier@intel.com>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

There was no warning when compiling with -O3, but gave a warning without it.

commit a19fa1f7dff40e56dc4327c5e5fdde9e15bd8a55
Author: Caleb Crome <ccrome@gmail.com>
Date:   Tue Oct 20 20:59:50 2015 +0000

    Add missing locale.h header.

diff --git a/bat/bat.c b/bat/bat.c
index 57c9db8..14666b2 100644
--- a/bat/bat.c
+++ b/bat/bat.c
@@ -23,6 +23,7 @@
 #include <getopt.h>
 #include <math.h>
 #include <limits.h>
+#include <locale.h>

 #include "aconfig.h"
 #include "gettext.h"
