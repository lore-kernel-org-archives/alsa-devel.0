From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 15/20] ASoC: fsl: make fsl_ssi driver
	compilable on	ARM/IMX
Date: Sun, 4 Mar 2012 23:28:17 +0000
Message-ID: <20120304232817.GA13516@n2100.arm.linux.org.uk>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
	<1330788001-10158-16-git-send-email-shawn.guo@linaro.org>
	<4F53F704.8080703@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id D9B6A243FB
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 00:28:33 +0100 (CET)
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
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

Is the SCR shared between capture and playback?  In that case, what
makes this read-modify-write thread safe?
