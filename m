From: Qais Yousef <qais.yousef@imgtec.com>
Subject: [TINYCOMPRESS][PATCH v3 2/7] add .gitignore file
Date: Tue, 5 May 2015 11:21:06 +0100
Message-ID: <1430821271-15624-3-git-send-email-qais.yousef@imgtec.com>
References: <1430821271-15624-1-git-send-email-qais.yousef@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id EA7F3265475
 for <alsa-devel@alsa-project.org>; Tue,  5 May 2015 12:23:29 +0200 (CEST)
In-Reply-To: <1430821271-15624-1-git-send-email-qais.yousef@imgtec.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: vinod.koul@intel.com
Cc: alsa-devel@alsa-project.org, Qais Yousef <qais.yousef@imgtec.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
---
 .gitignore | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 .gitignore

diff --git a/.gitignore b/.gitignore
new file mode 100644
index 000000000000..581b31038c8f
--- /dev/null
+++ b/.gitignore
@@ -0,0 +1,39 @@
+.*
+*.o
+*.so
+*.la
+*.lo
+*~
+configure
+config.log
+config.cache
+config.status
+config.guess
+config.sub
+config.h
+config.h.in
+Makefile
+Makefile.in
+libtool
+depcomp
+ltmain.sh
+aclocal.m4
+autom4te.cache
+compile
+install-sh
+missing
+stamp-h1
+m4/libtool.m4
+m4/ltoptions.m4
+m4/ltsugar.m4
+m4/ltversion.m4
+m4/lt~obsolete.m4
+
+# binary ignores
+cplay
+crecord
+
+# other ignores
+*.patch
+cscope.*
+tags
-- 
2.1.0
