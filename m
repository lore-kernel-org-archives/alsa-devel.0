From: Tim Blechmann <tim@klingt.org>
Subject: [PATCH 1/2] alsa: lx6464es - command buffer API cleanup
Date: Tue, 22 Nov 2011 11:15:44 +0100
Message-ID: <8a6917141177b8021a02eb0a9d0c9243cf61e779.1321956887.git.tim@klingt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from klingt.org (mail.klingt.org [86.59.21.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 864AD245D9
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 11:16:03 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Tim Blechmann <tim@klingt.org>
List-Id: alsa-devel@alsa-project.org

the command buffer is only accessed from one file, so we can declare the
specific functions as static in that file

Signed-off-by: Tim Blechmann <tim@klingt.org>
---
 sound/pci/lx6464es/lx_core.c |    7 ++++---
 sound/pci/lx6464es/lx_core.h |    3 ---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/pci/lx6464es/lx_core.c b/sound/pci/lx6464es/lx_core.c
index 5c8717e..ad52f41 100644
--- a/sound/pci/lx6464es/lx_core.c
+++ b/sound/pci/lx6464es/lx_core.c
@@ -78,7 +78,8 @@ unsigned long lx_dsp_reg_read(struct lx6464es *chip, int port)
 	return ioread32(address);
 }
 
-void lx_dsp_reg_readbuf(struct lx6464es *chip, int port, u32 *data, u32 len)
+static void lx_dsp_reg_readbuf(struct lx6464es *chip, int port, u32 *data,
+			       u32 len)
 {
 	void __iomem *address = lx_dsp_register(chip, port);
 	memcpy_fromio(data, address, len*sizeof(u32));
@@ -91,8 +92,8 @@ void lx_dsp_reg_write(struct lx6464es *chip, int port, unsigned data)
 	iowrite32(data, address);
 }
 
-void lx_dsp_reg_writebuf(struct lx6464es *chip, int port, const u32 *data,
-			 u32 len)
+static void lx_dsp_reg_writebuf(struct lx6464es *chip, int port,
+				const u32 *data, u32 len)
 {
 	void __iomem *address = lx_dsp_register(chip, port);
 	memcpy_toio(address, data, len*sizeof(u32));
diff --git a/sound/pci/lx6464es/lx_core.h b/sound/pci/lx6464es/lx_core.h
index 1dd5629..4d7ff79 100644
--- a/sound/pci/lx6464es/lx_core.h
+++ b/sound/pci/lx6464es/lx_core.h
@@ -72,10 +72,7 @@ enum {
 };
 
 unsigned long lx_dsp_reg_read(struct lx6464es *chip, int port);
-void lx_dsp_reg_readbuf(struct lx6464es *chip, int port, u32 *data, u32 len);
 void lx_dsp_reg_write(struct lx6464es *chip, int port, unsigned data);
-void lx_dsp_reg_writebuf(struct lx6464es *chip, int port, const u32 *data,
-			 u32 len);
 
 /* plx register access */
 enum {
-- 
1.7.5.4
