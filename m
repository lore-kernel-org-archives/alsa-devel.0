From: Remy Bruno <remy.bruno@trinnov.com>
Subject: Re: Issue with Intel HDA Sound card
	82801G	(laptop	Medion)
Date: Tue, 10 Oct 2006 00:21:49 +0200
Message-ID: <20061009222149.GA18348@trinnov.com>
References: <1160262039.45283197cf7cd@imp5-g19.free.fr>
	<1160416513.17297.135.camel@razman>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1160416513.17297.135.camel@razman>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Tobin Davis <tdavis@dsl-only.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

Unfortunaltely, it doesn't work... First of all, the codec config was not
found (it was using the auto config). I had to change the pci subdevice from
0xd82b to 0x2054. I would just like the recall what I had said in the first
email I made on this topic:
lspci -nv says:
00:1b.0 0403: 8086:27d8 (rev 02)
        Subsystem: 161f:2054
        Flags: fast devsel, IRQ 21
        Memory at d5300000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
+Enable-
        Capabilities: [70] Express Unknown type IRQ 0
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Unknown (5)

Codec info:
* vendor 0x10ec0883, subsystem 0x161fd82b, revision 0x100002
* vendor 0x11c11040, subsystem 0x11c10001, revision 0x100200

So in fact, the PCI subsystem is not the same as the first codec subsystem.

But after having changed this, it still doesn't work. The driver loads
successfuly, but I get not sound, as before. I checked that it still works with
my hack (ie not a volume problem).

Here are the messages I get when loading the driver:
Oct 10 00:03:46 localhost ALSA /usr/local/src/hda/alsa-driver-1.0.13/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:680: codec_mask = 0x3
Oct 10 00:03:46 localhost ALSA /usr/local/src/hda/alsa-driver-1.0.13/pci/hda/hda_codec.c:1760: hda_codec: PCI 161f:2054, codec config 6 is selected
Oct 10 00:03:48 localhost ALSA /usr/local/src/hda/alsa-driver-1.0.13/pci/hda/../../alsa-kernel/pci/hda/patch_si3054.c:245: si3054: cannot initialize. EXT MID = 0000
Oct 10 00:03:48 localhost ALSA /usr/local/src/hda/alsa-driver-1.0.13/pci/hda/../../alsa-kernel/pci/hda/patch_si3054.c:257: Link Frame Detect(FDT) is not ready (line status: 0000)

Here are the messages I get when loading the hacked (working) driver:
Oct 10 00:14:00 localhost Realtek HD Audio Driver Install
Oct 10 00:14:00 localhost ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) -> IRQ 21
Oct 10 00:14:00 localhost PCI: Setting latency timer of device 0000:00:1b.0 to 64
Oct 10 00:14:00 localhost ALSA /usr/local/src/alsa-driver-1.0.13/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:573: codec_mask = 0x3
Oct 10 00:14:00 localhost ALSA /usr/local/src/alsa-driver-1.0.13/pci/hda/hda_codec.c:519: hda_codec: no AFG node found


I also noticed that the current (patched) alsa driver more easily looses the
sync than the hacked (medion) one (even if there is no sound in the first case,
I'm able to see if an xrun occurs).


Here are the codecs files I get with the current alsa driver:

/proc/asound/card0/codec#0:
Codec: Realtek ALC883
Address: 0
Vendor Id: 0x10ec0883
Subsystem Id: 0x161fd82b
Revision Id: 0x100002
Default PCM: rates 0x560, bits 0x0e, types 0x1
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
Node 0x02 [Audio Output] wcaps 0x11: Stereo
  PCM: rates 0x560, bits 0x0e, types 0x1
Node 0x03 [Audio Output] wcaps 0x11: Stereo
  PCM: rates 0x560, bits 0x0e, types 0x1
Node 0x04 [Audio Output] wcaps 0x11: Stereo
  PCM: rates 0x560, bits 0x0e, types 0x1
Node 0x05 [Audio Output] wcaps 0x11: Stereo
  PCM: rates 0x560, bits 0x0e, types 0x1
Node 0x06 [Audio Output] wcaps 0x211: Stereo Digital
  PCM: rates 0x560, bits 0x1e, types 0x1
Node 0x07 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x08 [Audio Input] wcaps 0x10011b: Stereo Amp-In
  Amp-In caps: ofs=0x08, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x80 0x80]
  PCM: rates 0x160, bits 0x06, types 0x1
  Connection: 1
     0x23
Node 0x09 [Audio Input] wcaps 0x10011b: Stereo Amp-In
  Amp-In caps: ofs=0x08, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x80 0x80]
  PCM: rates 0x160, bits 0x06, types 0x1
  Connection: 1
     0x22
Node 0x0a [Audio Input] wcaps 0x100391: Stereo Digital
  PCM: rates 0x560, bits 0x1e, types 0x1
  Connection: 1
     0x1f
Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x19 0x19] [0x1a 0x1a] [0x1b 0x1b] [0x00 0x00] [0x18 0x18] [0x1b 0x1b] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Connection: 10
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17
Node 0x0c [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
  Amp-Out vals:  [0x1a 0x1a]
  Connection: 2
     0x02 0x0b
Node 0x0d [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
  Amp-Out vals:  [0x1a 0x1a]
  Connection: 2
     0x03 0x0b
Node 0x0e [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
  Amp-Out vals:  [0x1a 0x1a]
  Connection: 2
     0x04 0x0b
Node 0x0f [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
  Amp-Out vals:  [0x1c 0x1c]
  Connection: 2
     0x05 0x0b
Node 0x10 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x11 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x12 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x13 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x14 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x083e: IN OUT HP Detect
  Pin Default 0x01011110: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x40: OUT
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x15 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x083e: IN OUT HP Detect
  Pin Default 0x01011112: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x40: OUT
  Connection: 5
     0x0c 0x0d* 0x0e 0x0f 0x26
Node 0x16 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x083e: IN OUT HP Detect
  Pin Default 0x01011111: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x40: OUT
  Connection: 5
     0x0c 0x0d 0x0e* 0x0f 0x26
Node 0x17 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x083e: IN OUT HP Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x00:
  Connection: 5
     0x0c 0x0d 0x0e 0x0f* 0x26
Node 0x18 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x08173e: IN OUT HP Detect
  Pin Default 0x02a11c3f: [Jack] Mic at Ext Front
    Conn = 1/8, Color = Black
  Pin-ctls: 0x24: IN
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x19 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x08173e: IN OUT HP Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x24: IN
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x1a [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x08173e: IN OUT HP Detect
  Pin Default 0x99830130: [Fixed] Line In at Int ATAPI
    Conn = ATAPI, Color = Unknown
  Pin-ctls: 0x20: IN
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x1b [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x08173e: IN OUT HP Detect
  Pin Default 0x0221111f: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Black
  Pin-ctls: 0xc0: OUT HP
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x1c [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x00:
Node 0x1d [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x0820: IN
  Pin Default 0x99830131: [Fixed] Line In at Int ATAPI
    Conn = ATAPI, Color = Unknown
  Pin-ctls: 0x00:
Node 0x1e [Pin Complex] wcaps 0x400300: Mono Digital
  Pincap 0x0810: OUT
  Pin Default 0x01451120: [Jack] SPDIF Out at Ext Rear
    Conn = Optical, Color = Black
  Pin-ctls: 0x00:
  Connection: 1
     0x06
Node 0x1f [Pin Complex] wcaps 0x400200: Mono Digital
  Pincap 0x0820: IN
  Pin Default 0x01c46160: [Jack] SPDIF In at Ext Rear
    Conn = RCA, Color = Orange
  Pin-ctls: 0x00:
Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
Node 0x21 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x22 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x80 0x80] [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Amp-Out caps: N/A
  Amp-Out vals:  [0x00 0x00]
  Connection: 11
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
Node 0x23 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x80 0x80] [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Amp-Out caps: N/A
  Amp-Out vals:  [0x00 0x00]
  Connection: 11
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
Node 0x24 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x25 [Audio Output] wcaps 0x11: Stereo
  PCM: rates 0x560, bits 0x0e, types 0x1
Node 0x26 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x80 0x80]
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 2
     0x25 0x0b

/proc/asound/card0/codec#1:
Codec: Generic 11c1 Si3054
Address: 1
Vendor Id: 0x11c11040
Subsystem Id: 0x11c10001
Revision Id: 0x100200



Modem does not seem to work neither. It is recognized as pcm6, but when I
launch "slmodemd --alsa hw:0,6", I get the following alsa messages repeatedly
(a couple of them per second):
Oct  9 23:12:04 localhost ALSA /usr/local/src/hda/alsa-driver-1.0.13/pci/hda/hda_codec.c:630: hda_codec_setup_stream: NID=0x1, stream=0x5, channel=0, format=0x410
Oct  9 23:12:04 localhost ALSA /usr/local/src/hda/alsa-driver-1.0.13/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1142: azx_pcm_prepare: bufsize=0xc00, fragsize=0x60, format=0x410
Oct  9 23:12:04 localhost ALSA /usr/local/src/hda/alsa-driver-1.0.13/pci/hda/hda_codec.c:630: hda_codec_setup_stream: NID=0x1, stream=0x1, channel=0, format=0x410
Oct  9 23:12:04 localhost ALSA /usr/local/src/hda/alsa-driver-1.0.13/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1142: azx_pcm_prepare: bufsize=0xc00, fragsize=0x60, format=0x410



Regards,
Remy


On Monday 09 October at 10:55, Tobin Davis wrote:
> Here is a test patch.  Try it against a clean alsa-driver-1.0.13 tree
> and let me know the results.  I based this on Remy's tarball from
> Medion, using other Medion subvendor id configs as a basis.
> 
> If it doesn't work, could you also try the tarball that Remy posted last
> weekend?  I'd be interested in knowing if that works.  If it does, I'd
> like to see the output from dmesg with debug=detect enabled, along with
> the /proc/asound/card0/codec#0 output.
> 
> 
> -- 
> Tobin Davis <tdavis@dsl-only.net>

> --- alsa-driver/alsa-kernel/pci/hda/patch_realtek.c.orig	2006-10-08 10:58:28.000000000 -0700
> +++ alsa-driver/alsa-kernel/pci/hda/patch_realtek.c	2006-10-09 10:50:03.000000000 -0700
> @@ -112,6 +112,7 @@
>  	ALC883_6ST_DIG,
>  	ALC888_DEMO_BOARD,
>  	ALC883_ACER,
> +	ALC883_MEDION,
>  	ALC883_AUTO,
>  	ALC883_MODEL_LAST,
>  };
> @@ -5080,6 +5081,8 @@
>  	  .config = ALC883_ACER },
>  	{ .pci_subvendor = 0x1025, .pci_subdevice = 0x009f,
>  	  .config = ALC883_ACER },
> +	{ .pci_subvendor = 0x161f, .pci_subdevice = 0xd82b,
> +	  .modelname = "medion", .config = ALC883_MEDION }
>  	{ .modelname = "auto", .config = ALC883_AUTO },
>  	{}
>  };
> @@ -5167,6 +5170,20 @@
>  		.channel_mode = alc883_3ST_2ch_modes,
>  		.input_mux = &alc883_capture_source,
>  	},
> +	[ALC883_MEDION] = {
> +		.mixers = { alc883_base_mixer,
> +			    alc883_chmode_mixer },
> +		.init_verbs = { alc883_init_verbs,
> +				alc882_eapd_verbs },
> +		.num_dacs = ARRAY_SIZE(alc883_dac_nids),
> +		.dac_nids = alc883_dac_nids,
> +		.num_adc_nids = ARRAY_SIZE(alc883_adc_nids),
> +		.adc_nids = alc883_adc_nids,
> +		.num_channel_mode = ARRAY_SIZE(alc883_sixstack_modes),
> +		.channel_mode = alc883_sixstack_modes,
> +		.input_mux = &alc883_capture_source,
> +	}
> +
>  };
>  
>  

> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys -- and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
