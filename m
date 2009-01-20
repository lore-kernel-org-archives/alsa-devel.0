From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Misusing snd_pcm_avail_update()
Date: Tue, 20 Jan 2009 19:48:25 +0100
Message-ID: <49761C79.8060605@ladisch.de>
References: <20090120025727.GA30499@tango.0pointer.de>	<49758B71.8090605@ladisch.de>
	<20090120142614.GA27494@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 99700103822
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 19:52:47 +0100 (CET)
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 1940323536B
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 13:48:27 -0500 (EST)
Received: from [10.1.2.151] (srv004.schk01.int.dmc-one.com [85.232.8.141])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8D9F131FA4
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 13:48:26 -0500 (EST)
In-Reply-To: <20090120142614.GA27494@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Lennart Poettering wrote:
> Particularly with USB I experience that right after the device is
> started data is read much much faster from the playback buffer than
> expected. This feels as if the USB driver would at the beginning take
> all data from the playback buffer and copy it to some other buffer
> which was previously completely empty. Then after that second buffer
> is filled up the copying slows down to the expected speed.

Yes, the USB driver uses double-buffering, and the initial queueing of
data for the USB controller is done at faster rate, to reduce the
startup latency.

The size of the second buffer is about one period, but never more
than 64 ms.

> I currently deal with this by always halving the first wakeup time --
> which works most of the time but is a hack.

In theory, you could deduce this behaviour from
snd_pcm_hw_params_is_double(), but the USB driver forgets to set this
flag.

> With the function I suggest I'd be able to explicitly query how much
> time I have before I need to wake up.

I was thinking about a function that returns the hardware's block size
(i.e., the precision of the avail/delay values), but that wouldn't be
able to describe this behaviour of the USB driver.  I think I might just
remove this feature.

> > Well, you could make the "some extra margin" above larger than one
> > period.
>
> To save power I want to disable interrupts from the sound cards as
> much as possible.

In some cases (unusal hardware, but also USB), the period size affects
the block size, i.e., smaller periods give better timing precision.

For this case, it might be useful to make the "pointer precision" a
hardware parameter that can be restricted by an interval, like the other
parameters.


Best regards,
Clemens
