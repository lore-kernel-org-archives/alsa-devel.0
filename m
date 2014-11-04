From: Qais Yousef <qais.yousef@imgtec.com>
Subject: [PATCH TINYCOMPRESS][RESEND] makefile.linux: allow env
	to override CROSS_COMPILE and CC
Date: Tue, 4 Nov 2014 10:18:42 +0000
Message-ID: <1415096322-445-1-git-send-email-qais.yousef@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id C3EF22604CE
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 11:18:53 +0100 (CET)
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
 by Websense Email Security Gateway with ESMTPS id 0910C53DD626C
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 10:18:51 +0000 (GMT)
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
Cc: Qais Yousef <qais.yousef@imgtec.com>
List-Id: alsa-devel@alsa-project.org

allow env variables to override them without having to modify the makefile.

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
---
I'm not sure why but I think the first send didn't reach the list, hence
resending.

 makefile.linux | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/makefile.linux b/makefile.linux
index 81782d0af461..c4dab6d3b7d5 100644
--- a/makefile.linux
+++ b/makefile.linux
@@ -9,8 +9,8 @@ LIBOBJ = ${LIBSRC:.c=.o}
 PLAYOBJ = ${PLAYSRC:.c=.o}
 RECOBJ = ${RECSRC:.c=.o}
 
-CC = gcc
-CROSS_COMPILE =
+CROSS_COMPILE ?=
+CC ?= ${CROSS_COMPILE}gcc
 
 CFLAGS += -std=c99 -Wall -Wextra -Wunused -DVERSION=\"${VER}\" -I./include
 LDFLAGS += -L. -ltinycompress
@@ -20,19 +20,19 @@ all: libtinycompress cplay crec
 
 $(LIB): ${LIBOBJ}
 	@echo "  LD	"$@
-	@${CROSS_COMPILE}${CC} ${CFLAGS} -shared -Wl,-soname,$@.so -o $@.so ${LIBOBJ} ${LIBLDFLAGS}
+	@${CC} ${CFLAGS} -shared -Wl,-soname,$@.so -o $@.so ${LIBOBJ} ${LIBLDFLAGS}
 
 $(PLAYBIN): ${PLAYOBJ} ${LIB}
 	@echo "  LD	"$@
-	@${CROSS_COMPILE}${CC} ${CFLAGS} -o $@ ${PLAYOBJ} ${LDFLAGS}
+	@${CC} ${CFLAGS} -o $@ ${PLAYOBJ} ${LDFLAGS}
 
 $(RECBIN): ${RECOBJ} ${LIB}
 	@echo "  LD	"$@
-	@${CROSS_COMPILE}${CC} ${CFLAGS} -o $@ ${RECOBJ} ${LDFLAGS}
+	@${CC} ${CFLAGS} -o $@ ${RECOBJ} ${LDFLAGS}
 
 %.o: %.c
 	@echo "  CC	"$<
-	@${CROSS_COMPILE}${CC} ${CFLAGS} -c -fPIC -o $@ $<
+	@${CC} ${CFLAGS} -c -fPIC -o $@ $<
 
 clean:
 	@rm -rf ${BIN} ${PLAYOBJ} ${RECOBJ} ${LIB}.so ${LIBOBJ}
-- 
2.1.0
