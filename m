From: Aleksander Adamowski <alsa@olo.org.pl>
Subject: Re: snd-hda-intel: no data when recording from mic,
	"IRQ timing workaround is activated for card #0. Suggest a bigger
	bdl_pos_adj" logged in kern.log
Date: Wed, 17 Mar 2010 12:01:15 +0100
Message-ID: <1c690d741003170401p5b3c3054xd87ab832afd1339c@mail.gmail.com>
References: <1c690d740909221546i756e6724h45533c59f0a50179@mail.gmail.com>
	<s5hy6o69p3a.wl%tiwai@suse.de>
	<1c690d740909240023u6cc093d6hcf2d5766d7e1a58c@mail.gmail.com>
	<s5hr5twvlw6.wl%tiwai@suse.de>
	<1c690d740910041728m2560476bsb22aa410e45777e9@mail.gmail.com>
	<s5hab069zoi.wl%tiwai@suse.de>
	<1c690d740910140004l1383a08h6ae5c6fe86b0e731@mail.gmail.com>
	<1c690d740910170557i30d238a0jc07763585f6d7970@mail.gmail.com>
	<1c690d740910171009v3f62233ape39def2c2a9c105@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f188.google.com (mail-yx0-f188.google.com
	[209.85.210.188])
	by alsa0.perex.cz (Postfix) with ESMTP id 93C1F1037F8
	for <alsa-devel@alsa-project.org>; Wed, 17 Mar 2010 12:02:08 +0100 (CET)
Received: by yxe26 with SMTP id 26so450127yxe.23
	for <alsa-devel@alsa-project.org>; Wed, 17 Mar 2010 04:02:06 -0700 (PDT)
In-Reply-To: <1c690d740910171009v3f62233ape39def2c2a9c105@mail.gmail.com>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello again Takashi,

Got no answer from you back in October and I still experience the sound
capture problem, no daily release of alsa-driver would observably solve the
problem to date. Capture stops working; sometimes arecord is silent but
produces no output, sometimes it outputs a flood of "overrun!!! (at least
27.876 ms long)".

The problem persists until system is rebooted.

The kernel log error messages no longer occur at the moment time when
capture stops working (previosly they did), but when rebooting I usually get
a short burst of either "Too big adjustment 32" or "azx_get_response
timeout" errors:


kern.log:Mar 15 13:39:06 stacja kernel: [22003.694323] ALSA
hda_intel.c:1220: Too big adjustment 32
kern.log:Mar 15 13:39:06 stacja kernel: [22003.714642] ALSA
hda_intel.c:1220: Too big adjustment 32
......
kern.log:Mar 15 13:42:41 stacja kernel: [22218.254581] ALSA
hda_intel.c:1220: Too big adjustment 32
kern.log:Mar 15 13:42:41 stacja kernel: [22218.275689] ALSA
hda_intel.c:1220: Too big adjustment 32
kern.log:Mar 15 13:59:01 stacja kernel: [   22.431420] HDA Intel
0000:00:14.2: PCI INT A -> GSI 16 (level, low) -> IRQ 16
kern.log:Mar 15 13:59:01 stacja kernel: [   22.577821] ALSA
hda_codec.c:3441: hda_codec: model 'auto' is selected
kern.log:Mar 15 13:59:01 stacja kernel: [   22.577828] ALSA
hda_codec.c:4356: autoconfig: line_outs=1 (0x14/0x0/0x0/0x0/0x0)
kern.log:Mar 15 13:59:01 stacja kernel: [   22.577832] ALSA
hda_codec.c:4360:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
kern.log:Mar 15 13:59:01 stacja kernel: [   22.577835] ALSA
hda_codec.c:4364:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
kern.log:Mar 15 13:59:01 stacja kernel: [   22.577838] ALSA
hda_codec.c:4365:    mono: mono_out=0x0
kern.log:Mar 15 13:59:01 stacja kernel: [   22.577840] ALSA
hda_codec.c:4368:    dig-out=0x1e/0x0
kern.log:Mar 15 13:59:01 stacja kernel: [   22.577842] ALSA
hda_codec.c:4376:    inputs: mic=0x18, fmic=0x19, line=0x1a, fline=0x0,
cd=0x0, aux=0x0
kern.log:Mar 15 13:59:01 stacja kernel: [   22.579420] input: HDA Digital
PCBeep as /devices/pci0000:00/0000:00:14.2/input/input6
kern.log:Mar 15 13:59:01 stacja kernel: [   22.583527] HDA Intel
0000:01:05.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
kern.log:Mar 15 13:59:01 stacja kernel: [   22.583591] HDA Intel
0000:01:05.2: irq 27 for MSI/MSI-X

Unfortunately, the "azx_get_response timeout" logs occured before 2010-03-07
and were eaten by my logrotate script.


I've uploaded the alsa-info.sh data to the ALSA project hardware database:
http://www.alsa-project.org/db/?f=cf97d7cd4a29c306ddc6ca86a64842cb7cb9f634

My current module parameters are:
options snd-hda-intel model=auto probe_mask=1

I've also tried several other combinations, none of which really helped.
Here's my annotated modprobe config file, annotations explain which options
caused what effects. Unannotated entries simply didn't change much WRT to
the problem, apart from shuffling available mixer controls:


#options snd-hda-intel model=3stack-6ch
#options snd-hda-intel model=6stack-dig
# Advised at http://forum.ubuntu.pl/showthread.php?t=67236 :
#options snd-hda-intel model=acer-aspire
#options snd-hda-intel model=5stack
#options snd-hda-intel model=auto

# See http://www.kernel.org/pub/linux/kernel/people/tiwai/docs/HD-Audio.html,
"Codec-Probing Problem":
#options snd-hda-intel model=auto probe_mask=1
# doesn't help, "hda_intel: azx_get_response timeout, switching to
single_cmd mode" still happens. Upgrading kernel to 2.6.29.
# upgrading didn't help but the message disappeared.

# See
http://kerneltrap.org/mailarchive/git-commits-head/2008/7/14/2478124/thread
#options snd-hda-intel bdl_pos_adj=32 probe_mask=1 model=auto

# This conf still has capture problems (e.g. 2010-03-13):
options snd-hda-intel model=auto probe_mask=1

# This conf prevents audio from working at all:
#options snd-hda-intel model=auto probe_mask=8

# Needs testing:
#options snd-hda-intel model=auto probe_mask=1 position_fix=1

# Needs testing:
# http://www.linuxhardware.org/forums/viewtopic.php?t=9 :
#options snd-hda-intel model=3stack-6ch position_fix=1 bdl_pos_adj=0



<http://www.alsa-project.org/db/?f=cf97d7cd4a29c306ddc6ca86a64842cb7cb9f634>The
most important question for me now is whether the additional logging
statements from my patch will assist in debugging this problem?


On Sat, Oct 17, 2009 at 18:09, Aleksander Adamowski <alsa@olo.org.pl> wrote:

> BTW, Takashi, if that would be of any help, I could add some #ifdef's
> to the driver's code that would log additional information, if you
> could tell me what to log. It seems that the current log messages
> aren't detailed enough to diagnose the problem.
>
> For starters, I've added this:
>
> diff -ruN alsa-driver-20091017.orig/alsa-kernel/pci/hda/hda_intel.c
> alsa-driver-20091017/alsa-kernel/pci/hda/hda_intel.c
> --- alsa-driver-20091017.orig/alsa-kernel/pci/hda/hda_intel.c
> 2009-10-15 00:05:03.000000000 +0200
> +++ alsa-driver-20091017/alsa-kernel/pci/hda/hda_intel.c
> 2009-10-17 19:07:19.283328740 +0200
> @@ -1182,8 +1182,8 @@
>                                pos_align;
>                pos_adj = frames_to_bytes(runtime, pos_adj);
>                if (pos_adj >= period_bytes) {
> -                       snd_printk(KERN_WARNING SFX "Too big adjustment
> %d\n",
> -                                  bdl_pos_adj[chip->dev_index]);
> +                       snd_printk(KERN_WARNING SFX "Too big
> adjustment %d, pos_adj: %d, period_bytes: %d\n",
> +                                  bdl_pos_adj[chip->dev_index],
> pos_adj, period_bytes);
>                        pos_adj = 0;
>                } else {
>                        ofs = setup_bdle(substream, azx_dev,
>
>
> On Sat, Oct 17, 2009 at 2:57 PM, Aleksander Adamowski <alsa@olo.org.pl>
> wrote:
> > Concerning that problem, after a reboot the problem has reoccured two
> > days later:
> >
> > Oct 17 14:16:09 hostname kernel: [192087.249165] ALSA
> > hda_intel.c:1187: Too big adjustment 32
> > Oct 17 14:22:08 hostname kernel: [192447.072018] ALSA
> > hda_intel.c:1187: Too big adjustment 32
> > Oct 17 14:22:38 hostname kernel: [192477.062967] ALSA
> > hda_intel.c:1187: Too big adjustment 32
> > Oct 17 14:23:06 hostname kernel: [192504.918440] ALSA
> > hda_intel.c:1187: Too big adjustment 32
> > Oct 17 14:23:37 hostname kernel: [192535.594196] ALSA
> > hda_intel.c:1187: Too big adjustment 32
> >
> > Uploaded new alsa-info.sh data from the machine:
> >
> http://www.alsa-project.org/db/?f=e7e696254df6f61fa5e4755e9d1d06403dacf144
> >
> > Upgrading from alsa-driver-20091005 to alsa-driver-20091017 and will
> > let you know how it worked.
> >
> > On Wed, Oct 14, 2009 at 9:04 AM, Aleksander Adamowski <alsa@olo.org.pl>
> wrote:
> >
> >> After running for almost ten days with alsa-driver-20091005, I didn't
> >> observe that problem.
> >>
> >> However, a new one (well, one with slightly different symptoms) has
> surfaced.
> >>
> >> The difference is only in the log files.
> >> During a Skype conversation, the other side has stopped hearing us;
> >> after trying to record some sound with arecord, I got an empty stream
> >> (a 44 byte WAV file with only a header) - just like previously.
> >>
> >> However, this time there were no messages in the kernel logs
> >> whatsoever - no "azx_get_response timeout", no "Suggest a bigger
> >> bdl_pos_adj".
> >> Arecord also didn't flood the console with overrun errors - it was
> >> completely silent apart from the fact that it did not record anything.
> >>
> >> The only hda-related entries I saw in the kernel log were a couple
> >> hours earlier at 20:44 - while the failure has occured between 23:00
> >> and 00:00.
> >>
> >> At 20:44 the following has been logged:
> >>
> >> Oct 13 20:44:25 hostname kernel: [117828.065069] ALSA
> >> hda_intel.c:1187: Too big adjustment 32
> >> Oct 13 20:44:25 hostname kernel: [117828.073562] ALSA
> >> hda_intel.c:1187: Too big adjustment 32
> >> Oct 13 20:44:25 hostname kernel: [117828.083367] ALSA
> >> hda_intel.c:1187: Too big adjustment 32
> >> Oct 13 20:44:25 hostname kernel: [117828.578958] ALSA
> >> hda_intel.c:1187: Too big adjustment 32
> >> Oct 13 20:44:25 hostname kernel: [117828.584872] ALSA
> >> hda_intel.c:1187: Too big adjustment 32
> >> Oct 13 20:44:25 hostname kernel: [117828.592909] ALSA
> >> hda_intel.c:1187: Too big adjustment 32
> >> Oct 13 20:44:25 hostname kernel: [117828.651513] ALSA
> >> hda_intel.c:1187: Too big adjustment 32
> >> Oct 13 20:44:25 hostname kernel: [117828.657009] ALSA
> >> hda_intel.c:1187: Too big adjustment 32
> >> Oct 13 20:44:25 hostname kernel: [117828.665794] ALSA
> >> hda_intel.c:1187: Too big adjustment 32
> >>
> >> The machine is currently still in the failed state - I cannot record
> >> anything until I reboot.
> >>
> >>
> >> --
> >> Best Regards,
> >>  Aleksander Adamowski
> >>  http://olo.org.pl
> >>
> >
> >
> >
> > --
> > Best Regards,
> >  Aleksander Adamowski
> >  http://olo.org.pl
> >
>
>
>
> --
> Best Regards,
>  Aleksander Adamowski
>  http://olo.org.pl
>



-- 
Best Regards,
 Aleksander Adamowski
 http://olo.org.pl
