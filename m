From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: alsa timer slippage
Date: 14 Dec 2003 17:14:02 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1071450839.4688.18.camel@cmn19.stanford.edu>
References: <200312141335.00239.cannam@all-day-breakfast.com>
	 <1071410558.10990.3.camel@eviltwin>
	 <200312141434.59757.cannam@all-day-breakfast.com>
	 <200312141448.21384.cannam@all-day-breakfast.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200312141448.21384.cannam@all-day-breakfast.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Chris Cannam <cannam@all-day-breakfast.com>
Cc: Jan Depner <eviltwin69@cableone.net>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 2003-12-14 at 06:48, Chris Cannam wrote:
> On Sunday 14 Dec 2003 2:34 pm, Chris Cannam wrote:
> > On Sunday 14 Dec 2003 2:02 pm, Jan Depner wrote:
> > > If I'm not mistaken the timing for your audio is coming from your
> > > sound card not your system clock.
> >
> > [...]
> > I mentally ruled out a hardware problem quite early on because I
> > wasn't seeing this problem when using a low-latency kernel on the
> > same hardware -- but maybe I just hadn't done enough testing with
> > the low-latency kernel.  I'll give it another shot.
> 
> No, definitely no such problem visible when using the CCRMA kernel.

Or maybe it is just 10 times smaller. The Planet CCRMA kernel is
compiled with HZ=1000 (instead of the normal HZ=100). 

-- Fernando




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
