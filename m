From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: PCM driver only plays tiny portion of clip
Date: Tue, 28 Feb 2006 18:08:24 +0100
Message-ID: <20060228170824.GA24675@turing.informatik.uni-halle.de>
References: <44054.217.150.108.178.1141056426.squirrel@newgolddream.dyndns.info>
 <20060227172601.GA446@turing.informatik.uni-halle.de>
 <40613.217.150.108.178.1141061722.squirrel@newgolddream.dyndns.info>
 <20060228073049.GA4158@turing.informatik.uni-halle.de>
 <35384.217.150.108.178.1141117853.squirrel@newgolddream.dyndns.info>
 <20060228145541.GA20876@turing.informatik.uni-halle.de>
 <47411.217.150.108.178.1141139656.squirrel@newgolddream.dyndns.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate2.urz.uni-halle.de (mailgate2.urz.uni-halle.de [141.48.3.8])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 27B3F194
	for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2006 18:08:30 +0100 (MET)
In-reply-to: <47411.217.150.108.178.1141139656.squirrel@newgolddream.dyndns.info>
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
> On Tue, 28 February, 2006 2:55 pm, Clemens Ladisch wrote:
> > Dumping something into /dev/dsp should work.  It may use the wrong
> > sample format, but if the first part of the file can be heard, the rest
> > should play OK, too.
> 
> I am at something of a loss though.
> 
> I admit that my dma code as it is today won't work properly - the dma
> transfer function tries to fill the whole of the ring buffer everytime it
> is called. But it is only being called once - which is the real problem! I
> can fix the dma issue I am sure, but it is not the blockage at the moment.

Where is the source code of your driver?


Regards,
Clemens


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
