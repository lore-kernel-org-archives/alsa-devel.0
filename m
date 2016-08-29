From: Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: Re: No sound for several minutes after reboot
Date: Mon, 29 Aug 2016 10:33:34 +0200
Message-ID: <20160829083334.GA309@x4>
References: <20160827095018.GA309@x4> <20160827113908.GA312@x4>
 <s5htwe4t2hy.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.ud10.udmedia.de (ud10.udmedia.de [194.117.254.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 032E4267426
 for <alsa-devel@alsa-project.org>; Mon, 29 Aug 2016 18:58:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5htwe4t2hy.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 2016.08.29 at 10:15 +0200, Takashi Iwai wrote:
> On Sat, 27 Aug 2016 13:39:08 +0200,
> Markus Trippelsdorf wrote:
> > 
> > On 2016.08.27 at 11:50 +0200, Markus Trippelsdorf wrote:
> > > Hi,
> > > 
> > > since several kernel releases I get no sound for several minutes after
> > > reboot. After this delay it starts working normally.
> > > 
> > > Is this some kind of speaker protection? Is there a parameter that I can
> > > set to get sound immediately?
> > > 
> > >  % aplay -l
> > > **** List of PLAYBACK Hardware Devices ****
> > > card 0: SB [HDA ATI SB], device 0: VT1708S Analog [VT1708S Analog]
> > >   Subdevices: 1/1
> > >   Subdevice #0: subdevice #0
> > > card 0: SB [HDA ATI SB], device 3: VT1708S Digital [VT1708S Digital]
> > >   Subdevices: 1/1
> > >   Subdevice #0: subdevice #0
> > > card 1: HDMI [HDA ATI HDMI], device 3: Generic Digital [Generic Digital]
> > >   Subdevices: 1/1
> > >   Subdevice #0: subdevice #0
> > > 
> > > card 0, device 3 [VT1708S Digital] is the device that I use. It is a
> > > TOSLINK-S/PDIF link to my DAC.
> > 
> > Here is the diff (bad (after reboot) vs. good (after a few minutes)):
> > 
> > @@ -121,7 +121,7 @@
> >    Control: name="Surround Playback Volume", index=0, device=0
> >      ControlAmp: chs=3, dir=Out, idx=0, ofs=0
> >    Amp-Out caps: ofs=0x2a, nsteps=0x2a, stepsize=0x05, mute=0
> > -  Amp-Out vals:  [0x1c 0x1c]
> > +  Amp-Out vals:  [0x26 0x26]
> >    Converter: stream=0, channel=0
> >    PCM:
> >      rates [0x5e0]: 44100 48000 88200 96000 192000
> > @@ -174,12 +174,12 @@
> >      bits [0xe]: 16 20 24
> >      formats [0x1]: PCM
> >    Power states:  D0 D1 D2 D3
> > -  Power: setting=D0, actual=D0
> > +  Power: setting=D3, actual=D3
> >    Connection: 1
> >       0x1e
> 
> So this looks like the only significant change.  Others are about the
> volume level, and should lead to the complete mute.
> 
> Could you try to adjust the power state manually while it happens?
> 
> hda-verb /dev/snd/hwC0D0 0xXX SET_POWER 0x00
> 
> where 0xXX is filled with the node number of this widget.
> 
> BTW, at the next time, take a diff with -p option.  This will show the
> node ID in the diff.

Hmm, I have no /dev/snd/hwC0D0:

x4 ~ # ll /dev/snd/
total 0
drwxr-xr-x  3 root root      220 Aug 29 10:27 .
drwxr-xr-x 17 root root     3.2K Aug 29 10:27 ..
drwxr-xr-x  2 root root       80 Aug 29 10:27 by-path
crw-rw----  1 root audio 116,  4 Aug 29 10:27 controlC0
crw-rw----  1 root audio 116,  2 Aug 29 10:27 controlC1
crw-rw----  1 root audio 116,  6 Aug 29 10:27 pcmC0D0c
crw-rw----  1 root audio 116,  5 Aug 29 10:27 pcmC0D0p
crw-rw----  1 root audio 116,  7 Aug 29 10:29 pcmC0D3p
crw-rw----  1 root audio 116,  3 Aug 29 10:27 pcmC1D3p
crw-rw----  1 root audio 116,  1 Aug 29 10:27 seq
crw-rw----  1 root audio 116, 33 Aug 29 10:27 timer


x4 ~ # diff -up /var/tmp/alsa-info.txt.V6vt2PBEyd /tmp/alsa-info.txt.Vgxz8LN3wT
--- /var/tmp/alsa-info.txt.V6vt2PBEyd   2016-08-29 10:28:24.691020678 +0200
+++ /tmp/alsa-info.txt.Vgxz8LN3wT       2016-08-29 10:29:48.358506785 +0200
@@ -3,7 +3,7 @@ upload=true&script=true&cardinfo=
 !!ALSA Information Script v 0.4.64
 !!################################
 
-!!Script ran on: Mon Aug 29 08:28:24 UTC 2016
+!!Script ran on: Mon Aug 29 08:29:48 UTC 2016
 
 
 !!Linux Distribution
@@ -121,7 +121,7 @@ Node 0x11 [Audio Output] wcaps 0x41d: St
   Control: name="Surround Playback Volume", index=0, device=0
     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
   Amp-Out caps: ofs=0x2a, nsteps=0x2a, stepsize=0x05, mute=0
-  Amp-Out vals:  [0x1c 0x1c]
+  Amp-Out vals:  [0x26 0x26]
   Converter: stream=0, channel=0
   PCM:
     rates [0x5e0]: 44100 48000 88200 96000 192000
@@ -136,7 +136,7 @@ Node 0x12 [Audio Output] wcaps 0x611: St
   Control: name="IEC958 Playback Switch", index=0, device=0
   Control: name="IEC958 Default PCM Playback Switch", index=0, device=0
   Device: name="VT1708S Digital", type="HDMI", device=3
-  Converter: stream=0, channel=0
+  Converter: stream=5, channel=0
   Digital: Enabled
   Digital category: 0x0
   IEC Coding Type: 0x0
@@ -174,12 +174,12 @@ Node 0x14 [Audio Input] wcaps 0x10051b:
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Power states:  D0 D1 D2 D3
-  Power: setting=D0, actual=D0
+  Power: setting=D3, actual=D3
   Connection: 1
      0x1e
 Node 0x15 [Audio Output] wcaps 0x611: Stereo Digital
-  Converter: stream=0, channel=0
-  Digital:
+  Converter: stream=5, channel=0
+  Digital: Enabled
   Digital category: 0x0
   IEC Coding Type: 0x0
   PCM:
@@ -368,7 +368,7 @@ Node 0x24 [Audio Output] wcaps 0x41d: St
   Control: name="LFE Playback Volume", index=0, device=0
     ControlAmp: chs=2, dir=Out, idx=0, ofs=0
   Amp-Out caps: ofs=0x2a, nsteps=0x2a, stepsize=0x05, mute=0
-  Amp-Out vals:  [0x1c 0x1c]
+  Amp-Out vals:  [0x26 0x26]
   Converter: stream=0, channel=0
   PCM:
     rates [0x5e0]: 44100 48000 88200 96000 192000
@@ -380,7 +380,7 @@ Node 0x25 [Audio Output] wcaps 0x41d: St
   Control: name="Side Playback Volume", index=0, device=0
     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
   Amp-Out caps: ofs=0x2a, nsteps=0x2a, stepsize=0x05, mute=0
-  Amp-Out vals:  [0x1c 0x1c]
+  Amp-Out vals:  [0x26 0x26]
   Converter: stream=0, channel=0
   PCM:
     rates [0x5e0]: 44100 48000 88200 96000 192000
@@ -454,7 +454,7 @@ crw-rw---- 1 root audio 116,  4 Aug 29 1
 crw-rw---- 1 root audio 116,  2 Aug 29 10:27 /dev/snd/controlC1
 crw-rw---- 1 root audio 116,  6 Aug 29 10:27 /dev/snd/pcmC0D0c
 crw-rw---- 1 root audio 116,  5 Aug 29 10:27 /dev/snd/pcmC0D0p
-crw-rw---- 1 root audio 116,  7 Aug 29 10:27 /dev/snd/pcmC0D3p
+crw-rw---- 1 root audio 116,  7 Aug 29 10:29 /dev/snd/pcmC0D3p
 crw-rw---- 1 root audio 116,  3 Aug 29 10:27 /dev/snd/pcmC1D3p
 crw-rw---- 1 root audio 116,  1 Aug 29 10:27 /dev/snd/seq
 crw-rw---- 1 root audio 116, 33 Aug 29 10:27 /dev/snd/timer
@@ -534,7 +534,7 @@ card 0: SB [HDA ATI SB], device 0: VT170
   Subdevices: 1/1
   Subdevice #0: subdevice #0
 card 0: SB [HDA ATI SB], device 3: VT1708S Digital [VT1708S Digital]
-  Subdevices: 1/1
+  Subdevices: 0/1
   Subdevice #0: subdevice #0
 card 1: HDMI [HDA ATI HDMI], device 3: Generic Digital [Generic Digital]
   Subdevices: 1/1
@@ -1282,8 +1282,8 @@ state.SB {
                iface PCM
                device 3
                name 'Playback Channel Map'
-               value.0 0
-               value.1 0
+               value.0 3
+               value.1 4
                comment {
                        access read
                        type INTEGER

-- 
Markus
