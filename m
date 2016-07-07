From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-lib][PATCH] test: add linker flag with pthread
	for pcm-multi-thread stress test
Date: Fri,  8 Jul 2016 06:43:51 +0900
Message-ID: <1467927831-15461-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 48047261561
 for <alsa-devel@alsa-project.org>; Thu,  7 Jul 2016 23:43:56 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This test program is a pthread application, while Makefile has no flags
for linker about pthread library. This can cause below error.

$ make pcm-multi-thread
  CCLD     pcm-multi-thread
/usr/bin/ld: pcm-multi-thread.o: undefined reference to symbol 'pthread_cancel@@GLIBC_2.2.5'
//lib/x86_64-linux-gnu/libpthread.so.0: error adding symbols: DSO missing from command line
collect2: error: ld returned 1 exit status
Makefile:523: recipe for target 'pcm-multi-thread' failed
make: *** [pcm-multi-thread] Error 1

This commit fixes the bug by adding a corresponding flag.

Fixes: 147093ac5b8d('test: Add pcm-multi-thread program')
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 test/Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/Makefile.am b/test/Makefile.am
index 970595a..5f35159 100644
--- a/test/Makefile.am
+++ b/test/Makefile.am
@@ -24,7 +24,7 @@ code_CFLAGS=-Wall -pipe -g -O2
 chmap_LDADD=../src/libasound.la
 audio_time_LDADD=../src/libasound.la
 pcm_multi_thread_LDADD=../src/libasound.la
-
+pcm_multi_thread_LDFLAGS=-lpthread
 user_ctl_element_set_LDADD=../src/libasound.la
 user_ctl_element_set_CFLAGS=-Wall -g
 
-- 
2.7.4
