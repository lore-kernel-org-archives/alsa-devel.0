From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: PCM driver only plays tiny portion of clip
Date: Tue, 28 Feb 2006 15:55:41 +0100
Message-ID: <20060228145541.GA20876@turing.informatik.uni-halle.de>
References: <44054.217.150.108.178.1141056426.squirrel@newgolddream.dyndns.info>
 <20060227172601.GA446@turing.informatik.uni-halle.de>
 <40613.217.150.108.178.1141061722.squirrel@newgolddream.dyndns.info>
 <20060228073049.GA4158@turing.informatik.uni-halle.de>
 <35384.217.150.108.178.1141117853.squirrel@newgolddream.dyndns.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate2.urz.uni-halle.de (mailgate2.urz.uni-halle.de [141.48.3.8])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 40D7314B
	for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2006 15:56:01 +0100 (MET)
In-reply-to: <35384.217.150.108.178.1141117853.squirrel@newgolddream.dyndns.info>
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
> On Tue, 28 February, 2006 7:30 am, Clemens Ladisch wrote:
> > When an interrupt occurs (that is, when it calls
> > snd_pcm_period_elapsed()), ALSA calls the pointer callback.  A different
> > return value indicates that there is some free space in the buffer, so
> > ALSA wakes up the application so that it can write more data.
> 
> This (application writing more data) doesn't seem to be happening in my case.
> 
> I am using oss emulation and a simple car command ie cat somefile.wav >
> /dev/dsp - should I expect this to work, or do I really need to compile
> something like sox (does sox use the native alsa if)?

Dumping something into /dev/dsp should work.  It may use the wrong
sample format, but if the first part of the file can be heard, the rest
should play OK, too.


HTH
Clemens


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
