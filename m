From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: =?ISO-8859-1?Q?2=2E4=2E20-rc1=A0+_lowlat_+_preempt_+_alsa_+?=
 =?ISO-8859-1?Q?_jack_=3D_dead_computer?=
Date: Fri, 1 Nov 2002 16:00:57 -0800 (PST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0211011537590.2119-100000@cmn37.stanford.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: linux-audio-dev@music.columbia.edu, alsa-devel@lists.sourceforge.net, jackit-devel@lists.sourceforge.net
Cc: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
List-Id: alsa-devel@alsa-project.org

[sorry for the wide distribution]
Is anyone out there trying out this combination?:

  kernel 2.4.20-rc1
  capabilities patch
  low latency patch
  preemptible kernel patch
  almost current alsa cvs [20021028.170432 usa pacific time]

If I start jackd and then use the freqtweak jack client I get a completely
dead machine in a very short time (from a few seconds to 10 or 20
seconds).

Same alsa driver, but running on 2.4.19 (up to 20-pre4) seems to be fine
and I can play around with freqtweak for as long as I want :-)

No clues are left behind... something in the kernel is deadlocking, I
guess. I tried removing first the preemptible kernel patch with the same
result.  Just a moment ago I tried again after removing the low latency
patch and I still get the same result... that pretty much leaves alsa and
the kernel. Got the same result on a laptop intel810 and an ice1712 card.

Interestingly enough just the jack server running is not enough to kill
the machine. Adding a jack client (just tried alsaplayer, same problem as
freqtweak) kills the machine really fast.

Maybe there is a problem with the scheduler when there are several
SCHED_FIFO tasks competing for the processor?

-- Fernando



-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
