From: Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: Re: No sound for several minutes after reboot
Date: Mon, 29 Aug 2016 10:56:53 +0200
Message-ID: <20160829085653.GA306@x4>
References: <20160827095018.GA309@x4> <20160827113908.GA312@x4>
 <s5htwe4t2hy.wl-tiwai@suse.de> <20160829083334.GA309@x4>
 <s5hshtot1e2.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.ud10.udmedia.de (ud10.udmedia.de [194.117.254.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D2C02676A5
 for <alsa-devel@alsa-project.org>; Mon, 29 Aug 2016 19:21:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hshtot1e2.wl-tiwai@suse.de>
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

On 2016.08.29 at 10:39 +0200, Takashi Iwai wrote:
> On Mon, 29 Aug 2016 10:33:34 +0200,
> Markus Trippelsdorf wrote:
> > 
> > On 2016.08.29 at 10:15 +0200, Takashi Iwai wrote:
> > > On Sat, 27 Aug 2016 13:39:08 +0200,
> > > Markus Trippelsdorf wrote:
> > > > 
> > > > On 2016.08.27 at 11:50 +0200, Markus Trippelsdorf wrote:
> > > > > Hi,
> > > > > 
> > > > > since several kernel releases I get no sound for several minutes after
> > > > > reboot. After this delay it starts working normally.
> > > > > 
> > > > > Is this some kind of speaker protection? Is there a parameter that I can
> > > > > set to get sound immediately?
> > > > > 
> > > > >  % aplay -l
> > > > > **** List of PLAYBACK Hardware Devices ****
> > > > > card 0: SB [HDA ATI SB], device 0: VT1708S Analog [VT1708S Analog]
> > > > >   Subdevices: 1/1
> > > > >   Subdevice #0: subdevice #0
> > > > > card 0: SB [HDA ATI SB], device 3: VT1708S Digital [VT1708S Digital]
> > > > >   Subdevices: 1/1
> > > > >   Subdevice #0: subdevice #0
> > > > > card 1: HDMI [HDA ATI HDMI], device 3: Generic Digital [Generic Digital]
> > > > >   Subdevices: 1/1
> > > > >   Subdevice #0: subdevice #0
> > > > > 
> > > > > card 0, device 3 [VT1708S Digital] is the device that I use. It is a
> > > > > TOSLINK-S/PDIF link to my DAC.
> > > > 
> > > > Here is the diff (bad (after reboot) vs. good (after a few minutes)):
> > > > 
> > > > @@ -121,7 +121,7 @@
> > > >    Control: name="Surround Playback Volume", index=0, device=0
> > > >      ControlAmp: chs=3, dir=Out, idx=0, ofs=0
> > > >    Amp-Out caps: ofs=0x2a, nsteps=0x2a, stepsize=0x05, mute=0
> > > > -  Amp-Out vals:  [0x1c 0x1c]
> > > > +  Amp-Out vals:  [0x26 0x26]
> > > >    Converter: stream=0, channel=0
> > > >    PCM:
> > > >      rates [0x5e0]: 44100 48000 88200 96000 192000
> > > > @@ -174,12 +174,12 @@
> > > >      bits [0xe]: 16 20 24
> > > >      formats [0x1]: PCM
> > > >    Power states:  D0 D1 D2 D3
> > > > -  Power: setting=D0, actual=D0
> > > > +  Power: setting=D3, actual=D3
> > > >    Connection: 1
> > > >       0x1e
> > > 
> > > So this looks like the only significant change.  Others are about the
> > > volume level, and should lead to the complete mute.
> > > 
> > > Could you try to adjust the power state manually while it happens?
> > > 
> > > hda-verb /dev/snd/hwC0D0 0xXX SET_POWER 0x00
> > > 
> > > where 0xXX is filled with the node number of this widget.
> > > 
> > > BTW, at the next time, take a diff with -p option.  This will show the
> > > node ID in the diff.
> > 
> > Hmm, I have no /dev/snd/hwC0D0:
> 
> Build your kernel with CONFIG_SND_HDA_HWDEP=y.
> 
> > @@ -174,12 +174,12 @@ Node 0x14 [Audio Input] wcaps 0x10051b:
> >      bits [0xe]: 16 20 24
> >      formats [0x1]: PCM
> >    Power states:  D0 D1 D2 D3
> > -  Power: setting=D0, actual=D0
> > +  Power: setting=D3, actual=D3
> 
> So it's 0x14.

Thanks.

Unfortunately running: hda-verb /dev/snd/hwC0D0 0x14 SET_POWER 0x00
has no effect.

-- 
Markus
