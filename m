From: "Andrew L. Neporada" <nepal@asplinux.ru>
Subject: Re: Connexant HDA codec support
Date: Fri, 18 Aug 2006 17:04:59 +0400
Message-ID: <1155906299.27393.41.camel@leeloo.asplinux.ru>
References: <1155721544.3871.43.camel@leeloo.asplinux.ru>
	<s5hac64ygw0.wl%tiwai@suse.de> <s5h3bbwyez3.wl%tiwai@suse.de>
	<1155812567.25618.9.camel@leeloo.asplinux.ru>
	<s5hk657zjb4.wl%tiwai@suse.de>
	<1155815287.25618.13.camel@leeloo.asplinux.ru>
	<s5h3bbvza3v.wl%tiwai@suse.de>
	<1155885471.27393.13.camel@leeloo.asplinux.ru>
	<s5hk656z7ly.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-O8q/efiDVODpXWdT18f2"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hk656z7ly.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-O8q/efiDVODpXWdT18f2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:
> > 
> > Still can not record sound.
> > Btw, it seems that mic is detected only if
> > phone jack is inserted at modprobe moment.
> > There is also "azx_get_response timeout, switching to single_cmd
> > mode..." message in kernel debug output (see attached files).
> 
> The azx_get_response could be improved by the patch below (although
> you may see still a warning message once).  It will switch to polling
> mode if the irq mode fails by some reason.
> 

After applying this patch I have no "mic" control present, only
"Capture". And it seems that there is no invocation of
snd_hda_queue_unsol_events() function with this patch.


> The fact that the mic gets detected only when "phone" jack is
> inserted looks interesting.

Moreover, microphone jack sense is working only at module init time.
After that it is ignored.

>   Could you compare codec#0 before and
> after plugging the jack?  Any change? 

Difference between "no mic" and "mic present" cadec#0 files:
--- 1   2006-08-18 23:03:50.005736250 +0400
+++ 2   2006-08-18 23:04:38.140744500 +0400
@@ -32,7 +32,7 @@
   Pincap 0x08113c: IN OUT HP Detect
   Pin Default 0x01813030: [Jack] Line In at Ext Rear
     Conn = 1/8, Color = Blue
-  Pin-ctls: 0x00:
+  Pin-ctls: 0x20: IN
   Power: 0x0
   Connection: 2
      0x19* 0x17
@@ -58,7 +58,7 @@
   Amp-Out vals:  [0x06]
 Node 0x17 [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
   Amp-In caps: ofs=0x14, nsteps=0x2b, stepsize=0x05, mute=1
-  Amp-In vals:  [0x94 0x94] [0x94 0x94] [0x94 0x94] [0x94 0x94] [0x94
0x94]
+  Amp-In vals:  [0x94 0x94] [0x94 0x94] [0x17 0x17] [0x94 0x94] [0x94
0x94]
   Power: 0x0
   Connection: 5
      0x19 0x14 0x12 0x11 0x15


>  And, could you try inputs from
> "Line"?

Still same result - no sound.

> 
> Also, please check snd_hda_queue_unsol_event() is called, e.g. by
> adding a debug printk.  This is used on some devices such as a jack
> detection mechanism.  But we didn't turn it on, so I wonder whether
> it's really involved.
> I suppose you get just a silence data instead of empty or shortened
> file via arecord, right?

Yes, I am getting silent but otherwise pretty normal wav file from
arecord.

>   If so, it's likely a mixer volume, the input
> volume of audio-input widget 0x1a.
> The problem is that only the first amp-in volume can be changed by the
> mixer element...
> 
> 
> thanks,
> 
> Takashi
> 

Andrew

--=-O8q/efiDVODpXWdT18f2
Content-Disposition: attachment; filename=alsactl-store.txt
Content-Type: text/plain; name=alsactl-store.txt; charset=utf-8
Content-Transfer-Encoding: 7bit

state.Intel {
	control.1 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Capture Switch'
		value.0 true
		value.1 true
	}
	control.2 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 23'
		iface MIXER
		name 'Capture Volume'
		value.0 0
		value.1 0
	}
	control.3 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Master Playback Switch'
		value.0 true
		value.1 true
	}
	control.4 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 43'
		iface MIXER
		name 'Master Playback Volume'
		value.0 0
		value.1 0
	}
}

--=-O8q/efiDVODpXWdT18f2
Content-Disposition: attachment; filename=alsa-debug.txt
Content-Type: text/plain; name=alsa-debug.txt; charset=utf-8
Content-Transfer-Encoding: 7bit

ALSA /opt/src/asplinux/BUILD/kernel-2.6.17/linux-2.6.17.i686/alsa-driver-1.0.12rc3/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:679: codec_mask = 0x1
ALSA /opt/src/asplinux/BUILD/kernel-2.6.17/linux-2.6.17.i686/alsa-driver-1.0.12rc3/pci/hda/../../alsa-kernel/pci/hda/hda_generic.c:591: AUD_IN = 1a
ALSA /opt/src/asplinux/BUILD/kernel-2.6.17/linux-2.6.17.i686/alsa-driver-1.0.12rc3/pci/hda/../../alsa-kernel/pci/hda/hda_generic.c:226: UNMUTE IN: NID=0x1a IDX=0x0
ALSA /opt/src/asplinux/BUILD/kernel-2.6.17/linux-2.6.17.i686/alsa-driver-1.0.12rc3/pci/hda/../../alsa-kernel/pci/hda/hda_generic.c:226: UNMUTE IN: NID=0x14 IDX=0x0
ALSA /opt/src/asplinux/BUILD/kernel-2.6.17/linux-2.6.17.i686/alsa-driver-1.0.12rc3/pci/hda/../../alsa-kernel/pci/hda/hda_generic.c:628: [Capture Source] NID=0x1a, #SRC=1
ALSA /opt/src/asplinux/BUILD/kernel-2.6.17/linux-2.6.17.i686/alsa-driver-1.0.12rc3/pci/hda/../../alsa-kernel/pci/hda/hda_generic.c:631:   [Mic] IDX=0x1
ALSA /opt/src/asplinux/BUILD/kernel-2.6.17/linux-2.6.17.i686/alsa-driver-1.0.12rc3/pci/hda/../../alsa-kernel/pci/hda/hda_generic.c:282: AUD_OUT found 19
ALSA /opt/src/asplinux/BUILD/kernel-2.6.17/linux-2.6.17.i686/alsa-driver-1.0.12rc3/pci/hda/../../alsa-kernel/pci/hda/hda_generic.c:244: CONNECT: NID=0x10 IDX=0x0
ALSA /opt/src/asplinux/BUILD/kernel-2.6.17/linux-2.6.17.i686/alsa-driver-1.0.12rc3/pci/hda/../../alsa-kernel/pci/hda/hda_generic.c:226: UNMUTE IN: NID=0x10 IDX=0x0
ALSA /opt/src/asplinux/BUILD/kernel-2.6.17/linux-2.6.17.i686/alsa-driver-1.0.12rc3/pci/hda/../../alsa-kernel/pci/hda/hda_generic.c:210: UNMUTE OUT: NID=0x10
ALSA /opt/src/asplinux/BUILD/kernel-2.6.17/linux-2.6.17.i686/alsa-driver-1.0.12rc3/pci/hda/../../alsa-kernel/pci/hda/hda_generic.c:210: UNMUTE OUT: NID=0x10
ALSA /opt/src/asplinux/BUILD/kernel-2.6.17/linux-2.6.17.i686/alsa-driver-1.0.12rc3/pci/hda/../../alsa-kernel/pci/hda/hda_generic.c:282: AUD_OUT found 19
ALSA /opt/src/asplinux/BUILD/kernel-2.6.17/linux-2.6.17.i686/alsa-driver-1.0.12rc3/pci/hda/../../alsa-kernel/pci/hda/hda_generic.c:244: CONNECT: NID=0x11 IDX=0x0
ALSA /opt/src/asplinux/BUILD/kernel-2.6.17/linux-2.6.17.i686/alsa-driver-1.0.12rc3/pci/hda/../../alsa-kernel/pci/hda/hda_generic.c:226: UNMUTE IN: NID=0x11 IDX=0x0
ALSA /opt/src/asplinux/BUILD/kernel-2.6.17/linux-2.6.17.i686/alsa-driver-1.0.12rc3/pci/hda/../../alsa-kernel/pci/hda/hda_generic.c:210: UNMUTE OUT: NID=0x11
ALSA /opt/src/asplinux/BUILD/kernel-2.6.17/linux-2.6.17.i686/alsa-driver-1.0.12rc3/pci/hda/../../alsa-kernel/pci/hda/hda_generic.c:210: UNMUTE OUT: NID=0x11
ALSA /opt/src/asplinux/BUILD/kernel-2.6.17/linux-2.6.17.i686/alsa-driver-1.0.12rc3/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:534: hda_intel: azx_get_response timeout, switching to polling mode...
ALSA /opt/src/asplinux/BUILD/kernel-2.6.17/linux-2.6.17.i686/alsa-driver-1.0.12rc3/pci/hda/../../alsa-kernel/pci/hda/hda_generic.c:244: CONNECT: NID=0x1a IDX=0x1
ALSA /opt/src/asplinux/BUILD/kernel-2.6.17/linux-2.6.17.i686/alsa-driver-1.0.12rc3/pci/hda/../../alsa-kernel/pci/hda/hda_generic.c:686: [Capture Switch] NID=0x1a, DIR=IN, IDX=0x1
ALSA /opt/src/asplinux/BUILD/kernel-2.6.17/linux-2.6.17.i686/alsa-driver-1.0.12rc3/pci/hda/../../alsa-kernel/pci/hda/hda_generic.c:706: [Capture Volume] NID=0x1a, DIR=IN, IDX=0x1
ALSA /opt/src/asplinux/BUILD/kernel-2.6.17/linux-2.6.17.i686/alsa-driver-1.0.12rc3/pci/hda/../../alsa-kernel/pci/hda/hda_generic.c:693: [Master Playback Switch] NID=0x10, DIR=OUT
ALSA /opt/src/asplinux/BUILD/kernel-2.6.17/linux-2.6.17.i686/alsa-driver-1.0.12rc3/pci/hda/../../alsa-kernel/pci/hda/hda_generic.c:713: [Master Playback Volume] NID=0x10, DIR=OUT


--=-O8q/efiDVODpXWdT18f2
Content-Disposition: attachment; filename=codec0.txt
Content-Type: text/plain; name=codec0.txt; charset=utf-8
Content-Transfer-Encoding: 7bit

Codec: Generic 14f1 ID 5045
Address: 0
Vendor Id: 0x14f15045
Subsystem Id: 0x152d0753
Revision Id: 0x100100
Default PCM: rates 0x140, bits 0x0e, types 0x1
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
Node 0x10 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Amp-Out caps: ofs=0x2b, nsteps=0x2b, stepsize=0x05, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0810014: OUT EAPD Detect
  Pin Default 0x92170010: [Fixed] Speaker at Int Front
    Conn = Analog, Color = Unknown
  Pin-ctls: 0x40: OUT
  Power: 0x0
  Connection: 2
     0x19* 0x17
Node 0x11 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Amp-Out caps: ofs=0x2b, nsteps=0x2b, stepsize=0x05, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x08113c: IN OUT HP Detect
  Pin Default 0x01214020: [Jack] HP Out at Ext Rear
    Conn = 1/8, Color = Green
  Pin-ctls: 0xc0: OUT HP
  Power: 0x0
  Connection: 2
     0x19* 0x17
Node 0x12 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Amp-Out caps: ofs=0x2b, nsteps=0x2b, stepsize=0x05, mute=1
  Amp-Out vals:  [0xab 0xab]
  Pincap 0x08113c: IN OUT HP Detect
  Pin Default 0x01813030: [Jack] Line In at Ext Rear
    Conn = 1/8, Color = Blue
  Pin-ctls: 0x00:
  Power: 0x0
  Connection: 2
     0x19* 0x17
Node 0x13 [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x0810: OUT
  Pin Default 0x21447040: [Jack] SPDIF Out at Sep Rear
    Conn = RCA, Color = Yellow
  Pin-ctls: 0x00:
  Connection: 1
     0x18
Node 0x14 [Pin Complex] wcaps 0x400081: Stereo
  Pincap 0x081124: IN Detect
  Pin Default 0x97a70050: [Fixed] Mic at Int Riser
    Conn = Analog, Color = Unknown
  Pin-ctls: 0x20: IN
Node 0x15 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x99330060: [Fixed] CD at Int ATAPI
    Conn = ATAPI, Color = Unknown
  Pin-ctls: 0x00:
Node 0x16 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
  Amp-Out caps: ofs=0x07, nsteps=0x07, stepsize=0x0b, mute=1
  Amp-Out vals:  [0x06]
Node 0x17 [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
  Amp-In caps: ofs=0x14, nsteps=0x2b, stepsize=0x05, mute=1
  Amp-In vals:  [0x94 0x94] [0x94 0x94] [0x94 0x94] [0x94 0x94] [0x94 0x94]
  Power: 0x0
  Connection: 5
     0x19 0x14 0x12 0x11 0x15
Node 0x18 [Audio Output] wcaps 0x211: Stereo Digital
  PCM: rates 0x040, bits 0x06, types 0x5
Node 0x19 [Audio Output] wcaps 0xc11: Stereo
  PCM: rates 0x540, bits 0x0e, types 0x1
  Power: 0x0
Node 0x1a [Audio Input] wcaps 0x100d0b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x17, stepsize=0x05, mute=1
  Amp-In vals:  [0x17 0x17] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
  Power: 0x0
  Connection: 5
     0x17 0x14* 0x12 0x11 0x15
Node 0x1b [Vendor Defined Widget] wcaps 0xf00000: Mono

--=-O8q/efiDVODpXWdT18f2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=-O8q/efiDVODpXWdT18f2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-O8q/efiDVODpXWdT18f2--
