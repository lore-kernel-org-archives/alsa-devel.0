From: Adam Tla/lka <atlka@pg.gda.pl>
Subject: Re: How to lock the sample rate ?
Date: Sat, 6 Mar 2004 15:05:42 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040306140542.GM25734@sunrise.pg.gda.pl>
References: <20040306115426.6b48eaaf.pochini@shiny.it> <Pine.LNX.4.58.0403061157220.1881@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403061157220.1881@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, Mar 06, 2004 at 11:59:45AM +0100, Jaroslav Kysela wrote:
> On Sat, 6 Mar 2004, Giuliano Pochini wrote:
> 
> > On the Echoaudio cards the sample rate is a global setting, so I need a way
> > to prevent an app to change the rate if someone else already set it (the
> > card han several devices/subdevices). I was thinking to put a simple
> > "if (IsAudioOpen()) rate_min=rate_max=current_rate;" in pcm_open callback,
> > but this solution is racy.
Talking about race conditions you could use a variable which is set to 0
at the beginning. Now if app wants to set a rate it does atomic compare
and increase (cmpxchg on  x86) instruction so only one app could set
rate. The other could only read memorized rate settins and report an
error if rate is different.

Regards
-- 
Adam Tla/lka      mailto:atlka@pg.gda.pl    ^v^ ^v^ ^v^
System  & Network Administration Group           ~~~~~~
Computer Center,  Gdansk University of Technology, Poland
PGP public key:   finger atlka@sunrise.pg.gda.pl


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
