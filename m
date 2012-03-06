From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 15/20] ASoC: fsl: make fsl_ssi driver
	compilable on	ARM/IMX
Date: Tue, 6 Mar 2012 10:40:15 +0000
Message-ID: <20120306104015.GF17370@n2100.arm.linux.org.uk>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
	<1330788001-10158-16-git-send-email-shawn.guo@linaro.org>
	<4F53F704.8080703@freescale.com>
	<20120304232817.GA13516@n2100.arm.linux.org.uk>
	<4F53FBA1.8090200@freescale.com>
	<20120305000411.GL7363@n2100.arm.linux.org.uk>
	<4F54053F.9070502@freescale.com>
	<20120305002635.GA23798@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 70A861040C4
	for <alsa-devel@alsa-project.org>; Tue,  6 Mar 2012 11:40:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20120305002635.GA23798@opensource.wolfsonmicro.com>
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

On Mon, Mar 05, 2012 at 12:26:36AM +0000, Mark Brown wrote:
> On Mon, Mar 05, 2012 at 12:13:52AM +0000, Tabi Timur-B04825 wrote:
> 
> > To answer your question: I was lead to believe that the individual ALSA 
> > callback functions are atomic.  So one thread should not be trying to 
> > start playback while another thread is simultaneously trying to stop it.
> 
> That's correct, there's ALSA level locking.

Please explain which lock prevents the capture substream trigger callback
occuring simultaneously with a playback substream trigger callback on a
SMP system.

Thanks.
