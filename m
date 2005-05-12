From: spiral <spiral@laposte.net>
Subject: Re: Alsa-devel digest, Vol 1 #3297 - 13 msgs
Date: Thu, 12 May 2005 22:46:08 +0200
Message-ID: <200505122246.08566.spiral@laposte.net>
References: <20050512154727.B414212F1B@sc8-sf-spam2.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050512154727.B414212F1B@sc8-sf-spam2.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I can't have this patch working... I don't manage to set position_fix=3D1..=
=2E How=20
should I do so ? Maybe isn't it up2date on the cvs ?

Anyway, I give a copy of "cat /proc/asound/card0/codec#*" here :

Codec: Realtek ALC880
Address: 0
Vendor Id: 0x10ec0880
Subsystem Id: 0x0
Revision Id: 0x90500
Default PCM: rates 0x560, bits 0x0e, types 0x1
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
Node 0x02 [Audio Output] wcaps 0x411: Stereo
  PCM: rates 0x560, bits 0x0e, types 0x1
Node 0x03 [Audio Output] wcaps 0x411: Stereo
  PCM: rates 0x560, bits 0x0e, types 0x1
Node 0x04 [Audio Output] wcaps 0x411: Stereo
  PCM: rates 0x160, bits 0x0e, types 0x1
Node 0x05 [Audio Output] wcaps 0x411: Stereo
  PCM: rates 0x160, bits 0x0e, types 0x1
Node 0x06 [Audio Output] wcaps 0x211: Stereo Digital
  PCM: rates 0x160, bits 0x1e, types 0x1
Node 0x07 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Amp-In caps: ofs=3D0x00, nsteps=3D0x23, stepsize=3D0x03, mute=3D1
  Amp-In vals: 0x00 0x00
  PCM: rates 0x160, bits 0x06, types 0x1
  Connection: 7
     0x18* 0x19 0x1a 0x1b 0x1c 0x14 0x15
Node 0x08 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Amp-In caps: ofs=3D0x00, nsteps=3D0x23, stepsize=3D0x03, mute=3D1
  Amp-In vals: 0x00 0x00
  PCM: rates 0x160, bits 0x06, types 0x1
  Connection: 7
     0x18 0x19 0x1a* 0x1b 0x1c 0x14 0x15
Node 0x09 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Amp-In caps: ofs=3D0x00, nsteps=3D0x23, stepsize=3D0x03, mute=3D1
  Amp-In vals: 0x00 0x00
  PCM: rates 0x160, bits 0x06, types 0x1
  Connection: 10
     0x18 0x19 0x1a 0x1b 0x1c* 0x0b 0x14 0x15 0x16 0x17
Node 0x0a [Audio Input] wcaps 0x100391: Stereo Digital
  PCM: rates 0x160, bits 0x1e, types 0x1
  Connection: 1
     0x1f
Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=3D0x23, nsteps=3D0x41, stepsize=3D0x03, mute=3D1
  Amp-In vals: 0xa3 0xa3
  Connection: 8
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15
Node 0x0c [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals: 0x00 0x00
  Amp-Out caps: ofs=3D0x40, nsteps=3D0x40, stepsize=3D0x03, mute=3D0
  Amp-Out vals: 0x40 0x40
  Connection: 2
     0x02 0x0b
Node 0x0d [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals: 0x00 0x00
  Amp-Out caps: ofs=3D0x40, nsteps=3D0x40, stepsize=3D0x03, mute=3D0
  Amp-Out vals: 0x40 0x40
  Connection: 2
     0x03 0x0b
Node 0x0e [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals: 0x00 0x00
  Amp-Out caps: ofs=3D0x40, nsteps=3D0x40, stepsize=3D0x03, mute=3D0
  Amp-Out vals: 0x40 0x40
  Connection: 2
     0x04 0x0b
Node 0x0f [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals: 0x00 0x00
  Amp-Out caps: ofs=3D0x40, nsteps=3D0x40, stepsize=3D0x03, mute=3D0
  Amp-Out vals: 0x40 0x40
  Connection: 2
     0x05 0x0b
Node 0x10 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 4
     0x0c* 0x0d 0x0e 0x0f
Node 0x11 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 4
     0x0c* 0x0d 0x0e 0x0f
Node 0x12 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 4
     0x0c* 0x0d 0x0e 0x0f
Node 0x13 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 4
     0x0c* 0x0d 0x0e 0x0f
Node 0x14 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals: 0x00 0x00
  Pincap 0x083f: IN OUT HP
  Pin Default 0x01014020: [Jack] Line Out at Ext Rear
    Conn =3D 1/8, Color =3D Green
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0c
Node 0x15 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals: 0x00 0x00
  Pincap 0x083f: IN OUT HP
  Pin Default 0x01014021: [Jack] Line Out at Ext Rear
    Conn =3D 1/8, Color =3D Green
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0d
Node 0x16 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals: 0x00 0x00
  Pincap 0x083f: IN OUT HP
  Pin Default 0x01019022: [Jack] Line Out at Ext Rear
    Conn =3D 1/8, Color =3D Pink
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0e
Node 0x17 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals: 0x80 0x80
  Pincap 0x083f: IN OUT HP
  Pin Default 0x01013023: [Jack] Line Out at Ext Rear
    Conn =3D 1/8, Color =3D Blue
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0f
Node 0x18 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals: 0x80 0x80
  Pincap 0x08133f: IN OUT HP
  Pin Default 0x01a19031: [Jack] Mic at Ext Rear
    Conn =3D 1/8, Color =3D Pink
  Pin-ctls: 0x20: IN
  Connection: 1
     0x10
Node 0x19 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals: 0x80 0x80
  Pincap 0x08133f: IN OUT HP
  Pin Default 0x02a19060: [Jack] Mic at Ext Front
    Conn =3D 1/8, Color =3D Pink
  Pin-ctls: 0x20: IN
  Connection: 1
     0x11
Node 0x1a [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals: 0x80 0x80
  Pincap 0x08133f: IN OUT HP
  Pin Default 0x01813030: [Jack] Line In at Ext Rear
    Conn =3D 1/8, Color =3D Blue
  Pin-ctls: 0x20: IN
  Connection: 1
     0x12
Node 0x1b [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals: 0x00 0x00
  Pincap 0x08133f: IN OUT HP
  Pin Default 0x02214050: [Jack] HP Out at Ext Front
    Conn =3D 1/8, Color =3D Green
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x13
Node 0x1c [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x9933f170: [Fixed] CD at Int ATAPI
    Conn =3D ATAPI, Color =3D Other
  Pin-ctls: 0x00:
Node 0x1d [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x0820: IN
  Pin Default 0x99f3f180: [Fixed] Other at Int ATAPI
    Conn =3D ATAPI, Color =3D Other
  Pin-ctls: 0x00:
Node 0x1e [Pin Complex] wcaps 0x400300: Mono Digital
  Pincap 0x0810: OUT
  Pin Default 0x01442100: [Jack] SPDIF Out at Ext Rear
    Conn =3D RCA, Color =3D Grey
  Pin-ctls: 0x00:
  Connection: 1
     0x06
Node 0x1f [Pin Complex] wcaps 0x400200: Mono Digital
  Pincap 0x0820: IN
  Pin Default 0x01c42110: [Jack] SPDIF In at Ext Rear
    Conn =3D RCA, Color =3D Grey
  Pin-ctls: 0x00:
Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
Node 0x21 [Volume Knob Widget] wcaps 0x600080: Mono

Thanks for your help

Goodbye


=2D-=20
spiral


Le Jeudi 12 Mai 2005 17:45, alsa-devel-request@lists.sourceforge.net a =C3=
=A9crit=C2=A0:
> Date: Thu, 12 May 2005 16:25:02 +0200
> From: Takashi Iwai <tiwai@suse.de>
> To: fab <fab@gnux.info>
> Cc: alsa-devel@lists.sourceforge.net
> Subject: Re: [Alsa-devel] Medion + intel hda tests
>
> At Wed, 11 May 2005 00:02:38 +0200,
>
> fab wrote:
> > Hi,
> > since I reported bugs as well as I can and gave no answers,
>
> Since I've been in vacation and had no net access ;);)
>
> > =C2=A0I started to
> > do some very basic tests and sourcecode reading.
> > I tried to modprobe snd-hda-intel with different "model" option and then
> > tested all the outputs, I only marked the working ones :
> >
> > Availables inputs:
> > =C2=A0[front] [surround] [center] , [headphone]
> > tested model :
> > =C2=A03stack =C2=A0 =C2=A0 =C2=A0 =C2=A0: front
> > =C2=A03stack-digout : front
> > =C2=A05stack =C2=A0 =C2=A0 =C2=A0 =C2=A0: front
> > =C2=A05stack-digout : front
> > =C2=A0w810 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: front surround
>
> This implies that the pin assignment is different from what the normal
> models suppose.
>
> I added the "test" model for debugging such cases to ALSA CVS.
> Try ALSA CVS version (driver and lib), and set "model=3Dtest" module
> option to snd-hda-intel module. =C2=A0Then you'll have fully controllable
> volumes and switches.
>
> The noisy output may be fixed by setting "position_fix=3D1" or
> "position_fix=3D2" module option.
>
> Anyway, please show the content of /proc/asound/card0/codec#* file.
>
>
> Takashi


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
