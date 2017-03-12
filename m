From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] Meter causes freeze when closing audio
	device
Date: Sun, 12 Mar 2017 13:49:56 +0900
Message-ID: <29cab115-91fa-3a87-4560-f0d5a3d25630@sakamocchi.jp>
References: <CAO-Op+GZ_eX44eUpABF38LiAFrMDUYP+0SiySscBdjQz4XO8ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 57ABB2669D8
 for <alsa-devel@alsa-project.org>; Sun, 12 Mar 2017 05:50:02 +0100 (CET)
In-Reply-To: <CAO-Op+GZ_eX44eUpABF38LiAFrMDUYP+0SiySscBdjQz4XO8ng@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alistair Buxton <a.j.buxton@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Mar 6 2017 12:01, Alistair Buxton wrote:
> After adding assert(0); to snd_timer_stop I got the following backtrace:
>
> #0  0x00007ffff730d428 in __GI_raise (sig=sig@entry=6) at
> ../sysdeps/unix/sysv/linux/raise.c:54
> #1  0x00007ffff730f02a in __GI_abort () at abort.c:89
> #2  0x00007ffff7305bd7 in __assert_fail_base (fmt=<optimised out>,
> assertion=assertion@entry=0x7ffff7b9439e "0",
>     file=file@entry=0x7ffff7b9e8b9 "timer.c", line=line@entry=918,
>     function=function@entry=0x7ffff7b9e9c8 <__PRETTY_FUNCTION__.10913>
> "snd_timer_stop") at assert.c:92
> #3  0x00007ffff7305c82 in __GI___assert_fail
> (assertion=assertion@entry=0x7ffff7b9439e "0",
>     file=file@entry=0x7ffff7b9e8b9 "timer.c", line=line@entry=918,
>     function=function@entry=0x7ffff7b9e9c8 <__PRETTY_FUNCTION__.10913>
> "snd_timer_stop") at assert.c:101
> #4  0x00007ffff7b64503 in snd_timer_stop (timer=<optimised out>) at timer.c:918
> #5  0x00007ffff7b5158d in snd_pcm_dmix_sync_ptr0
> (pcm=pcm@entry=0x622de0, slave_hw_ptr=<optimised out>)
>     at pcm_dmix.c:421
> #6  0x00007ffff7b51aac in snd_pcm_dmix_status (pcm=0x622de0,
> status=0x7ffff6af1e80) at pcm_dmix.c:496
> #7  0x00007ffff7b18f11 in snd_pcm_status (pcm=pcm@entry=0x622de0,
> status=status@entry=0x7ffff6af1e80) at pcm.c:977
> #8  0x00007ffff7b48bc0 in snd_pcm_meter_thread (data=0x622940) at
> pcm_meter.c:200
> #9  0x00007ffff76a86ba in start_thread (arg=0x7ffff6af2700) at
> pthread_create.c:333
> #10 0x00007ffff73de82d in clone () at
> ../sysdeps/unix/sysv/linux/x86_64/clone.S:109
>
> So the meter thread is indirectly stopping the timer while the main
> thread is trying to poll it.
>
> The following patch avoids this issue. Is it the right way to fix it?

I can reproduce this issue in below environment:
  - Ubuntu 17.10 (amd64)
  - Linux kernel 4.8.0-41-generic
  - alsa-lib 1.1.2-1
  - your .asoundrc
  - 'aplay -v -fS16_LE -r48000 -c2 -d1 -Dmymeter /dev/zero'
(http://mailman.alsa-project.org/pipermail/alsa-devel/2017-March/118459.html)

Although you catch the cause as mostly correct and your patch is one of 
solutions for your issue, it's just a workaround for your case, because 
this is a bug of PCM dmix plugin. We can also generate this issue in the 
other cases.

I wrote a rough program as a proof. This program runs two threads; main 
and for lister. In the lister, snd_pcm_status() is called frequently. In 
the main thread, PCM frames as much as 1 sec are written, then 
snd_pcm_drain() is called. I can see this program is sometimes blocked 
in a call of poll(2).
https://gist.github.com/takaswie/a498329f0a09b1f715b562cb1942638f

As I work with strace(1), when the process is blocked, 
ioctl(SNDRV_TIMER_IOCTL_STOP) is called after the process starts to be 
blocked with a call of poll(2). As you know, timer character device is 
stopped before elapsing scheduled ticks.

[pid  8655] 13:31:39.338252 poll([{fd=3, 
events=POLLIN|POLLERR|POLLNVAL}], 1, -1 <unfinished ...>
[pid  8656] 13:31:39.338359 futex(0x55a553c93ca0, FUTEX_WAKE_PRIVATE, 1) = 0
[pid  8656] 13:31:39.358459 ioctl(3, SNDRV_TIMER_IOCTL_STOP, 0x2000) = 0
[pid  8656] 13:31:39.358507 read(3, 
"\3\0\0\0\0\0\0\0\305\31\0\0\0\0\0\0$\f/3\0\0\0\0\0\0\0\0\0\0\0\0", 128) 
= 32

I need more time to propose thorough solution for this issue. Anyway, 
thank you to report this bug.


Takashi Sakamoto
