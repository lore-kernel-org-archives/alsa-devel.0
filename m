From: Chris Cannam <cannam@all-day-breakfast.com>
Subject: Re: alsa timer slippage
Date: Sun, 14 Dec 2003 18:54:25 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200312141854.25649.cannam@all-day-breakfast.com>
References: <200312141335.00239.cannam@all-day-breakfast.com> <1071410558.10990.3.camel@eviltwin> <200312141434.59757.cannam@all-day-breakfast.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200312141434.59757.cannam@all-day-breakfast.com>
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

On Sunday 14 Dec 2003 2:34 pm, Chris Cannam wrote:
> On Sunday 14 Dec 2003 2:02 pm, Jan Depner wrote:
> > If I'm not mistaken the timing for your audio is coming from your
> > sound card not your system clock.
>
> [...] what if you have more
> than one soundcard or no soundcard at all

And of course I can trivially test that by disabling my soundcard in 
modules.conf.  So I did, and now I have no cards (at least, that's 
what /proc/asound/cards says) and yet the queue timer test program 
still runs and the queue timer still goes screwy.

So it's not a problem with the soundcard, unless ALSA is magically 
sync'ing from a soundcard I haven't told it about.


Chris



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
