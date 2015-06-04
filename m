From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] Added support for Creative
 SoundBlaster Omni Surround 5.1 USB sound card
Date: Thu, 4 Jun 2015 10:11:41 +0800
Message-ID: <CAN8ccibwks_f7S=5RxcT9vhKKcdUj1q0pkW2Ukt4gsiasvhDEg@mail.gmail.com>
References: <CAN8cciaGEY==jnmci0-_Sdgb0VqfVb84r_50J6E_rXY+Qw3KVg@mail.gmail.com>
 <CAN8ccibnZXUBQiHXTXkizGDatnUJmFT4KUAjoXKC2WKnCn0zjg@mail.gmail.com>
 <CAN8cciY7A1s=3PrYKms_9YSp3OmAj2umERQp4=E0VvpSVhz0Xg@mail.gmail.com>
 <CAN8cciaLdon3R3=vy3GGacYUVfjCBjO8e217nkpugFbXj+QE3g@mail.gmail.com>
 <CAN8cciYivuaPyuELXeKdLaVEn94evMMuw3XG3EsbGyPiMzaeyQ@mail.gmail.com>
 <CAN8ccia2ji9Kt0Au4=o9cemZe_edfzrh5TYzeD8nJdTffUpdEg@mail.gmail.com>
Reply-To: General PulseAudio Discussion
 <pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1172602507=="
Return-path: <pulseaudio-discuss-bounces@lists.freedesktop.org>
In-Reply-To: <CAN8ccia2ji9Kt0Au4=o9cemZe_edfzrh5TYzeD8nJdTffUpdEg@mail.gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
 <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
 <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Errors-To: pulseaudio-discuss-bounces@lists.freedesktop.org
Sender: "pulseaudio-discuss" <pulseaudio-discuss-bounces@lists.freedesktop.org>
To: General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--===============1172602507==
Content-Type: multipart/alternative; boundary=001a113de17642839f0517a7b2d7

--001a113de17642839f0517a7b2d7
Content-Type: text/plain; charset=UTF-8

>>
>> Have you tested surround21?
>
> Yes, front speakers work fine, however LFE doesn't seem to work. Instead
when I try to test LFE (from sound UI) I have weird noise in one of rear
speakers. There are no such problems with any other mode though (I see that
officially only 5.1 mode is supported, however 4.1, 5.0 and 5.1 all work
fine), I decided to leave 2.1 mode for now, not sure whose fault is that.

I: [pulseaudio] (alsa-lib)pcm_hw.c: Invalid PCM state for chmap_get: OPEN
I: [pulseaudio] (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_HW_PARAMS failed (-5)

http://git.alsa-project.org/?p=alsa-lib.git;a=blob;f=test/chmap.c;hb=HEAD

Do snd-usb-audio provide channel map ?

http://cgit.freedesktop.org/pulseaudio/pulseaudio/log/?qt=grep&q=lfe-filter

http://git.alsa-project.org/?p=alsa-lib.git;a=blob;f=src/conf/cards/USB-Audio.conf;hb=HEAD

   # If a device does not use the first PCM device for digital data, the
device
   # number for the iec958 device can be changed here.
   USB-Audio.pcm.iec958_device

Do the red light in the optical spdif alway turn on ?

Do the red light turn on when pulseaudio probe the devices ?

card 2: S51 [SB Omni Surround 5.1], device 0: USB Audio [USB Audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 2: S51 [SB Omni Surround 5.1], device 1: USB Audio [USB Audio #1]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 2: S51 [SB Omni Surround 5.1], device 2: USB Audio [USB Audio #2]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

--001a113de17642839f0517a7b2d7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p><br>
&gt;&gt;<br>
&gt;&gt; Have you tested surround21?<br>
&gt;<br>
&gt; Yes, front speakers work fine, however LFE doesn&#39;t seem to work. I=
nstead when I try to test LFE (from sound UI) I have weird noise in one of =
rear speakers. There are no such problems with any other mode though (I see=
 that officially only 5.1 mode is supported, however 4.1, 5.0 and 5.1 all w=
ork fine), I decided to leave 2.1 mode for now, not sure whose fault is tha=
t.</p>
<p>I: [pulseaudio] (alsa-lib)pcm_hw.c: Invalid PCM state for chmap_get: OPE=
N<br>
I: [pulseaudio] (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_HW_PARAMS failed (-5)</=
p>
<p><a href=3D"http://git.alsa-project.org/?p=3Dalsa-lib.git;a=3Dblob;f=3Dte=
st/chmap.c;hb=3DHEAD">http://git.alsa-project.org/?p=3Dalsa-lib.git;a=3Dblo=
b;f=3Dtest/chmap.c;hb=3DHEAD</a></p>
<p>Do snd-usb-audio provide channel map ?</p>
<p><a href=3D"http://cgit.freedesktop.org/pulseaudio/pulseaudio/log/?qt=3Dg=
rep&amp;q=3Dlfe-filter">http://cgit.freedesktop.org/pulseaudio/pulseaudio/l=
og/?qt=3Dgrep&amp;q=3Dlfe-filter</a><br></p>
<p><a href=3D"http://git.alsa-project.org/?p=3Dalsa-lib.git;a=3Dblob;f=3Dsr=
c/conf/cards/USB-Audio.conf;hb=3DHEAD">http://git.alsa-project.org/?p=3Dals=
a-lib.git;a=3Dblob;f=3Dsrc/conf/cards/USB-Audio.conf;hb=3DHEAD</a></p>
<p>=C2=A0=C2=A0 # If a device does not use the first PCM device for digital=
 data, the device<br>
=C2=A0=C2=A0 # number for the iec958 device can be changed here.<br>
=C2=A0=C2=A0 USB-Audio.pcm.iec958_device</p>
<p>Do the red light in the optical spdif alway turn on ?</p>
<p>Do the red light turn on when pulseaudio probe the devices ?</p>
<p>card 2: S51 [SB Omni Surround 5.1], device 0: USB Audio [USB Audio]<br>
=C2=A0 Subdevices: 1/1<br>
=C2=A0 Subdevice #0: subdevice #0<br>
card 2: S51 [SB Omni Surround 5.1], device 1: USB Audio [USB Audio #1]<br>
=C2=A0 Subdevices: 1/1<br>
=C2=A0 Subdevice #0: subdevice #0<br>
card 2: S51 [SB Omni Surround 5.1], device 2: USB Audio [USB Audio #2]<br>
=C2=A0 Subdevices: 1/1<br>
=C2=A0 Subdevice #0: subdevice #0</p>

--001a113de17642839f0517a7b2d7--

--===============1172602507==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KcHVsc2VhdWRp
by1kaXNjdXNzIG1haWxpbmcgbGlzdApwdWxzZWF1ZGlvLWRpc2N1c3NAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHA6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9wdWxz
ZWF1ZGlvLWRpc2N1c3MK

--===============1172602507==--
