From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Channel mapping
Date: Thu, 22 Nov 2007 09:55:27 +0100
Message-ID: <1195721727.28149.1222698051@webmail.messagingengine.com>
References: <20071120005151.GA25276@tango.0pointer.de>
	<s5hr6ijhljj.wl%tiwai@suse.de>
	<1195658261.9272.1222564051@webmail.messagingengine.com>
	<Pine.LNX.4.61.0711211621310.8325@tm8103.perex-int.cz>
	<1195660340.16225.1222569047@webmail.messagingengine.com>
	<s5h8x4rwqy1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 03608243E1
	for <alsa-devel@alsa-project.org>; Thu, 22 Nov 2007 09:55:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h8x4rwqy1.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Lennart Poettering <mznyfn@0pointer.de>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Clemens Ladisch wrote:
> > Jaroslav Kysela wrote:
> > > We can also encode PCM device / subdevice numbers to data structure. But
> > > I think that best way is to extend channel_info PCM ioctl (create new 
> > > version and emulate old one - it should be quite easy to implement).
> > 
> > The channel_info ioctl returns only information about one channel.
> 
> OTOH, it's simple and easy to parse.  But, certainly TLV is more
> flexible for additional metadata.
> 
> > I think we should have a more flexible ioctl that also allows us to
> > describe the PCM device itself (such as volume controls that affect
> > all channels, or latency information).
> 
> Indeed, the mixer <-> PCM mapping can be useful.  For such
> information, the fixed size struct isn't suitable as multiple mixer
> elements correspond to a single PCM channel.

Okay, we already have the control's (sub)device fields for that ...

> BTW, what latency information do you have in mind?

How long it takes audio data to travel through the device, probably
DSP processing time + group delay.  I doubt that this value will be
known in many cases, or that applications will care.


It seems at the moment there isn't any information except the channel
order that is of interest to applications, so extended channel_info
would suffice for now.  I'm just concerned that there will be more
information in the future and that using TLV will prepare us for that.


Regards,
Clemens
