From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Use of start_frame in usbusx2yaudio.c
Date: Wed, 12 May 2010 14:51:52 +0200
Message-ID: <4BEAA468.7030606@ladisch.de>
References: <20100512051058.GA32459@xanatos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id A202A243FD
	for <alsa-devel@alsa-project.org>;
	Wed, 12 May 2010 14:51:59 +0200 (CEST)
In-Reply-To: <20100512051058.GA32459@xanatos>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>, Karsten Wiese <fzu@wemgehoertderstaat.de>
Cc: alsa-devel@alsa-project.org, Christoph Lameter <cl@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>, Tejun Heo <tj@kernel.org>
List-Id: alsa-devel@alsa-project.org

Sarah Sharp wrote:
> Are there any drivers in the kernel that set urb->start_frame on every
> URB?
> 
> Could those drivers handle it if only the first URB they submitted to
> the host controller was scheduled for that frame ID, and all the rest of
> the URBs were scheduled ASAP?
> 
> I see there are three drivers that set start_frame (while not setting
> URB_ISO_ASAP):
>  - drivers/isdn/hisax/st5481_d.c
>  - drivers/usb/core/devio.c
>  - sound/usb/usx2y/usbusx2yaudio.c
> 
> I'm not really sure what usbusx2yaudio.c is doing.  I think when one URB
> completes, it sets the next URB's start_frame to the previous URB's
> start_frame plus the number of URBs (2 by default) times the number of
> packets (4 by default).  Isn't this basically like setting URB_ISO_ASAP?

For an audio driver, anything except ASAP (or the equivalent computation)
would not make sense because then there would be a gap in the audio
output.

> What is usbusx2yaudio.c attempting to do?  I've tried to get an overall
> picture of what it expects the isochronous scheduling to look like, but
> I'm finding the driver a bit hard to read.

AFAIK it just wants a continuous stream of packets, like the other
audio drivers.

> I really can't tell what fall back method is if this submission fails.

So I guess xHCI does not support start_frame?  A few other, seldom-used
HC drivers get away with silently ignoring start_frame:

ohci-hcd.c:             /* yes, only URB_ISO_ASAP is supported, and
                         * urb->start_frame is never used as input.
                         */
ehci-sched.c: /* NOTE: assumes URB_ISO_ASAP, to limit complexity/bugs */
 

Regards,
Clemens
