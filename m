From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: PCM driver only plays tiny portion of clip
Date: Mon, 27 Feb 2006 18:26:01 +0100
Message-ID: <20060227172601.GA446@turing.informatik.uni-halle.de>
References: <44054.217.150.108.178.1141056426.squirrel@newgolddream.dyndns.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate2.urz.uni-halle.de (mailgate2.urz.uni-halle.de [141.48.3.8])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F3313196
	for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2006 18:26:10 +0100 (MET)
In-reply-to: <44054.217.150.108.178.1141056426.squirrel@newgolddream.dyndns.info>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Adrian McMenamin wrote:
> How do I let my driver know that it has played a period and therefore it
> needs to load more into the buffer?
> 
> At the moment the following seems to be happening:
> 
> Create buffer in DMA space in main CPU addressed area
>     |
>     |
> Transfer contents of buffer into memory space of sound chip via DMA
>     |
>     |
> Start playback
>     |
>     |
> Fire interrupt for period played
> 
> Then it gets stuck in a loop ? the interrupt is fired and handled but
> nothing else seems to happen.

ALSA will notice that something has been played when the return value of
the pointer callback changes.

What are the contents of /proc/asound/card0/pcm0p/sub0/* while it's
playing?


Regards,
Clemens


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
