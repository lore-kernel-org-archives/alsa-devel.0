From: Qais Yousef <qais.yousef@imgtec.com>
Subject: [TINYCOMPRESS][PATCH 3/6] makefile.linux: delete as no
	longer necessary/used
Date: Mon, 23 Mar 2015 13:09:02 +0000
Message-ID: <1427116145-519-4-git-send-email-qais.yousef@imgtec.com>
References: <1427116145-519-1-git-send-email-qais.yousef@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id E2808260631
 for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2015 14:09:19 +0100 (CET)
In-Reply-To: <1427116145-519-1-git-send-email-qais.yousef@imgtec.com>
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

Now autotools takes care of generating Makefiles.
---
 makefile.linux | 41 -----------------------------------------
 1 file changed, 41 deletions(-)
 delete mode 100644 makefile.linux

diff --git a/makefile.linux b/makefile.linux
deleted file mode 100644
index c4dab6d3b7d5..000000000000
--- a/makefile.linux
+++ /dev/null
@@ -1,41 +0,0 @@
-LIB = libtinycompress
-VER = 0.1
-LIBSRC = compress.c
-PLAYBIN = cplay
-RECBIN = crec
-PLAYSRC = cplay.c utils.c
-RECSRC = crec.c utils.c
-LIBOBJ = ${LIBSRC:.c=.o}
-PLAYOBJ = ${PLAYSRC:.c=.o}
-RECOBJ = ${RECSRC:.c=.o}
-
-CROSS_COMPILE ?=
-CC ?= ${CROSS_COMPILE}gcc
-
-CFLAGS += -std=c99 -Wall -Wextra -Wunused -DVERSION=\"${VER}\" -I./include
-LDFLAGS += -L. -ltinycompress
-LIBLDFLAGS = -lasound
-
-all: libtinycompress cplay crec
-
-$(LIB): ${LIBOBJ}
-	@echo "  LD	"$@
-	@${CC} ${CFLAGS} -shared -Wl,-soname,$@.so -o $@.so ${LIBOBJ} ${LIBLDFLAGS}
-
-$(PLAYBIN): ${PLAYOBJ} ${LIB}
-	@echo "  LD	"$@
-	@${CC} ${CFLAGS} -o $@ ${PLAYOBJ} ${LDFLAGS}
-
-$(RECBIN): ${RECOBJ} ${LIB}
-	@echo "  LD	"$@
-	@${CC} ${CFLAGS} -o $@ ${RECOBJ} ${LDFLAGS}
-
-%.o: %.c
-	@echo "  CC	"$<
-	@${CC} ${CFLAGS} -c -fPIC -o $@ $<
-
-clean:
-	@rm -rf ${BIN} ${PLAYOBJ} ${RECOBJ} ${LIB}.so ${LIBOBJ}
-
-
-.PHONY: all clean
-- 
2.1.0
