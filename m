From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] ALSA: usb: refine delay information with
 USB	frame counter
Date: Thu, 25 Aug 2011 16:07:50 +0200
Message-ID: <4E565736.4070600@ladisch.de>
References: <1314221197-23719-1-git-send-email-pierre-louis.bossart@linux.intel.com>
	<4E55FFA6.90506@ladisch.de>
	<002301cc632f$5bfe0a90$13fa1fb0$@bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 6DA332440C
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Aug 2011 16:07:51 +0200 (CEST)
In-Reply-To: <002301cc632f$5bfe0a90$13fa1fb0$@bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: 'Sarah Sharp' <sarah.a.sharp@linux.intel.com>, 'ALSA Development Mailing List' <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Pierre-Louis Bossart wrote:
> > > +	if (frame_diff < 0)
> > > +		frame_diff += 1024; /* handle 10-bit wrap-around */
> > 
> > After reading through some HCD source files, I deduced the following
> > wrap-arounds:
> > 
> > EHCI: 8-10 bits (default 9)
> > FHCI: 11 bits
> > IMX21: 16 bits
> > ISP1760: 10 bits
> > OHCI: 16 bits
> > OXU210HP: 10 bits
> > R8A66597: 10 bits
> > SL811: 5 bits(!?)
> > UHCI: 32 bits
> > xHCI: ?
> > 
> > As long as there isn't an API that tells us about the valid range of the
> > frame counter, we should probably mask off all except the lowest few bits.
> 
> If we only used the 8 least-significant bits, it'd still leave us with up to
> 256 ms. That should work I guess. But the SL811 with 5 bits is a problem,
> that makes 32ms, this is probably too low.

Sorry, I read the code wrong; that driver returns a 16-bit frame counter, it
just doesn't allow to schedule more than 32 frame AFAICT.  And that driver
doesn't support USB audio anyway, so 8 bits should be fine.


Regards,
Clemens
