From: "Pierre-Louis Bossart" <pierre-louis.bossart@linux.intel.com>
Subject: Re: USB Audio questions
Date: Tue, 16 Aug 2011 10:38:21 -0500
Message-ID: <35257.63821458$1313509116@news.gmane.org>
References: <1313432124-22591-1-git-send-email-lars@metafoo.de>	<1313432124-22591-2-git-send-email-lars@metafoo.de>	<000001cc5b8a$4a6577c0$df306740$@bossart@linux.intel.com>
	<4E4A100D.9020302@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id D376C244A0
	for <alsa-devel@alsa-project.org>;
	Tue, 16 Aug 2011 17:38:23 +0200 (CEST)
In-Reply-To: <4E4A100D.9020302@ladisch.de>
Content-Language: en-us
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Clemens Ladisch' <clemens@ladisch.de>
Cc: 'Sarah Sharp' <sarah.a.sharp@linux.intel.com>, 'ALSA Development Mailing List' <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

> For playback, we know how many bytes we had submitted, so we could
> derive the current position from the USB frame counter, but for
> capture,
> we don't know the precise byte count until the HCD has looked at the
> descriptors.
>
> > Isn't there a direct way to query the usb core to know how many bytes
> > have been transmitted and make the hw_ptr/delay information
> independent
> > of the urb buffer size?
> 
> No, this information isn't returned earlier than the completion
> callback.

I am lost here, bear with my ignorance of USB... What is this USB frame
counter and what would to enable its use, at least for playback where there
is scope for lots of power optimizations.
 
> Why more efficient?  You cannot avoid double-buffering when a USB
> packet
> wraps around the end of the ALSA ring buffer.

What I had in mind is a case where the ring buffer is divided in separate
periods, which would each correspond to an integer number of URBs/packets.
This way there is _never_ a case of wrap-around and no need for memcpys.
It's probably less generic than the current driver but a whole lot
simpler/efficient.

> > - The period information is not updated when the urbs are allocated.
> In my
> > case the period specified was 25ms, but with all the approximations
> the
> > actual period (number of urbs*buffer_size_per_urb) was 24ms.
> 
> Please note that URBs are usually not completely filled.  For playback,
> the driver makes URBs shorter so that they end as nearly as possible on
> or after a period boundary; for capture, we cannot predict sample
> counts,
> so the driver just uses one URB per ms.

Well I am precisely preaching for filling the URBs as much as possible to
make things simpler for cases where latency doesn't matter. Of course for
capture/speech cases latency does matter and I understand the need to do
things differently there.
-Pierre
