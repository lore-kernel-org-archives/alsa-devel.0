From: Bruce Paterson <bruce@tele-ip.com>
Subject: Re: Underruns (borken pipes)
Date: Mon, 15 Jul 2002 16:37:13 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D326D99.5F419B7C@tele-ip.com>
References: <20020713135735.8C0A61F343@thorin.martin.com.au>
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
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: alsa development <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Paul Davis wrote:
> 
> this design is based (like a lot of JACK's API) on the way just about
> every non-Unix audio API works. it also models the way all the better

OK. I believe I now understand the tradeoffs. Also, it was not clear to
me that the Jack
audio driver would solve my problems since most of what Jack is about is
allowing multiple
audio clients (which I don't have, and in fact don't want at all in this
case).

> >You know nothing in the alsa docs even hints at this, well certainly
> >not in all the PCM bits I went through. Actually it IS working 90% of
> >the time at present, as long
> 
> precisely what would be expected. its not the average case scheduling
> latency that is bad in the regular kernel, its the worst case. thats
> why it works 90% of the time.

Would you care to speculate that the reason it works better *without*
poll is that
on average I'm stuffing something into the buffers before they are
totally empty
(which would be the case for poll), so the impact of a long system
latency
just prior to stuffing is less since there's a bit more left in the
hardware buffer ?

I suspect writing less in each time won't help because the behaviour of
'poll' remains
unchanged only reporting when the hardware buffer is empty (too late !).

> its not documented in the alsa docs because almost nothing is
> documented in the alsa docs. :) :(

I noticed !
 
> >Could you possibly give me some pointers as to where to look in the
> >Jack code ? I am totally unfamilier with it.
> 
> the relevant code is all in the ALSA driver/client, which lives in
> jack/drivers/alsa/alsa_driver.c. what's there is fairly complex,
> because of the full duplex requirement and the use of poll/mmap
> access. however, it works very well, at least on soundcards that have
> their playback and capture streams pretty well in sync (i.e. the same
> requirement needed for ASIO and probably EASI as well).

ok, will dive in when & if necessary.

> >> a kernel with Andrew Morton's low latency patches. you didn't say what
> >> buffer sizes you were using, so its hard to know if this is an issue.
> >
> >I did actually:
> >>>Output frame buffer size is 6553, and input 5461, as returned by the
> >>>hardware.
> >Nothing bigger can be assigned.
> 
> sorry, i missed that. if thats in frames, they are pretty big, and

Yes, in frames. frames size is the number of hardware channels (10in /
12out).

> you're just facing the inevitable poor scheduling latency of the

...and this would be fixed by jack driver style code, or would require
the low
latency kernel patch as well ?  No point going to Jack at this stage if
it's not
going to help.  
The fact that it's much better without Xwindows supports the occasional
latency 
problem.

> regular linux kernel. if its in bytes, its still fairly large. they
> are really odd values however, and they would normally be power-of-2
> figures no matter what the unit.

Ah, but if you divide 65536 by 10 and 12 respectively (the frame widths)
and
round down those are the numbers you get ! (I just worked that out
then). 
 
> >Also, if my plughw:0,0 interface to the envy24 doesn't work (segfault
> >in the plug code), whereas the hw:0,0 does, will Jack even work ??
> 
> since your application doesn't have any control over the hardware, and
> since JACK is known to work on ice1712-based hardware, there should be
> no problem.

Hmmm ok. Maybe the alsa 'plug' normal read/write code is screwed but the
mmap read/write used by Jack is fine. That's the only theory I can can
up with, 
since I'm sure Jack uses non-interleaved buffers.


-- 
Cheers,
Bruce
-------------------------------------------------------------------
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom
they are addressed. If you have received this email in error please
notify the system manager.

    /\\\/\\\/\\\    /   /      Bruce Paterson          
   /  \\\ \\\ \\\  /   /    Senior Design Engineer
  /   /\\\/\\\/\\\/   /   87 Peters Ave, Mulgrave, Vic, 3170
 /   /  \\\ \\\ \\\  /  PO Box 4112, Mulgrave, Vic, 3170, Australia
/   /    \\\/\\\ \\\/   Ph: +61 3 8561 4232   Fax: +61 3 9560 9055
      Tele-IP Ltd.      Email: bruce@tele-ip.com    Icq: #32015991
                        WWW:   http://www.tele-ip.com       VK3TJN
-------------------------------------------------------------------


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
