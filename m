From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH TINYCOMPRESS 12/14] compress: Add makefile for
	building	under standard linux
Date: Sun, 10 Feb 2013 00:21:01 +0000
Message-ID: <20130210002101.GL31139@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1B18C2616A0
 for <alsa-devel@alsa-project.org>; Sun, 10 Feb 2013 01:21:03 +0100 (CET)
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>

diff --git a/makefile.linux b/makefile.linux
new file mode 100644
index 0000000..60d6c04
--- /dev/null
+++ b/makefile.linux
@@ -0,0 +1,35 @@
+LIB = libtinycompress
+BIN = cplay
+VER = 0.1
+LIBSRC = compress.c
+SRC = cplay.c
+LIBOBJ = ${LIBSRC:.c=.o}
+OBJ = ${SRC:.c=.o}
+
+CC = gcc
+CROSS_COMPILE =
+
+CFLAGS += -std=c99 -Wall -Wextra -Wunused -DVERSION=\"${VER}\" -I./include
+LDFLAGS += -L. -ltinycompress
+LIBLDFLAGS = -lasound
+
+all: libtinycompress cplay
+
+$(LIB): ${LIBOBJ}
+	@echo "  LD	"$@
+	@${CROSS_COMPILE}${CC} ${CFLAGS} -shared -Wl,-soname,$@.so -o $@.so ${LIBOBJ} ${LIBLDFLAGS}
+
+$(BIN): ${OBJ} ${LIB}
+	@echo "  LD	"$@
+	@${CROSS_COMPILE}${CC} ${CFLAGS} -o $@ ${OBJ} ${LDFLAGS}
+
+
+%.o: %.c
+	@echo "  CC	"$<
+	@${CROSS_COMPILE}${CC} ${CFLAGS} -c -fPIC -o $@ $<
+
+clean:
+	@rm -rf ${BIN} ${OBJ} ${LIB}.so ${LIBOBJ}
+
+
+.PHONY: all clean
-- 
1.7.2.5
