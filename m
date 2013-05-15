From: Jordi Mallach <jordi@debian.org>
Subject: [PATCH 2/3] Show a warning if the alsa wrapper failed.
Date: Wed, 15 May 2013 18:58:06 +0200
Message-ID: <1368637087-28860-3-git-send-email-jordi@debian.org>
References: <1368637087-28860-1-git-send-email-jordi@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tempesta.oskuro.net (tempesta.oskuro.net [92.243.30.96])
 by alsa0.perex.cz (Postfix) with ESMTP id A07C8261694
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 18:58:30 +0200 (CEST)
Received: from penyagolosa.oskuro.net (169.219.14.37.dynamic.jazztel.es
 [37.14.219.169])
 by tempesta.oskuro.net (Postfix) with ESMTPSA id A3F0A62988
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 18:58:26 +0200 (CEST)
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

If /proc/asound is not found, throw a warning and continue without
any wrapping.

Signed-off-by: Jordi Mallach <jordi@debian.org>
---
 alsa/aoss.in |    1 +
 1 file changed, 1 insertion(+)

diff --git a/alsa/aoss.in b/alsa/aoss.in
index d8e1d6d..564eed9 100644
--- a/alsa/aoss.in
+++ b/alsa/aoss.in
@@ -9,6 +9,7 @@ if [ -d /proc/asound ]; then
   libdir=@libdir@
   LD_PRELOAD=${libdir}/libaoss.so${LD_PRELOAD:+:$LD_PRELOAD} exec "$@"
 else
+  echo "Warning: /proc/asound not found. Running without ALSA wrapper."
   exec "$@"
 fi
 exit 1
-- 
1.7.10.4
