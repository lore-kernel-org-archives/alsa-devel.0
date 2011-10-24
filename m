From: "Nenad Sljivic" <nenad.sljivic@rt-rk.com>
Subject: dmix - unable to open slave
Date: Mon, 24 Oct 2011 15:17:16 +0200
Message-ID: <5118DCBF03F5431599E4728F6F1B6DA1@domain.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.rt-rk.com (mail.rt-rk.ftn.uns.ac.rs [147.91.177.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 32FC8103834
	for <alsa-devel@alsa-project.org>;
	Mon, 24 Oct 2011 15:17:17 +0200 (CEST)
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


Hi,

I posted the same questions on alsa-user group, but no one could help me, so
I might have more luck here.


I am trying to enable a software mixer on an MIPS based embedded target
board using alsa-lib v1.0.23.

When I try to play two audio files using these commands:

#aplay -vDplug:dmix song1.wav &
#aplay -vDplug:dmix song2.wav 

mixing works fine.

For some strange reason when I try the same thing using the "nenad_dmix"
device I am getting the following error:

ALSA lib pcm_dmix.c:1068:(snd_pcm_dmix_open) unable to open slave
aplay: main:654: audio open error: Invalid argument

The error occurs while trying to open device for the second time (song2.wav
playback). At the same time, song1.wav plays fine.


The content of my .asoundrc is given bellow:

pcm.nenad_dmix {
        type plug
        slave.pcm "dmixer"
}

pcm.dmixer  {
        type dmix
        ipc_key 1024
        ipc_key_add_uid false
        ipc_perm 0666
        slave {
    pcm "hw:0,0"
    period_time 0
    period_size 3840
    buffer_size 15360
    rate 48000
    }
}

I narrowed down the problem using the strace tool and it showed me this:

open("/dev/snd/pcmC0D0p", O_RDWR|O_APPEND|O_NONBLOCK|O_CLOEXEC) = -1 EINVAL
(Invalid argument)


What can be the difference between using the plug:dmix and some virtual
device like nenad_dmix in this case ??

Could some of you help me to resolve this issue?

Thanks,
Nenad
