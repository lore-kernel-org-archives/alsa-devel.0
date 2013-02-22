From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH TINYCOMPRESS 12/14 v2] compress:
	Add	makefile for building under standard linux
Date: Fri, 22 Feb 2013 16:09:07 +0000
Message-ID: <20130222160907.GL21174@opensource.wolfsonmicro.com>
References: <20130210002101.GL31139@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 53D2F265DDD
 for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2013 17:09:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20130210002101.GL31139@opensource.wolfsonmicro.com>
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

---
 makefile.linux |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)
 create mode 100644 makefile.linux

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
