From: Tom Watson <sdc695@yahoo.com>
Subject: Re: More than stereo (4 channels in my case)
Date: Wed, 30 Apr 2003 02:25:59 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030430092559.85371.qmail@web21502.mail.yahoo.com>
References: <s5h1xzmzrtz.wl@alsa2.suse.de>
Reply-To: tsw@johana.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h1xzmzrtz.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--- Takashi Iwai <tiwai@suse.de> wrote:
> At Sun, 27 Apr 2003 01:02:49 -0700 (PDT),
> Tom Watson wrote:
> > 
> > In a related project I used OSS (even paid for it) and got did a
> > program that played 4 channel sound files (of my own making).  On
> that
> > project I had a CMI sound chip (CMI 8738).  To get the thing to
> work
> > properly (the back two playback channels on the "line in" jack, I
> > needed to have a special mixer control set, and used ossmix to do
> the
> > job "ossmix misc.rear2lin on".
>  
> you can toggle this via alsamixer on the fly.
> check alsa-kernel/Documentation/CMIPCI.txt for details.

WOW!!  Documentation.  This is VERY helpful for getting the settings
right for the mixer controls.  In particular, it explains the "copy
front to rear" (oss: misc.4spk) and "rear output is line in jack"
(oss:misc.rear2lin).

> 
> > Fast forward to my current configuration:  VIA SouthBridge chip
> audio,
> > VT8233 (Vendor 1106, Device 3059, Rev 50, from /sbin/lspci).  I'd
> like
> > to do the same thing.  Now I've read quite a few of the examples
> and my
> > attempts to make some sense out of 'amixer' and 'aplay' are
> frustrating
> > me quite a bit.  I've got 0.9.2 alsa, and a couple of problems:
> > 1)  The sound in the right channel has a lot of hash.  One time
> (god
> > knows what I did) it seemed to play OK.  I'm using 44.1 kHz sample
> > files (if that makes a difference), since the source code seems to
> want
> > 48kHz (or so I surmise).
> 
> it looks like a bug of AWARD BIOS.
> i'll put a workaround soon to cvs.

Just curious, what was/is the problem??  Somehow I could get it to come
and go.

> 
> > 2)  The rear channels are nowhere to be found.  I suspect that I
> need
> > to turn on some switch in the mixer, but which one is becoming a
> > mystery to me.
> 
> the multi-channel is supported on the second pcm device.  the first
> pcm device is so-called "direct sound" pcm, and supports up to 4
> playbacks at the same time but only for two channels.
> 
> for 4-channel output, there is no special configuration.
> (you need to adjust "Surround" volumes, though.)
> depending on the board, you might need to toggle some switches to
> configure the line-in as rear output.

OK, this is nice, but I'd like to know how to shift them using the
'amixer' program.  Is there an equivalent set of documentation like the
CMI8738 documentation (CMPPCI.txt) that explains the mixer controls as
detailed.  Also, why aren't the mixer controls (these are both AC'97
audio goodies) similar for similar functions.  This would be a GREAT
bonus, as the command line stuff could go from platform to platform.

> 
> > Eventually I'll be moving to a different sound card (a Turtle Beach
> > Santa Cruz), then another one. I suspect that some of the same
> problems
> > might continue, so I'd like to solve them here first.  Any/all
> > suggestions would be welcome.
> 
> is it cs46xx?  then it should work.  just raise the surround volume
> as
> above.

Yup, it is a cs46xx chip, ought to be OK.  I have yet to try it though.
  That's next on the list.

> 
> > p.s.  While I will convert to alsa, will the OSS stuff work in
> > emulation??  Will I have similar controls available like the
> > misc.rear2lin mentioned above??  Is there any way I can put them
> into
> > the OSS emulation stuff??  I'd be willing to do so.
> 
> so far, no.  using amixer (or alsamixer) wouldn't suffice?

Yes, it would.  My "problem" (yes I need to read more!!) is that the
OSS mixer command line control goodie (ossmix) was pretty simple to
understand.  The program 'amixer' while it does more is a bit more
difficult to understand.

By the way...  Just how does the mapping from alsa controls to oss
controls happen?  Is this unique for each chip, or a general thing??

Maybe if we have some knowledge of each it would be easier to
understand.
> 
> 
> Takashi
> 


Thanks so much.  All of this is very informative.

=====
-- 
Tom Watson
tsw@johana.com

__________________________________
Do you Yahoo!?
The New Yahoo! Search - Faster. Easier. Bingo.
http://search.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
