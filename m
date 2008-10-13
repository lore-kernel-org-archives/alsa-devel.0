From: Alexey Bazhin <baz@irc.msk.ru>
Subject: Re: Backported sbxfi driver (UNTESTED!)
Date: Mon, 13 Oct 2008 23:21:47 +0400
Message-ID: <20081013232147.026f38c9.baz@irc.msk.ru>
References: <20081012165353.a084d158.baz@irc.msk.ru>
	<s5hod1pz1xl.wl%tiwai@suse.de>
	<20081013165805.735bf06e.baz@irc.msk.ru>
	<s5htzbg63bq.wl%tiwai@suse.de> <48F35C4C.40307@gmail.com>
	<s5hej2k5ysj.wl%tiwai@suse.de> <s5hbpxo5wmw.wl%tiwai@suse.de>
	<s5h1vyk5vr3.wl%tiwai@suse.de> <s5hy70s4h0i.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.mosuzedu.ru (mail.mosuzedu.ru [62.117.117.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 68B1D245D0
	for <alsa-devel@alsa-project.org>;
	Mon, 13 Oct 2008 21:22:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.mosuzedu.ru (Postfix) with ESMTP id 6F7D02175E
	for <alsa-devel@alsa-project.org>; Mon, 13 Oct 2008 23:21:49 +0400 (MSD)
Received: from mail.mosuzedu.ru ([127.0.0.1])
	by localhost (sakura.mosuzedu.ru [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WMj9Qi5zOZFk for <alsa-devel@alsa-project.org>;
	Mon, 13 Oct 2008 23:21:47 +0400 (MSD)
Received: from firefly.flat.yume.ru (cicada.yume.ru [217.172.19.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested) (Authenticated sender: baz@yume.ru)
	by mail.mosuzedu.ru (Postfix) with ESMTP
	for <alsa-devel@alsa-project.org>; Mon, 13 Oct 2008 23:21:47 +0400 (MSD)
In-Reply-To: <s5hy70s4h0i.wl%tiwai@suse.de>
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

On Mon, 13 Oct 2008 18:05:49 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> At Mon, 13 Oct 2008 18:02:08 +0200,
> I wrote:
> > 
> > At Mon, 13 Oct 2008 17:43:03 +0200,
> > I wrote:
> > > 
> > > For example, the latest snapshot I uploaded now has
> > > alsa-kernel/HEAD: a3e1ef74a8ec8b6e3c30f7aa06c5d5d2f2bea7a9 Merge
> > > branch 'topic/sbxfi'
> > 
> > ... and again updated to:
> >   5d425dd626d107ff2b2ea97c27068f7ee4b36dd1 Merge branch
> > 'topic/sbxfi'
> 
> So, guys, please check the latest one.
> 
> If the hang up still occurs with this version, then try to define
> XXX_SYSTEM_TIMER in sbxfi.c, which is undefined as default.
> With this build option, the driver will use the system timer instead
> of emu20k1 timer irqs.
> 
> If this still doesn't help, try to remove all spinlocks.  That is,
> just comment out all spin_lock*() and spin_unlock*() calls to avoid
> spin deadlocks.  Of course, it can be racy, but better than a spin
> deadlock.

Now it doesn't hangs :) but speakers-test produces crackling sine and
fails on test...

root@mayonaka:~# speaker-test -c 2 -r 96000 -t
sine                                                                                                            

speaker-test 1.0.15

Playback device is default
Stream parameters are 96000Hz, S16_LE, 2 channels
Sine wave rate is 440.0000Hz
Rate set to 96000Hz (requested 96000Hz)
Buffer size range from 32 to 16384
Period size range from 32 to 16384
Using max buffer size 16384
Periods = 4
was set period_size = 4096
was set buffer_size = 16384
 0 - Front Left
Write error: -5,Input/output error
xrun_recovery failed: -5,Input/output error
Transfer failed: Operation not permitted

Also i tried mplayer, 96khz works almost fine (very rare cracklings),
48khz plays slow (like playing 96khz sample on 48khz rate without
resampling), 44.1khz doesn't work at all (mplayer doesn't even
show that it plays).

Master control on mixer seems to be working fine.

-- 
 Alexey Bazhin
  mailto:baz@irc.msk.ru
  ICQ 125125882
