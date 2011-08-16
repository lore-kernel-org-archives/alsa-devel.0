From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: USB Audio questions
Date: Tue, 16 Aug 2011 08:37:01 +0200
Message-ID: <4E4A100D.9020302@ladisch.de>
References: <1313432124-22591-1-git-send-email-lars@metafoo.de>	<1313432124-22591-2-git-send-email-lars@metafoo.de>
	<000001cc5b8a$4a6577c0$df306740$@bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 951CD245CD
	for <alsa-devel@alsa-project.org>;
	Tue, 16 Aug 2011 08:37:07 +0200 (CEST)
In-Reply-To: <000001cc5b8a$4a6577c0$df306740$@bossart@linux.intel.com>
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
> - Is there any good reason why the max number of packets per urb defaults to
> 8?

Not really.  It is an attempt to compromise between interrupt frequency
and the latency resulting from packet queueing.

> - Increasing the number of packets/urbs solves my power issue but not the
> synchronization issue. If I reduce the number of urbs to reduce the
> interrupt rate, then the accuracy of the hw_pointer is decreased big time
> and it becomes difficult to synchronize with video. The .pointer routine
> only keeps track of retired urbs, it seems there's no way to know how many
> samples were played at a given time?

Only the URB completion callback tells us about finished packets.

For playback, we know how many bytes we had submitted, so we could
derive the current position from the USB frame counter, but for capture,
we don't know the precise byte count until the HCD has looked at the
descriptors.

> Isn't there a direct way to query the usb core to know how many bytes
> have been transmitted and make the hw_ptr/delay information independent
> of the urb buffer size?

No, this information isn't returned earlier than the completion callback.

It would be nice to be able to tell the HCD to collect information about
all currently completed USB frames, regardless of whether the entire URB
has finished or whether its interrupt flag is set, but this would require
changes in all host controller drivers.  (I'm contemplating something
like this for FireWire, but there we have only one controller driver.)

> - Is there any reason why the driver relies on vmalloc and memcpy? It seems
> like using physically-contiguous memory would be more efficient, as done in
> the CAIQ driver?

Why more efficient?  You cannot avoid double-buffering when a USB packet
wraps around the end of the ALSA ring buffer.

> - The period information is not updated when the urbs are allocated. In my
> case the period specified was 25ms, but with all the approximations the
> actual period (number of urbs*buffer_size_per_urb) was 24ms.

Please note that URBs are usually not completely filled.  For playback,
the driver makes URBs shorter so that they end as nearly as possible on
or after a period boundary; for capture, we cannot predict sample counts,
so the driver just uses one URB per ms.


Regards,
Clemens
