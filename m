From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: PCM driver only plays tiny portion of clip
Date: Tue, 28 Feb 2006 08:30:49 +0100
Message-ID: <20060228073049.GA4158@turing.informatik.uni-halle.de>
References: <44054.217.150.108.178.1141056426.squirrel@newgolddream.dyndns.info>
 <20060227172601.GA446@turing.informatik.uni-halle.de>
 <40613.217.150.108.178.1141061722.squirrel@newgolddream.dyndns.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate2.urz.uni-halle.de (mailgate2.urz.uni-halle.de [141.48.3.8])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5AB2019C
	for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2006 08:31:38 +0100 (MET)
In-reply-to: <40613.217.150.108.178.1141061722.squirrel@newgolddream.dyndns.info>
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
> On Mon, 27 February, 2006 5:26 pm, Clemens Ladisch wrote:
> > ALSA will notice that something has been played when the return value of
> > the pointer callback changes.
> 
> And what happens then? ie what will the alsa subsystem do when that
> changes (as it certainly will be duting the playback as it cycles through
> the buffer)

When an interrupt occurs (that is, when it calls
snd_pcm_period_elapsed()), ALSA calls the pointer callback.  A different
return value indicates that there is some free space in the buffer, so
ALSA wakes up the application so that it can write more data.


HTH
Clemens


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
