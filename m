From: Michael Hirsch <m.hirsch@phase-zero.de>
Subject: set_params:1073: not enough memory
Date: Tue, 13 Jan 2009 13:11:33 +0100
Message-ID: <496C84F5.9020407@phase-zero.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wp122.webpack.hosteurope.de (wp122.webpack.hosteurope.de
	[80.237.132.129])
	by alsa0.perex.cz (Postfix) with ESMTP id CC00F1037EC
	for <Alsa-devel@alsa-project.org>; Tue, 13 Jan 2009 13:10:04 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello all,

I'm trying to get alsa 1.0.18 working on a ARM PXA processor and I'm 
stuck with the following error message:

aplay /Sinus.raw -fcd
Playing raw data '/Sinus.raw' : Signed 16 bit Little Endian, Rate 44100 
Hz, Stereo
aplay: set_params:1073: not enough memory

alsa kernel was compiled with alsa 1.0.16, alsa.conf, located in 
/usr/share/alsa is the basic:

pcm.!default {
	type hw
	card 0
	}

	ctl.!default {
	type hw
	card 0
         }

also aplay -l and alsaconf store show the message:

ALSA lib control.c:909:(snd_ctl_open_noupdate) Invalid CTL hw:0

However the card shows up /proc/asound/cards and alsamixer is able to 
access it.

Any ideas?

Best regards

Michael
