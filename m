From: "Ivica Ico Bukvic" <ico@fuse.net>
Subject: RE: [linux-audio-user] snd-hdsp+cardbus+M6807 notebook=distortion -- First good news!
Date: Fri, 9 Apr 2004 18:25:47 -0400
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040409222552.MLZG22605.smtp2.fuse.net@64BitBadass>
References: <20040403041732.FAYW17964.smtp2.fuse.net@64BitBadass>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20040403041732.FAYW17964.smtp2.fuse.net@64BitBadass>
To: 'A list for linux audio users' <linux-audio-user@music.columbia.edu>, 'Russell King' <rmk+lkml@arm.linux.org.uk>
Cc: alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org, 'Thomas Charbonnel' <thomas@undata.org>, ccheney@debian.org, 'Tim Blechmann' <TimBlechmann@gmx.net>
List-Id: alsa-devel@alsa-project.org

Hi all!

I've just achieved a first milestone in fixing (fighting?) this issue. I've
been in close correspondence with the notebook manufacturer (Arima --
notebook is eMachines M6807) and here's what I found out so far.

(this should be especially valuable for the linux-pcmcia people, Russel are
you there? :-)

Arima provided me with the hex editor (real-time DOS-like app that allows
monitoring of various "registers" of every particular controller/hw on the
notebook, including the dreaded pcmcia). After tinkering with it for some
time in Windows XP, I finally fixed the issue where I had the distortion
after resume (the fix needs to be applied manually at this point in time
using this app, although I am hoping a BIOS update will soon fix this in a
much more elegant way). The issues I learned are as follows:

1) Accroding to Matthias (RME), the hdsp multiface is limited to bursts of
16 (bytes?) of data via cardbus controller.

2) The Windows driver automatically adjusts any pcmcia controller's latency
from (in my case default, yours could vary) 0x20 (or 32) to 0xFF (or 255).
This always happens except in one case where the card remains plugged-in
during the suspend/resume cycle which Matthias acknowledged it may be an
overlook in their drivers, but is no big deal as the card works ok even with
0x20 latency. The higher latency simply ensures that if the PCI is snagged
by something else that the audio packets are never late.

3) In my case the distortion of the sound after "resume" came from the fact
that when the computer is resumed, 2 registers on the pcmcia controller got
slightly altered (whose function is yet to be determined -- Arima is in
process of dealing with this) and always to the same value (there are other
values that also change but are of no importance in this case). By changing
them to the previous state the soundcard works just fine! Yay!

So what does all this mean in Linux?

Well, if there is a way of monitoring these hex registers for various
hardware in Linux I could try to compare their state upon initialization in
Linux to that one in Windows (since in both situations they share the same
IRQ, at least on my notebook) and forward this info to you guys.

So my question at this point is, is there such hex-editor in Linux that
allows this kind of monitoring and if so where can I obtain it?

More info on the Windows version (uses DOS-like commandline):

It's called "System Explorer v.1.00"
Screenshot of the pcmcia controller's state while card is disconnected:
http://meowing.ccm.uc.edu/~ico/eMachines/SE-before_suspend.jpg
Written by Danny Liu (AMI) and it's free (supposedly, haven't looked for it
on the Internet just yet, too tired right now)

On the screenshot you can see position (ROW,COL) 00,0D the value for setting
the latency (FWIW at this point this does not seem to be the problem but I
am pointing it out just to let the pcmcia and RME driver maintainers that it
does get bumped-up when the RME card is connected to 0xFF). In my case after
resume 2 values get altered (among other things) which cause the distortion
in Windows, but as of right now I do not know their exact function (see:
http://meowing.ccm.uc.edu/~ico/eMachines/SE-after_suspend_problem_highlighte
d.jpg). Once these 2 values are changed to their old ones (90 to D0, 06 to
04) the card works just fine even after resume. Both values need to be fixed
for the card to work properly. The 04/06 value is especially important as it
adjusts the distortion timbre and/or speed of the sound so this should be
one to be watched closely. Yet it by itself does not fix the issue and the
other register also needs to be reverted to D0 value before the card works
properly.

This is in a nutshell the likely culprit for Linux (in my case at least) and
this may very well help trace the problem down. Please bear in mind that in
Linux I am not using any power management and the sound is trashed even upon
first init. It would be great to see how its hex state looks when compared
with Windows as this could shed some light as to how to fix the problem.

In Linux I am using MDK Community 10.0, patched 2.6.3 kernel (with patches
for M6807 notebook to make its pcmcia work).

Apologies for the long blurb.

Best wishes,

Ivica Ico Bukvic, composer & multimedia sculptor
http://meowing.ccm.uc.edu/~ico/
