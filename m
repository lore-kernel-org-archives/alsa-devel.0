From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH v2 6/9] ASoC: sunxi: allow the sun8i-codec
	driver to be built on ARM64
Date: Sat, 13 Oct 2018 09:53:26 -0700
Message-ID: <20181013165329.13363-7-anarsoul@gmail.com>
References: <20181013165329.13363-1-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B953726795A
 for <alsa-devel@alsa-project.org>; Sat, 13 Oct 2018 18:54:33 +0200 (CEST)
Received: by mail-pg1-f193.google.com with SMTP id a5-v6so7224526pgv.13
 for <alsa-devel@alsa-project.org>; Sat, 13 Oct 2018 09:54:33 -0700 (PDT)
In-Reply-To: <20181013165329.13363-1-anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Marcus Cooper <codekipper@gmail.com>, Mylene JOSSERAND <mylene.josserand@free-electrons.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
List-Id: alsa-devel@alsa-project.org

Allwinner A64 uses the same digital codec part as in A33, so we need
to build this driver on ARM64 as well.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 sound/soc/sunxi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/Kconfig b/sound/soc/sunxi/Kconfig
index da1aac68ab03..0f992bdf1a10 100644
--- a/sound/soc/sunxi/Kconfig
+++ b/sound/soc/sunxi/Kconfig
@@ -12,7 +12,7 @@ config SND_SUN4I_CODEC
 config SND_SUN8I_CODEC
 	tristate "Allwinner SUN8I audio codec"
 	depends on OF
-	depends on MACH_SUN8I || COMPILE_TEST
+	depends on MACH_SUN8I || (ARM64 && ARCH_SUNXI) || COMPILE_TEST
 	select REGMAP_MMIO
 	help
 	  This option enables the digital part of the internal audio codec for
-- 
2.19.0
