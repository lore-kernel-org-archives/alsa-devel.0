From: Bruce Paterson <bruce@tele-ip.com>
Subject: Re: Underruns (borken pipes)
Date: Sat, 13 Jul 2002 11:43:40 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D2F85CC.24A88F5@tele-ip.com>
References: <E17Szsx-0001PX-00@usw-sf-list1.sourceforge.net>
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
> >I got around my previous problems (readn) in an output/capture
> >application with an envy24
> >(ice1712) by bypassing the plugin and going straight to hw:0,0. Had to
> >change my code a bit
> >but it's now **almost** working.
> 
> i humbly suggest that you:
> 
>   (1) read the source code for JACK's ALSA driver/client
>   (2) consider using JACK

I did, but the Jack introduction frankly scared me off a bit. I'm sure
that it's not its
intention, but the talk about necessary mods to the kernel and
synchronisation issues between
channels (I&O) seemed a huge amount of bother to go to at the time.
Maybe (based on your comments)
it's necessary evil afterall anyway.

> the first suggestion will reveal quite a bit. you additionally will
> need to know that you can't avoid underruns with small buffer sizes
> unless you run with SCHED_FIFO or SCHED_RR scheduling, and not without

You know nothing in the alsa docs even hints at this, well certainly not
in all the
PCM bits I went through. Actually it IS working 90% of the time at
present, as long
as; 
a) I leave lots of RAM (don't run X etc)
b) I bash away at write/read regardless every 10ms in my hacky version
of code (the "poll" version
is a disaster)
Could you possibly give me some pointers as to where to look in the Jack
code ? I am totally
unfamilier with it.

> a kernel with Andrew Morton's low latency patches. you didn't say what
> buffer sizes you were using, so its hard to know if this is an issue.

I did actually:
>>Output frame buffer size is 6553, and input 5461, as returned by the
>>hardware.
Nothing bigger can be assigned.

I have my own frame buffer for tx of full channel width 10, and another
for rx of channel
width 12. Each is only the frame sizes above only.
I have on top of that my own buffers (non interleaved) for my 4 capture
channels and 1
output channel. These are typically 40s at 96000 long * 32bits....all
are preallocated.
I copy from these in/out of the tx/rx frame buffers prior/after a
sucessful write/read
call.

Also, if my plughw:0,0 interface to the envy24 doesn't work (segfault in
the plug code),
whereas the hw:0,0 does, will Jack even work ??
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
Gadgets, caffeine, t-shirts, fun stuff.
http://thinkgeek.com/sf
