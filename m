From: Milton Vandersloot <miltonrobertvandersloot1412@protonmail.com>
Subject: [PATCH] amixer: define _GNU_SOURCE to get exp10
Date: Wed, 27 Mar 2019 16:43:40 +0000
Message-ID: <WK2BhKt3rTlZDZ0_9eX_qoLKm-mqTzorh2_MG2ScLB-3BvfEyU3q3d-MUZNEUxv8BPjILG8zi8RYxWuyVz2vtJWx9XREEeTXvMrKx2b_VfI=@protonmail.com>
Reply-To: Milton Vandersloot <miltonrobertvandersloot1412@protonmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-40135.protonmail.ch (mail-40135.protonmail.ch
 [185.70.40.135])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 718E7F8071D
 for <alsa-devel@alsa-project.org>; Wed, 27 Mar 2019 17:43:44 +0100 (CET)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi

I get a warning about the implicit declaration of exp10 for amixer (not alsamixer). The same issue was reported at beginning of the year for alsamixer [0,1] and solved by adding -D_GNU_SOURCE to the CFLAGS. (In fact both alsamixer and amixer use the same file alsamixer/volume_mapping.c.) I suggest adding the same CFLAG also to the  amixer Makefile.am.

Cheers
Milton

[0] https://patchwork.kernel.org/patch/10765311/
[1] commit 116488e5f2f1b897084bd151381ee254e1cc177d

Patch suggestion:

>From d31f804d171e7548ecf6e96e96edc7a694a51612 Mon Sep 17 00:00:00 2001
From: Milton Vandersloot <miltonvandersloot@fake-box.com>
Date: Wed, 27 Mar 2019 17:36:54 +0100
Subject: [PATCH] amixer: define _GNU_SOURCE to get exp10

Get rid of a warning about implicit declarition of exp10, which is
behind _GNU_SOURCE as a non-standard feature. The same problem was fixed
for alsamixer in commit 116488e5f2f1b897084bd151381ee254e1cc177d.
---
 amixer/Makefile.am | 1 +
 1 file changed, 1 insertion(+)

diff --git a/amixer/Makefile.am b/amixer/Makefile.am
index 0343c8e..b4526ca 100644
--- a/amixer/Makefile.am
+++ b/amixer/Makefile.am
@@ -1,3 +1,4 @@
+AM_CFLAGS = -D_GNU_SOURCE
 AM_CPPFLAGS = -I$(top_srcdir)/include
 LDADD = -lm
 # LDFLAGS = -static
