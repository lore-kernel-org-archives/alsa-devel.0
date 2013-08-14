From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Buffer size for ALSA USB PCM audio
Date: Wed, 14 Aug 2013 20:34:36 +0200
Message-ID: <520BCDBC.2060507@ladisch.de>
References: <Pine.LNX.4.44L0.1308131659320.897-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 1C5C5261AE8
 for <alsa-devel@alsa-project.org>; Wed, 14 Aug 2013 20:35:09 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.44L0.1308131659320.897-100000@iolanthe.rowland.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Takashi Iwai <tiwai@suse.de>, Eldad Zack <eldad@fogrefinery.com>, USB list <linux-usb@vger.kernel.org>, alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Alan Stern wrote:
> On Mon, 12 Aug 2013, Alan Stern wrote:
>> Here's a revised version of the patch (still untested).  The difference
>> is that this version tries always to keep a period's worth of bytes in
>> the USB hardware queue.  This will provide better protection against
>> underruns when the period is larger than the queue's minimum
>> requirement.
>
> After more thought, I decided that patch does too much.  It's not
> necessary to keep track of the number of packets.  Instead, the driver
> should always try to keep as much data in the USB hardware queue as it
> is allowed to.

This is what the current code does (i.e., re-submitting all URBs in
their completion handler).

> In other words, there should be enough URBs so that an entire ALSA
> buffer can be queued at any time, subject only to the limit on the
> maximum number of URBs and packets.

The URB queue adds latency, so it should never be made too big, even
for big ALSA buffers.  Once we have reached a queue length that is
practically guaranteed to be safe from underruns, more URBs do not make
sense.  (The current limit of 24 ms is somewhat arbitrary.)

> It doesn't make sense to allocate just enough URBs to cover a single
> period.

Indeed.  I've used two periods in my recent patch, but I don't really
know how I would justify this choice in the commit message.  ;-)

What doesn't make sense either is the current algorithm that computes
a specific value for the total number of packets (total_packs) and then
takes great care to allocate the URBs so that this number is reached,
even if this means that the number of packets per URBs varies.

And while we're at it: the default number of packets per URB was chosen
before the driver had the ability to estimate the delay from the current
frame number; it should now be quite safe to increase it.


Regards,
Clemens
