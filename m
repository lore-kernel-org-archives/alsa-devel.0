From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Testers of M-Audio Delta/Audiophile cards wanted
Date: Fri, 20 Sep 2002 11:08:10 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D8AE57A.D59A47DF@ladisch.de>
References: <Pine.LNX.4.21.0209191715140.595-100000@summer.quitte>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Tim Goetze <tim@quitte.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Tim Goetze wrote:
> Takashi Iwai wrote:
> 
> >At Thu, 19 Sep 2002 17:06:08 +0200 (CEST),
> >Tim Goetze wrote:
> >>
> >> much simpler. you did a c++ style auto variable allocation, declare
> >> 'ak' at the start of snd_ice1712_ews_init and it compiles cleanly.
> >
> >oops, never noticed that.  i relied too much upon the compiler.
> >well, this means that gcc-3.2 accepts this style as normal C...?
> 
> strange that 3.2 isn't ANSI C compliant here.

3.2 _is_ ANSI C compliant here. ("ANSI C" being C99 in this case :-)

I wanted to use mixed declarations and code in my drivers, too, but
there are too many users out there using 2.95.x.


HTH
Clemens


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
