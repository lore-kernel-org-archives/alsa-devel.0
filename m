From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 04/11] ASoC: Add macros for defining virtual
	enums
Date: Fri, 28 Feb 2014 08:31:05 +0100
Message-ID: <1393572672-13937-5-git-send-email-lars@metafoo.de>
References: <1393572672-13937-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-167.synserver.de (smtp-out-127.synserver.de
 [212.40.185.127])
 by alsa0.perex.cz (Postfix) with ESMTP id 910672658F2
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 08:30:53 +0100 (CET)
In-Reply-To: <1393572672-13937-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, =?UTF-8?q?Philippe=20R=C3=A9tornaz?= <philippe.retornaz@epfl.ch>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

With the upcoming consolidation of normal MUXs and virtual MUXs we need to be
able to distinguish between enums with and without a backing register at the
enum level. Use the same approach as used for virtual mixer controls by setting
the reg field of the enum to SND_SOC_NOPM for enums without a backing register.
This patch adds a set of helper macros that can be used to define such enums.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
Changes since v1:
	* Renamed xmax to xitems
---
 include/sound/soc.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 662e645..56c4c71 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -189,6 +189,8 @@
 	.mask = xmask, .items = xitems, .texts = xtexts, .values = xvalues}
 #define SOC_VALUE_ENUM_SINGLE(xreg, xshift, xmask, xnitmes, xtexts, xvalues) \
 	SOC_VALUE_ENUM_DOUBLE(xreg, xshift, xshift, xmask, xnitmes, xtexts, xvalues)
+#define SOC_ENUM_SINGLE_VIRT(xitems, xtexts) \
+	SOC_ENUM_SINGLE(SND_SOC_NOPM, 0, xitems, xtexts)
 #define SOC_ENUM(xname, xenum) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname,\
 	.info = snd_soc_info_enum_double, \
@@ -293,6 +295,8 @@
 							ARRAY_SIZE(xtexts), xtexts, xvalues)
 #define SOC_VALUE_ENUM_SINGLE_DECL(name, xreg, xshift, xmask, xtexts, xvalues) \
 	SOC_VALUE_ENUM_DOUBLE_DECL(name, xreg, xshift, xshift, xmask, xtexts, xvalues)
+#define SOC_ENUM_SINGLE_VIRT_DECL(name, xtexts) \
+	const struct soc_enum name = SOC_ENUM_SINGLE_VIRT(ARRAY_SIZE(xtexts), xtexts)
 
 /*
  * Component probe and remove ordering levels for components with runtime
@@ -1091,7 +1095,7 @@ struct soc_mreg_control {
 
 /* enumerated kcontrol */
 struct soc_enum {
-	unsigned short reg;
+	int reg;
 	unsigned char shift_l;
 	unsigned char shift_r;
 	unsigned int items;
-- 
1.8.0
