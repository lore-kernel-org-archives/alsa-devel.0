From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: More than stereo (4 channels in my case)
Date: Mon, 28 Apr 2003 13:39:58 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EAD211E.6010502@superbug.demon.co.uk>
References: <20030427080249.21484.qmail@web21504.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030427080249.21484.qmail@web21504.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tsw@johana.com
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Tom Watson wrote:

>In a related project I used OSS (even paid for it) and got did a
>program that played 4 channel sound files (of my own making).  On that
>project I had a CMI sound chip (CMI 8738).  To get the thing to work
>properly (the back two playback channels on the "line in" jack, I
>needed to have a special mixer control set, and used ossmix to do the
>job "ossmix misc.rear2lin on".
>
>Fast forward to my current configuration:  VIA SouthBridge chip audio,
>VT8233 (Vendor 1106, Device 3059, Rev 50, from /sbin/lspci).  I'd like
>to do the same thing.  Now I've read quite a few of the examples and my
>attempts to make some sense out of 'amixer' and 'aplay' are frustrating
>me quite a bit.  I've got 0.9.2 alsa, and a couple of problems:
>1)  The sound in the right channel has a lot of hash.  One time (god
>knows what I did) it seemed to play OK.  I'm using 44.1 kHz sample
>files (if that makes a difference), since the source code seems to want
>48kHz (or so I surmise).
>2)  The rear channels are nowhere to be found.  I suspect that I need
>to turn on some switch in the mixer, but which one is becoming a
>mystery to me.
>
>Eventually I'll be moving to a different sound card (a Turtle Beach
>Santa Cruz), then another one. I suspect that some of the same problems
>might continue, so I'd like to solve them here first.  Any/all
>suggestions would be welcome.
>
>p.s.  While I will convert to alsa, will the OSS stuff work in
>emulation??  Will I have similar controls available like the
>misc.rear2lin mentioned above??  Is there any way I can put them into
>the OSS emulation stuff??  I'd be willing to do so.
>
>Thanks.
>
>=====
>  
>
Although I do not have your sound card, I have a SB Live, and in order 
to get sound coming out of different speakers, one just uses a different 
device name at snd_pcm_open.
E.g. "front" for front speaker stereo,
 "rear" for rear speaker stereo,
"surround40" for 4-channel surround. (front and rear together)
"surround51" for 5.1 Surround. (front, rear, center and SubWoofer)
"default" for the same sound copied to all speakers.

All these device "aliases" are already set up for the sb live. You might 
have to configure some alsa config files to get them to be the same for 
your sound card.
All the alsa config files I have are in /usr/share/alsa and 
/usr/share/alsa/pcm

Cheers
James




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
