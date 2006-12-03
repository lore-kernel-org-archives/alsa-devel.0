From: Ray Heasman <lists@mythral.org>
Subject: Update (RTC Timer problem): MIDI Timer stuck with Alsa
	1.0.13
Date: Sun, 03 Dec 2006 13:09:48 -0800
Message-ID: <1165180188.31863.20.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I posted last week with a bug where my timers wouldn't advance correctly
in the sequencer.

I have found that disabling the "ALSA->RTC Timer" option in the kernel
config fixes the problem.

Is there a better place to report this than here?

Here is the diff between the non-working and working .configs:

4c4
< # Thu Nov 23 17:04:54 2006
---
> # Sun Dec  3 12:04:37 2006
1855,1856c1855
< CONFIG_SND_RTCTIMER=m
< CONFIG_SND_SEQ_RTCTIMER_DEFAULT=y
---
> # CONFIG_SND_RTCTIMER is not set

When the sequencer is broken, /proc/asound/seq/timer has this in it:

Timer for queue 0 : RTC timer
  Period time : 0.000976562
  Skew : 65536 / 65536

When the sequencer works, /proc/asound/seq/timer has this in it:

Timer for queue 0 : system timer
  Period time : 0.001000000
  Skew : 65536 / 65536

Thanks,
Ray



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
