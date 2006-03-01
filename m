From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [RFC][PATCH] Transparent network support through
 polypaudio
Date: Wed, 01 Mar 2006 09:32:45 +0100
Message-ID: <20060301083245.GB6381@turing.informatik.uni-halle.de>
References: <43F09D76.9060004@cendio.se>
 <20060214094741.GA8943@turing.informatik.uni-halle.de>
 <1141186155.5860.91.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate2.urz.uni-halle.de (mailgate2.urz.uni-halle.de [141.48.3.8])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0C9B01CA
	for <alsa-devel@alsa-project.org>; Wed,  1 Mar 2006 09:36:22 +0100 (MET)
In-reply-to: <1141186155.5860.91.camel@mindpipe>
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
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> I still get smoother playback with OSS emulation than mplayer's ALSA
> driver.  I think it's because the ALSA driver resets the stream on
> xruns:
> 
> alsa-space: xrun of at least 862.101 msecs. resetting stream3% 7 0                                    
> 
> This seems like a waste of CPU - after all there's nothing we can do but
> drop frames if I'm trying to play a movie that my CPU can't quite
> handle.  Shouldn't mplayer just ignore xruns?

Yes, it should.  And it does in the CVS version; the last is horribly
outdated.


Regards,
Clemens


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
