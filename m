From: AthlonRob <athlonrob@data.4t3.com>
Subject: Re: Multiple Audio Streams
Date: 07 Oct 2002 17:44:44 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1034037884.7319.9.camel@duron>
References: <3D9F3D84.4040102@boom.org.il> <1033859918.1118.24.camel@duron>
	 <3DA15968.1000205@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3DA15968.1000205@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Sagi Bashari <sagi@boom.org.il>
List-Id: alsa-devel@alsa-project.org

On Mon, 2002-10-07 at 02:52, James Courtier-Dutton wrote:

> mypc: /proc/asound/card0/pcm0p# cat info

> subdevices_count: 1
> subdevices_avail: 1   <- This tells you how many streams the sound card 
> can handle in hardware at the same time.
> E.g. Only one application at a time can use the card.

Thanks, that does help some.  But, I fear the subdevice_count and avail
are only reporting the numbers that the driver supports... not the
number that the hardware itself supports.

At least, I hope so, because mine is reporting as 1 & 0 (I have esd
running).  :-)

> I also have a SB Live in another machine, the subdevices_avail is then 
> 32 because the SB Live can handle 32 streams at once in hardware.

I can probably scrounge up a SB Live if need be... maybe I'll do that so
I'm able to play multiple streams (if we can't get a better driver
written, that is).

> There are other applications/tools you can use, one of which is "JACK" 
> that allows for multiple audio streams mixed in software and lots of 
> other cool stuff.

Cool, I'll see if I can find some information about that.  I hadn't
heard of it before... is it GPL'd?

Rob



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
