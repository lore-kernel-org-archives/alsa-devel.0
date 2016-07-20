From: Shahram Shabpareh <shabpareh.shahram.7@gmail.com>
Subject: Re: problem with copy function
Date: Wed, 20 Jul 2016 10:58:24 +0430
Message-ID: <CAFJxsad9=GTM5z_def16NCusc=gTyyxhR7Hoi+vv+t1a5vrXVg@mail.gmail.com>
References: <CAFJxsaei2DCb8T0JBbKLdpxUvM5BrYyRXUGFF7tam9-0DsfX5g@mail.gmail.com>
 <578E3775.1010005@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 5829E260851
 for <alsa-devel@alsa-project.org>; Wed, 20 Jul 2016 08:28:25 +0200 (CEST)
Received: by mail-wm0-f51.google.com with SMTP id o80so52432512wme.1
 for <alsa-devel@alsa-project.org>; Tue, 19 Jul 2016 23:28:25 -0700 (PDT)
In-Reply-To: <578E3775.1010005@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi
Thanks for reply

I switched from interleaved to non interleaved mode with the following
command and problem solved. no need to implement the copy function.

aplay -vv -c 32 -f u8 -D plughw:0,0 -I file.wav null.wav null.wav null.wav
null.wav null.wav null.wav null.wav null.wav null.wav null.wav null.wav
null.wav null.wav null.wav null.wav null.wav null.wav null.wav null.wav
null.wav null.wav null.wav null.wav null.wav null.wav null.wav null.wav
null.wav null.wav null.wav null.wav

the null.wav file is created from /dev/zero with dd command

On Tue, Jul 19, 2016 at 6:51 PM, Takashi Sakamoto <o-takashi@sakamocchi.jp>
wrote:

> Hi,
>
> On Jul 19 2016 16:56, Shahram Shabpareh wrote:
> > I have a board with ti am3358 processor. it has a sound port called McASP
> > and I've used IDT821034 as codec. The Linux kernel source package that is
> > included by board company is 3.2.0 and I wrote a basic driver for
> IDT821034
> > codec and changed the code of davinci-mcasp.c . Now the basic
> functionality
> > of system is ok and i have signals on oscilloscope. Another thing is i
> have
> > to setup a specific configuration for this system. the target system must
> > have 32 tdm slots in each frame and 32 PCM channels and each slot is 8
> > bits. this is also done in kernel source code. currently the problem is i
> > want that data of channel 1 be mapped to slot 1, channel 2 be mapped to
> > slot 2, .... and channel 32 be mapped to slot 32. but when i run aplay to
> > send to only channel 1, data will be send to all slots! i want that all
> > slots be 0 except slot 1. How can i do that?
> >
> > I searched in source tree and found the function that i need to override
> > this behaviour is copy that is defined in snd_pcm_ops structure. I
> defined
> > a function called davinci_pcm_copy in davinci-pcm.c file and added the
> > function to structure like below:
> >
> > static struct snd_pcm_ops davinci_pcm_ops = {
> >     ....
> >     .copy = davinci_pcm_copy,
> > };
> >
> > the problem is, this copy function is not called at all by kernel pcm
> > subsystem.
> >
> > Again i searched the kernel code and found that copy function has a
> calling
> > path as below:
> >
> > alsa-lib -> snd_pcm_playback_ioctl -> snd_pcm_playback_ioctl1 ->
> > snd_pcm_lib_write -> snd_pcm_lib_write1 -> snd_pcm_lib_write_transfer ->
> > copy
> >
> > but my calling path is:
> >
> > alsa-lib -> snd_pcm_playback_ioctl -> snd_pcm_playback_ioctl1 ->
> > snd_pcm_common_ioctl1 -> snd_pcm_sync_ptr
> >
> > I created a wav file from a mp3 file with this command:
> >
> > ffmpeg -i file.mp3 -ac 1 -ar 8000 -ab 64k -f u8 file.wav
> >
> > and played with this command:
> >
> > aplay -vv -c 1 file.wav
> >
> > Strange thing is when i run this aplay command in my PC the first calling
> > path is executed but when i run the same aplay with same file in my board
> > the second calling path is executed. Is it related to software and
> hardware
> > params of sound devices? if yes, what should i do to copy function being
> > called in my board?
>
> Would you check output of aplay command in a point of 'access' way? Like:
>
> $ aplay -v -D hw:0,0 -f S16_LE -r 44100 -c 2 /dev/urandom
> ...
> Hardware PCM card 0 'HDA Intel PCH' device 0 subdevice 0
> Its setup is:
>   stream       : PLAYBACK
>   access       : RW_INTERLEAVED
> ...
>
> In this case, the process executes ioctl(2) with
> SNDRV_PCM_IOCTL_WRITEI_FRAMES, thus the .copy() in kernel is probably
> executed.
>
> But in this case:
> $ aplay -v -D plughw:0,0 /dev/urandom
> ...
> Slave: Hardware PCM card 0 'HDA Intel PCH' device 0 subdevice 0
> Its setup is:
>   stream       : PLAYBACK
>   access       : MMAP_INTERLEAVED
> ...
>
> The process run with mmap(2)ed page frame, thus PCM frames are not
> transferred by ioctl(2).
>
> Before going to the details, please check it.
>
>
> Regards
>
> Takashi Sakamoto
>
