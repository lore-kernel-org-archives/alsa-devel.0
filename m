From: Tom Watson <sdc695@yahoo.com>
Subject: More than stereo (4 channels in my case)
Date: Sun, 27 Apr 2003 01:02:49 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030427080249.21484.qmail@web21504.mail.yahoo.com>
References: <1051378211.3087.7.camel@Jay>
Reply-To: tsw@johana.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1051378211.3087.7.camel@Jay>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

In a related project I used OSS (even paid for it) and got did a
program that played 4 channel sound files (of my own making).  On that
project I had a CMI sound chip (CMI 8738).  To get the thing to work
properly (the back two playback channels on the "line in" jack, I
needed to have a special mixer control set, and used ossmix to do the
job "ossmix misc.rear2lin on".

Fast forward to my current configuration:  VIA SouthBridge chip audio,
VT8233 (Vendor 1106, Device 3059, Rev 50, from /sbin/lspci).  I'd like
to do the same thing.  Now I've read quite a few of the examples and my
attempts to make some sense out of 'amixer' and 'aplay' are frustrating
me quite a bit.  I've got 0.9.2 alsa, and a couple of problems:
1)  The sound in the right channel has a lot of hash.  One time (god
knows what I did) it seemed to play OK.  I'm using 44.1 kHz sample
files (if that makes a difference), since the source code seems to want
48kHz (or so I surmise).
2)  The rear channels are nowhere to be found.  I suspect that I need
to turn on some switch in the mixer, but which one is becoming a
mystery to me.

Eventually I'll be moving to a different sound card (a Turtle Beach
Santa Cruz), then another one. I suspect that some of the same problems
might continue, so I'd like to solve them here first.  Any/all
suggestions would be welcome.

p.s.  While I will convert to alsa, will the OSS stuff work in
emulation??  Will I have similar controls available like the
misc.rear2lin mentioned above??  Is there any way I can put them into
the OSS emulation stuff??  I'd be willing to do so.

Thanks.

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
