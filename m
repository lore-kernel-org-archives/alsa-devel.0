From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [RFC][PATCH] Transparent network support through
	polypaudio
Date: Wed, 01 Mar 2006 12:00:37 -0500
Message-ID: <1141232437.5860.103.camel@mindpipe>
References: <43F09D76.9060004@cendio.se>
	 <20060214094741.GA8943@turing.informatik.uni-halle.de>
	 <1141186155.5860.91.camel@mindpipe>
	 <20060301083245.GB6381@turing.informatik.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from viper.oldcity.dca.net (viper.oldcity.dca.net [216.158.38.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 901EF1C9
	for <alsa-devel@alsa-project.org>; Wed,  1 Mar 2006 18:00:40 +0100 (MET)
In-Reply-To: <20060301083245.GB6381@turing.informatik.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2006-03-01 at 09:32 +0100, Clemens Ladisch wrote:
> Lee Revell wrote:
> > I still get smoother playback with OSS emulation than mplayer's ALSA
> > driver.  I think it's because the ALSA driver resets the stream on
> > xruns:
> > 
> > alsa-space: xrun of at least 862.101 msecs. resetting stream3% 7 0                                    
> > 
> > This seems like a waste of CPU - after all there's nothing we can do but
> > drop frames if I'm trying to play a movie that my CPU can't quite
> > handle.  Shouldn't mplayer just ignore xruns?
> 
> Yes, it should.  And it does in the CVS version; the last is horribly
> outdated.

Thanks for taking this on!  Mplayer's ALSA support was so bad for so
long, I had given up...

Lee



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
