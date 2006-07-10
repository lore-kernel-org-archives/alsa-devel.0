From: Rene Rebe <rene@exactcode.de>
Subject: Re: ALSA Intel HDA MacBook
Date: Mon, 10 Jul 2006 13:44:13 +0200
Message-ID: <200607101344.13837.rene@exactcode.de>
References: <200607081323.17265.rene@exactcode.de>
	<200607082120.02137.rene@exactcode.de>
	<s5hk66lda2l.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hk66lda2l.wl%tiwai@suse.de>
Content-Disposition: inline
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
Cc: Nicolas Boichat <nicolas@boichat.ch>, Matt Porter <mporter@embeddedalley.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

On Monday 10 July 2006 12:32, Takashi Iwai wrote:
> At Sat, 8 Jul 2006 21:20:02 +0200,
> Rene Rebe wrote:
> > =

> > +static unsigned int apple_pin_configs[10] =3D {
> > +	0x0121E230, 0x90A70120, 0x9017E110, 0x400000FE,
> > +	0x400000FD, 0x0181E021, 0x1145E040, 0x400000FA,
> > +	0x400000FC, 0x400000FB,
> > +};
> > +
> =

> Interesting.  How did yo figure this out?

No idea, as I wrote the best patch "I found" on the internet. I think
it was Nicolas who came up with it.

> > The patch might work on the MacBook Pro, I have none - how-
> > ever the MacBook has three speakers, a left and right one and
> > one under the keyboard for the bass and mids. However this
> > third speaker is only driver when the headphone right channel
> > is unmuted and consequently continous to play the sound
> > when the headphone is plugged in and the speakers are suppost
> > to be muted. Only the left and right channel is muted in that
> > case - this "below the keyboard" bass speaker still emmits
> > the audio and it's volume is controlled by the right headphone
> > channel (???).
> =

> Is the headphone itself controlled via "Headphone" volume mixer?
> Or is it unaffected?

Yes, the headphone is controlled with Headphone volume control
just that it's right channel also controlls this center speaker below
the keyboard.

> Anyway, show /proc/asound/card0/codec#*, and the kernel message
> regarding pin detections (after compiling with debug option).

Codec: SigmaTel STAC9221 A1
Address: 0
Vendor Id: 0x83847680
Subsystem Id: 0x100
Revision Id: 0x103401
Default PCM: rates 0x7e0, bits 0x0e, types 0x1
Default Amp-In caps: ofs=3D0x00, nsteps=3D0x0e, stepsize=3D0x05, mute=3D1
Default Amp-Out caps: ofs=3D0x7f, nsteps=3D0x7f, stepsize=3D0x02, mute=3D1
Node 0x02 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0xff 0xff]
  Power: 0x0
Node 0x03 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0xff 0xff]
  Power: 0x0
Node 0x04 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0xff 0xff]
  Power: 0x0
Node 0x05 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0xff 0xff]
  Power: 0x0
Node 0x06 [Audio Input] wcaps 0x1d0541: Stereo
  Power: 0x0
  Connection: 1
     0x17
Node 0x07 [Audio Input] wcaps 0x1d0541: Stereo
  Power: 0x0
  Connection: 1
     0x18
Node 0x08 [Audio Output] wcaps 0x40211: Stereo Digital
  PCM: rates 0x7e0, bits 0x0e, types 0x5
Node 0x09 [Audio Input] wcaps 0x140311: Stereo Digital
  PCM: rates 0x160, bits 0x0e, types 0x5
  Connection: 1
     0x11
Node 0x0a [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x08173f: IN OUT HP
  Pin Default 0x0121e230: [Jack] HP Out at Ext Rear
    Conn =3D 1/8, Color =3D White
  Pin-ctls: 0x80: HP
  Connection: 1
     0x02
Node 0x0b [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x081737: IN OUT
  Pin Default 0x90a70120: [Fixed] Mic at Int N/A
    Conn =3D Analog, Color =3D Unknown
  Pin-ctls: 0x24: IN
  Connection: 1
     0x04
Node 0x0c [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x081737: IN OUT
  Pin Default 0x9017e110: [Fixed] Speaker at Int N/A
    Conn =3D Analog, Color =3D White
  Pin-ctls: 0x60: IN OUT
  Connection: 1
     0x03
Node 0x0d [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x08173f: IN OUT HP
  Pin Default 0x400000fe: [N/A] Line Out at Ext N/A
    Conn =3D Unknown, Color =3D Unknown
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x02
Node 0x0e [Pin Complex] wcaps 0x400081: Stereo
  Pincap 0x0824: IN
  Pin Default 0x400000fd: [N/A] Line Out at Ext N/A
    Conn =3D Unknown, Color =3D Unknown
  Pin-ctls: 0x20: IN
Node 0x0f [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x0837: IN OUT
  Pin Default 0x0181e021: [Jack] Line In at Ext Rear
    Conn =3D 1/8, Color =3D White
  Pin-ctls: 0x20: IN
  Connection: 1
     0x05
Node 0x10 [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x0810: OUT
  Pin Default 0x1145e040: [Jack] SPDIF Out at Int Rear
    Conn =3D Optical, Color =3D White
  Pin-ctls: 0x40: OUT
  Connection: 3
     0x08* 0x17 0x19
Node 0x11 [Pin Complex] wcaps 0x430681: Stereo Digital
  Pincap 0x0810024: IN
  Pin Default 0x400000fa: [N/A] Line Out at Ext N/A
    Conn =3D Unknown, Color =3D Unknown
  Pin-ctls: 0x00:
  Power: 0x0
Node 0x12 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x04, stepsize=3D0x27, mute=3D0
  Amp-Out vals:  [0x00 0x00]
  Connection: 7
     0x0e* 0x15 0x0f 0x0b 0x0c 0x0d 0x0a
Node 0x13 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x04, stepsize=3D0x27, mute=3D0
  Amp-Out vals:  [0x00 0x00]
  Connection: 7
     0x0e 0x15* 0x0f 0x0b 0x0c 0x0d 0x0a
Node 0x14 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
  Amp-Out caps: ofs=3D0x03, nsteps=3D0x03, stepsize=3D0x17, mute=3D0
  Amp-Out vals:  [0x00]
Node 0x15 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x400000fc: [N/A] Line Out at Ext N/A
    Conn =3D Unknown, Color =3D Unknown
  Pin-ctls: 0x00:
Node 0x16 [Volume Knob Widget] wcaps 0x600000: Mono
Node 0x17 [Audio Selector] wcaps 0x300903: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x80 0x80]
  Connection: 1
     0x12
Node 0x18 [Audio Selector] wcaps 0x300903: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x80 0x80]
  Connection: 1
     0x13
Node 0x19 [Vendor Defined Widget] wcaps 0xf30201: Stereo Digital
Node 0x1a [Audio Output] wcaps 0x30201: Stereo Digital
Node 0x1b [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x0810: OUT
  Pin Default 0x400000fb: [N/A] Line Out at Ext N/A
    Conn =3D Unknown, Color =3D Unknown
  Pin-ctls: 0x00:
  Connection: 1
     0x1a

I think there is no printout of the snd-intel-hda driver about pin
config, should there?

> > Since I have no spec for the Intel HDA or Sigmatel chip
> > (the SigmaTel STAC9221 A1) I feel a bit lost.
> =

> Heh, nor do I ;)

Ouhm.

-- =

Ren=E9 Rebe - ExactCODE - Berlin (Europe / Germany)
            http://exactcode.de | http://t2-project.org | http://rene.rebe.=
name
            +49 (0)30 / 255 897 45


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
