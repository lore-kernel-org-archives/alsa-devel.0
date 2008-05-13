From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.26-rc1 regression: ISA DMA broken (bisected)
Date: Tue, 13 May 2008 18:01:07 +0100
Message-ID: <20080513180107.1a3893f1@core>
References: <4823AAF2.7070102@keyaccess.nl> <s5hzlr0105c.wl%tiwai@suse.de>
	<200805131059.32911.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lxorguk.ukuu.org.uk (unknown [81.2.110.250])
	by alsa0.perex.cz (Postfix) with ESMTP id 2107E24B4E
	for <alsa-devel@alsa-project.org>;
	Tue, 13 May 2008 19:11:36 +0200 (CEST)
In-Reply-To: <200805131059.32911.bjorn.helgaas@hp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Thomas@alsa-project.org, ALSA devel <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Linux Kernel <linux-kernel@vger.kernel.org>, Glauber Costa <gcosta@redhat.com>, Pete Clements <clem@clem.clem-digital.net>, Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
List-Id: alsa-devel@alsa-project.org

On Tue, 13 May 2008 10:59:32 -0600
Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:

> On Friday 09 May 2008 12:06:55 am Takashi Iwai wrote:
> > Thanks for catching it.  Yeah, the patch looks buggy.  We had an
> > implicit assumption that dev = NULL for ISA devices that require 24bit
> > DMA.
> 
> Naive question #1:  Why don't we have a struct device for these
> ISA devices?  PNP builds a struct device with DMA_24BIT_MASK
> for ISAPNP devices.

Because nobody has done the needed work to get all the old ISA drivers
converted. I guess isa_device would actually be a platform_device
wrapper ?
