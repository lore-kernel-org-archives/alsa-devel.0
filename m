From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] treewide: fix typos of SPDX-License-Identifier
Date: Sat,  1 Jun 2019 12:22:42 +0900
Message-ID: <20190601032242.10405-1-yamada.masahiro@socionext.com>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: alsa-devel@alsa-project.org, Kees Cook <keescook@chromium.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-gpio@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, linux-renesas-soc@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Mark Brown <broonie@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Joe Perches <joe@perches.com>, linux-spdx@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Kishon Vijay Abraham I <kishon@ti.com>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, Alexandre Torgue <alexandre.torgue@st.com>
List-Id: alsa-devel@alsa-project.org

Prior to the adoption of SPDX, it was difficult for tools to determine
the correct license due to incomplete or badly formatted license text.
The SPDX solves this issue, assuming people can correctly spell
"SPDX-License-Identifier" although this assumption is broken in some
places.

Since scripts/spdxcheck.py parses only lines that exactly matches to
the correct tag, it cannot (should not) detect this kind of error.

If the correct tag is missing, scripts/checkpatch.pl warns like this:

 WARNING: Missing or malformed SPDX-License-Identifier tag in line *

So, people should notice it before the patch submission, but in reality
broken tags sometimes slip in. The checkpatch warning is not useful for
checking the committed files globally since large number of files still
have no SPDX tag.

Also, I am not sure about the legal effect when the SPDX tag is broken.

Anyway, these typos are absolutely worth fixing. It is pretty easy to
find suspicious lines by grep.

  $ git grep --not -e SPDX-License-Identifier --and -e SPDX- -- \
    :^LICENSES :^scripts/spdxcheck.py :^*/license-rules.rst
  arch/arm/kernel/bugs.c:// SPDX-Identifier: GPL-2.0
  drivers/phy/st/phy-stm32-usbphyc.c:// SPDX-Licence-Identifier: GPL-2.0
  drivers/pinctrl/sh-pfc/pfc-r8a77980.c:// SPDX-Lincense-Identifier: GPL 2.0
  lib/test_stackinit.c:// SPDX-Licenses: GPLv2
  sound/soc/codecs/max9759.c:// SPDX-Licence-Identifier: GPL-2.0

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/kernel/bugs.c                | 2 +-
 drivers/phy/st/phy-stm32-usbphyc.c    | 2 +-
 drivers/pinctrl/sh-pfc/pfc-r8a77980.c | 2 +-
 lib/test_stackinit.c                  | 2 +-
 sound/soc/codecs/max9759.c            | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/bugs.c b/arch/arm/kernel/bugs.c
index d41d3598e5e5..14c8dbbb7d2d 100644
--- a/arch/arm/kernel/bugs.c
+++ b/arch/arm/kernel/bugs.c
@@ -1,4 +1,4 @@
-// SPDX-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0
 #include <linux/init.h>
 #include <asm/bugs.h>
 #include <asm/proc-fns.h>
diff --git a/drivers/phy/st/phy-stm32-usbphyc.c b/drivers/phy/st/phy-stm32-usbphyc.c
index 1255cd1d9a60..56bdea4b0bd9 100644
--- a/drivers/phy/st/phy-stm32-usbphyc.c
+++ b/drivers/phy/st/phy-stm32-usbphyc.c
@@ -1,4 +1,4 @@
-// SPDX-Licence-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0
 /*
  * STMicroelectronics STM32 USB PHY Controller driver
  *
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77980.c b/drivers/pinctrl/sh-pfc/pfc-r8a77980.c
index 473da65890a7..9ed4ead2dafb 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77980.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77980.c
@@ -1,4 +1,4 @@
-// SPDX-Lincense-Identifier: GPL 2.0
+// SPDX-License-Identifier: GPL-2.0
 /*
  * R8A77980 processor support - PFC hardware block.
  *
diff --git a/lib/test_stackinit.c b/lib/test_stackinit.c
index 13115b6f2b88..e97dc54b4fdf 100644
--- a/lib/test_stackinit.c
+++ b/lib/test_stackinit.c
@@ -1,4 +1,4 @@
-// SPDX-Licenses: GPLv2
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Test cases for compiler-based stack variable zeroing via future
  * compiler flags or CONFIG_GCC_PLUGIN_STRUCTLEAK*.
diff --git a/sound/soc/codecs/max9759.c b/sound/soc/codecs/max9759.c
index ecfb4a80424b..00e9d4fd1651 100644
--- a/sound/soc/codecs/max9759.c
+++ b/sound/soc/codecs/max9759.c
@@ -1,4 +1,4 @@
-// SPDX-Licence-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0
 /*
  * MAX9759 Amplifier Driver
  *
-- 
2.17.1
