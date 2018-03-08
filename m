From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] ASoC: uniphier: remove superfluous <linux/mfd/syscon.h>
 inclusion
Date: Thu,  8 Mar 2018 17:09:29 +0900
Message-ID: <1520496569-32032-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>, Jassi Brar <jaswinder.singh@linaro.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

None of aio-compress.c depends on the syscon header.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
---

 sound/soc/uniphier/aio-compress.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/uniphier/aio-compress.c b/sound/soc/uniphier/aio-compress.c
index 4751c8b..4c1027a 100644
--- a/sound/soc/uniphier/aio-compress.c
+++ b/sound/soc/uniphier/aio-compress.c
@@ -22,7 +22,6 @@
 #include <linux/dma-mapping.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
-#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
-- 
2.7.4
