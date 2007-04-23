From: "Ben DiDonc" <ben.didonc@gmail.com>
Subject: Re: Fwd: No sound with ATI SB450
Date: Mon, 23 Apr 2007 21:58:17 +1000
Message-ID: <feca60390704230458h43404a8ao75c1261974d1962a@mail.gmail.com>
References: <feca60390704202156h5a34ef0ao975d8c398dee9473@mail.gmail.com>
	<1177172786.21521.163.camel@razman.gruemaster.com>
	<feca60390704220245o1cd98dd3od5d4bb999f25c71@mail.gmail.com>
	<1177261620.9698.18.camel@razman.gruemaster.com>
	<feca60390704222041m15a04b5cj418152756ce5dd67@mail.gmail.com>
	<1177302518.9698.47.camel@razman.gruemaster.com>
	<feca60390704230350k29822175ge46b7f7c803b9423@mail.gmail.com>
	<s5h4pn7uzns.wl%tiwai@suse.de>
	<feca60390704230405y12d44483t4ce7561913cfbca5@mail.gmail.com>
	<s5h3b2ruysq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.243])
	by alsa0.perex.cz (Postfix) with ESMTP id 3BD6824850
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Apr 2007 13:58:19 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c18so1694590anc
	for <alsa-devel@alsa-project.org>; Mon, 23 Apr 2007 04:58:18 -0700 (PDT)
In-Reply-To: <s5h3b2ruysq.wl%tiwai@suse.de>
Content-Disposition: inline
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

Tobin, Takashi,
upon Takashi's advice, I tried loading hda-intel
(alsa-driver-hg20070421) using the probe_mask argument under 2.6.20.
With probe_mask=1, the codec isnt detected and only the modem shows up
(just like before). However, with probe_mask=8, the codec IS correctly
detected (alsa-info.sh at http://pastebin.ca/454059 ). syslog shows:
ACPI: PCI Interrupt 0000:00:14.2[A] -> GSI 16 (level, low) -> IRQ 19
ALSA .../alsa-driver-hg20070421/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:696:
codec_mask = 0x9
ALSA .../alsa/alsa-driver-hg20070421/pci/hda/hda_codec.c:1819:
hda_codec: model 'toshiba' is selected for config 1179:ff10 (Toshiba)

However, there is still no playback (no muted control, all volumes at
100% as shown by amixer in alsa-info.sh). Here again, capture works, I
successfully captured from the mic with arecord.

Can I draw your attention on something ? I m not sure about what i m
going to say (specially the part on NIDs) but i ll try. I know Tobin
already explained that this was normal, but if you have a look at the
post where I loaded edgy (2 posts ago), where the playback
works(2.6.17 with 1.0.12), you ll see that when I aplay something,
syslog shows only a single call to hda_codec_setup_stream with
NID=0x3. In all cases where playback doesnt work (1.0.14rcX under
2.6.20), running aplay makes 4 calls to hda_codec_setup_stream with
NID=3, 6 ,5 and 4 in turn. Why does it try 6 5 and 4 ? Is it because 3
fails ? We know that 3 should be used as its the one that works (under
2.6.17). Now arent NIDs node IDs of codecs connected to the HDA
controller ? Is it possible that 6, 5 and 4 are mistakenly detected
and cannot be used for playback ?
Let me know if I m way off track.
Ben

On 4/23/07, Takashi Iwai <tiwai@suse.de> wrote:
> At Mon, 23 Apr 2007 11:05:19 +0000,
> Ben DiDonc wrote:
> >
> > Takashi,
> > I did try passing model=auto to all 14 release candidates,
>
> Did you already try the HG version (or daily snapshot), right?
>
> > but without
> > success. the codec is never detected (see my previous posts for
> > alsa-info.sh outputs with both 2.6.20 and 2.6.17).
> > My problem is I cant get my sound card to work with kernel 2.6.20,
> > when it used to work with 2.6.17.
>
> The codec mask probed is 0x09, so you can pass either probe_mask=8 or
> probe_mask=1 to skip the modem detection (if it matters).
>
>
> Takashi
>
>
> >
> > Ben
> >
> > On 4/23/07, Takashi Iwai <tiwai@suse.de> wrote:
> > > At Mon, 23 Apr 2007 10:50:18 +0000,
> > > Ben DiDonc wrote:
> > > >
> > > > Tobin,
> > > > Unfortunately, ACPI was on at all times. My laptop hardly ever boots
> > > > without ACPI (randomly, the SATA driver fails before it can even mount
> > > > the root partition).
> > > > I ran some more tests today:
> > > > I loaded Ubuntu Edgy from the live CD where the sound chip used to
> > > > work (kernel 2.6.17, alsa driver 1.0.12rc1). Obviously the sound works
> > > > straight away. From there , I ran the same series of test: download
> > > > and build (--with-debug=detect) the next version of alsa-driver, run a
> > > > capture from mic and try playing it back, check syslog and run
> > > > alsa-info.sh. I did this for successive versions of alsa-driver
> > > > (starting with 1.0.12) until it fails.
> > > > Here are the results:
> > > >
> > > > Alsa driver 1.0.12rc1(shipped with edgy):
> > > > capture: working, playback working, alsa-info.sh at http://pastebin.ca/453947
> > > >
> > > > Alsa driver 1.0.12: (alsa-info.sh at http://pastebin.ca/453971 )
> > > > syslog lines after modprobe:
> > > > ACPI: PCI Interrupt 0000:00:14.2[A] -> GSI 16 (level, low) -> IRQ 233
> > > > ALSA alsa-driver-1.0.12/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:663:
> > > > codec_mask = 0x9
> > > > hda_codec: Unknown model for ALC861, trying auto-probe from BIOS...
> > > > ALSA alsa-driver-1.0.12/pci/hda/hda_codec.c:2150: autoconfig:
> > > > line_outs=1 (0xb/0x0/0x0/0x0/0x0)
> > > > ALSA alsa-driver-1.0.12/pci/hda/hda_codec.c:2154:    speaker_outs=0
> > > > (0x0/0x0/0x0/0x0/0x0)
> > > > ALSA alsa-driver-1.0.12/pci/hda/hda_codec.c:2156:    hp=0x0,
> > > > dig_out=0x0, din_in=0x0
> > > > ALSA alsa-driver-1.0.12/pci/hda/hda_codec.c:2164:    inputs: mic=0xd,
> > > > fmic=0x0, line=0x0, fline=0x0, cd=0x11, aux=0x0
> > > >
> > > > capture: working
> > > > //capture starting
> > > > hda_intel.c:1124: azx_pcm_prepare: bufsize=0x10000, fragsize=0x1000, format=0x11
> > > > hda_codec.c:628: hda_codec_setup_stream: NID=0x8, stream=0x1,
> > > > channel=0, format=0x11
> > > > //capture stopping
> > > > hda_codec.c:628: hda_codec_setup_stream: NID=0x8, stream=0x0,
> > > > channel=0, format=0x0
> > > >
> > > > playback: working
> > > > //starting
> > > > ALSA hda_intel.c:1124: azx_pcm_prepare: bufsize=0x10000,
> > > > fragsize=0x1000, format=0x11
> > > > ALSA hda_codec.c:628: hda_codec_setup_stream: NID=0x3, stream=0x5,
> > > > channel=0, format=0x11
> > > > //stopping
> > > > ALSA hda_codec.c:628: hda_codec_setup_stream: NID=0x3, stream=0x0,
> > > > channel=0, format=0x0
> > > >
> > > > alsa-driver-1.0.13 (alsa-info.sh at http://pastebin.ca/453975 )
> > > > modprobe snd-hda-intel:
> > > > hda_intel.c:680: codec_mask = 0x9
> > > > hda_codec: Unknown model for ALC861, trying auto-probe from BIOS...
> > > > hda_codec.c:2164: autoconfig: line_outs=1 (0xb/0x0/0x0/0x0/0x0)
> > > > hda_codec.c:2168:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
> > > > hda_codec.c:2172:    hp_outs=0 (0x0/0x0/0x0/0x0/0x0)
> > > > hda_codec.c:2180:    inputs: mic=0xd, fmic=0x0, line=0x0, fline=0x0,
> > > > cd=0x11, aux=0x0
> > > > capture works fine, syslog output similar to 1.0.12 plus an extra
> > > > "hda-intel: Invalid position buffer, using LPIB read method instead"
> > > > in the middle of the capture. Playback works fine too, with the same
> > > > syslog entries as 1.0.12
> > > >
> > > >
> > > > alsa-driver-1.0.14rc1 (alsa-info.sh at http://pastebin.ca/453991 )
> > > > modprobe:
> > > > ALSA hda_intel.c:696: codec_mask = 0x9
> > > > ALSA hda_codec.c:1768: hda_codec: model 'toshiba' is selected for
> > > > config 1179:ff10 (Toshiba)
> > > > Capture works (output similar to 1.0.12)
> > > > Playback does NOT work this time:
> > > > syslog shows a call to azx_pcm_prepare: and 4 calls to
> > > > hda_codec_setup_stream with different nids (3, 6 ,5, 4 as pointed out
> > > > my previous post)
> > > >
> > > >
> > > > alsa-driver-1.0.14rc2 (alsa-info.sh at http://pastebin.ca/453799 )
> > > > modprobe: the codec is correctly detected
> > > > ALSA hda_intel.c:696: codec_mask = 0x9
> > > > ALSA hda_codec.c:1764: hda_codec: model 'toshiba' is selected for
> > > > config 1179:ff10 (Toshiba)
> > > > Capture works. Playback does NOT work, same syslog entries as
> > > > 1.0.14rc1 with multiple calls to hda_codec_setup_stream
> > > >
> > > >
> > > > alsa-driver-1.0.14rc3 (alsa-info.sh at http://pastebin.ca/453785 )
> > > > modprobe: the codec isnt detected.
> > > > ALSA hda_intel.c:696: codec_mask = 0x9
> > > > capture and playback dont work.
> > > >
> > > > Summary: I tried alsa-driver 1.012 through to 1.0.14rc3 on ubuntu edgy
> > > > (kernel 2.6.17). 12 and 13 work fine, 14rc1 and 2 capture works but
> > > > not playback, 14rc3 doesnt detect the codec.
> > > > What next ? not sure, maybe make a diff of alsa-kernel/pci/hda-intel
> > > > between releases 13 and 14 ...
> > >
> > > Try to pass model=auto to snd-hda-intel module, and check whether it
> > > works (make sure that you have unmuted/adjusted mixer elements before
> > > that).  Then get /proc/asound/card0/codec#* files, and compare with
> > > the files without model option.
> > >
> > >
> > > Takashi
> > >
> >
>
