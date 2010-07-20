From: Stefan Schoenleitner <dev.c0debabe@gmail.com>
Subject: Re: underruns and POLLERR when copying audio frames
Date: Wed, 21 Jul 2010 00:50:15 +0200
Message-ID: <4C462827.10105@gmail.com>
References: <4C4581D9.8020309@gmail.com> <4C45A77B.4070802@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from keymachine.tbmn.org (mail.tbmn.org [87.118.84.39])
	by alsa0.perex.cz (Postfix) with ESMTP id DA40B2436E
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Jul 2010 00:50:18 +0200 (CEST)
In-Reply-To: <4C45A77B.4070802@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> Stefan Schoenleitner wrote:
>> I have some code that basically captures audio frames from one device
>> and then writes it for playback to another device.
> 
> How do you synchronize the clocks of both devices?

I don't.
One device is a regular sound-card, while the other one is actually a
speech processing plugin.
The output of the plugin is sent over a network to a remote host, where
the frames are being processed by the plugin once again and then played
back on the sound-card there.
I guess if clock drift gets too high, I will get xruns as well ?

>> Ideally mmapped IO could be used for such a task,
> 
> Why would mmap be more ideal?

I though that it would be possible to use mmapping to "connect" sound
devices together in a way that read/write operations in between are no
longer necessary.

I.e. instead of

soundcard device (read/write) <-- application (read/write) --> plugin
device (read/write)

it would be

soundcard device (read/write) <-- application (direct mapping) -->
plugin (read/write)

Thus each time one devices writes, it would actually *write through* to
the destination device without the need for any additional code in between.
But as mmapping just seems to work for files, I no longer think it is
possible.


>> My idea would be to just increment avail_min to something bigger, so
>> that more frames are being buffered before playback starts.
>> Would this work ?
> 
> Yes; to avoid underruns, try to have buffer as full as possible, and try
> to use a bigger buffer.  However, this will increase latency.
> 
> To avoid overruns in the capture device, use a bigger buffer, which will
> _not_ increase latency.

Can you explain to me why a bigger capture buffer will not introduce
latency ?
IMHO if there is a large capture buffer, then the sound-card will need
to capture until the buffer is filled.
Once this is the case, the application can start to read from the
capture device.
Hence the latency introduced would depend on the size of the capture
buffer, right ?

>> 2. Another idea would be to do some buffering on my own in the application.
> 
> This is bascially the same as the first idea, except that you have to
> manage this buffer yourself.  This might be worthwile if the devices do
> not have big enough buffers.

Hmm, ok.
It seems that at least one of my devices only supports a small avail_min
setting.
So I could either set avail_min to a high value on the device that
allows it, but still have a low value on the other device that does not
support large buffers.
Or I could just use FIFO buffering and do everything on my own.

E.g. when capturing I would wait until let's say at least 10 periods are
in my buffer.
Once this is the case, I will start to drain the buffer (by playing back
 periods) and at the same time refill the FIFO by capturing new ones.

Maybe the best solution will be to just try it out ;)

cheers,
stefan
