From: Josh Green <jgreen@users.sourceforge.net>
Subject: Clicks in output using intel8x0 driver (and a few questions)
Date: Thu, 18 Mar 2004 23:03:11 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1079679790.2906.17.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I have a laptop with the following hardware:
P4 3.06Ghz CPU
82801DB AC'97 Audio Controller
82801DB AC'97 Modem Controller
nVidia GeForce Go5200


and software:
Linux Kernel 2.6.3 (with some ACPI patches)
Alsa 1.0.3
Glibc 2.3.2

For the most part the audio works fine, except when doing CPU intensive
tasks. When there is a lot of CPU activity the audio will sometimes
degrade into a lot of clicks and pops in the output, this can go on for
some time and vary in loudness and rate of occurrence and sometimes it
sounds like a whole audio fragment is skipped after which it will
sometimes go back into sync again.
I first noticed this in games, but afterward I noticed it when compiling
the kernel or re-encoding a movie in the background but listening to
music with XMMS (using OSS emulation). When audio gets bad with XMMS, it
is sufficient to pause and play again, in which case it will be back to
normal, and then degrade again eventually.

While I'm at it, I'll throw a couple of questions out there (hopefully
no one minds).

I was curious what the state is of the intel8x0m driver, since I have an
accursed CH4 82801DB AC'97 Modem Controller which is an HSF Conexant
device. I have it working with the linuxant.com drivers, but they are
rather unstable with the newer 2.6.4 kernel and contain binary code.
Anyone have this working with this modem?

My last question pertains to profiling. This laptop tends to have rather
large latency stutters at regular intervals (probably between 1 and 2
seconds apart). This is noticeable particularly in games and when
playing movies. I ran oprofile but the output isn't too helpful, since
it would be nicer to know exactly when a section of code was taking a
long time. Anyone know of some good strategies for tracking down latency
issues with 2.6 kernels? Thanks in advance for any help :) Cheers!
	Josh Green




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
