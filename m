From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: ham radio OSS duplex realtime mmap program.
Date: Fri, 26 Sep 2003 16:23:52 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0309261623170.1362@pnote.perex-int.cz>
References: <200309251628.48034.Safari.Doktor@addcom.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200309251628.48034.Safari.Doktor@addcom.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Dr. med. =?iso-8859-15?q?G=FCnther?= Montag" <Safari.Doktor@addcom.de>
Cc: alsa-devel@lists.sourceforge.net, hfterm-hackers@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 26 Sep 2003, Dr. med. [iso-8859-15] G=FCnther Montag wrote:

> Hello
> I work at "hfkernel" by Tom Sailer, a program for pactor/rtty (soundcard =
ham
> radio digimodes). It seems complicated, because it uses realtime scheduli=
ng,
> select(), mmap(), and runs in 3 threads.
> It was made in 1996 for OSS; I am trying to get it running with ALSA.
>
> It is unique thing because it can do
> Pactor without the expensive PTC (something like a radio modem),
> may be of interest for many hams outside Europe /USA.
>
> I and friends see messages like
> " 512 fragments passed since last wakeup", in endless loop, leading to
> crashes, seems to be xruns, not able to ctrl-alt-del, have to switch off
> machine.
> .
> What do You think, how can ALSA support it, or Do I have to rewrite it fo=
r
> ALSA.
> I tried already with no success to say "Direct" and "non-block" in all
> combinations to /proc/asound/card0/pcm0p etc...
> If to rewrite, what function / ioctl matches
> SNDCTL_DSP_GETISPACE...SNDCTL_DSP_GETOSPACE...
> " ioctl(fd_audio, SNDCTL_DSP_GETIPTR, &cinfo) "
> and
> " ioctl(fd_audio, SNDCTL_DSP_GETOPTR, &cinfo) " ?
>
> The prog is at https//projects.sourceforge.net/hfterm.
> Here is one of the important functions out of l1/user/oss.c my prog:
> Thanks for Your ideas!

Try 0.9.7 release, it comes with some OSS emulation fixes.

=09=09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
