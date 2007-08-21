From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: problems writing pcm driver
Date: Wed, 22 Aug 2007 10:02:08 +1200
Message-ID: <46CB60E0.7000805@audioscience.com>
References: <Pine.LNX.4.58.0708201250360.30669@shell2.speakeasy.net>
	<s5hd4xhkytk.wl%tiwai@suse.de>
	<Pine.LNX.4.58.0708210907460.30669@shell2.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.clear.net.nz (smtp3.clear.net.nz [203.97.33.64])
	by alsa0.perex.cz (Postfix) with ESMTP id DF9951038A4
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Aug 2007 00:02:15 +0200 (CEST)
Received: from [192.168.1.4]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp3.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0JN500MRX97KXY20@smtp3.clear.net.nz> for
	alsa-devel@alsa-project.org; Wed, 22 Aug 2007 10:02:09 +1200 (NZST)
In-reply-to: <Pine.LNX.4.58.0708210907460.30669@shell2.speakeasy.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Trent Piepho <xyzzy@speakeasy.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Trent Piepho wrote:

>>> Suppose my period size is 256 frames and I'm doing audio capture.  If pointer
>>> is called before any DMA transfers have completed, do I return 0?  

yes

>>> Now suppose
>>> it's called after one period of audio has been DMAed into the buffer.  Do I
>>> return 255 or 256?  After two periods have been received, should I return 511
>>> or 0?

0 (assuming buffer size is 2 periods)

>> The pointer callback returns the position offset of the "ring
>> buffer".  It's not the period size.  Usually, a ring buffer consists
> 
> Suppose the ring buffer has 256 frames of valid data in it, from position 0
> to position 255.  Do I return 255 or 256?  It could be either one,
> depending on how your ring buffer operates.

The difference between the current and previous pointer values needs to
be the amount of new data (capture) in the buffer.  Given that the
pointer starts at zero,  you should return 256 in the above scenario.

> 
>> (snip)
>>> exited, it's called again.  What is the purpose of this?  Is it ok that
>>> I return the same value as the previous time it was called?
>> The pointer callback isn't necessarily to be so accurate, but it's
>> supposed to be fast.  Hence, yes, it's fine that you return the same
>> value as before unless updated via IRQ if the operation takes long
>> time.

> I have the pointer callback read a hardware register to get the number of
> frames transferred.  

Does this report partial periods (ie count 0,1,2,3,4 rather than 0,256,
etc).
If so, it is better to read the register in the pointer callback.
(unless as Takashi mentions, it is an expensive operation)

One scenario in general is that by the time the alsa core calls the
pointer callback, there is more than one period available. (with short
periods, scheduling delays)

> Maybe I should instead have the irq handler save this
> register in the chip struct, and just read the value from there in the
> pointer callback?  

It is OK to do it this way tpo.

> This means I have to use locking between the irq handler
> and the pointer callback, which I have been able to avoid so far.

?? probably not as long as you only read the cached value from the chip
struct once in the pointer callback.
However you might need locking to provide exclusive access to the
hardware if there are accesses that have to happen in sequence.
