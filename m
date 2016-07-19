From: Shahram Shabpareh <shabpareh.shahram.7@gmail.com>
Subject: problem with copy function
Date: Tue, 19 Jul 2016 12:26:06 +0430
Message-ID: <CAFJxsaei2DCb8T0JBbKLdpxUvM5BrYyRXUGFF7tam9-0DsfX5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 8665C2657B1
 for <alsa-devel@alsa-project.org>; Tue, 19 Jul 2016 09:56:07 +0200 (CEST)
Received: by mail-wm0-f66.google.com with SMTP id o80so1880883wme.0
 for <alsa-devel@alsa-project.org>; Tue, 19 Jul 2016 00:56:07 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi
I have a board with ti am3358 processor. it has a sound port called McASP
and I've used IDT821034 as codec. The Linux kernel source package that is
included by board company is 3.2.0 and I wrote a basic driver for IDT821034
codec and changed the code of davinci-mcasp.c . Now the basic functionality
of system is ok and i have signals on oscilloscope. Another thing is i have
to setup a specific configuration for this system. the target system must
have 32 tdm slots in each frame and 32 PCM channels and each slot is 8
bits. this is also done in kernel source code. currently the problem is i
want that data of channel 1 be mapped to slot 1, channel 2 be mapped to
slot 2, .... and channel 32 be mapped to slot 32. but when i run aplay to
send to only channel 1, data will be send to all slots! i want that all
slots be 0 except slot 1. How can i do that?

I searched in source tree and found the function that i need to override
this behaviour is copy that is defined in snd_pcm_ops structure. I defined
a function called davinci_pcm_copy in davinci-pcm.c file and added the
function to structure like below:

static struct snd_pcm_ops davinci_pcm_ops = {
    ....
    .copy = davinci_pcm_copy,
};

the problem is, this copy function is not called at all by kernel pcm
subsystem.

Again i searched the kernel code and found that copy function has a calling
path as below:

alsa-lib -> snd_pcm_playback_ioctl -> snd_pcm_playback_ioctl1 ->
snd_pcm_lib_write -> snd_pcm_lib_write1 -> snd_pcm_lib_write_transfer ->
copy

but my calling path is:

alsa-lib -> snd_pcm_playback_ioctl -> snd_pcm_playback_ioctl1 ->
snd_pcm_common_ioctl1 -> snd_pcm_sync_ptr

I created a wav file from a mp3 file with this command:

ffmpeg -i file.mp3 -ac 1 -ar 8000 -ab 64k -f u8 file.wav

and played with this command:

aplay -vv -c 1 file.wav

Strange thing is when i run this aplay command in my PC the first calling
path is executed but when i run the same aplay with same file in my board
the second calling path is executed. Is it related to software and hardware
params of sound devices? if yes, what should i do to copy function being
called in my board?

thanks
