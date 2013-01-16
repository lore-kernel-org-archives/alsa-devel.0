From: Yoichi Yuasa <yuasa@linux-mips.org>
Subject: [PATCH 06/19] ALSA: ymu831: add device interface driver
Date: Wed, 16 Jan 2013 17:32:04 +0900
Message-ID: <20130116173204.978b7cba3c9b1a99038ac0b7@linux-mips.org>
References: <20130116172530.857b627ef3303fb6fe43f603@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20130116172530.857b627ef3303fb6fe43f603@linux-mips.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, yuasa@linux-mips.org
List-Id: alsa-devel@alsa-project.org


Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 sound/soc/codecs/ymu831/Makefile  |    3 +-
 sound/soc/codecs/ymu831/mcdevif.c |  100 +++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/ymu831/mcdevif.h |   69 +++++++++++++++++++++++++
 3 files changed, 171 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/codecs/ymu831/mcdevif.c
 create mode 100644 sound/soc/codecs/ymu831/mcdevif.h

diff --git a/sound/soc/codecs/ymu831/Makefile b/sound/soc/codecs/ymu831/Makefile
index b42881e..949640e 100644
--- a/sound/soc/codecs/ymu831/Makefile
+++ b/sound/soc/codecs/ymu831/Makefile
@@ -1,5 +1,6 @@
 snd-soc-ymu831-objs := \
 	mcbdspdrv.o	\
-	mccdspdrv.o
+	mccdspdrv.o	\
+	mcdevif.o
 
 obj-$(CONFIG_SND_SOC_YMU831) += snd-soc-ymu831.o
diff --git a/sound/soc/codecs/ymu831/mcdevif.c b/sound/soc/codecs/ymu831/mcdevif.c
new file mode 100644
index 0000000..6909dc5
--- /dev/null
+++ b/sound/soc/codecs/ymu831/mcdevif.c
@@ -0,0 +1,100 @@
+/****************************************************************************
+ *
+ * Copyright(c) 2012 Yamaha Corporation. All rights reserved.
+ *
+ * Module	: mcdevif.c
+ * Description	: MC device interface driver
+ * Version	: 1.0.0	Dec 13 2012
+ *
+ * This software is provided 'as-is', without any express or implied
+ * warranty.	In no event will the authors be held liable for any damages
+ * arising from the use of this software.
+ *
+ * Permission is granted to anyone to use this software for any purpose,
+ * including commercial applications, and to alter it and redistribute it
+ * freely, subject to the following restrictions:
+ *
+ * 1. The origin of this software must not be misrepresented; you must not
+ *	claim that you wrote the original software. If you use this software
+ *	in a product, an acknowledgment in the product documentation would be
+ *	appreciated but is not required.
+ * 2. Altered source versions must be plainly marked as such, and must not be
+ *	misrepresented as being the original software.
+ * 3. This notice may not be removed or altered from any source distribution.
+ *
+ ****************************************************************************/
+/*
+ * changelog:
+ * - change in the Linux coding style
+ * - remove unnecessary comments
+ * - remove unused codes
+ * - mc_packet_*() functions move to mcpacking.c
+ */
+#include <linux/types.h>
+
+#include "mcdefs.h"
+#include "mcdevif.h"
+
+static struct mcdrv_bus_ops *mc_bus_ops;
+
+void mc_bus_register(struct mcdrv_bus_ops *ops)
+{
+	mc_bus_ops = ops;
+}
+
+void mc_read(enum mcdrv_slave_addr slave_addr, u8 addr, u8 *data, u32 size)
+{
+	if (mc_bus_ops && mc_bus_ops->read)
+		mc_bus_ops->read(mc_bus_ops->priv, slave_addr, addr, data,
+				 size);
+}
+
+void mc_read_b(u8 addr, u8 *data, u32 size)
+{
+	u8 addr_cmd[2];
+
+	addr_cmd[0] = MCI_B_REG_A << 1;
+	addr_cmd[1] = addr;
+
+	mc_write_digital(addr_cmd, 2);
+	mc_read_digital(MCI_B_REG_D, data, size);
+}
+
+void mc_read_c(u8 addr, u8 *data, u32 size)
+{
+	u8 addr_cmd[2];
+
+	addr_cmd[0] = MCI_C_REG_A << 1;
+	addr_cmd[1] = addr;
+
+	mc_write_digital(addr_cmd, 2);
+	mc_read_digital(MCI_C_REG_D, data, size);
+}
+
+void mc_read_e(u8 addr, u8 *data, u32 size)
+{
+	u8 addr_cmd[2];
+
+	addr_cmd[0] = MCI_E_REG_A << 1;
+	addr_cmd[1] = addr;
+
+	mc_write_digital(addr_cmd, 2);
+	mc_read_digital(MCI_E_REG_D, data, size);
+}
+
+void mc_read_f(u8 addr, u8 *data, u32 size)
+{
+	u8 addr_cmd[2];
+
+	addr_cmd[0] = MCI_F_REG_A << 1;
+	addr_cmd[1] = addr;
+
+	mc_write_digital(addr_cmd, 2);
+	mc_read_digital(MCI_F_REG_D, data, size);
+}
+
+void mc_write(enum mcdrv_slave_addr slave_addr, u8 *data, u32 size)
+{
+	if (mc_bus_ops && mc_bus_ops->write)
+		mc_bus_ops->write(mc_bus_ops->priv, slave_addr, data, size);
+}
diff --git a/sound/soc/codecs/ymu831/mcdevif.h b/sound/soc/codecs/ymu831/mcdevif.h
new file mode 100644
index 0000000..af9f8c8
--- /dev/null
+++ b/sound/soc/codecs/ymu831/mcdevif.h
@@ -0,0 +1,69 @@
+/****************************************************************************
+ *
+ * Copyright(c) 2012 Yamaha Corporation. All rights reserved.
+ *
+ * Module	: mcdevif.h
+ * Description	: MC device interface driver header
+ * Version	: 1.0.0 Dec 13 2012
+ *
+ * This software is provided 'as-is', without any express or implied
+ * warranty.	In no event will the authors be held liable for any damages
+ * arising from the use of this software.
+ *
+ * Permission is granted to anyone to use this software for any purpose,
+ * including commercial applications, and to alter it and redistribute it
+ * freely, subject to the following restrictions:
+ *
+ * 1. The origin of this software must not be misrepresented; you must not
+ *	claim that you wrote the original software. If you use this software
+ *	in a product, an acknowledgment in the product documentation would be
+ *	appreciated but is not required.
+ * 2. Altered source versions must be plainly marked as such, and must not be
+ *	misrepresented as being the original software.
+ * 3. This notice may not be removed or altered from any source distribution.
+ *
+ ****************************************************************************/
+/*
+ * changelog:
+ * - change in the Linux coding style
+ * - remove unnecessary comments
+ * - remove unused codes
+ * - mc_packet_*() functions move to mcpacking.h
+ */
+#ifndef _MCDEVIF_H
+#define _MCDEVIF_H
+
+#include <linux/types.h>
+
+enum mcdrv_slave_addr {
+	MCDRV_SLAVE_ADDR_ANALOG,
+	MCDRV_SLAVE_ADDR_DIGITAL,
+};
+
+struct mcdrv_bus_ops {
+	int (*read) (void *bus_priv, enum mcdrv_slave_addr slave_addr,
+		     u8 addr, u8 *data, u32 size);
+	int (*write) (void *bus_priv, enum mcdrv_slave_addr slave_addr,
+		      u8 *data, u32 size);
+	void *priv;
+};
+
+void mc_bus_register(struct mcdrv_bus_ops *ops);
+void mc_read(enum mcdrv_slave_addr slave_addr, u8 addr, u8 *data, u32 size);
+void mc_read_b(u8 addr, u8 *data, u32 size);
+void mc_read_c(u8 addr, u8 *data, u32 size);
+void mc_read_e(u8 addr, u8 *data, u32 size);
+void mc_read_f(u8 addr, u8 *data, u32 size);
+void mc_write(enum mcdrv_slave_addr slave_addr, u8 *data, u32 size);
+
+#define mc_read_analog(address, data, size)   \
+		mc_read(MCDRV_SLAVE_ADDR_ANALOG, (address), (data), (size))
+#define mc_read_digital(address, data, size)  \
+		mc_read(MCDRV_SLAVE_ADDR_DIGITAL, (address), (data), (size))
+
+#define mc_write_analog(data, size)   \
+		mc_write(MCDRV_SLAVE_ADDR_ANALOG, (data), (size))
+#define mc_write_digital(data, size)  \
+		mc_write(MCDRV_SLAVE_ADDR_DIGITAL, (data), (size))
+
+#endif /* _MCDEVIF_H */
-- 
1.7.9.5
