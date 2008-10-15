From: Alexey Bazhin <baz@irc.msk.ru>
Subject: Re: Backported sbxfi driver (UNTESTED!)
Date: Wed, 15 Oct 2008 12:26:49 +0400
Message-ID: <20081015122649.65b32ee4.baz@irc.msk.ru>
References: <20081012165353.a084d158.baz@irc.msk.ru>
	<s5hod1pz1xl.wl%tiwai@suse.de>
	<20081013165805.735bf06e.baz@irc.msk.ru>
	<s5htzbg63bq.wl%tiwai@suse.de> <48F35C4C.40307@gmail.com>
	<s5hej2k5ysj.wl%tiwai@suse.de> <s5hbpxo5wmw.wl%tiwai@suse.de>
	<s5h1vyk5vr3.wl%tiwai@suse.de> <s5hy70s4h0i.wl%tiwai@suse.de>
	<20081013232147.026f38c9.baz@irc.msk.ru>
	<s5hzll7oetb.wl%tiwai@suse.de>
	<20081015003531.6b96847e.baz@irc.msk.ru>
	<s5hej2iz7yb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.mosuzedu.ru (mail.mosuzedu.ru [62.117.117.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 6EAFB1037F3
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Oct 2008 10:27:08 +0200 (CEST)
In-Reply-To: <s5hej2iz7yb.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 15 Oct 2008 08:30:20 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> At Wed, 15 Oct 2008 00:35:31 +0400,
> Alexey Bazhin wrote:
> > 
> > On Tue, 14 Oct 2008 08:45:20 +0200
> > Takashi Iwai <tiwai@suse.de> wrote:
> > 
> > > At Mon, 13 Oct 2008 23:21:47 +0400,
> > > Alexey Bazhin wrote:
> > > > 
> > > > Now it doesn't hangs :)
> > > 
> > > Glad to hear.  Did you have to use XXX_SYSTEM_TIMER or any
> > > workaround needed?  Or, did it work as is?
> > > 
> > > > but speakers-test produces crackling sine and
> > > > fails on test...
> > > 
> > > Do you mean it aborts some time later after starting the stream?
> > > Could you show the kernel messages?  The default debug level
> > > should suffice, I guess.  If any, try debug=2.
> > 
> > root@mayonaka:~/linux-2.6# dmesg -c >/dev/null
> > root@mayonaka:~/linux-2.6# insmod sound/pci/sbxfi/snd-sbxfi.ko
> > root@mayonaka:~/linux-2.6# dmesg
> > [ 2957.493602] SBXFI: INIT HW
> > [ 2957.596133] SBXFI: Setting TLB buffer page 0xc02000
> > root@mayonaka:~/linux-2.6# speaker-test -c 2 -r 96000 -t sine
> > 
> > speaker-test 1.0.15
> > 
> > Playback device is default
> > Stream parameters are 96000Hz, S16_LE, 2 channels
> > Sine wave rate is 440.0000Hz
> > Rate set to 96000Hz (requested 96000Hz)
> > Buffer size range from 32 to 16384
> > Period size range from 32 to 16384
> > Using max buffer size 16384
> > Periods = 4
> > was set period_size = 4096
> > was set buffer_size = 16384
> >  0 - Front Left
> > 
> > 
> > 
> > Write error: -5,Input/output error
> > xrun_recovery failed: -5,Input/output error
> > Transfer failed: Operation not permitted
> > root@mayonaka:~/linux-2.6# 
> > root@mayonaka:~/linux-2.6# dmesg
> > [ 2957.493602] SBXFI: INIT HW
> > [ 2957.596133] SBXFI: Setting TLB buffer page 0xc02000
> > [ 2974.854578] SBXFI: Allocate SRC 0
> > [ 2974.855368] SBXFI: allocated TLB at 0 for 16 pages
> > [ 2974.855372] SBXFI: filled TLB pages starting at 0xc10000
> > [ 2974.855393] SBXFI: PLAYBACK PREPARE: rate=96000,
> > period_size=4096, buffer_size=16384
> > [ 2974.855396] SBXFI: INIT DAC
> > [ 2974.855400] SBXFI: RESET DAC
> > [ 2975.059435] SBXFI: SETUP I2S
> > [ 2975.059445] SBXFI: Pitch [0:fa6] = 0x1000000
> > [ 2975.059449] SBXFI: Pitch [80:7a6] = 0x1000000
> > [ 2975.059453] SBXFI: Pitch [1:fb6] = 0x1000000
> > [ 2975.059456] SBXFI: Pitch [81:7b6] = 0x1000000
> > [ 2975.059460] SBXFI: Amp [00:0001] = 0x101c
> > [ 2975.059465] SBXFI: Amp [80:07a6] = 0x101c
> > [ 2975.059470] SBXFI: Amp [01:0011] = 0x101c
> > [ 2975.059474] SBXFI: Amp [81:07b6] = 0x101c
> > [ 2975.062594] SBXFI: PLAY TRIGGER START
> > [ 2975.062600] SBXFI: SETUP SRC: ch=0x0, start=0x0, loop=0x10000,
> > cache=0x100, ctrl=0x1045c 
> > [ 2975.062612] SBXFI: SETUP SRC: ch=0x1, start=0x0, loop=0x10000,
> > cache=0x100, ctrl=0x5c
> > [ 2975.062625] SBXFI: PLAY UPDATE TIMER
> > [ 2995.148059] SBXFI: PLAY TRIGGER STOP
> > [ 2995.148072] SBXFI: PLAY UPDATE TIMER
> > [ 2995.148079] SBXFI: release TLB at 0 for 16 pages
> > [ 2995.148218] SBXFI: Release SRC 0
> 
> Hmm, then there is no serious error here.  Did you build the driver
> with --with-debug=full or --with-debug=detect option?
No, i'm just building kernel from git with your tree.

> Also, run with debug=2.  Then it prints the timer/IRQ handling, too.
> 
> Does this happen with aplay, too?
> 
> Also, please track via strace to check which syscall it gets an error.
I'll try it later, sorry...

> > Two more things:
> > -speakers-test on 48khz doesn't produce above errors, but frequency
> > is still not right
> 
> OK, let's postpone this issue.
> 
> > -24-bit samples is silent for me too
> 
> Too?  What are other cases that cause silent output?
I saw that "The Source <thesourcehim@gmail.com>" was trying to play
only 24-bit 96khz samples and they were silent.

> Also, can you check whether "aplay -M foo.wav" (with 96khz sound file)
> gives any output?
> 
> > > How about the patch below for 48kHz?
> > Didn't changed anything...
> 
> OK.  Just to make clear: you get any (more or less) reasonable sound,
> not silent, with 96kHz stereo, right?
Yes, on 96khz 16bit stereo only

> If yes, then there seems a difference between machines or
> environments.  Could you clarify your system again?
> 
> 
> Takashi


-- 
 Alexey Bazhin
  mailto:baz@irc.msk.ru
  ICQ 125125882
