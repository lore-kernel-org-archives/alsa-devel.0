From: Landis McGauhey <b3zdomny@hotmail.com>
Subject: Re: is this card supported by ALSA?
Date: Wed, 16 Jul 2008 06:38:23 -0700
Message-ID: <BLU137-W200E329BE55D7983681A9958F0@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_b40a7109-724c-486b-9c4a-0850ba416ff0_"
Return-path: <alsa-user-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-user-bounces@lists.sourceforge.net
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-user@lists.sourceforge.net, devel <alsa-devel@alsa-project.org>, ALSA@sc8-sf-spam2.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--_b40a7109-724c-486b-9c4a-0850ba416ff0_
Content-Type: multipart/alternative;
	boundary="_15d954f5-54ee-4ba8-b0e6-17dccbf43395_"

--_15d954f5-54ee-4ba8-b0e6-17dccbf43395_
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable









> Date: Wed=2C 16 Jul 2008 11:16:32 +0200
> From: rene.herman@keyaccess.nl
> To: b3zdomny@hotmail.com
> CC: tiwai@suse.de=3B alsa-user@lists.sourceforge.net=3B alsa-devel@alsa-p=
roject.org
> Subject: Re: [Alsa-user] is this card supported by ALSA?

<snip>

OK=2C here we go:

# patch -p1 --dry-run < /home/bezdomny/Desktop/ens1371-ac97_reset_hack.diff=
=3D no errors

# patch -p1 < /home/bezdomny/Desktop/ens1371-ac97_reset_hack.diff=3D no err=
ors

# make=3D no errors

# make modules_install=3D no errors

# modprobe -r snd-ens1371=3D no errors

# modprobe -r es1371=3D no errors

# modprobe snd-ens1371=3D no errors

# alsamixer=3D usb mic in webcam

#alsamixer -c 1=3D  PCI card.  Checked for good levels and no mutes-- all i=
s well.

# speaker-test=3D

speaker-test 1.0.16

Playback device is default
Stream parameters are 48000Hz=2C S16_LE=2C 1 channels
Using 16 octaves of pink noise
ALSA lib pcm_dmix.c:864:(snd_pcm_dmix_open) unable to open slave

silence

# aplay -D hw:AudioPCI /usr/share/sounds/startup3.wav=3D

Playing WAVE '/usr/share/sounds/startup3.wav' : Signed 16 bit Little Endian=
=2C Rate 44100 Hz=2C Stereo

but with silence

running dmesg and attaching the result

alsaconf=3D
Unloading ALSA sound driver modules: snd-ens1371 snd-ac97-codec snd-usb-aud=
io snd-pcm snd-timer snd-page-alloc snd-usb-lib snd-rawmidi snd-seq-device =
snd-hwdep.
building card database...

following cards are found on your system:

ens1371 Creative Labs Ective 1938
legacy Probe legacy ISA (non-PnP) chips

(OK)

 Configuring snd-ens1371                        =81=20
               =81 Do you want to modify /etc/modprobe.d/sound    =81=20
               =81 (and /etc/modprobe.conf if present)?=20

(yes)

"pop" in speaker as alsaconf loads snd-ens1371

running alsamixer-- no mute toggle underneath mic=2C that's a first

and just so you know=2C  there's no mute toggle under "master"=2C "master-m=
"=2C and "PCM"=2C either=2C but that's nominal.  There was one time=2C howe=
ver=2C that "master" and/or "PCM" had a mute toggle.  Perhaps "master" and/=
or "PCM" are muted and we can't tell because there are supposed to be mute =
toggles there=2C but they are missing?  Something to consider...

#speaker -test=3D

speaker-test 1.0.16

Playback device is default
Stream parameters are 48000Hz=2C S16_LE=2C 1 channels
Using 16 octaves of pink noise
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 2048 to 16384
Period size range from 1024 to 1024
Using max buffer size 16384
Periods =3D 4
was set period_size =3D 1024
was set buffer_size =3D 16384
 0 - Front Left
Time per period =3D 2.653267

but with silence

# aplay -D hw:AudioPCI /usr/share/sounds/startup3.wav=3DPlaying WAVE '/usr/=
share/sounds/startup3.wav' : Signed 16 bit Little Endian=2C Rate 44100 Hz=
=2C Stereo
Playing WAVE '/usr/share/sounds/startup3.wav' : Signed 16 bit Little Endian=
=2C Rate 44100 Hz=2C Stereo

but with silence.

tried to run audacity=2C but it doesn't appear.  go to process table-- ther=
e's audacity=2C killed it.

ran xmms=2C changed preferences to ALSA=2C  it runs=2C you can see the volu=
me bars pumping=2C but it's silent.

and that's about it.

Not going to reboot.

Rene & Takashi: I fear this is taking up too much of our time and this effo=
rt may have long passed the point of diminishing returns.  Personally=2C my=
 goal is to have audio with Skype=2C whether with OSS or ALSA=2C I don't ca=
re.  If you want to continue to work on this for the sake of the community
at large and others who have this same card and this same problem=2C then I=
'm willing and would
be honored to be the guinea pig and be an active participant in the
community. I'm sorry this problem is so stubborn and if you have better thi=
ngs to do=2C I understand.  If you don't care to work on this anymore=2C I =
would understand and if you could perhaps just help me get sound in Skype (=
that is=2C to have /dev/dsp appear as I/O options in Skype configuration) w=
ith OSS=2C then I would be a happy camper indeed.

thank you as always for your persistence=2C expertise=2C and patience=2C

Landis










_________________________________________________________________
Use video conversation to talk face-to-face with Windows Live Messenger.
http://www.windowslive.com/messenger/connect_your_way.html?ocid=3DTXT_TAGLM=
_WL_Refresh_messenger_video_072008=

--_15d954f5-54ee-4ba8-b0e6-17dccbf43395_
Content-Type: text/html; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style>
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
FONT-SIZE: 10pt=3B
FONT-FAMILY:Tahoma
}
</style>
</head>
<body class=3D'hmmessage'>





<style>.hmmessage P{margin:0px=3Bpadding:0px}body.hmmessage{FONT-SIZE: 10pt=
=3BFONT-FAMILY:Tahoma}</style><style>.hmmessage P{margin:0px=3Bpadding:0px}=
body.hmmessage{FONT-SIZE: 10pt=3BFONT-FAMILY:Tahoma}</style><br><br>&gt=3B =
Date: Wed=2C 16 Jul 2008 11:16:32 +0200<br>&gt=3B From: rene.herman@keyacce=
ss.nl<br>&gt=3B To: b3zdomny@hotmail.com<br>&gt=3B CC: tiwai@suse.de=3B als=
a-user@lists.sourceforge.net=3B alsa-devel@alsa-project.org<br>&gt=3B Subje=
ct: Re: [Alsa-user] is this card supported by ALSA?<br><br>&lt=3Bsnip&gt=3B=
<br><br>OK=2C here we go:<br><br># patch -p1 --dry-run &lt=3B /home/bezdomn=
y/Desktop/ens1371-ac97_reset_hack.diff=3D no errors<br><br># patch -p1 &lt=
=3B /home/bezdomny/Desktop/ens1371-ac97_reset_hack.diff=3D no errors<br><br=
># make=3D no errors<br><br># make modules_install=3D no errors<br><br># mo=
dprobe -r snd-ens1371=3D no errors<br><br># modprobe -r es1371=3D no errors=
<br><br># modprobe snd-ens1371=3D no errors<br><br># alsamixer=3D usb mic i=
n webcam<br><br>#alsamixer -c 1=3D&nbsp=3B PCI card.&nbsp=3B Checked for go=
od levels and no mutes-- all is well.<br><br># speaker-test=3D<br><br>speak=
er-test 1.0.16<br><br>Playback device is default<br>Stream parameters are 4=
8000Hz=2C S16_LE=2C 1 channels<br>Using 16 octaves of pink noise<br>ALSA li=
b pcm_dmix.c:864:(snd_pcm_dmix_open) unable to open slave<br><br>silence<br=
><br># aplay -D hw:AudioPCI /usr/share/sounds/startup3.wav=3D<br><br>Playin=
g WAVE '/usr/share/sounds/startup3.wav' : Signed 16 bit Little Endian=2C Ra=
te 44100 Hz=2C Stereo<br><br>but with silence<br><br>running dmesg and atta=
ching the result<br><br>alsaconf=3D<br>Unloading ALSA sound driver modules:=
 snd-ens1371 snd-ac97-codec snd-usb-audio snd-pcm snd-timer snd-page-alloc =
snd-usb-lib snd-rawmidi snd-seq-device snd-hwdep.<br>building card database=
...<br><br>following cards are found on your system:<br><br>ens1371 Creativ=
e Labs Ective 1938<br>legacy Probe legacy ISA (non-PnP) chips<br><br>(OK)<b=
r><br>&nbsp=3BConfiguring snd-ens1371&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B =
=81 <br>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B =81 Do you want to modify /et=
c/modprobe.d/sound&nbsp=3B&nbsp=3B&nbsp=3B =81 <br>&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B =81 (and /etc/modprobe.conf if present)? <br><br>(yes)<br><br=
>"pop" in speaker as alsaconf loads snd-ens1371<br><br>running alsamixer-- =
no mute toggle underneath mic=2C that's a first<br><br>and just so you know=
=2C&nbsp=3B there's no mute toggle under "master"=2C "master-m"=2C and "PCM=
"=2C either=2C but that's nominal.&nbsp=3B There was one time=2C however=2C=
 that "master" and/or "PCM" had a mute toggle.&nbsp=3B Perhaps "master" and=
/or "PCM" are muted and we can't tell because there are supposed to be mute=
 toggles there=2C but they are missing?&nbsp=3B Something to consider...<br=
><br>#speaker -test=3D<br><br>speaker-test 1.0.16<br><br>Playback device is=
 default<br>Stream parameters are 48000Hz=2C S16_LE=2C 1 channels<br>Using =
16 octaves of pink noise<br>Rate set to 48000Hz (requested 48000Hz)<br>Buff=
er size range from 2048 to 16384<br>Period size range from 1024 to 1024<br>=
Using max buffer size 16384<br>Periods =3D 4<br>was set period_size =3D 102=
4<br>was set buffer_size =3D 16384<br>&nbsp=3B0 - Front Left<br>Time per pe=
riod =3D 2.653267<br><br>but with silence<br><br># aplay -D hw:AudioPCI /us=
r/share/sounds/startup3.wav=3DPlaying WAVE '/usr/share/sounds/startup3.wav'=
 : Signed 16 bit Little Endian=2C Rate 44100 Hz=2C Stereo<br>Playing WAVE '=
/usr/share/sounds/startup3.wav' : Signed 16 bit Little Endian=2C Rate 44100=
 Hz=2C Stereo<br><br>but with silence.<br><br>tried to run audacity=2C but =
it doesn't appear.&nbsp=3B go to process table-- there's audacity=2C killed=
 it.<br><br>ran xmms=2C changed preferences to ALSA=2C&nbsp=3B it runs=2C y=
ou can see the volume bars pumping=2C but it's silent.<br><br>and that's ab=
out it.<br><br>Not going to reboot.<br><br>Rene &amp=3B Takashi: I fear thi=
s is taking up too much of our time and this effort may have long passed th=
e point of diminishing returns.&nbsp=3B Personally=2C my goal is to have au=
dio with Skype=2C whether with OSS or ALSA=2C I don't care.&nbsp=3B If you =
want to continue to work on this for the sake of the community
at large and others who have this same card and this same problem=2C then I=
'm willing and would
be honored to be the guinea pig and be an active participant in the
community. I'm sorry this problem is so stubborn and if you have better thi=
ngs to do=2C I understand.&nbsp=3B If you don't care to work on this anymor=
e=2C I would understand and if you could perhaps just help me get sound in =
Skype (that is=2C to have /dev/dsp appear as I/O options in Skype configura=
tion) with OSS=2C then I would be a happy camper indeed.<br><br>thank you a=
s always for your persistence=2C expertise=2C and patience=2C<br><br>Landis=
<br><br><br><br><br><br><br><br><br><br><br /><hr />Use video conversation =
to talk face-to-face with Windows Live Messenger. <a href=3D'http://www.win=
dowslive.com/messenger/connect_your_way.html?ocid=3DTXT_TAGLM_WL_Refresh_me=
ssenger_video_072008' target=3D'_new'>Get started.</a></body>
</html>=

--_15d954f5-54ee-4ba8-b0e6-17dccbf43395_--

--_b40a7109-724c-486b-9c4a-0850ba416ff0_
Content-Type: text/plain
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="ens1371-ac97_reset_hack.diff_dmesg.txt"

IyBkbWVzZwpMaW51eCB2ZXJzaW9uIDIuNi4yNS45IChyb290QGJlemRvbW55KSAoZ2NjIHZlcnNp
b24gNC4zLjEgKERlYmlhbiA0LjMuMS0yKSApICMxIFNNUCBGcmkgSnVsIDQgMTk6NTI6MjAgUERU
IDIwMDgKQklPUy1wcm92aWRlZCBwaHlzaWNhbCBSQU0gbWFwOgogQklPUy1lODIwOiAwMDAwMDAw
MDAwMDAwMDAwIC0gMDAwMDAwMDAwMDA5ZmMwMCAodXNhYmxlKQogQklPUy1lODIwOiAwMDAwMDAw
MDAwMDlmYzAwIC0gMDAwMDAwMDAwMDBhMDAwMCAocmVzZXJ2ZWQpCiBCSU9TLWU4MjA6IDAwMDAw
MDAwMDAwZTAwMDAgLSAwMDAwMDAwMDAwMTAwMDAwIChyZXNlcnZlZCkKIEJJT1MtZTgyMDogMDAw
MDAwMDAwMDEwMDAwMCAtIDAwMDAwMDAwM2ZmYzAwMDAgKHVzYWJsZSkKIEJJT1MtZTgyMDogMDAw
MDAwMDAzZmZjMDAwMCAtIDAwMDAwMDAwM2ZmZjgwMDAgKEFDUEkgZGF0YSkKIEJJT1MtZTgyMDog
MDAwMDAwMDAzZmZmODAwMCAtIDAwMDAwMDAwNDAwMDAwMDAgKEFDUEkgTlZTKQogQklPUy1lODIw
OiAwMDAwMDAwMGZlYzAwMDAwIC0gMDAwMDAwMDBmZWMwMTAwMCAocmVzZXJ2ZWQpCiBCSU9TLWU4
MjA6IDAwMDAwMDAwZmVlMDAwMDAgLSAwMDAwMDAwMGZlZTAxMDAwIChyZXNlcnZlZCkKIEJJT1Mt
ZTgyMDogMDAwMDAwMDBmZmI4MDAwMCAtIDAwMDAwMDAwZmZjMDAwMDAgKHJlc2VydmVkKQogQklP
Uy1lODIwOiAwMDAwMDAwMGZmZjAwMDAwIC0gMDAwMDAwMDEwMDAwMDAwMCAocmVzZXJ2ZWQpCjEy
N01CIEhJR0hNRU0gYXZhaWxhYmxlLgo4OTZNQiBMT1dNRU0gYXZhaWxhYmxlLgpTY2FuIFNNUCBm
cm9tIGMwMDAwMDAwIGZvciAxMDI0IGJ5dGVzLgpTY2FuIFNNUCBmcm9tIGMwMDlmYzAwIGZvciAx
MDI0IGJ5dGVzLgpTY2FuIFNNUCBmcm9tIGMwMGYwMDAwIGZvciA2NTUzNiBieXRlcy4KU2NhbiBT
TVAgZnJvbSBjMDA5ZmMwMCBmb3IgMTAyNCBieXRlcy4KRW50ZXJpbmcgYWRkX2FjdGl2ZV9yYW5n
ZSgwLCAwLCAyNjIwODApIDAgZW50cmllcyBvZiAyNTYgdXNlZApab25lIFBGTiByYW5nZXM6CiAg
RE1BICAgICAgICAgICAgIDAgLT4gICAgIDQwOTYKICBOb3JtYWwgICAgICAgNDA5NiAtPiAgIDIy
OTM3NgogIEhpZ2hNZW0gICAgMjI5Mzc2IC0+ICAgMjYyMDgwCk1vdmFibGUgem9uZSBzdGFydCBQ
Rk4gZm9yIGVhY2ggbm9kZQplYXJseV9ub2RlX21hcFsxXSBhY3RpdmUgUEZOIHJhbmdlcwogICAg
MDogICAgICAgIDAgLT4gICAyNjIwODAKT24gbm9kZSAwIHRvdGFscGFnZXM6IDI2MjA4MAogIERN
QSB6b25lOiAzMiBwYWdlcyB1c2VkIGZvciBtZW1tYXAKICBETUEgem9uZTogMCBwYWdlcyByZXNl
cnZlZAogIERNQSB6b25lOiA0MDY0IHBhZ2VzLCBMSUZPIGJhdGNoOjAKICBOb3JtYWwgem9uZTog
MTc2MCBwYWdlcyB1c2VkIGZvciBtZW1tYXAKICBOb3JtYWwgem9uZTogMjIzNTIwIHBhZ2VzLCBM
SUZPIGJhdGNoOjMxCiAgSGlnaE1lbSB6b25lOiAyNTUgcGFnZXMgdXNlZCBmb3IgbWVtbWFwCiAg
SGlnaE1lbSB6b25lOiAzMjQ0OSBwYWdlcywgTElGTyBiYXRjaDo3CiAgTW92YWJsZSB6b25lOiAw
IHBhZ2VzIHVzZWQgZm9yIG1lbW1hcApETUkgMi4zIHByZXNlbnQuCkFDUEk6IFJTRFAgMDAwRkY5
ODAsIDAwMTQgKHIwIEFNSSAgICkKQUNQSTogUlNEVCAzRkZGMDAwMCwgMDAzMCAocjEgREVMTCAg
IEZsYXNoICAgIDIwMDIwMjEyIE1TRlQgICAgIDEwMTEpCkFDUEk6IEZBQ1AgM0ZGRjEwMDAsIDAw
NzQgKHIxIERFTEwgICBGbGFzaCAgICAyMDAyMDIxMiBNU0ZUICAgICAxMDExKQpBQ1BJOiBEU0RU
IDNGRkUwMDAwLCAyRTNBIChyMSBEODQ1UFQgRkxBU0ggICAgICAgICAgIDEgTVNGVCAgMTAwMDAw
QikKQUNQSTogRkFDUyAzRkZGODAwMCwgMDA0MApBQ1BJOiBBUElDIDNGRkUyRTNBLCAwMDY4IChy
MSBERUxMICAgRmxhc2ggICAgMjAwMjAyMTIgTVNGVCAgICAgMTAxMSkKQUNQSTogU1NEVCAzRkZF
MkVBMiwgMDAzNSAocjEgRDg0NVBUIEZMQVNIICAgICAgICAgICAxIE1TRlQgIDEwMDAwMEIpCkFD
UEk6IFBNLVRpbWVyIElPIFBvcnQ6IDB4NDA4CkFDUEk6IExvY2FsIEFQSUMgYWRkcmVzcyAweGZl
ZTAwMDAwCkFDUEk6IExBUElDIChhY3BpX2lkWzB4MDFdIGxhcGljX2lkWzB4MDBdIGVuYWJsZWQp
ClByb2Nlc3NvciAjMCAxNToxIEFQSUMgdmVyc2lvbiAyMApBQ1BJOiBMQVBJQyAoYWNwaV9pZFsw
eDAyXSBsYXBpY19pZFsweDAxXSBkaXNhYmxlZCkKQUNQSTogTEFQSUNfTk1JIChhY3BpX2lkWzB4
MDFdIGRmbCBkZmwgbGludFsweDFdKQpBQ1BJOiBMQVBJQ19OTUkgKGFjcGlfaWRbMHgwMl0gZGZs
IGRmbCBsaW50WzB4MV0pCkFDUEk6IElPQVBJQyAoaWRbMHgwMl0gYWRkcmVzc1sweGZlYzAwMDAw
XSBnc2lfYmFzZVswXSkKSU9BUElDWzBdOiBhcGljX2lkIDIsIHZlcnNpb24gMzIsIGFkZHJlc3Mg
MHhmZWMwMDAwMCwgR1NJIDAtMjMKQUNQSTogSU5UX1NSQ19PVlIgKGJ1cyAwIGJ1c19pcnEgOSBn
bG9iYWxfaXJxIDkgaGlnaCBsZXZlbCkKQUNQSTogSU5UX1NSQ19PVlIgKGJ1cyAwIGJ1c19pcnEg
MCBnbG9iYWxfaXJxIDIgZGZsIGRmbCkKQUNQSTogSVJRMCB1c2VkIGJ5IG92ZXJyaWRlLgpBQ1BJ
OiBJUlEyIHVzZWQgYnkgb3ZlcnJpZGUuCkFDUEk6IElSUTkgdXNlZCBieSBvdmVycmlkZS4KRW5h
YmxpbmcgQVBJQyBtb2RlOiAgRmxhdC4gIFVzaW5nIDEgSS9PIEFQSUNzClVzaW5nIEFDUEkgKE1B
RFQpIGZvciBTTVAgY29uZmlndXJhdGlvbiBpbmZvcm1hdGlvbgpBbGxvY2F0aW5nIFBDSSByZXNv
dXJjZXMgc3RhcnRpbmcgYXQgNTAwMDAwMDAgKGdhcDogNDAwMDAwMDA6YmVjMDAwMDApCkJ1aWx0
IDEgem9uZWxpc3RzIGluIFpvbmUgb3JkZXIsIG1vYmlsaXR5IGdyb3VwaW5nIG9uLiAgVG90YWwg
cGFnZXM6IDI2MDAzMwpLZXJuZWwgY29tbWFuZCBsaW5lOiByb290PS9kZXYvbWFwcGVyL2JlemRv
bW55LXJvb3Qgcm8gCm1hcHBlZCBBUElDIHRvIGZmZmZiMDAwIChmZWUwMDAwMCkKbWFwcGVkIElP
QVBJQyB0byBmZmZmYTAwMCAoZmVjMDAwMDApCkVuYWJsaW5nIGZhc3QgRlBVIHNhdmUgYW5kIHJl
c3RvcmUuLi4gZG9uZS4KRW5hYmxpbmcgdW5tYXNrZWQgU0lNRCBGUFUgZXhjZXB0aW9uIHN1cHBv
cnQuLi4gZG9uZS4KSW5pdGlhbGl6aW5nIENQVSMwClBJRCBoYXNoIHRhYmxlIGVudHJpZXM6IDQw
OTYgKG9yZGVyOiAxMiwgMTYzODQgYnl0ZXMpCkRldGVjdGVkIDE1OTQuODQ0IE1IeiBwcm9jZXNz
b3IuCkNvbnNvbGU6IGNvbG91ciBWR0ErIDgweDI1CmNvbnNvbGUgW3R0eTBdIGVuYWJsZWQKRGVu
dHJ5IGNhY2hlIGhhc2ggdGFibGUgZW50cmllczogMTMxMDcyIChvcmRlcjogNywgNTI0Mjg4IGJ5
dGVzKQpJbm9kZS1jYWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6IDY1NTM2IChvcmRlcjogNiwgMjYy
MTQ0IGJ5dGVzKQpNZW1vcnk6IDEwMjkzODhrLzEwNDgzMjBrIGF2YWlsYWJsZSAoMTY4Mmsga2Vy
bmVsIGNvZGUsIDE4MTg0ayByZXNlcnZlZCwgNjg3ayBkYXRhLCAyMjBrIGluaXQsIDEzMDgxNmsg
aGlnaG1lbSkKdmlydHVhbCBrZXJuZWwgbWVtb3J5IGxheW91dDoKICAgIGZpeG1hcCAgOiAweGZm
ZjRkMDAwIC0gMHhmZmZmZjAwMCAgICggNzEyIGtCKQogICAgcGttYXAgICA6IDB4ZmY4MDAwMDAg
LSAweGZmYzAwMDAwICAgKDQwOTYga0IpCiAgICB2bWFsbG9jIDogMHhmODgwMDAwMCAtIDB4ZmY3
ZmUwMDAgICAoIDExMSBNQikKICAgIGxvd21lbSAgOiAweGMwMDAwMDAwIC0gMHhmODAwMDAwMCAg
ICggODk2IE1CKQogICAgICAuaW5pdCA6IDB4YzAzNTkwMDAgLSAweGMwMzkwMDAwICAgKCAyMjAg
a0IpCiAgICAgIC5kYXRhIDogMHhjMDJhNGJlYiAtIDB4YzAzNTBhMTQgICAoIDY4NyBrQikKICAg
ICAgLnRleHQgOiAweGMwMTAwMDAwIC0gMHhjMDJhNGJlYiAgICgxNjgyIGtCKQpDaGVja2luZyBp
ZiB0aGlzIHByb2Nlc3NvciBob25vdXJzIHRoZSBXUCBiaXQgZXZlbiBpbiBzdXBlcnZpc29yIG1v
ZGUuLi5Pay4KQ1BBOiBwYWdlIHBvb2wgaW5pdGlhbGl6ZWQgMSBvZiAxIHBhZ2VzIHByZWFsbG9j
YXRlZApDYWxpYnJhdGluZyBkZWxheSB1c2luZyB0aW1lciBzcGVjaWZpYyByb3V0aW5lLi4gMzE5
My41MSBCb2dvTUlQUyAobHBqPTYzODcwMzApClNlY3VyaXR5IEZyYW1ld29yayBpbml0aWFsaXpl
ZApTRUxpbnV4OiAgRGlzYWJsZWQgYXQgYm9vdC4KQ2FwYWJpbGl0eSBMU00gaW5pdGlhbGl6ZWQK
TW91bnQtY2FjaGUgaGFzaCB0YWJsZSBlbnRyaWVzOiA1MTIKQ1BVOiBUcmFjZSBjYWNoZTogMTJL
IHVvcHMsIEwxIEQgY2FjaGU6IDhLCkNQVTogTDIgY2FjaGU6IDI1NksKQ1BVOiBIeXBlci1UaHJl
YWRpbmcgaXMgZGlzYWJsZWQKSW50ZWwgbWFjaGluZSBjaGVjayBhcmNoaXRlY3R1cmUgc3VwcG9y
dGVkLgpJbnRlbCBtYWNoaW5lIGNoZWNrIHJlcG9ydGluZyBlbmFibGVkIG9uIENQVSMwLgpDUFUw
OiBJbnRlbCBQNC9YZW9uIEV4dGVuZGVkIE1DRSBNU1JzICgxMikgYXZhaWxhYmxlCkNQVTA6IFRo
ZXJtYWwgbW9uaXRvcmluZyBlbmFibGVkCkNvbXBhdCB2RFNPIG1hcHBlZCB0byBmZmZmZTAwMC4K
Q2hlY2tpbmcgJ2hsdCcgaW5zdHJ1Y3Rpb24uLi4gT0suClNNUCBhbHRlcm5hdGl2ZXM6IHN3aXRj
aGluZyB0byBVUCBjb2RlCkZyZWVpbmcgU01QIGFsdGVybmF0aXZlczogMTdrIGZyZWVkCkFDUEk6
IENvcmUgcmV2aXNpb24gMjAwNzAxMjYKQ1BVMDogSW50ZWwoUikgUGVudGl1bShSKSA0IENQVSAx
LjYwR0h6IHN0ZXBwaW5nIDAyClRvdGFsIG9mIDEgcHJvY2Vzc29ycyBhY3RpdmF0ZWQgKDMxOTMu
NTEgQm9nb01JUFMpLgpFTkFCTElORyBJTy1BUElDIElSUXMKLi5USU1FUjogdmVjdG9yPTB4MzEg
YXBpYzE9MCBwaW4xPTIgYXBpYzI9LTEgcGluMj0tMQpCcm91Z2h0IHVwIDEgQ1BVcwpuZXRfbmFt
ZXNwYWNlOiA1NDggYnl0ZXMKTkVUOiBSZWdpc3RlcmVkIHByb3RvY29sIGZhbWlseSAxNgpBQ1BJ
OiBidXMgdHlwZSBwY2kgcmVnaXN0ZXJlZApQQ0k6IFBDSSBCSU9TIHJldmlzaW9uIDIuMTAgZW50
cnkgYXQgMHhmZGE5NSwgbGFzdCBidXM9MgpQQ0k6IFVzaW5nIGNvbmZpZ3VyYXRpb24gdHlwZSAx
ClNldHRpbmcgdXAgc3RhbmRhcmQgUENJIHJlc291cmNlcwpBQ1BJOiBFQzogTG9vayB1cCBFQyBp
biBEU0RUCkFDUEk6IEludGVycHJldGVyIGVuYWJsZWQKQUNQSTogKHN1cHBvcnRzIFMwIFMxIFMz
IFM1KQpBQ1BJOiBVc2luZyBJT0FQSUMgZm9yIGludGVycnVwdCByb3V0aW5nCkFDUEk6IFBDSSBS
b290IEJyaWRnZSBbUENJMF0gKDAwMDA6MDApCnBjaSAwMDAwOjAwOjFmLjA6IHF1aXJrOiByZWdp
b24gMDQwMC0wNDdmIGNsYWltZWQgYnkgSUNINCBBQ1BJL0dQSU8vVENPCnBjaSAwMDAwOjAwOjFm
LjA6IHF1aXJrOiByZWdpb24gMDUwMC0wNTNmIGNsYWltZWQgYnkgSUNINCBHUElPClBDSTogVHJh
bnNwYXJlbnQgYnJpZGdlIC0gMDAwMDowMDoxZS4wCkFDUEk6IFBDSSBJbnRlcnJ1cHQgUm91dGlu
ZyBUYWJsZSBbXF9TQl8uUENJMC5fUFJUXQpBQ1BJOiBQQ0kgSW50ZXJydXB0IFJvdXRpbmcgVGFi
bGUgW1xfU0JfLlBDSTAuUENJMS5fUFJUXQpBQ1BJOiBQQ0kgSW50ZXJydXB0IExpbmsgW0xOS0Fd
IChJUlFzIDMgNCA1IDYgNyA5IDEwICoxMSAxMiAxNCAxNSkKQUNQSTogUENJIEludGVycnVwdCBM
aW5rIFtMTktCXSAoSVJRcyAzIDQgNSA2IDcgOSAqMTAgMTEgMTIgMTQgMTUpCkFDUEk6IFBDSSBJ
bnRlcnJ1cHQgTGluayBbTE5LQ10gKElSUXMgMyA0IDUgNiA3IDkgMTAgMTEgMTIgMTQgMTUpICow
LCBkaXNhYmxlZC4KQUNQSTogUENJIEludGVycnVwdCBMaW5rIFtMTktEXSAoSVJRcyAzIDQgKjUg
NiA3IDkgMTAgMTEgMTIgMTQgMTUpCkFDUEk6IFBDSSBJbnRlcnJ1cHQgTGluayBbTE5LRV0gKElS
UXMgMyA0IDUgNiA3IDkgMTAgMTEgMTIgMTQgMTUpICowLCBkaXNhYmxlZC4KQUNQSTogUENJIElu
dGVycnVwdCBMaW5rIFtMTktGXSAoSVJRcyAqMyA0IDUgNiA3IDkgMTAgMTEgMTIgMTQgMTUpCkFD
UEk6IFBDSSBJbnRlcnJ1cHQgTGluayBbTE5LR10gKElSUXMgMyA0IDUgNiA3IDkgMTAgKjExIDEy
IDE0IDE1KQpBQ1BJOiBQQ0kgSW50ZXJydXB0IExpbmsgW0xOS0hdIChJUlFzIDMgNCA1IDYgNyAq
OSAxMCAxMSAxMiAxNCAxNSkKQUNQSTogUG93ZXIgUmVzb3VyY2UgW0ZERFBdIChvZmYpCkFDUEk6
IFBvd2VyIFJlc291cmNlIFtVUlAxXSAob2ZmKQpBQ1BJOiBQb3dlciBSZXNvdXJjZSBbVVJQMl0g
KG9mZikKQUNQSTogUG93ZXIgUmVzb3VyY2UgW0xQVFBdIChvZmYpCkxpbnV4IFBsdWcgYW5kIFBs
YXkgU3VwcG9ydCB2MC45NyAoYykgQWRhbSBCZWxheQpwbnA6IFBuUCBBQ1BJIGluaXQKQUNQSTog
YnVzIHR5cGUgcG5wIHJlZ2lzdGVyZWQKcG5wOiBQblAgQUNQSTogZm91bmQgMTIgZGV2aWNlcwpB
Q1BJOiBBQ1BJIGJ1cyB0eXBlIHBucCB1bnJlZ2lzdGVyZWQKUG5QQklPUzogRGlzYWJsZWQgYnkg
QUNQSSBQTlAKUENJOiBVc2luZyBBQ1BJIGZvciBJUlEgcm91dGluZwpQQ0k6IElmIGEgZGV2aWNl
IGRvZXNuJ3Qgd29yaywgdHJ5ICJwY2k9cm91dGVpcnEiLiAgSWYgaXQgaGVscHMsIHBvc3QgYSBy
ZXBvcnQKTkVUOiBSZWdpc3RlcmVkIHByb3RvY29sIGZhbWlseSA4Ck5FVDogUmVnaXN0ZXJlZCBw
cm90b2NvbCBmYW1pbHkgMjAKc3lzdGVtIDAwOjBiOiBpb21lbSByYW5nZSAweDAtMHg5ZmZmZiBj
b3VsZCBub3QgYmUgcmVzZXJ2ZWQKc3lzdGVtIDAwOjBiOiBpb21lbSByYW5nZSAweGUwMDAwLTB4
ZmZmZmYgY291bGQgbm90IGJlIHJlc2VydmVkCnN5c3RlbSAwMDowYjogaW9tZW0gcmFuZ2UgMHgx
MDAwMDAtMHgzZmZmZmZmZiBjb3VsZCBub3QgYmUgcmVzZXJ2ZWQKc3lzdGVtIDAwOjBiOiBpb21l
bSByYW5nZSAweGZlYzAwMDAwLTB4ZmVjMDBmZmYgY291bGQgbm90IGJlIHJlc2VydmVkCnN5c3Rl
bSAwMDowYjogaW9tZW0gcmFuZ2UgMHhmZWUwMDAwMC0weGZlZTAwZmZmIGNvdWxkIG5vdCBiZSBy
ZXNlcnZlZApQQ0k6IEJyaWRnZTogMDAwMDowMDowMS4wCiAgSU8gd2luZG93OiBkaXNhYmxlZC4K
ICBNRU0gd2luZG93OiAweGZjNTAwMDAwLTB4ZmU1ZmZmZmYKICBQUkVGRVRDSCB3aW5kb3c6IDB4
MDAwMDAwMDBlNDIwMDAwMC0weDAwMDAwMDAwZjQyZmZmZmYKUENJOiBCcmlkZ2U6IDAwMDA6MDA6
MWUuMAogIElPIHdpbmRvdzogZDAwMC1kZmZmCiAgTUVNIHdpbmRvdzogMHhmZTYwMDAwMC0weGZl
YWZmZmZmCiAgUFJFRkVUQ0ggd2luZG93OiAweDAwMDAwMDAwZjQzMDAwMDAtMHgwMDAwMDAwMGY0
M2ZmZmZmClBDSTogU2V0dGluZyBsYXRlbmN5IHRpbWVyIG9mIGRldmljZSAwMDAwOjAwOjFlLjAg
dG8gNjQKTkVUOiBSZWdpc3RlcmVkIHByb3RvY29sIGZhbWlseSAyCklQIHJvdXRlIGNhY2hlIGhh
c2ggdGFibGUgZW50cmllczogMzI3NjggKG9yZGVyOiA1LCAxMzEwNzIgYnl0ZXMpClRDUCBlc3Rh
Ymxpc2hlZCBoYXNoIHRhYmxlIGVudHJpZXM6IDEzMTA3MiAob3JkZXI6IDgsIDEwNDg1NzYgYnl0
ZXMpClRDUCBiaW5kIGhhc2ggdGFibGUgZW50cmllczogNjU1MzYgKG9yZGVyOiA3LCA1MjQyODgg
Ynl0ZXMpClRDUDogSGFzaCB0YWJsZXMgY29uZmlndXJlZCAoZXN0YWJsaXNoZWQgMTMxMDcyIGJp
bmQgNjU1MzYpClRDUCByZW5vIHJlZ2lzdGVyZWQKY2hlY2tpbmcgaWYgaW1hZ2UgaXMgaW5pdHJh
bWZzLi4uIGl0IGlzCkZyZWVpbmcgaW5pdHJkIG1lbW9yeTogNjIzNmsgZnJlZWQKYXVkaXQ6IGlu
aXRpYWxpemluZyBuZXRsaW5rIHNvY2tldCAoZGlzYWJsZWQpCnR5cGU9MjAwMCBhdWRpdCgxMjE2
MTgzNDQ0LjExNjoxKTogaW5pdGlhbGl6ZWQKaGlnaG1lbSBib3VuY2UgcG9vbCBzaXplOiA2NCBw
YWdlcwpWRlM6IERpc2sgcXVvdGFzIGRxdW90XzYuNS4xCkRxdW90LWNhY2hlIGhhc2ggdGFibGUg
ZW50cmllczogMTAyNCAob3JkZXIgMCwgNDA5NiBieXRlcykKaW8gc2NoZWR1bGVyIG5vb3AgcmVn
aXN0ZXJlZAppbyBzY2hlZHVsZXIgYW50aWNpcGF0b3J5IHJlZ2lzdGVyZWQKaW8gc2NoZWR1bGVy
IGRlYWRsaW5lIHJlZ2lzdGVyZWQKaW8gc2NoZWR1bGVyIGNmcSByZWdpc3RlcmVkIChkZWZhdWx0
KQpwY2kgMDAwMDowMTowMC4wOiBCb290IHZpZGVvIGRldmljZQpwY2kgMDAwMDowMjowOS4wOiBG
aXJtd2FyZSBsZWZ0IGUxMDAgaW50ZXJydXB0cyBlbmFibGVkOyBkaXNhYmxpbmcKaXNhcG5wOiBT
Y2FubmluZyBmb3IgUG5QIGNhcmRzLi4uCmlzYXBucDogTm8gUGx1ZyAmIFBsYXkgZGV2aWNlIGZv
dW5kClNlcmlhbDogODI1MC8xNjU1MCBkcml2ZXIgJFJldmlzaW9uOiAxLjkwICQgNCBwb3J0cywg
SVJRIHNoYXJpbmcgZW5hYmxlZApzZXJpYWw4MjUwOiB0dHlTMCBhdCBJL08gMHgzZjggKGlycSA9
IDQpIGlzIGEgMTY1NTBBCjAwOjA4OiB0dHlTMCBhdCBJL08gMHgzZjggKGlycSA9IDQpIGlzIGEg
MTY1NTBBCmJyZDogbW9kdWxlIGxvYWRlZApQTlA6IFBTLzIgQ29udHJvbGxlciBbUE5QMDMwMzpQ
UzJLLFBOUDBmMDM6UFMyTV0gYXQgMHg2MCwweDY0IGlycSAxLDEyCnNlcmlvOiBpODA0MiBLQkQg
cG9ydCBhdCAweDYwLDB4NjQgaXJxIDEKc2VyaW86IGk4MDQyIEFVWCBwb3J0IGF0IDB4NjAsMHg2
NCBpcnEgMTIKbWljZTogUFMvMiBtb3VzZSBkZXZpY2UgY29tbW9uIGZvciBhbGwgbWljZQpjcHVp
ZGxlOiB1c2luZyBnb3Zlcm5vciBsYWRkZXIKVENQIGJpYyByZWdpc3RlcmVkCk5FVDogUmVnaXN0
ZXJlZCBwcm90b2NvbCBmYW1pbHkgMQpORVQ6IFJlZ2lzdGVyZWQgcHJvdG9jb2wgZmFtaWx5IDE3
ClVzaW5nIElQSSBOby1TaG9ydGN1dCBtb2RlCkZyZWVpbmcgdW51c2VkIGtlcm5lbCBtZW1vcnk6
IDIyMGsgZnJlZWQKaW5wdXQ6IEFUIFRyYW5zbGF0ZWQgU2V0IDIga2V5Ym9hcmQgYXMgL2NsYXNz
L2lucHV0L2lucHV0MApBQ1BJOiBBQ1BJMDAwNzowMCBpcyByZWdpc3RlcmVkIGFzIGNvb2xpbmdf
ZGV2aWNlMApVbmlmb3JtIE11bHRpLVBsYXRmb3JtIEUtSURFIGRyaXZlcgppZGU6IEFzc3VtaW5n
IDMzTUh6IHN5c3RlbSBidXMgc3BlZWQgZm9yIFBJTyBtb2Rlczsgb3ZlcnJpZGUgd2l0aCBpZGVi
dXM9eHgKZTEwMDogSW50ZWwoUikgUFJPLzEwMCBOZXR3b3JrIERyaXZlciwgMy41LjIzLWs0LU5B
UEkKZTEwMDogQ29weXJpZ2h0KGMpIDE5OTktMjAwNiBJbnRlbCBDb3Jwb3JhdGlvbgpBQ1BJOiBQ
Q0kgSW50ZXJydXB0IDAwMDA6MDI6MDkuMFtBXSAtPiBHU0kgMjEgKGxldmVsLCBsb3cpIC0+IElS
USAyMQplMTAwOiBldGgwOiBlMTAwX3Byb2JlOiBhZGRyIDB4ZmVhZmYwMDAsIGlycSAyMSwgTUFD
IGFkZHIgMDA6MDI6YjM6OTk6NWI6OTEKSUNIMjogSURFIGNvbnRyb2xsZXIgKDB4ODA4NjoweDI0
NGIgcmV2IDB4MDUpIGF0ICBQQ0kgc2xvdCAwMDAwOjAwOjFmLjEKSUNIMjogbm90IDEwMCUgbmF0
aXZlIG1vZGU6IHdpbGwgcHJvYmUgaXJxcyBsYXRlcgogICAgaWRlMDogQk0tRE1BIGF0IDB4ZmZh
MC0weGZmYTcsIEJJT1Mgc2V0dGluZ3M6IGhkYTpETUEsIGhkYjpETUEKICAgIGlkZTE6IEJNLURN
QSBhdCAweGZmYTgtMHhmZmFmLCBCSU9TIHNldHRpbmdzOiBoZGM6RE1BLCBoZGQ6UElPClByb2Jp
bmcgSURFIGludGVyZmFjZSBpZGUwLi4uCnVzYmNvcmU6IHJlZ2lzdGVyZWQgbmV3IGludGVyZmFj
ZSBkcml2ZXIgdXNiZnMKdXNiY29yZTogcmVnaXN0ZXJlZCBuZXcgaW50ZXJmYWNlIGRyaXZlciBo
dWIKdXNiY29yZTogcmVnaXN0ZXJlZCBuZXcgZGV2aWNlIGRyaXZlciB1c2IKVVNCIFVuaXZlcnNh
bCBIb3N0IENvbnRyb2xsZXIgSW50ZXJmYWNlIGRyaXZlciB2My4wCkZsb3BweSBkcml2ZShzKTog
ZmQwIGlzIDEuNDRNCkZEQyAwIGlzIGEgcG9zdC0xOTkxIDgyMDc3CmhkYTogU1QzNDAwMTZBLCBB
VEEgRElTSyBkcml2ZQpoZGI6IFNUMzgwMDExQSwgQVRBIERJU0sgZHJpdmUKaGRhOiBob3N0IG1h
eCBQSU80IHdhbnRlZCBQSU8yNTUoYXV0by10dW5lKSBzZWxlY3RlZCBQSU80CmhkYTogVURNQS8x
MDAgbW9kZSBzZWxlY3RlZApoZGI6IGhvc3QgbWF4IFBJTzQgd2FudGVkIFBJTzI1NShhdXRvLXR1
bmUpIHNlbGVjdGVkIFBJTzQKaGRiOiBVRE1BLzEwMCBtb2RlIHNlbGVjdGVkClByb2JpbmcgSURF
IGludGVyZmFjZSBpZGUxLi4uCmhkYzogQ1JELTg0ODJCLCBBVEFQSSBDRC9EVkQtUk9NIGRyaXZl
CmhkYzogaG9zdCBtYXggUElPNCB3YW50ZWQgUElPMjU1KGF1dG8tdHVuZSkgc2VsZWN0ZWQgUElP
NApoZGM6IERpc2FibGluZyAoVSlETUEgZm9yIENSRC04NDgyQiAoYmxhY2tsaXN0ZWQpCmhkYzog
aG9zdCBtYXggUElPNCB3YW50ZWQgUElPMjU1KGF1dG8tdHVuZSkgc2VsZWN0ZWQgUElPNAppZGUw
IGF0IDB4MWYwLTB4MWY3LDB4M2Y2IG9uIGlycSAxNAppZGUxIGF0IDB4MTcwLTB4MTc3LDB4Mzc2
IG9uIGlycSAxNQpBQ1BJOiBQQ0kgSW50ZXJydXB0IDAwMDA6MDA6MWYuMltEXSAtPiBHU0kgMTkg
KGxldmVsLCBsb3cpIC0+IElSUSAxOQpQQ0k6IFNldHRpbmcgbGF0ZW5jeSB0aW1lciBvZiBkZXZp
Y2UgMDAwMDowMDoxZi4yIHRvIDY0CnVoY2lfaGNkIDAwMDA6MDA6MWYuMjogVUhDSSBIb3N0IENv
bnRyb2xsZXIKdWhjaV9oY2QgMDAwMDowMDoxZi4yOiBuZXcgVVNCIGJ1cyByZWdpc3RlcmVkLCBh
c3NpZ25lZCBidXMgbnVtYmVyIDEKdWhjaV9oY2QgMDAwMDowMDoxZi4yOiBpcnEgMTksIGlvIGJh
c2UgMHgwMDAwZWY0MAp1c2IgdXNiMTogY29uZmlndXJhdGlvbiAjMSBjaG9zZW4gZnJvbSAxIGNo
b2ljZQpodWIgMS0wOjEuMDogVVNCIGh1YiBmb3VuZApodWIgMS0wOjEuMDogMiBwb3J0cyBkZXRl
Y3RlZApBQ1BJOiBQQ0kgSW50ZXJydXB0IDAwMDA6MDA6MWYuNFtDXSAtPiBHU0kgMjMgKGxldmVs
LCBsb3cpIC0+IElSUSAyMwpQQ0k6IFNldHRpbmcgbGF0ZW5jeSB0aW1lciBvZiBkZXZpY2UgMDAw
MDowMDoxZi40IHRvIDY0CnVoY2lfaGNkIDAwMDA6MDA6MWYuNDogVUhDSSBIb3N0IENvbnRyb2xs
ZXIKdWhjaV9oY2QgMDAwMDowMDoxZi40OiBuZXcgVVNCIGJ1cyByZWdpc3RlcmVkLCBhc3NpZ25l
ZCBidXMgbnVtYmVyIDIKdWhjaV9oY2QgMDAwMDowMDoxZi40OiBpcnEgMjMsIGlvIGJhc2UgMHgw
MDAwZWY4MAp1c2IgdXNiMjogY29uZmlndXJhdGlvbiAjMSBjaG9zZW4gZnJvbSAxIGNob2ljZQpo
dWIgMi0wOjEuMDogVVNCIGh1YiBmb3VuZApodWIgMi0wOjEuMDogMiBwb3J0cyBkZXRlY3RlZApo
ZGE6IG1heCByZXF1ZXN0IHNpemU6IDEyOEtpQgpoZGE6IDc4MTY1MzYwIHNlY3RvcnMgKDQwMDIw
IE1CKSB3LzIwNDhLaUIgQ2FjaGUsIENIUz02NTUzNS8xNi82MwpoZGE6IGNhY2hlIGZsdXNoZXMg
bm90IHN1cHBvcnRlZAogaGRhOiBoZGExCmhkYjogbWF4IHJlcXVlc3Qgc2l6ZTogNTEyS2lCCmhk
YjogMTU2MzAxNDg4IHNlY3RvcnMgKDgwMDI2IE1CKSB3LzIwNDhLaUIgQ2FjaGUsIENIUz0xNjM4
My8yNTUvNjMKaGRiOiBjYWNoZSBmbHVzaGVzIHN1cHBvcnRlZAogaGRiOiBoZGIxIGhkYjIgPCBo
ZGI1ID4KaGRjOiBBVEFQSSA0OFggQ0QtUk9NIGRyaXZlLCAxMjhrQiBDYWNoZQpVbmlmb3JtIENE
LVJPTSBkcml2ZXIgUmV2aXNpb246IDMuMjAKdXNiIDEtMTogbmV3IGZ1bGwgc3BlZWQgVVNCIGRl
dmljZSB1c2luZyB1aGNpX2hjZCBhbmQgYWRkcmVzcyAyCnVzYiAxLTE6IGNvbmZpZ3VyYXRpb24g
IzEgY2hvc2VuIGZyb20gMSBjaG9pY2UKZGV2aWNlLW1hcHBlcjogaW9jdGw6IDQuMTMuMC1pb2N0
bCAoMjAwNy0xMC0xOCkgaW5pdGlhbGlzZWQ6IGRtLWRldmVsQHJlZGhhdC5jb20KdXNiIDItMTog
bmV3IGZ1bGwgc3BlZWQgVVNCIGRldmljZSB1c2luZyB1aGNpX2hjZCBhbmQgYWRkcmVzcyAyCnVz
YiAyLTE6IGNvbmZpZ3VyYXRpb24gIzEgY2hvc2VuIGZyb20gMSBjaG9pY2UKcGFkbG9jazogVklB
IFBhZExvY2sgbm90IGRldGVjdGVkLgpram91cm5hbGQgc3RhcnRpbmcuICBDb21taXQgaW50ZXJ2
YWwgNSBzZWNvbmRzCkVYVDMtZnM6IG1vdW50ZWQgZmlsZXN5c3RlbSB3aXRoIG9yZGVyZWQgZGF0
YSBtb2RlLgpkY2RiYXMgZGNkYmFzOiBEZWxsIFN5c3RlbXMgTWFuYWdlbWVudCBCYXNlIERyaXZl
ciAodmVyc2lvbiA1LjYuMC0zLjIpCkxpbnV4IGFncGdhcnQgaW50ZXJmYWNlIHYwLjEwMwphZ3Bn
YXJ0OiBEZXRlY3RlZCBhbiBJbnRlbCA4NDVHIENoaXBzZXQuCmFncGdhcnQ6IEFHUCBhcGVydHVy
ZSBpcyA2NE0gQCAweGY4MDAwMDAwCnBjaV9ob3RwbHVnOiBQQ0kgSG90IFBsdWcgUENJIENvcmUg
dmVyc2lvbjogMC41CnNocGNocDogU3RhbmRhcmQgSG90IFBsdWcgUENJIENvbnRyb2xsZXIgRHJp
dmVyIHZlcnNpb246IDAuNAppbnRlbF9ybmc6IEZpcm13YXJlIHNwYWNlIGlzIGxvY2tlZCByZWFk
LW9ubHkuIElmIHlvdSBjYW4ndCBvcgppbnRlbF9ybmc6IGRvbid0IHdhbnQgdG8gZGlzYWJsZSB0
aGlzIGluIGZpcm13YXJlIHNldHVwLCBhbmQgaWYKaW50ZWxfcm5nOiB5b3UgYXJlIGNlcnRhaW4g
dGhhdCB5b3VyIHN5c3RlbSBoYXMgYSBmdW5jdGlvbmFsCmludGVsX3JuZzogUk5HLCB0cnkgdXNp
bmcgdGhlICdub19md2hfZGV0ZWN0JyBvcHRpb24uCmlucHV0OiBQb3dlciBCdXR0b24gKEZGKSBh
cyAvY2xhc3MvaW5wdXQvaW5wdXQxCkFDUEk6IFBvd2VyIEJ1dHRvbiAoRkYpIFtQV1JGXQppbnB1
dDogUG93ZXIgQnV0dG9uIChDTSkgYXMgL2NsYXNzL2lucHV0L2lucHV0MgpBQ1BJOiBQb3dlciBC
dXR0b24gKENNKSBbUEJUTl0KQUNQSTogUENJIEludGVycnVwdCAwMDAwOjAxOjAwLjBbQV0gLT4g
R1NJIDE2IChsZXZlbCwgbG93KSAtPiBJUlEgMTYKbnZpZGlhZmI6IERldmljZSBJRDogMTBkZTAx
MTAgCmVzMTM3MTogdmVyc2lvbiB2MC4zMiB0aW1lIDE3OjMxOjA3IEp1bCAxMCAyMDA4CkxpbnV4
IHZpZGVvIGNhcHR1cmUgaW50ZXJmYWNlOiB2Mi4wMApwd2M6IFBoaWxpcHMgd2ViY2FtIG1vZHVs
ZSB2ZXJzaW9uIDEwLjAuMTMgbG9hZGVkLgpwd2M6IFN1cHBvcnRzIFBoaWxpcHMgUENBNjQ1LzY0
NiwgUENWQzY3NS82ODAvNjkwLCBQQ1ZDNzIwWzQwXS83MzAvNzQwLzc1MCAmIFBDVkM4MzAvODQw
Lgpwd2M6IEFsc28gc3VwcG9ydHMgdGhlIEFza2V5IFZDMDEwLCB2YXJpb3VzIExvZ2l0ZWNoIFF1
aWNrY2FtcywgU2Ftc3VuZyBNUEMtQzEwIGFuZCBNUEMtQzMwLApwd2M6IHRoZSBDcmVhdGl2ZSBX
ZWJDYW0gNSAmIFBybyBFeCwgU09URUMgQWZpbmEgRXllIGFuZCBWaXNpb25pdGUgVkNTLVVDMzAw
IGFuZCBWQ1MtVU0xMDAuCnB3YzogTG9naXRlY2ggUXVpY2tDYW0gWm9vbSBVU0Igd2ViY2FtIGRl
dGVjdGVkLgpwd2M6IFJlZ2lzdGVyZWQgYXMgL2Rldi92aWRlbzAuCmlucHV0OiBQQyBTcGVha2Vy
IGFzIC9jbGFzcy9pbnB1dC9pbnB1dDMKbnZpZGlhZmI6IEVESUQgZm91bmQgZnJvbSBCVVMxCiAg
ICAgIERpc3BsYXkgaXMgR1RGIGNhcGFibGUKaTJjLWFkYXB0ZXIgaTJjLTE6IHVuYWJsZSB0byBy
ZWFkIEVESUQgYmxvY2suCnVzYmNvcmU6IHJlZ2lzdGVyZWQgbmV3IGludGVyZmFjZSBkcml2ZXIg
UGhpbGlwcyB3ZWJjYW0KaTJjLWFkYXB0ZXIgaTJjLTE6IHVuYWJsZSB0byByZWFkIEVESUQgYmxv
Y2suCmkyYy1hZGFwdGVyIGkyYy0xOiB1bmFibGUgdG8gcmVhZCBFRElEIGJsb2NrLgpudmlkaWFm
YjogVW5hYmxlIHRvIGRldGVjdCB3aGljaCBDUlRDTnVtYmVyLi4uCi4uLkRlZmF1bHRpbmcgdG8g
Q1JUQ051bWJlciAwCm52aWRpYWZiOiBVc2luZyBDUlQgb24gQ1JUQyAwCm52aWRpYWZiOiBNVFJS
IHNldCB0byBPTgpDb25zb2xlOiBzd2l0Y2hpbmcgdG8gY29sb3VyIGZyYW1lIGJ1ZmZlciBkZXZp
Y2UgMTYweDY0Cm52aWRpYWZiOiBQQ0kgblZpZGlhIE5WMTEgZnJhbWVidWZmZXIgKDY0TUIgQCAw
eEU4MDAwMDAwKQpBQ1BJOiBQQ0kgSW50ZXJydXB0IDAwMDA6MDA6MWYuM1tCXSAtPiBHU0kgMTcg
KGxldmVsLCBsb3cpIC0+IElSUSAxNwpBQ1BJOiBQQ0kgSW50ZXJydXB0IDAwMDA6MDI6MGIuMFtB
XSAtPiBHU0kgMjMgKGxldmVsLCBsb3cpIC0+IElSUSAyMwplczEzNzE6IGZvdW5kIGNoaXAsIHZl
bmRvciBpZCAweDExMDIgZGV2aWNlIGlkIDB4ODkzOCByZXZpc2lvbiAweDAwCmVzMTM3MTogZm91
bmQgZXMxMzcxIHJldiAwIGF0IGlvIDB4ZGU4MCBpcnEgMjMKZXMxMzcxOiBFbmFibGluZyBpbnRl
cm5hbCBhbXBsaWZpZXIuCmFjOTdfY29kZWM6IEFDOTcgQXVkaW8gY29kZWMsIGlkOiAgKFVua25v
d24pCmdhbWVwb3J0OiBFU1MxMzcxIEdhbWVwb3J0IGlzIGlzYTAyMTgvZ2FtZXBvcnQwLCBpbyAw
eDIxOCwgc3BlZWQgMTEyNWtIegppbnB1dDogSW1FeFBTLzIgTG9naXRlY2ggV2hlZWwgTW91c2Ug
YXMgL2NsYXNzL2lucHV0L2lucHV0NApwYXJwb3J0X3BjIDAwOjA5OiByZXBvcnRlZCBieSBQbHVn
IGFuZCBQbGF5IEFDUEkKcGFycG9ydDA6IFBDLXN0eWxlIGF0IDB4Mzc4LCBpcnEgNyBbUENTUFAs
VFJJU1RBVEUsRVBQXQp1c2Jjb3JlOiByZWdpc3RlcmVkIG5ldyBpbnRlcmZhY2UgZHJpdmVyIHNu
ZC11c2ItYXVkaW8KRVhUMyBGUyBvbiBkbS0xLCBpbnRlcm5hbCBqb3VybmFsCmxvb3A6IG1vZHVs
ZSBsb2FkZWQKa2pvdXJuYWxkIHN0YXJ0aW5nLiAgQ29tbWl0IGludGVydmFsIDUgc2Vjb25kcwpF
WFQzIEZTIG9uIGhkYjEsIGludGVybmFsIGpvdXJuYWwKRVhUMy1mczogbW91bnRlZCBmaWxlc3lz
dGVtIHdpdGggb3JkZXJlZCBkYXRhIG1vZGUuCkFkZGluZyAyNzE1NjQwayBzd2FwIG9uIC9kZXYv
bWFwcGVyL2JlemRvbW55LXN3YXBfMS4gIFByaW9yaXR5Oi0xIGV4dGVudHM6MSBhY3Jvc3M6Mjcx
NTY0MGsKZTEwMDogZXRoMDogZTEwMF93YXRjaGRvZzogbGluayB1cCwgMTAwTWJwcywgZnVsbC1k
dXBsZXgKbHAwOiB1c2luZyBwYXJwb3J0MCAoaW50ZXJydXB0LWRyaXZlbikuCnBwZGV2OiB1c2Vy
LXNwYWNlIHBhcmFsbGVsIHBvcnQgZHJpdmVyCk5FVDogUmVnaXN0ZXJlZCBwcm90b2NvbCBmYW1p
bHkgMTAKbG86IERpc2FibGVkIFByaXZhY3kgRXh0ZW5zaW9ucwp3YXJuaW5nOiBgYXZhaGktZGFl
bW9uJyB1c2VzIDMyLWJpdCBjYXBhYmlsaXRpZXMgKGxlZ2FjeSBzdXBwb3J0IGluIHVzZSkKZXRo
MDogbm8gSVB2NiByb3V0ZXJzIHByZXNlbnQKZXMxMzcxOiB1bmxvYWRpbmcKZ2FtZXBvcnQ6IGtn
YW1lcG9ydGQgZXhpdGluZw==

--_b40a7109-724c-486b-9c4a-0850ba416ff0_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--_b40a7109-724c-486b-9c4a-0850ba416ff0_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-user mailing list
Alsa-user@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-user

--_b40a7109-724c-486b-9c4a-0850ba416ff0_--
