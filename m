From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: how to use mcbsp for i2s?
Date: Thu, 2 Apr 2009 19:56:53 +0300
Message-ID: <20090402195653.0bcfb59e.jhnikula@gmail.com>
References: <fb44c3530904011129s7dd5cf1fgcf266fac3fb059d3@mail.gmail.com>
	<bd7b27490904020048h672ce810j3c79868a7f5ef4e0@mail.gmail.com>
	<bd7b27490904020320i714cd812i49bd834676ce4dee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="Multipart=_Thu__2_Apr_2009_19_56_53_+0300_OCGZiXCSMdXq4.P8"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f166.google.com (mail-ew0-f166.google.com
	[209.85.219.166])
	by alsa0.perex.cz (Postfix) with ESMTP id 5FDE6103877
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Apr 2009 18:57:04 +0200 (CEST)
Received: by ewy10 with SMTP id 10so671819ewy.32
	for <alsa-devel@alsa-project.org>; Thu, 02 Apr 2009 09:57:03 -0700 (PDT)
In-Reply-To: <bd7b27490904020320i714cd812i49bd834676ce4dee@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Ernesto Torres <skullmate@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--Multipart=_Thu__2_Apr_2009_19_56_53_+0300_OCGZiXCSMdXq4.P8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Apr 2009 13:20:36 +0300
Jarkko Nikula <jhnikula@gmail.com> wrote:

> > Grrr... cannot find the hack, I'm too keen to delete temporary
> > hacks. I was
> pretty sure I had
> it somewhere.
> 
> Basically it was adding necessary pin multiplexing configuration into
> arch/arm/plat-omap/include/mach/mux.h and arch/arm/mach-omap2/mux.c
> and then using omap_cfg_reg(...) in omap3beagle.c to change pin
> configuration from
> GPIOs to McBPS[1 | 3] pins.
> 
Yes, I found it. Hack attached :-)

Now I don't have here Beagle to test but hack still applies on top of
linux-omap. Then you will need CONFIG_OMAP_MUX=y and following lines
into omap3beagle.c or board-omap3beagle.c.

omap_cfg_reg(AF6_3430_MCBSP3_DX);
omap_cfg_reg(AE6_3430_MCBSP3_DR);
omap_cfg_reg(AF5_3430_MCBSP3_CLKX);
omap_cfg_reg(AE5_3430_MCBSP3_FSX);


Jarkko

--Multipart=_Thu__2_Apr_2009_19_56_53_+0300_OCGZiXCSMdXq4.P8
Content-Type: text/x-diff;
 name="0001-ARM-OMAP-Hack-add-some-OMAP3-McBSP-muxing.patch"
Content-Disposition: attachment;
 filename="0001-ARM-OMAP-Hack-add-some-OMAP3-McBSP-muxing.patch"
Content-Transfer-Encoding: 7bit

>From 01d684991c9683383dd78df61328e67c6f593ad5 Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula@nokia.com>
Date: Thu, 9 Oct 2008 15:28:02 +0300
Subject: [PATCH] ARM: OMAP: Hack add some OMAP3 McBSP muxing

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 arch/arm/mach-omap2/mux.c             |   52 +++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/mux.h |   29 ++++++++++++++++++
 2 files changed, 81 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index dacb41f..1dff09e 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -261,6 +261,58 @@ static struct pin_config __initdata_or_module omap34xx_pins[] = {
  *		mux-mode | [active-mode | off-mode]
  */
 
+/* Primary McBSP multiplexing */
+MUX_CFG_34XX("Y21_3430_MCBSP1_CLKR", 0x18c,
+		OMAP34XX_MUX_MODE0)
+MUX_CFG_34XX("AA21_3430_MCBSP1_FSR", 0x18e,
+		OMAP34XX_MUX_MODE0)
+MUX_CFG_34XX("Y21_3430_MCBSP1_DX", 0x190,
+		OMAP34XX_MUX_MODE0)
+MUX_CFG_34XX("U21_3430_MCBSP1_DR", 0x192,
+		OMAP34XX_MUX_MODE0)
+MUX_CFG_34XX("T21_3430_MCBSP1_CLKS", 0x194,
+		OMAP34XX_MUX_MODE0)
+MUX_CFG_34XX("K26_3430_MCBSP1_FSX", 0x196,
+		OMAP34XX_MUX_MODE0)
+MUX_CFG_34XX("W21_3430_MCBSP1_CLKX", 0x198,
+		OMAP34XX_MUX_MODE0)
+
+MUX_CFG_34XX("P21_3430_MCBSP2_FSX", 0x13c,
+		OMAP34XX_MUX_MODE0)
+MUX_CFG_34XX("N21_3430_MCBSP2_CLKX", 0x13e,
+		OMAP34XX_MUX_MODE0)
+MUX_CFG_34XX("R21_3430_MCBSP2_DR", 0x140,
+		OMAP34XX_MUX_MODE0)
+MUX_CFG_34XX("M21_3430_MCBSP2_DX", 0x142,
+		OMAP34XX_MUX_MODE0)
+
+MUX_CFG_34XX("AF6_3430_MCBSP3_DX", 0x16c,
+		OMAP34XX_MUX_MODE0)
+MUX_CFG_34XX("AE6_3430_MCBSP3_DR", 0x16e,
+		OMAP34XX_MUX_MODE0)
+MUX_CFG_34XX("AF5_3430_MCBSP3_CLKX", 0x170,
+		OMAP34XX_MUX_MODE0)
+MUX_CFG_34XX("AE5_3430_MCBSP3_FSX", 0x172,
+		OMAP34XX_MUX_MODE0)
+
+MUX_CFG_34XX("AE1_3430_MCBSP4_CLKX", 0x184,
+		OMAP34XX_MUX_MODE0)
+MUX_CFG_34XX("AD1_3430_MCBSP4_DR", 0x186,
+		OMAP34XX_MUX_MODE0)
+MUX_CFG_34XX("AD2_3430_MCBSP4_DX", 0x188,
+		OMAP34XX_MUX_MODE0)
+MUX_CFG_34XX("AC1_3430_MCBSP4_FSX", 0x18a,
+		OMAP34XX_MUX_MODE0)
+
+MUX_CFG_34XX("AF10_3430_MCBSP5_CLKX", 0x5d8,
+		OMAP34XX_MUX_MODE1)
+MUX_CFG_34XX("AE11_3430_MCBSP5_DR", 0x5e4,
+		OMAP34XX_MUX_MODE1)
+MUX_CFG_34XX("AH9_3430_MCBSP5_FSX", 0x5e6,
+		OMAP34XX_MUX_MODE1)
+MUX_CFG_34XX("AF13_3430_MCBSP5_DX", 0x5e8,
+		OMAP34XX_MUX_MODE1)
+
 /* 34xx I2C */
 MUX_CFG_34XX("K21_34XX_I2C1_SCL", 0x1ba,
 		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
diff --git a/arch/arm/plat-omap/include/mach/mux.h b/arch/arm/plat-omap/include/mach/mux.h
index f4362b8..c0cfa73 100644
--- a/arch/arm/plat-omap/include/mach/mux.h
+++ b/arch/arm/plat-omap/include/mach/mux.h
@@ -677,6 +677,35 @@ enum omap24xx_index {
 };
 
 enum omap34xx_index {
+	/* Primary McBSP multiplexing */
+	Y21_3430_MCBSP1_CLKR,
+	AA21_3430_MCBSP1_FSR,
+	Y21_3430_MCBSP1_DX,
+	U21_3430_MCBSP1_DR,
+	T21_3430_MCBSP1_CLKS,
+	K26_3430_MCBSP1_FSX,
+	W21_3430_MCBSP1_CLKX,
+
+	P21_3430_MCBSP2_FSX,
+	N21_3430_MCBSP2_CLKX,
+	R21_3430_MCBSP2_DR,
+	M21_3430_MCBSP2_DX,
+
+	AF6_3430_MCBSP3_DX,
+	AE6_3430_MCBSP3_DR,
+	AF5_3430_MCBSP3_CLKX,
+	AE5_3430_MCBSP3_FSX,
+
+	AE1_3430_MCBSP4_CLKX,
+	AD1_3430_MCBSP4_DR,
+	AD2_3430_MCBSP4_DX,
+	AC1_3430_MCBSP4_FSX,
+
+	AF10_3430_MCBSP5_CLKX,
+	AE11_3430_MCBSP5_DR,
+	AH9_3430_MCBSP5_FSX,
+	AF13_3430_MCBSP5_DX,
+
 	/* 34xx I2C */
 	K21_34XX_I2C1_SCL,
 	J21_34XX_I2C1_SDA,
-- 
1.5.6.5


--Multipart=_Thu__2_Apr_2009_19_56_53_+0300_OCGZiXCSMdXq4.P8
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Multipart=_Thu__2_Apr_2009_19_56_53_+0300_OCGZiXCSMdXq4.P8--
