From: "Ivan N. Zlatev" <contact@i-nz.net>
Subject: Re: Strange findings about the microphone in SigmaTel
	STAC9221 A1
Date: Tue, 15 May 2007 18:11:58 +0100
Message-ID: <3db1ec7f0705151011w7e511e50p9397a8429083d956@mail.gmail.com>
References: <3db1ec7f0705110248p788b3d9q2ea5774331fded9d@mail.gmail.com>
	<s5hps52gtmx.wl%tiwai@suse.de>
	<3db1ec7f0705150741k72427556y6b91d9ab13cba5c5@mail.gmail.com>
	<s5hbqgmgm8h.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_2369_26361928.1179249118392"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.228])
	by alsa0.perex.cz (Postfix) with ESMTP id 131902486A
	for <alsa-devel@alsa-project.org>;
	Tue, 15 May 2007 19:12:04 +0200 (CEST)
Received: by wr-out-0506.google.com with SMTP id 58so1948246wri
	for <alsa-devel@alsa-project.org>; Tue, 15 May 2007 10:11:59 -0700 (PDT)
In-Reply-To: <s5hbqgmgm8h.wl%tiwai@suse.de>
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

------=_Part_2369_26361928.1179249118392
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I was wrong about _vref. Output %X of pincap  and returned vref as
follows on modprobe:

hda_codec: STAC922x, Apple subsys_id=106b1700
ALSA /root/tmp/alsa-driver-1.0.14rc4/pci/hda/hda_codec.c:2270:
autoconfig: line_outs=1 (0xd/0x0/0x0/0x0/0x0)
ALSA /root/tmp/alsa-driver-1.0.14rc4/pci/hda/hda_codec.c:2274:
speaker_outs=1 (0xc/0x0/0x0/0x0/0x0)
ALSA /root/tmp/alsa-driver-1.0.14rc4/pci/hda/hda_codec.c:2278:
hp_outs=1 (0xa/0x0/0x0/0x0/0x0)
ALSA /root/tmp/alsa-driver-1.0.14rc4/pci/hda/hda_codec.c:2286:
inputs: mic=0xb, fmic=0xe, line=0xf, fline=0x0, cd=0x0, aux=0x0
17 - AC_PINCTL_VREF_80
0 - AC_PINCTL_VREF_0
17 - AC_PINCTL_VREF_80

> Could you check the connection of node 0x12 at the very beginning?
> I guess it's not 0x0b.

Node 0x12 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 7
     0x0e* 0x15 0x0f 0x0b 0x0c 0x0d 0x0a

> Then try to add model=macbook or model=macbook-pro-v2.  Now iMac has
> its own pin setting (corresponding to model=imac-intel).

I am on an intel imac. Also I wanted to mention that I have manged to
get hold of the pin configs supplied by apple for windows for all
apple systems. I mailed them last month to the list. I don't honestly
know if they could be of any use to you. For example according to them
for my codec subsystem's the pin config is:

[HKR\Settings\Pin\0A]
CfgDflt = dword: 0x0121E21F
Action = hex: 01,0A,81,0C,81,10,85,51,05,21
[HKR\Settings\Pin\0B]
CfgDflt = dword: 0x90A7012E
[HKR\Settings\Pin\0C]
CfgDflt = dword: 0x9017E110
[HKR\Settings\Pin\0D]
CfgDflt = dword: 0x400000FD
[HKR\Settings\Pin\0E]
CfgDflt = dword: 0x400000FE
Action = hex: 01,10,81,0A,81,0C
[HKR\Settings\Pin\0F]
CfgDflt = dword: 0x0181E020
Action = hex: 09,0F
[HKR\Settings\Pin\10]
CfgDflt = dword: 0x1145E230
[HKR\Settings\Pin\11]
CfgDflt = dword: 0x11C5E240
[HKR\Settings\Pin\15]
CfgDflt = dword: 0x400000FC
[HKR\Settings\Pin\1B]
CfgDflt = dword: 0x400000FB
[HKR\Settings\GPIO]
00                                   = hex: 85
01                                   = hex: 82

This in comparison to the current imac-intel pinconfig

static unsigned int imac_intel_pin_configs[10] = {
	0x0121e230, 0x90a70120, 0x9017e110, 0x400000fe,
	0x400000fd, 0x0181e021, 0x1145e040, 0x400000fa,
	0x400000fc, 0x400000fb,
};

My mail on the archive with the pinconfigs is
http://mailman.alsa-project.org/pipermail/alsa-devel/2007-April/000731.html

I have tried using this pinconfig with rc4 and the input is set okay,
but I still need to set capture to 0. A major issue is that there is
no sound with this pinconfig. This is the output of modprobe:

ALSA /root/tmp/alsa-driver-1.0.14rc4/pci/hda/hda_codec.c:1795:
hda_codec: model 'imac-intel' is selected
ALSA /root/tmp/alsa-driver-1.0.14rc4/pci/hda/hda_codec.c:2270:
autoconfig: line_outs=0 (0x0/0x0/0x0/0x0/0x0)
ALSA /root/tmp/alsa-driver-1.0.14rc4/pci/hda/hda_codec.c:2274:
speaker_outs=1 (0xc/0x0/0x0/0x0/0x0)
ALSA /root/tmp/alsa-driver-1.0.14rc4/pci/hda/hda_codec.c:2278:
hp_outs=1 (0xa/0x0/0x0/0x0/0x0)
ALSA /root/tmp/alsa-driver-1.0.14rc4/pci/hda/hda_codec.c:2286:
inputs: mic=0xb, fmic=0x0, line=0xf, fline=0x0, cd=0x0, aux=0x0
17 - AC_PINCTL_VREF_80
17 - AC_PINCTL_VREF_80

I have attached the initial codec info after modprobing with the
pinconfig from apple.

> What happens if you use different values for "Capture Volume" and
> "Capture Mux Volume"?

There seems to be a proportional dependancy. If I increase caption vol
by 1 and lower capture mux vol by 1 it will record (not 100% sure on
the 1 to 1 factor here).

Else, recording doesn't work if I change capture volume to something >
0. This is the change in the codec:

Node 0x17 [Audio Selector] wcaps 0x300903: Stereo Amp-In
   Amp-In caps: N/A
-  Amp-In vals:  [0x00 0x00]
+  Amp-In vals:  [0x0e 0x0e]
   Connection: 1
      0x12

I can provide you a root ssh account on the machine if you want?
-- 
Ivan N. Zlatev

Web: http://www.i-nZ.net
"It's all some kind of whacked out conspiracy."

------=_Part_2369_26361928.1179249118392
Content-Type: application/octet-stream; name=codec-apple-pinconfig
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f1p70tgw
Content-Disposition: attachment; filename="codec-apple-pinconfig"

Q29kZWM6IFNpZ21hVGVsIFNUQUM5MjIxIEExCkFkZHJlc3M6IDAKVmVuZG9yIElkOiAweDgzODQ3
NjgwClN1YnN5c3RlbSBJZDogMHgxMDZiMTcwMApSZXZpc2lvbiBJZDogMHgxMDM0MDEKRGVmYXVs
dCBQQ006CiAgICByYXRlcyBbMHg3ZTBdOiA0NDEwMCA0ODAwMCA4ODIwMCA5NjAwMCAxNzY0MDAg
MTkyMDAwCiAgICBiaXRzIFsweGVdOiAxNiAyMCAyNAogICAgZm9ybWF0cyBbMHgxXTogUENNCkRl
ZmF1bHQgQW1wLUluIGNhcHM6IG9mcz0weDAwLCBuc3RlcHM9MHgwZSwgc3RlcHNpemU9MHgwNSwg
bXV0ZT0xCkRlZmF1bHQgQW1wLU91dCBjYXBzOiBvZnM9MHg3ZiwgbnN0ZXBzPTB4N2YsIHN0ZXBz
aXplPTB4MDIsIG11dGU9MQpOb2RlIDB4MDIgW0F1ZGlvIE91dHB1dF0gd2NhcHMgMHhkMGMwNTog
U3RlcmVvIEFtcC1PdXQKICBBbXAtT3V0IGNhcHM6IE4vQQogIEFtcC1PdXQgdmFsczogIFsweDdm
IDB4N2ZdCiAgUG93ZXI6IDB4MApOb2RlIDB4MDMgW0F1ZGlvIE91dHB1dF0gd2NhcHMgMHhkMGMw
NTogU3RlcmVvIEFtcC1PdXQKICBBbXAtT3V0IGNhcHM6IE4vQQogIEFtcC1PdXQgdmFsczogIFsw
eDdmIDB4N2ZdCiAgUG93ZXI6IDB4MApOb2RlIDB4MDQgW0F1ZGlvIE91dHB1dF0gd2NhcHMgMHhk
MGMwNTogU3RlcmVvIEFtcC1PdXQKICBBbXAtT3V0IGNhcHM6IE4vQQogIEFtcC1PdXQgdmFsczog
IFsweDdmIDB4N2ZdCiAgUG93ZXI6IDB4MApOb2RlIDB4MDUgW0F1ZGlvIE91dHB1dF0gd2NhcHMg
MHhkMGMwNTogU3RlcmVvIEFtcC1PdXQKICBBbXAtT3V0IGNhcHM6IE4vQQogIEFtcC1PdXQgdmFs
czogIFsweDdmIDB4N2ZdCiAgUG93ZXI6IDB4MApOb2RlIDB4MDYgW0F1ZGlvIElucHV0XSB3Y2Fw
cyAweDFkMDU0MTogU3RlcmVvCiAgUG93ZXI6IDB4MAogIENvbm5lY3Rpb246IDEKICAgICAweDE3
Ck5vZGUgMHgwNyBbQXVkaW8gSW5wdXRdIHdjYXBzIDB4MWQwNTQxOiBTdGVyZW8KICBQb3dlcjog
MHgwCiAgQ29ubmVjdGlvbjogMQogICAgIDB4MTgKTm9kZSAweDA4IFtBdWRpbyBPdXRwdXRdIHdj
YXBzIDB4NDAyMTE6IFN0ZXJlbyBEaWdpdGFsCiAgUENNOgogICAgcmF0ZXMgWzB4N2UwXTogNDQx
MDAgNDgwMDAgODgyMDAgOTYwMDAgMTc2NDAwIDE5MjAwMAogICAgYml0cyBbMHhlXTogMTYgMjAg
MjQKICAgIGZvcm1hdHMgWzB4NV06IFBDTSBBQzMKTm9kZSAweDA5IFtBdWRpbyBJbnB1dF0gd2Nh
cHMgMHgxNDAzMTE6IFN0ZXJlbyBEaWdpdGFsCiAgUENNOgogICAgcmF0ZXMgWzB4MTYwXTogNDQx
MDAgNDgwMDAgOTYwMDAKICAgIGJpdHMgWzB4ZV06IDE2IDIwIDI0CiAgICBmb3JtYXRzIFsweDVd
OiBQQ00gQUMzCiAgQ29ubmVjdGlvbjogMQogICAgIDB4MTEKTm9kZSAweDBhIFtQaW4gQ29tcGxl
eF0gd2NhcHMgMHg0MDAxODE6IFN0ZXJlbwogIFBpbmNhcCAweDA4MTczZjogSU4gT1VUIEhQIERl
dGVjdAogIFBpbiBEZWZhdWx0IDB4MDEyMWUyMWY6IFtKYWNrXSBIUCBPdXQgYXQgRXh0IFJlYXIK
ICAgIENvbm4gPSAxLzgsIENvbG9yID0gV2hpdGUKICBQaW4tY3RsczogMHhjMDogT1VUIEhQCiAg
Q29ubmVjdGlvbjogMQogICAgIDB4MDIKTm9kZSAweDBiIFtQaW4gQ29tcGxleF0gd2NhcHMgMHg0
MDAxODE6IFN0ZXJlbwogIFBpbmNhcCAweDA4MTczNzogSU4gT1VUIERldGVjdAogIFBpbiBEZWZh
dWx0IDB4OTBhNzAxMmU6IFtGaXhlZF0gTWljIGF0IEludCBOL0EKICAgIENvbm4gPSBBbmFsb2cs
IENvbG9yID0gVW5rbm93bgogIFBpbi1jdGxzOiAweDI0OiBJTgogIENvbm5lY3Rpb246IDEKICAg
ICAweDA0Ck5vZGUgMHgwYyBbUGluIENvbXBsZXhdIHdjYXBzIDB4NDAwMTgxOiBTdGVyZW8KICBQ
aW5jYXAgMHgwODE3Mzc6IElOIE9VVCBEZXRlY3QKICBQaW4gRGVmYXVsdCAweDkwMTdlMTEwOiBb
Rml4ZWRdIFNwZWFrZXIgYXQgSW50IE4vQQogICAgQ29ubiA9IEFuYWxvZywgQ29sb3IgPSBXaGl0
ZQogIFBpbi1jdGxzOiAweDAwOgogIENvbm5lY3Rpb246IDEKICAgICAweDAzCk5vZGUgMHgwZCBb
UGluIENvbXBsZXhdIHdjYXBzIDB4NDAwMTgxOiBTdGVyZW8KICBQaW5jYXAgMHgwODE3M2Y6IElO
IE9VVCBIUCBEZXRlY3QKICBQaW4gRGVmYXVsdCAweDQwMDAwMGZkOiBbTi9BXSBMaW5lIE91dCBh
dCBFeHQgTi9BCiAgICBDb25uID0gVW5rbm93biwgQ29sb3IgPSBVbmtub3duCiAgUGluLWN0bHM6
IDB4NDA6IE9VVAogIENvbm5lY3Rpb246IDEKICAgICAweDAyCk5vZGUgMHgwZSBbUGluIENvbXBs
ZXhdIHdjYXBzIDB4NDAwMDgxOiBTdGVyZW8KICBQaW5jYXAgMHgwODI0OiBJTiBEZXRlY3QKICBQ
aW4gRGVmYXVsdCAweDQwMDAwMGZlOiBbTi9BXSBMaW5lIE91dCBhdCBFeHQgTi9BCiAgICBDb25u
ID0gVW5rbm93biwgQ29sb3IgPSBVbmtub3duCiAgUGluLWN0bHM6IDB4MjA6IElOCk5vZGUgMHgw
ZiBbUGluIENvbXBsZXhdIHdjYXBzIDB4NDAwMTgxOiBTdGVyZW8KICBQaW5jYXAgMHgwODM3OiBJ
TiBPVVQgRGV0ZWN0CiAgUGluIERlZmF1bHQgMHgwMTgxZTAyMDogW0phY2tdIExpbmUgSW4gYXQg
RXh0IFJlYXIKICAgIENvbm4gPSAxLzgsIENvbG9yID0gV2hpdGUKICBQaW4tY3RsczogMHgyMDog
SU4KICBDb25uZWN0aW9uOiAxCiAgICAgMHgwNQpOb2RlIDB4MTAgW1BpbiBDb21wbGV4XSB3Y2Fw
cyAweDQwMDMwMTogU3RlcmVvIERpZ2l0YWwKICBQaW5jYXAgMHgwODEwOiBPVVQKICBQaW4gRGVm
YXVsdCAweDExNDVlMjMwOiBbSmFja10gU1BESUYgT3V0IGF0IEludCBSZWFyCiAgICBDb25uID0g
T3B0aWNhbCwgQ29sb3IgPSBXaGl0ZQogIFBpbi1jdGxzOiAweDQwOiBPVVQKICBDb25uZWN0aW9u
OiAzCiAgICAgMHgwOCogMHgxNyAweDE5Ck5vZGUgMHgxMSBbUGluIENvbXBsZXhdIHdjYXBzIDB4
NDMwNjgxOiBTdGVyZW8gRGlnaXRhbAogIFBpbmNhcCAweDA4MTAwMjQ6IElOIEVBUEQgRGV0ZWN0
CiAgUGluIERlZmF1bHQgMHgxMWM1ZTI0MDogW0phY2tdIFNQRElGIEluIGF0IEludCBSZWFyCiAg
ICBDb25uID0gT3B0aWNhbCwgQ29sb3IgPSBXaGl0ZQogIFBpbi1jdGxzOiAweDIwOiBJTgogIFBv
d2VyOiAweDAKTm9kZSAweDEyIFtBdWRpbyBTZWxlY3Rvcl0gd2NhcHMgMHgzMDAxMGQ6IFN0ZXJl
byBBbXAtT3V0CiAgQW1wLU91dCBjYXBzOiBvZnM9MHgwMCwgbnN0ZXBzPTB4MDQsIHN0ZXBzaXpl
PTB4MjcsIG11dGU9MAogIEFtcC1PdXQgdmFsczogIFsweDAwIDB4MDBdCiAgQ29ubmVjdGlvbjog
NwogICAgIDB4MGUqIDB4MTUgMHgwZiAweDBiIDB4MGMgMHgwZCAweDBhCk5vZGUgMHgxMyBbQXVk
aW8gU2VsZWN0b3JdIHdjYXBzIDB4MzAwMTBkOiBTdGVyZW8gQW1wLU91dAogIEFtcC1PdXQgY2Fw
czogb2ZzPTB4MDAsIG5zdGVwcz0weDA0LCBzdGVwc2l6ZT0weDI3LCBtdXRlPTAKICBBbXAtT3V0
IHZhbHM6ICBbMHgwMCAweDAwXQogIENvbm5lY3Rpb246IDcKICAgICAweDBlIDB4MTUqIDB4MGYg
MHgwYiAweDBjIDB4MGQgMHgwYQpOb2RlIDB4MTQgW0JlZXAgR2VuZXJhdG9yIFdpZGdldF0gd2Nh
cHMgMHg3MDAwMGM6IE1vbm8gQW1wLU91dAogIEFtcC1PdXQgY2Fwczogb2ZzPTB4MDMsIG5zdGVw
cz0weDAzLCBzdGVwc2l6ZT0weDE3LCBtdXRlPTAKICBBbXAtT3V0IHZhbHM6ICBbMHgwMF0KTm9k
ZSAweDE1IFtQaW4gQ29tcGxleF0gd2NhcHMgMHg0MDAwMDE6IFN0ZXJlbwogIFBpbmNhcCAweDA4
MjA6IElOCiAgUGluIERlZmF1bHQgMHg0MDAwMDBmYzogW04vQV0gTGluZSBPdXQgYXQgRXh0IE4v
QQogICAgQ29ubiA9IFVua25vd24sIENvbG9yID0gVW5rbm93bgogIFBpbi1jdGxzOiAweDAwOgpO
b2RlIDB4MTYgW1ZvbHVtZSBLbm9iIFdpZGdldF0gd2NhcHMgMHg2MDAwMDA6IE1vbm8KTm9kZSAw
eDE3IFtBdWRpbyBTZWxlY3Rvcl0gd2NhcHMgMHgzMDA5MDM6IFN0ZXJlbyBBbXAtSW4KICBBbXAt
SW4gY2FwczogTi9BCiAgQW1wLUluIHZhbHM6ICBbMHg4MCAweDgwXQogIENvbm5lY3Rpb246IDEK
ICAgICAweDEyCk5vZGUgMHgxOCBbQXVkaW8gU2VsZWN0b3JdIHdjYXBzIDB4MzAwOTAzOiBTdGVy
ZW8gQW1wLUluCiAgQW1wLUluIGNhcHM6IE4vQQogIEFtcC1JbiB2YWxzOiAgWzB4ODAgMHg4MF0K
ICBDb25uZWN0aW9uOiAxCiAgICAgMHgxMwpOb2RlIDB4MTkgW1ZlbmRvciBEZWZpbmVkIFdpZGdl
dF0gd2NhcHMgMHhmMzAyMDE6IFN0ZXJlbyBEaWdpdGFsCk5vZGUgMHgxYSBbQXVkaW8gT3V0cHV0
XSB3Y2FwcyAweDMwMjAxOiBTdGVyZW8gRGlnaXRhbApOb2RlIDB4MWIgW1BpbiBDb21wbGV4XSB3
Y2FwcyAweDQwMDMwMTogU3RlcmVvIERpZ2l0YWwKICBQaW5jYXAgMHgwODEwOiBPVVQKICBQaW4g
RGVmYXVsdCAweDQwMDAwMGZiOiBbTi9BXSBMaW5lIE91dCBhdCBFeHQgTi9BCiAgICBDb25uID0g
VW5rbm93biwgQ29sb3IgPSBVbmtub3duCiAgUGluLWN0bHM6IDB4MDA6CiAgQ29ubmVjdGlvbjog
MQogICAgIDB4MWEK
------=_Part_2369_26361928.1179249118392
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_2369_26361928.1179249118392--
