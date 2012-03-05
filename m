From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH 15/20] ASoC: fsl: make fsl_ssi driver
 compilable on ARM/IMX
Date: Mon, 5 Mar 2012 00:13:52 +0000
Message-ID: <4F54053F.9070502@freescale.com>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
	<1330788001-10158-16-git-send-email-shawn.guo@linaro.org>
	<4F53F704.8080703@freescale.com>
	<20120304232817.GA13516@n2100.arm.linux.org.uk>
	<4F53FBA1.8090200@freescale.com>
	<20120305000411.GL7363@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
	by alsa0.perex.cz (Postfix) with ESMTP id BF17B2441D
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 01:14:01 +0100 (CET)
In-Reply-To: <20120305000411.GL7363@n2100.arm.linux.org.uk>
Content-Language: en-US
Content-ID: <BB732B2A1B410D49817102D08D7D67A3@mgd.freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Russell King - ARM Linux wrote:
> On Sun, Mar 04, 2012 at 11:32:50PM +0000, Tabi Timur-B04825 wrote:
>> Russell King - ARM Linux wrote:
>>> Is the SCR shared between capture and playback?  In that case, what
>>> makes this read-modify-write thread safe?
>>
>> What's "SCR"?
>
> I assumed you knew the code you were commenting on.
>
>                  clrbits32(&ssi->scr, CCSR_SSI_SCR_SSIEN);
>
> The register these functions seem to be used on appears to be called
> 'SCR'.

Oh, I didn't know you were referencing a specific register on the part. 
There are multiple uses of clrsetbits_be32 (and its variants) in the function.

To answer your question: I was lead to believe that the individual ALSA 
callback functions are atomic.  So one thread should not be trying to 
start playback while another thread is simultaneously trying to stop it.

> Why do you say "can't" - what prevents it?  If nothing, then this stuff
> is buggy when preempt is enabled, or you're running on SMP.

Sorry, let me rephrase the sentence to be more clear.

"You can't have two threads attempt to initialize the hardware at the same 
time, and expect it to work."

Since I expect ALSA callback functions to be atomic, I'm not concerned 
about one two threads trying to use SCR at the same time.

-- 
Timur Tabi
Linux kernel developer at Freescale
