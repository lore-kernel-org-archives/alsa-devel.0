From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Hardware audio decoder driver design
Date: Thu, 28 Jul 2011 18:05:47 +0200
Message-ID: <4E3188DB.9040706@ladisch.de>
References: <201107281910.10535@zigzag.lvk.cs.msu.su>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 3ABBA244E7
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Jul 2011 18:02:09 +0200 (CEST)
In-Reply-To: <201107281910.10535@zigzag.lvk.cs.msu.su>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Nikita V. Youshchenko" <yoush@cs.msu.su>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Nikita V. Youshchenko wrote:
> > Nikita V. Youshchenko wrote:
> > > If not going into details, that devices reads A52-encoded stream
> > > from system memory, and writes raw pcm stream to system memory.
> > >
> > > Simplest thing to do is - implement a character device, where
> > > user-space will write encoded stream, and from where user-space will
> > > read decoded stream.
> > >
> > > However, perhaps a better architecture (e.g. in-kernel intergation
> > > with an audio sink) is possible?
> >
> > One of the implicit assumptions of ALSA sound devices is that they run
> > in real time, and at a constant bit rate.  As far as I can tell, your
> > device would be 'just' a DSP, so a character device would be
> > appropriate.
> 
> But there is such thing as 'ac3 passthrough' - to make use of hardware ac3
> decoders on sound cards that have this feature.

It's more intended to be used to transport AC-3 data over a S/PDIF cable
where the decoder is _not_ in the computer itself.

> I was thinking that something similar could be done for 'our device +
> standard alsa driver' combination - to make use of existing software using
> that interface.

This would be possible, but it would result in a userspace ALSA plugin
that still has to access your device with some private API.

Building a kernel driver with virtual playback/capture devices would
be harder because there isn't an official API to access other sound
devices in kernel space.  (However, the OSS emulation has some sample
format conversion plugins that do something like this.)


Regards,
Clemens
