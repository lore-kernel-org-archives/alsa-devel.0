From: Jan Depner <eviltwin69@cableone.net>
Subject: Re: alsa timer slippage
Date: 14 Dec 2003 08:38:51 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1071412731.10990.11.camel@eviltwin>
References: <200312141335.00239.cannam@all-day-breakfast.com>
	<1071410558.10990.3.camel@eviltwin>
	<200312141434.59757.cannam@all-day-breakfast.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200312141434.59757.cannam@all-day-breakfast.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Chris Cannam <cannam@all-day-breakfast.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Multiple soundcards usually have to use word clock or some proprietary
method of syncing the cards.  Usually one card will be the master and
the others slaves.  I know you can put up to 4 ST Audio DSP24 cards in
one system and set one up as master.  I believe the same is true for the
M-Audio Delta 1010.

As for having a bad timer on a system, I've worked a lot with realtime
systems and sometimes you just get a lemon.

Jan


On Sun, 2003-12-14 at 08:34, Chris Cannam wrote:
> On Sunday 14 Dec 2003 2:02 pm, Jan Depner wrote:
> > If I'm not mistaken the timing for your audio is coming from your
> > sound card not your system clock.
> 
> Is that so?  Obvious though it is, that simply hadn't occurred to me.
> 
> I mentally ruled out a hardware problem quite early on because I 
> wasn't seeing this problem when using a low-latency kernel on the 
> same hardware -- but maybe I just hadn't done enough testing with the 
> low-latency kernel.  I'll give it another shot.
> 
> The other points that brings to mind are, what if you have more than 
> one soundcard or no soundcard at all (only say USB devices)? and what 
> if the soundcard's just a chip on the motherboard, as mine is -- 
> wouldn't it get its own timing from the system clock?  It's plausible 
> that this crappy i810 could have a crappy timer, though this example 
> would be unusually crappy.
> 
> 
> Chris
> 




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
