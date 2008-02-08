From: Nitin Mahajan <nitinm76@yahoo.com>
Subject: Ac97 on Au1200- No Sound
Date: Fri, 8 Feb 2008 12:00:25 +0000 (GMT)
Message-ID: <834996.85920.qm@web50101.mail.re2.yahoo.com>
Reply-To: nitinm76@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web50101.mail.re2.yahoo.com (web50101.mail.re2.yahoo.com
	[206.190.38.29]) by alsa0.perex.cz (Postfix) with SMTP id 461D024597
	for <alsa-devel@alsa-project.org>; Fri,  8 Feb 2008 13:01:17 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

HI!

I am working with a Au1200 based board and trying to
make the audio(AC97 + STAC9752) work after applying
the ASoC patch at
http://opensource.wolfsonmicro.com/~git/asoc/.

After writing the machine driver for my board based on
the exmmb-ac97.c as a template, my codec is being
detected, which is on PSC1.

But when I play some .wav file using aplay, I get to
hear the sound with a very low volume, which is almost
not recognizable.

I unmuted the codec with these two commands

#amixer set "Master" 255 unmute
#amixer set "PCM" 255 unmute

I also tried to watch /proc/interrupts but I am not
able to see any interrupts coming on IRQ 11 that is
for PSC1.

Could some one provide more insight into what might be
going wrong?

Thanking in advance

regards

-Nitin

Send instant messages to your online friends http://uk.messenger.yahoo.com 
