From: Bruce Paterson <bruce@tele-ip.com>
Subject: Underruns (borken pipes)
Date: Fri, 12 Jul 2002 13:22:01 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D2E4B59.60ACA464@tele-ip.com>
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
To: alsa development <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


I got around my previous problems (readn) in an output/capture
application with an envy24
(ice1712) by bypassing the plugin and going straight to hw:0,0. Had to
change my code a bit
but it's now **almost** working.

I'm now running into underrun problems...occasionally.
I am outputting and capturing at 32 bits, 96000 on 4 input channels and
1 output (but of course
using hw:0,0 its actually 10 output & 12 input hard-wired). All IO is
being stored in RAM buffers
and I'm not running into swap.

Is my machine simply not fast enough ? (700MHz Pentium, 500M RAM) Help
!!!

What I don't understand is this:

If I put write & read in a loop, with a small 10ms delay, setup both in
& out to be non-blocking, I
get only occasional underruns. Underruns are unacceptable in my
application so I have to completely
abort. About every 2nd call to read or write gets an EAGAIN, as you
would expect.

If, however, I use file descriptor polling before read and write; don't
attempt a write till
POLLOUT, or a read until POLLIN or POLLPRI, but have the whole lot in a
big loop so I handle
either as soon as they require, I get failures EVERY time I run.
Somewhere about the 5th
hardware buffer iteration. Underrun is randomly on read or write. Doing
the code "properly"
seems to be far worse !
I never get EAGAIN from read/write in this case, and I haven't seen a
poll failure yet.

Output frame buffer size is 6553, and input 5461, as returned by the
hardware.

As far as I can see I'm roughly complying with the example code
/test/pcm.c with transfer method
"write and wait for room in buffer using poll"
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
PC Mods, Computing goodies, cases & more
http://thinkgeek.com/sf
