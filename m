From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 15/20] ASoC: fsl: make fsl_ssi driver
	compilable on	ARM/IMX
Date: Tue, 6 Mar 2012 10:39:16 +0000
Message-ID: <20120306103916.GE17370@n2100.arm.linux.org.uk>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
	<1330788001-10158-16-git-send-email-shawn.guo@linaro.org>
	<4F53F704.8080703@freescale.com>
	<20120304232817.GA13516@n2100.arm.linux.org.uk>
	<4F53FBA1.8090200@freescale.com>
	<20120305000411.GL7363@n2100.arm.linux.org.uk>
	<4F54053F.9070502@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 6BC1010397D
	for <alsa-devel@alsa-project.org>; Tue,  6 Mar 2012 11:39:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4F54053F.9070502@freescale.com>
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

On Mon, Mar 05, 2012 at 12:13:52AM +0000, Tabi Timur-B04825 wrote:
> Russell King - ARM Linux wrote:
> > On Sun, Mar 04, 2012 at 11:32:50PM +0000, Tabi Timur-B04825 wrote:
> >> Russell King - ARM Linux wrote:
> >>> Is the SCR shared between capture and playback?  In that case, what
> >>> makes this read-modify-write thread safe?
> >>
> >> What's "SCR"?
> >
> > I assumed you knew the code you were commenting on.
> >
> >                  clrbits32(&ssi->scr, CCSR_SSI_SCR_SSIEN);
> >
> > The register these functions seem to be used on appears to be called
> > 'SCR'.
> 
> Oh, I didn't know you were referencing a specific register on the part. 
> There are multiple uses of clrsetbits_be32 (and its variants) in the function.
> 
> To answer your question: I was lead to believe that the individual ALSA 
> callback functions are atomic.  So one thread should not be trying to 
> start playback while another thread is simultaneously trying to stop it.

Atomic with respect to what though?  The substream?  The PCM?  All PCMs?
Reading through the code, it turns out that the answer is the PCM, so
calls into the low level driver are serialized by a per-PCM mutex.

However, this is not true of the trigger callback - the trigger callback
does not take this mutex, but instead takes a spinlock (or two.)  Whether
this is enough to stop the capture and playback substream triggers being
called simultaneously seems to depend on whether the substreams are part
of the same group (which they probably aren't.)

So, in theory you could have the trigger method being called for the
capture device while the playback device is in the middle of being opened.
Luckily, for this case, the startup method only touches the hardware if
its the first substream being opened, and shutdown only touches the
hardware if its the last substream being closed.

However, I'm left wondering whether two trigger callbacks, one for the
playback substream and one for the capture substream could be called
simultaneously on two different CPUs.  I see nothing which prevents
this happening.
