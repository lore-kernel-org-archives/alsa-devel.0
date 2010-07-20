From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: underruns and POLLERR when copying audio frames
Date: Tue, 20 Jul 2010 15:41:15 +0200
Message-ID: <4C45A77B.4070802@ladisch.de>
References: <4C4581D9.8020309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 1A35510390B
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Jul 2010 15:41:37 +0200 (CEST)
In-Reply-To: <4C4581D9.8020309@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stefan Schoenleitner <dev.c0debabe@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Stefan Schoenleitner wrote:
> I have some code that basically captures audio frames from one device
> and then writes it for playback to another device.

How do you synchronize the clocks of both devices?

> Ideally mmapped IO could be used for such a task,

Why would mmap be more ideal?

> My idea would be to just increment avail_min to something bigger, so
> that more frames are being buffered before playback starts.
> Would this work ?

Yes; to avoid underruns, try to have buffer as full as possible, and try
to use a bigger buffer.  However, this will increase latency.

To avoid overruns in the capture device, use a bigger buffer, which will
_not_ increase latency.

> 2. Another idea would be to do some buffering on my own in the application.

This is bascially the same as the first idea, except that you have to
manage this buffer yourself.  This might be worthwile if the devices do
not have big enough buffers.


Regards,
Clemens
