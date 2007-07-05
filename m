From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: default setting not fully working with new
	ALSA	device
Date: Thu, 05 Jul 2007 10:42:45 -0700
Message-ID: <1183657365.9416.114.camel@razman.gruemaster.com>
References: <200707041648.54926.PeterMatthias@web.de>
	<1183583611.9416.72.camel@razman.gruemaster.com>
	<200707051834.08729.PeterMatthias@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 4D4C4103859
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jul 2007 19:42:50 +0200 (CEST)
In-Reply-To: <200707051834.08729.PeterMatthias@web.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Matthias <PeterMatthias@web.de>
Cc: ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Try this patch.  It adds support for both ALC883 and HDMI ports on your
system.

Summary:  HDA-Intel - Add support for MSI K9AGM2-FIH motherboard

This patch adds support for the MSI K9AGM2-FIH on-board audio.

Signed off by
Tobin Davis <tdavis@dsl-only.net>

On Thu, 2007-07-05 at 18:34 +0200, Peter Matthias wrote:

> The Board is a MSI K9AGM2-FIH, Sockel AM2, ATI RS690G, mATX, PCIe
> 
> The script gave following output: 
> "Your ALSA information is located at http://pastebin.ca/604529"
> 
> Other drivers are statically linked in my kernel.
> 
> Thank you for your work! In case of any questions, contact me.
> 
> Peter
> 
> 
> Am Mittwoch, 4. Juli 2007 schrieben Sie:
> > Could you post the output from
> > http://bulletproof.servebeer.com/alsa/scripts/alsa-info.sh ?  This
> > script will give us more detailed information on what sound chip it is.
> > We will also need to know the brand of board, for the driver file.
> >
> > Thanks,
> >
> > Tobin
> >
> > On Wed, 2007-07-04 at 16:48 +0200, Peter Matthias wrote:
> > > Hello,
> > >
> > > I have got a 690G board with following lspic -nv output:
> > >
> > > 01:05.2 0403: 1002:7919
> > >         Subsystem: 1002:7919
> > >         Flags: bus master, fast devsel, latency 64, IRQ 19
> > >         Memory at fe9e8000 (64-bit, non-prefetchable) [size=16K]
> > >         Capabilities: [50] Power Management version 2
> > >         Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
> > > Enable-
> > >
> > > With the default setting, microphone does not work. With module
> > > parameter "modprobe -i snd-hda-intel model=6stack-dig" microphone works
> > > well. Please add to default setting. It was written in Linux Kernel
> > > documentation to report this issue here.
> > >
> > > Thank you,
> > > 	Peter
> > > _______________________________________________
> > > Alsa-devel mailing list
> > > Alsa-devel@alsa-project.org
> > > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
> 

-- 
Tobin Davis <tdavis@dsl-only.net>
