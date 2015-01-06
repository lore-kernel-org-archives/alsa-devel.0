From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH 1/3] ASoC: rt5670: fix bit definition for
	ASRC control
Date: Tue, 6 Jan 2015 02:08:45 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D70103ABE3@RTITMBSV03.realtek.com.tw>
References: <1481c597e90b5daacce80a021fa0c513a7a2ec6d.1420451186.git.mengdong.lin@intel.com>
 <20150105181714.GA2634@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id C1BD726042F
 for <alsa-devel@alsa-project.org>; Tue,  6 Jan 2015 03:08:52 +0100 (CET)
In-Reply-To: <20150105181714.GA2634@sirena.org.uk>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, "mengdong.lin@intel.com" <mengdong.lin@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Tuesday, January 06, 2015 2:17 AM
> To: mengdong.lin@intel.com
> Cc: alsa-devel@alsa-project.org; Bard Liao
> Subject: Re: [PATCH 1/3] ASoC: rt5670: fix bit definition for ASRC control
> 
> On Mon, Jan 05, 2015 at 05:48:15PM +0800, mengdong.lin@intel.com
> wrote:
> > From: Bard Liao <bardliao@realtek.com>
> >
> > This patch fixes bit definitions for two ASRC control registers 0x84 and
> 0x85.
> 
> This appears to do something more or different to fixing definitions - if it
> was fixing I'd expect to see equal numbers of lines added and removed in
> blocks identical apart from some numbers but this appears to be adding
> some new definitions like these...

Maybe we should call redefine rather than fix. The previous definition of
registers 0x84 and 0x85 doesn't match the register's description. To make
the code more readable, we would like to rewrite the definition of registers
0x84 and 0x85.

> 
> > +/* ASRC clock source selection (0x84, 0x85) */
> > +#define RT5670_CLK_SEL_SYS			(0x0)
> > +#define RT5670_CLK_SEL_I2S1_ASRC		(0x1)
> > +#define RT5670_CLK_SEL_I2S2_ASRC		(0x2)
> > +#define RT5670_CLK_SEL_I2S3_ASRC		(0x3)
> > +#define RT5670_CLK_SEL_SYS2			(0x5)
> > +#define RT5670_CLK_SEL_SYS3			(0x6)
> 
> ...among other things, and this block here:

The description above is the same for all ASRC blocks. To save code size,
we define it in a separate part.
If we define it in each ASRC block, it would be something like
+#define RT5670_DA_STO_CLK_SEL_MASK		(0xf << 12)
+#define RT5670_DA_STO_CLK_SEL_SFT		12
+#define RT5670_DA_STO_CLK_SEL_SYS		(0 << 12)
+#define RT5670_DA_STO_CLK_SEL_I2S1_ASRC	(1 << 12)
+#define RT5670_DA_STO_CLK_SEL_I2S2_ASRC	(2 << 12)
+#define RT5670_DA_STO_CLK_SEL_I2S3_ASRC	(3 << 12)
+#define RT5670_DA_STO_CLK_SEL_ SYS2		(5 << 12)
+#define RT5670_DA_STO_CLK_SEL_ SYS3		(6 << 12)
And same thing for other ASRC blocks.

> 
> >  /* ASRC Control 2 (0x84) */
> > -#define RT5670_MDA_L_M_MASK			(0x1 << 15)
> > -#define RT5670_MDA_L_M_SFT			15
> > -#define RT5670_MDA_L_M_NOR			(0x0 << 15)
> > -#define RT5670_MDA_L_M_ASYN			(0x1 << 15)
> > -#define RT5670_MDA_R_M_MASK			(0x1 << 14)
> > -#define RT5670_MDA_R_M_SFT			14
> > -#define RT5670_MDA_R_M_NOR			(0x0 << 14)
> > -#define RT5670_MDA_R_M_ASYN			(0x1 << 14)
> > -#define RT5670_MAD_L_M_MASK			(0x1 << 13)
> > -#define RT5670_MAD_L_M_SFT			13
> > -#define RT5670_MAD_L_M_NOR			(0x0 << 13)
> > -#define RT5670_MAD_L_M_ASYN			(0x1 << 13)
> > -#define RT5670_MAD_R_M_MASK			(0x1 << 12)
> > -#define RT5670_MAD_R_M_SFT			12
> > -#define RT5670_MAD_R_M_NOR			(0x0 << 12)
> > -#define RT5670_MAD_R_M_ASYN			(0x1 << 12)
> > -#define RT5670_ADC_M_MASK			(0x1 << 11)
> > -#define RT5670_ADC_M_SFT			11
> > -#define RT5670_ADC_M_NOR			(0x0 << 11)
> > -#define RT5670_ADC_M_ASYN			(0x1 << 11)
> > -#define RT5670_STO_DAC_M_MASK			(0x1 << 5)
> > -#define RT5670_STO_DAC_M_SFT			5
> > -#define RT5670_STO_DAC_M_NOR			(0x0 << 5)
> > -#define RT5670_STO_DAC_M_ASYN			(0x1 << 5)
> > -#define RT5670_I2S1_R_D_MASK			(0x1 << 4)
> > -#define RT5670_I2S1_R_D_SFT			4
> > -#define RT5670_I2S1_R_D_DIS			(0x0 << 4)
> > -#define RT5670_I2S1_R_D_EN			(0x1 << 4)
> > -#define RT5670_I2S2_R_D_MASK			(0x1 << 3)
> > -#define RT5670_I2S2_R_D_SFT			3
> > -#define RT5670_I2S2_R_D_DIS			(0x0 << 3)
> > -#define RT5670_I2S2_R_D_EN			(0x1 << 3)
> > -#define RT5670_PRE_SCLK_MASK			(0x3)
> > -#define RT5670_PRE_SCLK_SFT			0
> > -#define RT5670_PRE_SCLK_512			(0x0)
> > -#define RT5670_PRE_SCLK_1024			(0x1)
> > -#define RT5670_PRE_SCLK_2048			(0x2)
> > +#define RT5670_DA_STO_CLK_SEL_MASK		(0xf << 12)
> > +#define RT5670_DA_STO_CLK_SEL_SFT		12
> > +#define RT5670_DA_MONOL_CLK_SEL_MASK		(0xf << 8)
> > +#define RT5670_DA_MONOL_CLK_SEL_SFT		8
> > +#define RT5670_DA_MONOR_CLK_SEL_MASK		(0xf << 4)
> > +#define RT5670_DA_MONOR_CLK_SEL_SFT		4
> > +#define RT5670_AD_STO1_CLK_SEL_MASK		(0xf << 0)
> > +#define RT5670_AD_STO1_CLK_SEL_SFT		0
> 
> removes a lot more things than it adds, with different names too.

The previous definition is totally wrong, so we just remove it and
write a new definition for it.

> 
> ------Please consider the environment before printing this e-mail.
