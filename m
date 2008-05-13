From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: 2.6.26-rc1 regression: ISA DMA broken (bisected)
Date: Tue, 13 May 2008 19:33:25 +0200
Message-ID: <4829D0E5.8050905@keyaccess.nl>
References: <4823AAF2.7070102@keyaccess.nl>	<s5hzlr0105c.wl%tiwai@suse.de>	<200805131059.32911.bjorn.helgaas@hp.com>
	<20080513180107.1a3893f1@core>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.tilbu1.nb.home.nl (smtpq2.tilbu1.nb.home.nl
	[213.51.146.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 63BA724B61
	for <alsa-devel@alsa-project.org>;
	Tue, 13 May 2008 19:32:11 +0200 (CEST)
In-Reply-To: <20080513180107.1a3893f1@core>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>, Glauber Costa <gcosta@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Pete Clements <clem@clem.clem-digital.net>, Bjorn Helgaas <bjorn.helgaas@hp.com>
List-Id: alsa-devel@alsa-project.org

On 13-05-08 19:01, Alan Cox wrote:

> On Tue, 13 May 2008 10:59:32 -0600
> Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> 
>> On Friday 09 May 2008 12:06:55 am Takashi Iwai wrote:
>>> Thanks for catching it.  Yeah, the patch looks buggy.  We had an
>>> implicit assumption that dev = NULL for ISA devices that require 24bit
>>> DMA.
>> Naive question #1:  Why don't we have a struct device for these
>> ISA devices?  PNP builds a struct device with DMA_24BIT_MASK
>> for ISAPNP devices.
> 
> Because nobody has done the needed work to get all the old ISA drivers
> converted. I guess isa_device would actually be a platform_device
> wrapper ?

No, isa_device is its own thing, on its own isa_bus (*). It has a struct 
device * readily available though...

Rene

(*) drivers/base/isa.c, and explanatory changelog at:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=a5117ba7da37deb09df5eb802dace229b3fb1e9f
