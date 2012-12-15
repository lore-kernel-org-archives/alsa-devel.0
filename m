From: Olivier Blin <dev@blino.org>
Subject: [PATCH] configure: do not detect incorrect
	cross-compiler
Date: Sat, 15 Dec 2012 01:58:59 +0100
Message-ID: <1355533139-9539-1-git-send-email-dev@blino.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by alsa0.perex.cz (Postfix) with ESMTP id 25015264F18
 for <alsa-devel@alsa-project.org>; Sat, 15 Dec 2012 01:59:05 +0100 (CET)
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
Cc: Olivier Blin <dev@blino.org>
List-Id: alsa-devel@alsa-project.org

On Ubuntu 11.04, configuring with --build=x86_64-unknown-linux-gnu
--host=x86_64-linux-gnu finds a wrong cross-compiler:
checking for cross-compiler... x86_64-x86_64-pc-linux-gnu-gcc

This happens because of a dash vs underscore inconsistency in configure.in:
host=x86_64-pc-linux-gnu
host_cpu=x86_64
host_os=linux-gnu
which ${host_cpu}-${host_os}-gcc >/dev/null 2>&1 && echo ${host_cpu}-${host-os}-gcc

This bug has been introduced in the initial --with-host support from
2002, commit eb267ade29c9a49c07b1c33dc9bf7a6790217400

This configure command is about "cross-compiling for i586", where the
system compiler is used, which just -m32 additional options.
The --build value comes from config.guess.
---
 configure.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.in b/configure.in
index e397dad..4af917b 100644
--- a/configure.in
+++ b/configure.in
@@ -31,7 +31,7 @@ then
 
   which ${program_prefix}gcc >/dev/null 2>&1 && CC=${program_prefix}gcc
   which ${host_cpu}-${host_os}-gcc >/dev/null 2>&1 \
-  && CC=${host_cpu}-${host-os}-gcc
+  && CC=${host_cpu}-${host_os}-gcc
   which ${host_cpu}-${host_vendor}-${host_os}-gcc >/dev/null 2>&1 \
   && CC=${host_cpu}-${host_vendor}-${host_os}-gcc
 
-- 
1.8.0.2
