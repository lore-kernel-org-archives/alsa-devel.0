From: Ray Heasman <lists@mythral.org>
Subject: MIDI Timer stuck with Alsa 1.0.13, HDSP 9632
Date: Fri, 24 Nov 2006 15:33:15 -0800
Message-ID: <1164411195.608.29.camel@localhost>
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

About a year ago I had MIDI working fine on my system (software only to
timidity plus a USB MIDI keyboard), but haven't been using it for the
last year. Having just acquired a MIDI synth module, I decided to set up
an audio workstation again, but can't get it to work.

My problem is that I only hear the MIDI events that are right at the
beginning of a MIDI file. Looking at /proc/asound/seq/queues shows a
"running" timer with a current time that never advances beyond zero.

I have tried different combinations of kernels and alsa-drivers, with no
change in behaviour. I have tried linux 2.6.16-rt29 (Gentoo Proaudio
overlay) and 2.6.18.1 vanilla. I have tried the alsa drivers that came
with those kernels and also alsa-driver 1.0.11 and 1.0.13.

I notice that I can't get software MIDI devices to work either.
aplaymidi will not talk to Timidity, nor will it talk to my external
MIDI synth module. Kmid and Rosegarden behave exactly the same way.

I have a small Windows program that generates MIDI events, and this
works perfectly when I run it under wine.

I have made a package of everything I can think of and put it at
http://www.mythral.org/~ray/public/alsapost/

It contains /proc/asound, dmesg output, kernel configs, etc.

I am happy to provide more information or test new source code if that
helps.

Thanks,
Ray



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
