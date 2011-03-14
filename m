From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: [PATCH] alsamixer: fix build on uClibc
Date: Mon, 14 Mar 2011 09:48:13 +0100
Message-ID: <1300092493-7414-1-git-send-email-jacmet@sunsite.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id F27701037EA
	for <alsa-devel@alsa-project.org>; Mon, 14 Mar 2011 09:48:26 +0100 (CET)
Received: by wwj40 with SMTP id 40so4467906wwj.20
	for <alsa-devel@alsa-project.org>; Mon, 14 Mar 2011 01:48:25 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, clemens@ladisch.de, alsa-devel@alsa-project.org
Cc: Peter Korsgaard <jacmet@sunsite.dk>
List-Id: alsa-devel@alsa-project.org

exp10 is a glibc extension, which isn't supported on uClibc. Luckily,
exp10() is trivial to compute based on exp(), so add a wrapper for
the uClibc case.

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
---
 alsamixer/volume_mapping.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/alsamixer/volume_mapping.c b/alsamixer/volume_mapping.c
index 9cacad8..1c0d7c4 100644
--- a/alsamixer/volume_mapping.c
+++ b/alsamixer/volume_mapping.c
@@ -37,6 +37,11 @@
 #include <stdbool.h>
 #include "volume_mapping.h"
 
+#ifdef __UCLIBC__
+/* 10^x = 10^(log e^x) = (e^x)^log10 = e^(x * log 10) */
+#define exp10(x) (exp((x) * log(10)))
+#endif /* __UCLIBC__ */
+
 #define MAX_LINEAR_DB_SCALE	24
 
 static inline bool use_linear_dB_scale(long dBmin, long dBmax)
-- 
1.7.2.3
