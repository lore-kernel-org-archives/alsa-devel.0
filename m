From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 15/20] ASoC: fsl: make fsl_ssi driver
 compilable on ARM/IMX
Date: Mon, 5 Mar 2012 15:39:32 +0800
Message-ID: <20120305073930.GC16232@S2101-09.ap.freescale.net>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
	<1330788001-10158-16-git-send-email-shawn.guo@linaro.org>
	<4F53F704.8080703@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 120FB103EDC
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 08:25:05 +0100 (CET)
Received: by iakh37 with SMTP id h37so5499492iak.38
	for <alsa-devel@alsa-project.org>; Sun, 04 Mar 2012 23:25:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4F53F704.8080703@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Mar 04, 2012 at 11:13:09PM +0000, Tabi Timur-B04825 wrote:
> Shawn Guo wrote:
> > +#ifdef PPC
> > +#define read_ssi(addr)		in_be32(addr)
> > +#define write_ssi(val, addr)	out_be32(addr, val)
> > +#elif defined ARM
> > +#define read_ssi(addr)		readl(addr)
> > +#define write_ssi(val, addr)	writel(val, addr)
> > +#endif
> 
> Can you also add an ARM version of clrsetbits_be32()?  Something like this:
> 
> #ifdef PPC
> #define read_ssi(addr)		in_be32(addr)
> #define write_ssi(val, addr)	out_be32(addr, val)
> #define write_ssi_mask(addr, clear, set)	clrsetbits_be32(addr, clear, set)
> #elif defined ARM
> #define read_ssi(addr)		readl(addr)
> #define write_ssi(val, addr)	writel(val, addr)
> #define write_ssi_mask(addr, clear, set) \
> 	{ u32 __val; \
> 	val = readl(&ssi->scr); \
> 	val = (val & ~(clear) | (set); \
> 	writel(val, addr)
> #endif
> 
Yeah, it makes the diff neat.  However I would make it an inline
function which is easier to play.

#ifdef PPC
#define read_ssi(addr)                   in_be32(addr)
#define write_ssi(val, addr)             out_be32(addr, val)
#define write_ssi_mask(addr, clear, set) clrsetbits_be32(addr, clear, set)
#elif defined ARM
#define read_ssi(addr)                   readl(addr)
#define write_ssi(val, addr)             writel(val, addr)
static inline void write_ssi_mask(void __iomem *addr, u32 clear, u32 set)
{
        u32 val = readl(addr);
        val = (val & ~clear) | set;
        writel(val, addr);
}
#endif

-- 
Regards,
Shawn
