From: John Stile <john@stilen.com>
Subject: Re:
	snd-hda-intel	support	for	SPDIF-in	wiht	vt1708	card?
Date: Wed, 09 Jan 2008 09:49:11 -0800
Message-ID: <1199900951.9681.88.camel@genx.localdomain>
References: <010720081840.4095.47827221000A2BAB00000FFF220702455305029A06039A9D0100@comcast.net>
	<1199777722.10421.29.camel@genx.localdomain>
	<s5hejcs931e.wl%tiwai@suse.de>
	<1199780495.10421.32.camel@genx.localdomain>
	<1199810328.10421.55.camel@genx.localdomain>
	<s5h8x302rdc.wl%tiwai@suse.de>
	<1199815030.31742.29.camel@genx.localdomain>
	<s5h7iijo3c6.wl%tiwai@suse.de>
	<1199873213.9681.50.camel@genx.localdomain>
	<s5hir233que.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-zvZ0wJ2qNXN0LkR6H4rP"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mother.stilen.com (dsl027-182-089.sfo1.dsl.speakeasy.net
	[216.27.182.89]) by alsa0.perex.cz (Postfix) with ESMTP id 3B3CA24502
	for <alsa-devel@alsa-project.org>; Wed,  9 Jan 2008 18:49:59 +0100 (CET)
In-Reply-To: <s5hir233que.wl%tiwai@suse.de>
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


--=-zvZ0wJ2qNXN0LkR6H4rP
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, 2008-01-09 at 17:29 +0100, Takashi Iwai wrote:
> To be sure: you are using 32bit version, right?
> For 64bit, the library path might be /usr/lib64, instead of /usr/lib
> (depending on distro).

Yes. 32 bit. =20
find / -name "*64*"=20
  < nothing found >
My gentoo /etc/make.conf contains
  CHOST=3D"i686-pc-linux-gnu"
  CFLAGS=3D"-march=3Di686 -mmmx -msse -msse2 -O2 -pipe -fomit-frame-point=
er"

> So far so good.
>=20
> >=20
> > IEC958 shows
> >  =E2=94=8C=E2=94=80=E2=94=80=E2=94=90
> >  =E2=94=82MM=E2=94=82=20
> > L=E2=94=94=E2=94=80=E2=94=80=E2=94=98R
> > CAPTUR

Yay!

> Attach the generated file via "alsactl -f somefile store" instead of
> ascii art.  This contains the all mixer information.

Sorry.=20
alsactl -f /etc/asound.state  store
asound.state file attached.

> It's a user error :)  The usage below, -D plug:spdif, is correct,
> though.

> > arecord -D plug:spdif        -d 10 -f dat -t wav |aplay
> >=20
> > ALSA lib dlmisc.c:118:(snd_dlsym_verify) unable to verify version for=
 symbol _snd_pcm_hook_ctl_elems_install
>=20
> OK, this is a bug in the recent alsa-lib.
> I fixed it now on HG tree.  Please update your alsa-lib repo (maybe
> better from hg.alsa-project.org).

I re-pulled alsa-lib, and now:

arecord -D plug:spdif        -d 10 -f dat -t wav |aplay
And
arecord -D cards.pcm.iec958  -d 10 -f dat -t wav |aplay

In both cases, I hear nothing, and they end with the same output:

Recording WAVE 'stdin' : Signed 16 bit Little Endian, Rate 48000 Hz, Ster=
eo
Playing WAVE 'stdin' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
arecord: pcm_read:1324: read error: Input/output error

I re-pulled alsa-lib, built successfully, and retry record, with same err=
or:

rm -rf alsa-lib
hg clone  http://hg.alsa-project.org/alsa-lib alsa-lib
pushd alsa-lib
./hgcompile && make install
popd
arecord -D plug:spdif        -d 10 -f dat -t wav |aplay

At this point, should I pull from your daily builds?

I retried arecord with verbose mode on:

arecord -v -D plug:spdif        -d 10 -f dat -t wav |aplay

Recording WAVE 'stdin' : Signed 16 bit Little Endian, Rate 48000 Hz, Ster=
eo
Plug PCM: Hooks PCM
Its setup is:
  stream       : CAPTURE
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 16
  buffer_size  : 16384
  period_size  : 4096
  period_time  : 85333
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 4096
  start_threshold  : 1
  stop_threshold   : 16384
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824
Slave: Hardware PCM card 0 'HDA VIA VT82xx' device 1 subdevice 0
Its setup is:
  stream       : CAPTURE
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 16
  buffer_size  : 16384
  period_size  : 4096
  period_time  : 85333
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 4096
  start_threshold  : 1
  stop_threshold   : 16384
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824
Playing WAVE 'stdin' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
arecord: pcm_read:1324: read error: Input/output error


--=-zvZ0wJ2qNXN0LkR6H4rP
Content-Disposition: attachment; filename=asound.state
Content-Type: text/plain; name=asound.state; charset=utf-8
Content-Transfer-Encoding: 7bit

state.VT82xx {
	control.1 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -4025
		comment.dbmax 1400
		iface MIXER
		name 'Master Front Playback Volume'
		value.0 26
		value.1 26
	}
	control.2 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Master Front Playback Switch'
		value.0 true
		value.1 true
	}
	control.3 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 27'
		comment.dbmin -4725
		comment.dbmax 0
		iface MIXER
		name 'Front Playback Volume'
		value.0 23
		value.1 23
	}
	control.4 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Front Playback Switch'
		value.0 true
		value.1 true
	}
	control.5 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -4025
		comment.dbmax 1400
		iface MIXER
		name 'Mic Playback Volume'
		value.0 26
		value.1 26
	}
	control.6 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Mic Playback Switch'
		value.0 false
		value.1 false
	}
	control.7 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -4025
		comment.dbmax 1400
		iface MIXER
		name 'Line Playback Volume'
		value.0 26
		value.1 26
	}
	control.8 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Line Playback Switch'
		value.0 true
		value.1 true
	}
	control.9 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 20'
		comment.dbmin 0
		comment.dbmax 3500
		iface MIXER
		name 'Capture Volume'
		value.0 20
		value.1 20
	}
	control.10 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Capture Switch'
		value.0 true
		value.1 true
	}
	control.11 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 20'
		comment.dbmin 0
		comment.dbmax 3500
		iface MIXER
		name 'Capture Volume'
		index 1
		value.0 20
		value.1 20
	}
	control.12 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Capture Switch'
		index 1
		value.0 true
		value.1 true
	}
	control.13 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 'Stereo Mixer'
		comment.item.1 Mic
		comment.item.2 Line
		iface MIXER
		name 'Input Source'
		value Line
	}
	control.14 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.15 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.16 {
		comment.access 'read write'
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Default'
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.17 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Switch'
		value false
	}
	control.18 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Capture Switch'
		value true
	}
	control.19 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Capture Default'
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.20 {
		comment.access 'read write user'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 255'
		comment.tlv '0000000100000008ffffec1400000014'
		comment.dbmin -5100
		comment.dbmax 0
		iface MIXER
		name 'PCM Playback Volume'
		value.0 210
		value.1 210
	}
	control.21 {
		comment.access 'read write user'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 120'
		comment.tlv '0000000100000008fffff44800000032'
		comment.dbmin -3000
		comment.dbmax 3000
		iface MIXER
		name 'Digital Capture Volume'
		value.0 116
		value.1 116
	}
}

--=-zvZ0wJ2qNXN0LkR6H4rP
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-zvZ0wJ2qNXN0LkR6H4rP--
