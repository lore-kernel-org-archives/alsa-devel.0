From: Trent Piepho <tpiepho@gmail.com>
Subject: Re: [PATCH 4/4] ASoC: fsl: make fsl_ssi driver
 compilable on ARM/IMX
Date: Thu, 23 Feb 2012 14:01:20 -0500
Message-ID: <CA+7tXigQ=R3-b0jiFJF3rmBRQS4RM77Z9Thq2pkE2yrs03NYWw@mail.gmail.com>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
	<1330008519-3584-1-git-send-email-shawn.guo@linaro.org>
	<1330008519-3584-5-git-send-email-shawn.guo@linaro.org>
	<4F465A33.3020208@ru.mvista.com> <4F465EE5.4010908@freescale.com>
	<20120223165242.GB22562@n2100.arm.linux.org.uk>
	<4F4671BB.7060409@freescale.com>
	<20120223171407.GC22562@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 020AD24360
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2012 20:01:20 +0100 (CET)
Received: by wera1 with SMTP id a1so1053678wer.38
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2012 11:01:20 -0800 (PST)
In-Reply-To: <20120223171407.GC22562@n2100.arm.linux.org.uk>
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
Cc: alsa-devel@alsa-project.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Shawn Guo <shawn.guo@linaro.org>, Timur Tabi <timur@freescale.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 23, 2012 at 12:14 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Feb 23, 2012 at 11:04:59AM -0600, Timur Tabi wrote:
>> Russell King - ARM Linux wrote:
>> We almost never use readl. =A0I see that it is used in some places, but
>> honestly I can't see how it can be valid. =A0For instance, the mpic driv=
er
>> uses it in mpic_startup_ht_interrupt(). =A0I don't understand how that's
>> valid, since there's nothing preventing the readl() from happening
>> *before* the writeb.
>
> That just sounds broken. =A0If readl() can happen before a writeb() issued
> in program order, how do most of the PCI drivers work?

I was under the impression that on powerpc io memory was mapped
cache-inhibited and guarded, which provides most ordered, but not
store to load ordering without an additional synchronization
instruction.  See
http://cache.freescale.com/files/32bit/doc/app_note/AN3441.pdf on page
8.

PCI adds some additional complexity, since the PCI device is not
connected directly to the CPU.  One must consider the actions of the
PCI host controller.
