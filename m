From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 15/20] ASoC: fsl: make fsl_ssi driver
	compilable on	ARM/IMX
Date: Tue, 6 Mar 2012 12:25:16 +0000
Message-ID: <20120306122516.GH17370@n2100.arm.linux.org.uk>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
	<1330788001-10158-16-git-send-email-shawn.guo@linaro.org>
	<4F53F704.8080703@freescale.com>
	<20120304232817.GA13516@n2100.arm.linux.org.uk>
	<4F53FBA1.8090200@freescale.com>
	<20120305000411.GL7363@n2100.arm.linux.org.uk>
	<4F54053F.9070502@freescale.com>
	<20120305002635.GA23798@opensource.wolfsonmicro.com>
	<20120306104015.GF17370@n2100.arm.linux.org.uk>
	<20120306120646.GH19635@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 6208B1044CF
	for <alsa-devel@alsa-project.org>; Tue,  6 Mar 2012 13:25:32 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20120306120646.GH19635@opensource.wolfsonmicro.com>
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

On Tue, Mar 06, 2012 at 12:06:47PM +0000, Mark Brown wrote:
> On Tue, Mar 06, 2012 at 10:40:15AM +0000, Russell King - ARM Linux wrote:
> > On Mon, Mar 05, 2012 at 12:26:36AM +0000, Mark Brown wrote:
> > > On Mon, Mar 05, 2012 at 12:13:52AM +0000, Tabi Timur-B04825 wrote:
> 
> > > > To answer your question: I was lead to believe that the individual ALSA 
> > > > callback functions are atomic.  So one thread should not be trying to 
> > > > start playback while another thread is simultaneously trying to stop it.
> 
> > > That's correct, there's ALSA level locking.
> 
> > Please explain which lock prevents the capture substream trigger callback
> > occuring simultaneously with a playback substream trigger callback on a
> > SMP system.
> 
> Oh, bother - that one is per substream not per stream.  Which isn't
> terribly helpful.

It's actually entirely right that the core shouldn't take care of this:
it's entirely possible that drivers do not have any dependencies between
the two substreams and so they should not be exposed to enforced exclusivity
between the actions of two substreams in multiprocessor systems.

Please also note that in ALSA documentation, an 'atomic' callback means
little with respect to race conditions.  All it means is that the callback
is called from a context where sleeping in the callback is not permitted.
The documentation does not say what is protected by the ALSA spinlocks and
mutexes, so without reviewing the ALSA code, driver writters have little
idea whether they need their own locks or not.
