From: Jordi Mallach <jordi@debian.org>
Subject: [PATCH] Add -lm to test programs to fix build failure.
Date: Fri, 28 Jun 2013 15:05:44 +0200
Message-ID: <1372424744-27504-1-git-send-email-jordi@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tempesta.oskuro.net (tempesta.oskuro.net [92.243.30.96])
 by alsa0.perex.cz (Postfix) with ESMTP id F0AED2656EF
 for <alsa-devel@alsa-project.org>; Fri, 28 Jun 2013 15:05:54 +0200 (CEST)
Received: from penyagolosa.oskuro.net (167.22.15.37.dynamic.jazztel.es
 [37.15.22.167])
 by tempesta.oskuro.net (Postfix) with ESMTPSA id A075762742
 for <alsa-devel@alsa-project.org>; Fri, 28 Jun 2013 15:06:02 +0200 (CEST)
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

Add -lm to test programs that use sin(), to fix a build failure with recent
binutils.

Signed-off-by: Jordi Mallach <jordi@debian.org>
---
 test/Makefile.am | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/test/Makefile.am b/test/Makefile.am
index 8705402..c1896f8 100644
--- a/test/Makefile.am
+++ b/test/Makefile.am
@@ -7,8 +7,10 @@ check_PROGRAMS=control pcm pcm_min latency seq \
 
 control_LDADD=../src/libasound.la
 pcm_LDADD=../src/libasound.la
+pcm_LDFLAGS= -lm
 pcm_min_LDADD=../src/libasound.la
 latency_LDADD=../src/libasound.la
+latency_LDFLAGS= -lm
 seq_LDADD=../src/libasound.la
 playmidi1_LDADD=../src/libasound.la
 timer_LDADD=../src/libasound.la
-- 
1.8.3.1
