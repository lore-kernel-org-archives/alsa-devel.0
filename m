From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Handle large period size end-of-stream situation
Date: Wed, 03 Apr 2013 18:49:02 +0200
Message-ID: <515C5D7E.6000609@ladisch.de>
References: <515C459A.5070209@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 2D2CC265CBE
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2013 18:49:11 +0200 (CEST)
In-Reply-To: <515C459A.5070209@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Patrick Lai <plai@codeaurora.org>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Patrick Lai wrote:
> Data is transferred in chunk equal to period size.

Data is transferred in whatever chunk size the hardware uses.

The period size specifies when the hardware raises an interrupt.
If some application is blocking, this interrupt is the only mechanism
by which userspace is woken up.

> At the end of playback, there may not be enough audio data left in the
> music stream to fill entire period. If remaining audio data only takes
> up very small chunk of period, playback takes longer to stop. Given
> that period size I have to deal with is quite large, this problem is
> observed easily. If my understanding is correct, what is the standard/
> recommended way of handling end of stream case?

I guess you wouldn't ask if your hardware supported smaller periods? ;-)

Use non-blocking writes, and use some other timer to wait for the actual
data to be played.  (But if the hardware cannot report the current
playback position accurately, ALSA won't notice that the playback has
reached the end.)


Regards,
Clemens
