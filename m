From: pavel.hofman@ivitera.com
Subject: [PATCH 1/6] AK4114 - fix output selector bits,
	fix spelling
Date: Tue, 15 Sep 2009 00:44:58 +0200
Message-ID: <1252968303-29334-1-git-send-email-pavel.hofman@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Pavel Hofman <pavel.hofman@ivitera.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Pavel Hofman <pavel.hofman@ivitera.com>


Signed-off-by: Pavel Hofman <pavel.hofman@ivitera.com>

diff --git a/include/ak4114.h b/include/ak4114.h
index d293d36..3ce69fd 100644
--- a/include/ak4114.h
+++ b/include/ak4114.h
@@ -95,13 +95,13 @@
 
 /* AK4114_REG_IO0 */
 #define AK4114_TX1E		(1<<7)	/* TX1 Output Enable (1 = enable) */
-#define AK4114_OPS12		(1<<2)	/* Output Though Data Selector for TX1 pin */
-#define AK4114_OPS11		(1<<1)	/* Output Though Data Selector for TX1 pin */
-#define AK4114_OPS10		(1<<0)	/* Output Though Data Selector for TX1 pin */
+#define AK4114_OPS12		(1<<6)	/* Output Data Selector for TX1 pin */
+#define AK4114_OPS11		(1<<5)	/* Output Data Selector for TX1 pin */
+#define AK4114_OPS10		(1<<4)	/* Output Data Selector for TX1 pin */
 #define AK4114_TX0E		(1<<3)	/* TX0 Output Enable (1 = enable) */
-#define AK4114_OPS02		(1<<2)	/* Output Though Data Selector for TX0 pin */
-#define AK4114_OPS01		(1<<1)	/* Output Though Data Selector for TX0 pin */
-#define AK4114_OPS00		(1<<0)	/* Output Though Data Selector for TX0 pin */
+#define AK4114_OPS02		(1<<2)	/* Output Data Selector for TX0 pin */
+#define AK4114_OPS01		(1<<1)	/* Output Data Selector for TX0 pin */
+#define AK4114_OPS00		(1<<0)	/* Output Data Selector for TX0 pin */
 
 /* AK4114_REG_IO1 */
 #define AK4114_EFH1		(1<<7)	/* Interrupt 0 pin Hold */
-- 
1.5.6.3
