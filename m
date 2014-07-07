From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: add SOC_VALUE_ENUM_EXT
Date: Mon, 7 Jul 2014 13:16:54 +0100
Message-ID: <20140707121644.GA26105@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Adds an equivalent of SOC_ENUM_EXT for value enums

Strictly speaking SOC_ENUM_EXT can also be used to define
a value enum since the only difference is the get and set
functions. But this doesn't look good in code because it is
inconsistent with the normal control definitions. Adding a
specific SOC_VALUE_ENUM_EXT is better for code clarity.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 include/sound/soc.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 9a5b4f6..1483920 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -248,6 +248,8 @@
 	.info = snd_soc_info_enum_double, \
 	.get = xhandler_get, .put = xhandler_put, \
 	.private_value = (unsigned long)&xenum }
+#define SOC_VALUE_ENUM_EXT(xname, xenum, xhandler_get, xhandler_put) \
+	SOC_ENUM_EXT(xname, xenum, xhandler_get, xhandler_put)
 
 #define SND_SOC_BYTES(xname, xbase, xregs)		      \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname,   \
-- 
1.7.2.5
