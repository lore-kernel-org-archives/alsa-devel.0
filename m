From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: samsung: s3c-i2s-v2.c needs module.h
Date: Sun, 02 Oct 2011 21:34:26 +0800
Message-ID: <1317562466.4996.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 47CE724525
	for <alsa-devel@alsa-project.org>;
	Sun,  2 Oct 2011 15:34:40 +0200 (CEST)
Received: by gyg4 with SMTP id 4so3105599gyg.38
	for <alsa-devel@alsa-project.org>; Sun, 02 Oct 2011 06:34:39 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sangbeom Kim <sbkim73@samsung.com>, Jassi Brar <jassisinghbrar@gmail.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Liam@alsa-project.org, Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Include <linux/module.h> to fix below build error:

  CC      sound/soc/samsung/s3c-i2s-v2.o
sound/soc/samsung/s3c-i2s-v2.c:573: warning: data definition has no type or storage class
sound/soc/samsung/s3c-i2s-v2.c:573: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
sound/soc/samsung/s3c-i2s-v2.c:573: warning: parameter names (without types) in function declaration
sound/soc/samsung/s3c-i2s-v2.c:638: warning: data definition has no type or storage class
sound/soc/samsung/s3c-i2s-v2.c:638: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
sound/soc/samsung/s3c-i2s-v2.c:638: warning: parameter names (without types) in function declaration
sound/soc/samsung/s3c-i2s-v2.c:677: warning: data definition has no type or storage class
sound/soc/samsung/s3c-i2s-v2.c:677: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
sound/soc/samsung/s3c-i2s-v2.c:677: warning: parameter names (without types) in function declaration
sound/soc/samsung/s3c-i2s-v2.c: In function 's3c_i2sv2_register_dai':
sound/soc/samsung/s3c-i2s-v2.c:736: warning: initialization discards qualifiers from pointer target type
sound/soc/samsung/s3c-i2s-v2.c: At top level:
sound/soc/samsung/s3c-i2s-v2.c:754: warning: data definition has no type or storage class
sound/soc/samsung/s3c-i2s-v2.c:754: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
sound/soc/samsung/s3c-i2s-v2.c:754: warning: parameter names (without types) in function declaration
sound/soc/samsung/s3c-i2s-v2.c:756: error: expected declaration specifiers or '...' before string constant
sound/soc/samsung/s3c-i2s-v2.c:756: warning: data definition has no type or storage class
sound/soc/samsung/s3c-i2s-v2.c:756: warning: type defaults to 'int' in declaration of 'MODULE_LICENSE'
sound/soc/samsung/s3c-i2s-v2.c:756: warning: function declaration isn't a prototype
make[3]: *** [sound/soc/samsung/s3c-i2s-v2.o] Error 1
make[2]: *** [sound/soc/samsung] Error 2
make[1]: *** [sound/soc] Error 2
make: *** [sound] Error 2

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
This patch is against linux-next (20110930).

 sound/soc/samsung/s3c-i2s-v2.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/samsung/s3c-i2s-v2.c b/sound/soc/samsung/s3c-i2s-v2.c
index 52074a2b..7a73380 100644
--- a/sound/soc/samsung/s3c-i2s-v2.c
+++ b/sound/soc/samsung/s3c-i2s-v2.c
@@ -16,6 +16,7 @@
  * option) any later version.
  */
 
+#include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/clk.h>
 #include <linux/io.h>
-- 
1.7.4.1
