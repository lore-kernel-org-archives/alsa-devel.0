From: Wolfgang Hesseler <wolf1122@gmx.net>
Subject: Re: Callback after a specified number of samples
Date: Mon, 30 Sep 2002 20:46:46 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D989C16.74A1@gmx.net>
References: <20020930145227.16640gmx1@mx003-rz3.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Paul Davis <pbd@op.net> wrote:
 
>    [ please forward to alsa-devel@lists.sourceforge.net. thanks. ]
> 
> >> however, it won't do what you want, because the resolution is limited
> >> to the interrupt frequency of the audio card, and for just about every
> >> interface out there, this is almost always a power of 2 value.
> >
> >Is this an Alsa design or a hardware limitation?
> 
> hardware limitation.
> 
> >> to put it another way, your approach is wrong :) syncing audio and
> >> video needs to be done differently. audio has a much higher frame
> >> rate, so use that as the basic time source, and simply redraw the
> >> screen at suitable intervals (preferably the vertical refresh
> >> interval), using the current audio "time" as a guide to what to draw.
> >
> >You think of polling snd_pcm_avail_update and drawing the picture when
> >the calculated number of samples have been played?
> 
> sure, if you want to burn 90-100% of your available CPU cycles on the
> poll.
> 
> look, the screen gets redrawn at most 80 times a second and regular
> video is at most 30 frames a second. that contrasts with the audio
> frame rate by 2 orders of magnitude. if you had a way to redraw the
> screen at the start of the vertical refresh cycle, you could maintain
> absolutely perfect sync without anything more than a way to ask "which
> audio frame is audible right now?", which ALSA provides.
> 
> unfortunately, as i understand it, X provides no way to do this
> without hacks and patches, so you have to settle for a given frame
> rate, timed by the kernel with usleep(2), and then do the same check
> on the current audible frame when you wake up to redraw the screen.
> 
> --p



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
