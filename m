From: Jordi Mallach <jordi@debian.org>
Subject: [PATCH 1/3] Fix path to libaoss.so.
Date: Wed, 15 May 2013 18:58:05 +0200
Message-ID: <1368637087-28860-2-git-send-email-jordi@debian.org>
References: <1368637087-28860-1-git-send-email-jordi@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tempesta.oskuro.net (tempesta.oskuro.net [92.243.30.96])
 by alsa0.perex.cz (Postfix) with ESMTP id A046926168B
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 18:58:30 +0200 (CEST)
Received: from penyagolosa.oskuro.net (169.219.14.37.dynamic.jazztel.es
 [37.14.219.169])
 by tempesta.oskuro.net (Postfix) with ESMTPSA id 15796628EE
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 18:58:25 +0200 (CEST)
In-Reply-To: <1368637087-28860-1-git-send-email-jordi@debian.org>
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

Fix path to libaoss.so using ${libdir} instead of ${exec_prefix}.
${libdir} has the value given at configure time and works with Debian's
Multiarch implementation.

Signed-off-by: Jordi Mallach <jordi@debian.org>
---
 alsa/aoss.in |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/alsa/aoss.in b/alsa/aoss.in
index c551431..d8e1d6d 100644
--- a/alsa/aoss.in
+++ b/alsa/aoss.in
@@ -6,8 +6,8 @@
 
 if [ -d /proc/asound ]; then
   prefix=@prefix@
-  exec_prefix=@exec_prefix@
-  LD_PRELOAD=${exec_prefix}/\$LIB/libaoss.so${LD_PRELOAD:+:$LD_PRELOAD} exec "$@"
+  libdir=@libdir@
+  LD_PRELOAD=${libdir}/libaoss.so${LD_PRELOAD:+:$LD_PRELOAD} exec "$@"
 else
   exec "$@"
 fi
-- 
1.7.10.4
