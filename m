From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 15/20] ASoC: fsl: make fsl_ssi driver
	compilable on	ARM/IMX
Date: Tue, 6 Mar 2012 13:46:44 +0000
Message-ID: <20120306134644.GI17370@n2100.arm.linux.org.uk>
References: <4F53F704.8080703@freescale.com>
	<20120304232817.GA13516@n2100.arm.linux.org.uk>
	<4F53FBA1.8090200@freescale.com>
	<20120305000411.GL7363@n2100.arm.linux.org.uk>
	<4F54053F.9070502@freescale.com>
	<20120305002635.GA23798@opensource.wolfsonmicro.com>
	<20120306104015.GF17370@n2100.arm.linux.org.uk>
	<20120306120646.GH19635@opensource.wolfsonmicro.com>
	<20120306122516.GH17370@n2100.arm.linux.org.uk>
	<20120306123322.GP19635@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 3C1DA103CF9
	for <alsa-devel@alsa-project.org>; Tue,  6 Mar 2012 14:46:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20120306123322.GP19635@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shawn Guo <shawn.guo@linaro.org>, Tabi Timur-B04825 <B04825@freescale.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 06, 2012 at 12:33:22PM +0000, Mark Brown wrote:
> On Tue, Mar 06, 2012 at 12:25:16PM +0000, Russell King - ARM Linux wrote:
> 
> > Please also note that in ALSA documentation, an 'atomic' callback means
> > little with respect to race conditions.  All it means is that the callback
> > is called from a context where sleeping in the callback is not permitted.
> > The documentation does not say what is protected by the ALSA spinlocks and
> > mutexes, so without reviewing the ALSA code, driver writters have little
> > idea whether they need their own locks or not.
> 
> Well, who reads the documentation to get this stuff anyway?

Strangely, I do, and I'd bet most people writing an ALSA driver read
the "Writing an ALSA Driver" document, even though it's seven years old.
I also tend to read the code as well, though not everyone does.

> As you
> observe it's far from complete about what's what locked when and how so
> you need to go to the code to see what's actually going on, especially
> whenever you need to call back into the ALSA APIs.

The point is, during this thread I've had this 'atomic' business quoted
at me as the reason why read-modify-write of registers is safe.  That's
also proof that people other than me read that document - but not only
that, they then go on to misunderstand it and don't bother to read the
code.
