From: Martin Langer <martin-langer@gmx.de>
Subject: Re: Tascam US-224/428 MMC?
Date: Tue, 20 Jul 2004 20:05:12 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040720180512.GA527@tuba.home>
References: <33466.195.245.190.93.1089901175.squirrel@195.245.190.93> <7444.195.245.190.93.1090312112.squirrel@195.245.190.93>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <7444.195.245.190.93.1090312112.squirrel@195.245.190.93>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: alsa-devel@lists.sourceforge.net, annabellesgarden@yahoo.de, ws@seh.de
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 20, 2004 at 09:28:32AM +0100, Rui Nuno Capela wrote:
> Hi,
> 
> (I'm resending this as I suspect the previous one went into some
> blackhole; please forgive me for the waste :)

No blackhole, but it doesn't touch us122 users like me.

> I remember some time ago, while fighting to get some LEDs lighten up on my
> us224 from linux, it was then referred that us428control would possibly
> act as a MMC proxy or something like to it.
> 
> Then I was wondering if I could get my us224 to act like a "real" control
> surface with some linux DAW (i.e. ardour :), being able to effectively use
> the transport buttons, the jog wheeel, etc.
> 
> Are you guys having any luck with this issue? I'm assuming that us224 is
> the lil'sister of us428, and I'm guessing that the command control
> protocol is quite the same. Am I right?

comparing some log-files of usbsnoopy (or any similar program) should solve
it. But I, too, believe that 224/428 are nearly the same on a high level.

> So, all I want is about having my us224 to respond and react to MMC, and
> see some transport control LEDs blinking all the way up :)
> 
> Are there any efforts already being thought in this direction? If it's
> only a question of man-power I wouldn't mind to step in and go for it. I'd
> rather love to hear from you in the first place, nevertheless.

Well, my us122 has no controller stuff. I guess it's even impossible to fix
this with a more advanced firmware;-) But, go ahead and improve things. 
Your code is always welcome, except Karsten has already solved it;-)

BTW: I'm still searching an us224 user who wants to try out a free firmware
file ( http://www.langerland.de/us122/usx2y-fw-0.1b.tar.bz2 ). It works with
us122/us428, but us224 is still untested.


martin


-- 
                                     Living on earth may be expensive,
                   but it includes an annual free trip around the sun. 


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
