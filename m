From: Chris Cannam <cannam@all-day-breakfast.com>
Subject: Re: alsa timer slippage
Date: Sun, 14 Dec 2003 14:34:59 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200312141434.59757.cannam@all-day-breakfast.com>
References: <200312141335.00239.cannam@all-day-breakfast.com> <1071410558.10990.3.camel@eviltwin>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1071410558.10990.3.camel@eviltwin>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jan Depner <eviltwin69@cableone.net>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sunday 14 Dec 2003 2:02 pm, Jan Depner wrote:
> If I'm not mistaken the timing for your audio is coming from your
> sound card not your system clock.

Is that so?  Obvious though it is, that simply hadn't occurred to me.

I mentally ruled out a hardware problem quite early on because I 
wasn't seeing this problem when using a low-latency kernel on the 
same hardware -- but maybe I just hadn't done enough testing with the 
low-latency kernel.  I'll give it another shot.

The other points that brings to mind are, what if you have more than 
one soundcard or no soundcard at all (only say USB devices)? and what 
if the soundcard's just a chip on the motherboard, as mine is -- 
wouldn't it get its own timing from the system clock?  It's plausible 
that this crappy i810 could have a crappy timer, though this example 
would be unusually crappy.


Chris



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
