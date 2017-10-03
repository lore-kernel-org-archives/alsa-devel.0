From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: usb/sound/bcd2000: warning in bcd2000_init_device
Date: Tue, 3 Oct 2017 10:21:57 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1710031004160.1500-100000@iolanthe.rowland.org>
References: <s5ho9povfai.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
 by alsa0.perex.cz (Postfix) with SMTP id 31F422668F0
 for <alsa-devel@alsa-project.org>; Tue,  3 Oct 2017 16:21:58 +0200 (CEST)
In-Reply-To: <s5ho9povfai.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Andrey Konovalov <andreyknvl@google.com>, linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arvind Yadav <arvind.yadav.cs@gmail.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Dmitry Vyukov <dvyukov@google.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 3 Oct 2017, Takashi Iwai wrote:

> On Mon, 25 Sep 2017 14:39:51 +0200,
> Andrey Konovalov wrote:
> > 
> > Hi!
> > 
> > I've got the following report while fuzzing the kernel with syzkaller.
> > 
> > On commit e19b205be43d11bff638cad4487008c48d21c103 (4.14-rc2).
> > 
> > It seems that there's no check of the endpoint type.
> > 
> > usb 1-1: BOGUS urb xfer, pipe 1 != type 3
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 1846 at drivers/usb/core/urb.c:449
> 
> How is this bug triggered?  As it's syzkaller with QEMU, it looks
> hitting an inconsistent state the driver didn't expect (it sets the
> fixed endpoint), then USB-core detects the inconsistency and spews the
> kernel warning with stack trace.  If so, it's no serious problem as it
> appears.
> 
> Suppose my guess is right, I'm not sure what's the best way to fix
> this.  Certainly we can add more sanity check in the caller side.
> OTOH, I find the reaction of USB core too aggressive, it's not
> necessary to be dev_WARN() but a normal dev_err().
> Or I might be looking at a wrong place?

It's a dev_WARN because it indicates a potentially serious error in the 
driver: The driver has submitted an interrupt URB to a bulk endpoint.  
That may not sound bad, but the same check gets triggered if a driver 
submits a bulk URB to an isochronous endpoint, or any other invalid 
combination.

Most likely the explanation here is that the driver doesn't bother to
check the endpoint type because it expects the endpoint will always be
interrupt.  But that is not a safe strategy.  USB devices and their
firmware should not be trusted unnecessarily.

The best fix is, like you said, to add a sanity check in the caller.

Alan Stern
