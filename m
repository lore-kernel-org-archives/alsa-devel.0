From: "Ivan N. Zlatev" <contact@i-nz.net>
Subject: Re: Strange findings about the microphone in SigmaTel
	STAC9221 A1
Date: Sat, 19 May 2007 21:28:31 +0100
Message-ID: <3db1ec7f0705191328i6c40366w196c278b1ebaca7a@mail.gmail.com>
References: <3db1ec7f0705110248p788b3d9q2ea5774331fded9d@mail.gmail.com>
	<s5hps52gtmx.wl%tiwai@suse.de>
	<3db1ec7f0705150741k72427556y6b91d9ab13cba5c5@mail.gmail.com>
	<s5hbqgmgm8h.wl%tiwai@suse.de>
	<3db1ec7f0705151011w7e511e50p9397a8429083d956@mail.gmail.com>
	<s5hveeqkqd2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_31005_3696346.1179606511984"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 3CCE52452D
	for <alsa-devel@alsa-project.org>;
	Sat, 19 May 2007 22:28:33 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id j3so565669ugf
	for <alsa-devel@alsa-project.org>; Sat, 19 May 2007 13:28:32 -0700 (PDT)
In-Reply-To: <s5hveeqkqd2.wl%tiwai@suse.de>
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

------=_Part_31005_3696346.1179606511984
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> - Build the latest driver with your pingconfig patch.

Patch, which adds an "intel-imac-20" pinconfig attached.

> - Unload the driver module.
> - Remove /etc/asound.state (or whatever alsactl stores -- the path is
>   depending on distro)
> - Load the module again; at this state, mixers are muted
> - Get the first codec dump here once

initial-codec attached.

> - Unmute the playbacks as usual.  Check playback.
Playback works.

> - Turn on only "Capture Switch".  Don't adjust "Capture Volume" and
>   "Mux Capture Volume" if they are zero.
>   Test recording once here.  Get codec dump again.

Recording doesn't work. Codec diff:

 Node 0x02 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
   Amp-Out caps: N/A
-  Amp-Out vals:  [0x7f 0x7f]
+  Amp-Out vals:  [0xff 0xff]
   Power: 0x0
 Node 0x03 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
   Amp-Out caps: N/A
-  Amp-Out vals:  [0x7f 0x7f]
+  Amp-Out vals:  [0xff 0xff]
   Power: 0x0
 Node 0x04 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
   Amp-Out caps: N/A
-  Amp-Out vals:  [0x7f 0x7f]
+  Amp-Out vals:  [0xff 0xff]
   Power: 0x0
 Node 0x05 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
   Amp-Out caps: N/A
-  Amp-Out vals:  [0x7f 0x7f]
+  Amp-Out vals:  [0xff 0xff]
   Power: 0x0

> - If not working, try resetting the input source.
>   Test recording.  Get codec dump.

Reseting the input source doesn't result a difference in the codec
info and recording still doesn't work.

> - Raise "Capture Volume".  Test recording, get codec dump.

After this recording works! Woho! :-)

 Node 0x17 [Audio Selector] wcaps 0x300903: Stereo Amp-In
   Amp-In caps: N/A
-  Amp-In vals:  [0x0e 0x0e]
+  Amp-In vals:  [0x00 0x00]
   Connection: 1
      0x12

> - Raise "Mux Capture Volume".  Test recording, get codec dump.

For the sake of the test I have also umuted and increased Mux, which
results the following diff and a non-working recording

 Node 0x12 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
   Amp-Out caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=0
-  Amp-Out vals:  [0x04 0x04]
+  Amp-Out vals:  [0x00 0x00]
   Connection: 7
      0x0e 0x15 0x0f 0x0b* 0x0c 0x0d 0x0a


Regards.
-- 
Ivan N. Zlatev

Web: http://www.i-nZ.net
"It's all some kind of whacked out conspiracy."

------=_Part_31005_3696346.1179606511984
Content-Type: application/octet-stream; name=initial-codec
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f1v3sq89
Content-Disposition: attachment; filename="initial-codec"

Q29kZWM6IFNpZ21hVGVsIFNUQUM5MjIxIEExCkFkZHJlc3M6IDAKVmVuZG9yIElkOiAweDgzODQ3
NjgwClN1YnN5c3RlbSBJZDogMHgxMDZiMTcwMApSZXZpc2lvbiBJZDogMHgxMDM0MDEKRGVmYXVs
dCBQQ006CiAgICByYXRlcyBbMHg3ZTBdOiA0NDEwMCA0ODAwMCA4ODIwMCA5NjAwMCAxNzY0MDAg
MTkyMDAwCiAgICBiaXRzIFsweGVdOiAxNiAyMCAyNAogICAgZm9ybWF0cyBbMHgxXTogUENNCkRl
ZmF1bHQgQW1wLUluIGNhcHM6IG9mcz0weDAwLCBuc3RlcHM9MHgwZSwgc3RlcHNpemU9MHgwNSwg
bXV0ZT0xCkRlZmF1bHQgQW1wLU91dCBjYXBzOiBvZnM9MHg3ZiwgbnN0ZXBzPTB4N2YsIHN0ZXBz
aXplPTB4MDIsIG11dGU9MQpOb2RlIDB4MDIgW0F1ZGlvIE91dHB1dF0gd2NhcHMgMHhkMGMwNTog
U3RlcmVvIEFtcC1PdXQKICBBbXAtT3V0IGNhcHM6IE4vQQogIEFtcC1PdXQgdmFsczogIFsweGZm
IDB4ZmZdCiAgUG93ZXI6IDB4MApOb2RlIDB4MDMgW0F1ZGlvIE91dHB1dF0gd2NhcHMgMHhkMGMw
NTogU3RlcmVvIEFtcC1PdXQKICBBbXAtT3V0IGNhcHM6IE4vQQogIEFtcC1PdXQgdmFsczogIFsw
eGZmIDB4ZmZdCiAgUG93ZXI6IDB4MApOb2RlIDB4MDQgW0F1ZGlvIE91dHB1dF0gd2NhcHMgMHhk
MGMwNTogU3RlcmVvIEFtcC1PdXQKICBBbXAtT3V0IGNhcHM6IE4vQQogIEFtcC1PdXQgdmFsczog
IFsweGZmIDB4ZmZdCiAgUG93ZXI6IDB4MApOb2RlIDB4MDUgW0F1ZGlvIE91dHB1dF0gd2NhcHMg
MHhkMGMwNTogU3RlcmVvIEFtcC1PdXQKICBBbXAtT3V0IGNhcHM6IE4vQQogIEFtcC1PdXQgdmFs
czogIFsweGZmIDB4ZmZdCiAgUG93ZXI6IDB4MApOb2RlIDB4MDYgW0F1ZGlvIElucHV0XSB3Y2Fw
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
NwogICAgIDB4MGUgMHgxNSAweDBmIDB4MGIqIDB4MGMgMHgwZCAweDBhCk5vZGUgMHgxMyBbQXVk
aW8gU2VsZWN0b3JdIHdjYXBzIDB4MzAwMTBkOiBTdGVyZW8gQW1wLU91dAogIEFtcC1PdXQgY2Fw
czogb2ZzPTB4MDAsIG5zdGVwcz0weDA0LCBzdGVwc2l6ZT0weDI3LCBtdXRlPTAKICBBbXAtT3V0
IHZhbHM6ICBbMHgwMCAweDAwXQogIENvbm5lY3Rpb246IDcKICAgICAweDBlIDB4MTUgMHgwZiAw
eDBiKiAweDBjIDB4MGQgMHgwYQpOb2RlIDB4MTQgW0JlZXAgR2VuZXJhdG9yIFdpZGdldF0gd2Nh
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
------=_Part_31005_3696346.1179606511984
Content-Type: text/x-diff; name=imac20_alsa.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f1v3vfd2
Content-Disposition: attachment; filename="imac20_alsa.patch"

ZGlmZiAtciBiZTczNTAwYmQ0MmEgcGNpL2hkYS9wYXRjaF9zaWdtYXRlbC5jCi0tLSBhL3BjaS9o
ZGEvcGF0Y2hfc2lnbWF0ZWwuYwlTYXQgTWF5IDE5IDE3OjIxOjA0IDIwMDcgKzAyMDAKKysrIGIv
cGNpL2hkYS9wYXRjaF9zaWdtYXRlbC5jCUZyaSBNYXkgMTggMjA6NDg6MDEgMjAwNyArMDEwMApA
QCAtNjQsNiArNjQsNyBAQCBlbnVtIHsKIAlTVEFDX01BQ0JPT0tfUFJPX1YxLAogCVNUQUNfTUFD
Qk9PS19QUk9fVjIsCiAJU1RBQ19JTUFDX0lOVEVMLAorCVNUQUNfSU1BQ19JTlRFTF8yMCwKIAlT
VEFDXzkyMlhfTU9ERUxTCiB9OwogCkBAIC01NjcsNiArNTY4LDEyIEBAIHN0YXRpYyB1bnNpZ25l
ZCBpbnQgaW1hY19pbnRlbF9waW5fY29uZmkKIAkweDQwMDAwMGZjLCAweDQwMDAwMGZiLAogfTsK
IAorc3RhdGljIHVuc2lnbmVkIGludCBpbWFjX2ludGVsXzIwX3Bpbl9jb25maWdzWzEwXSA9IHsK
KwkweDAxMjFFMjFGLCAweDkwQTcwMTJFLCAweDkwMTdFMTEwLCAweDQwMDAwMEZELAorCTB4NDAw
MDAwRkUsIDB4MDE4MUUwMjAsIDB4MTE0NUUyMzAsIDB4MTFDNUUyNDAsCisJMHg0MDAwMDBGQywg
MHg0MDAwMDBGQiwKK307CisKIHN0YXRpYyB1bnNpZ25lZCBpbnQgKnN0YWM5MjJ4X2JyZF90Ymxb
U1RBQ185MjJYX01PREVMU10gPSB7CiAJW1NUQUNfRDk0NV9SRUZdID0gcmVmOTIyeF9waW5fY29u
ZmlncywKIAlbU1RBQ19EOTQ1R1RQM10gPSBkOTQ1Z3RwM19waW5fY29uZmlncywKQEAgLTU3Niw2
ICs1ODMsNyBAQCBzdGF0aWMgdW5zaWduZWQgaW50ICpzdGFjOTIyeF9icmRfdGJsW1NUCiAJW1NU
QUNfTUFDQk9PS19QUk9fVjFdID0gbWFjYm9va19wcm9fdjFfcGluX2NvbmZpZ3MsCiAJW1NUQUNf
TUFDQk9PS19QUk9fVjJdID0gbWFjYm9va19wcm9fdjJfcGluX2NvbmZpZ3MsCiAJW1NUQUNfSU1B
Q19JTlRFTF0gPSBpbWFjX2ludGVsX3Bpbl9jb25maWdzLAorCVtTVEFDX0lNQUNfSU5URUxfMjBd
ID0gaW1hY19pbnRlbF8yMF9waW5fY29uZmlncywKIH07CiAKIHN0YXRpYyBjb25zdCBjaGFyICpz
dGFjOTIyeF9tb2RlbHNbU1RBQ185MjJYX01PREVMU10gPSB7CkBAIC01ODcsNiArNTk1LDcgQEAg
c3RhdGljIGNvbnN0IGNoYXIgKnN0YWM5MjJ4X21vZGVsc1tTVEFDXwogCVtTVEFDX01BQ0JPT0tf
UFJPX1YxXQk9ICJtYWNib29rLXByby12MSIsCiAJW1NUQUNfTUFDQk9PS19QUk9fVjJdCT0gIm1h
Y2Jvb2stcHJvIiwKIAlbU1RBQ19JTUFDX0lOVEVMXSA9ICJpbWFjLWludGVsIiwKKwlbU1RBQ19J
TUFDX0lOVEVMXzIwXSA9ICJpbWFjLWludGVsLTIwIiwKIH07CiAKIHN0YXRpYyBzdHJ1Y3Qgc25k
X3BjaV9xdWlyayBzdGFjOTIyeF9jZmdfdGJsW10gPSB7CkBAIC0yMDIyLDYgKzIwMzEsOSBAQCBz
dGF0aWMgaW50IHBhdGNoX3N0YWM5MjJ4KHN0cnVjdCBoZGFfY29kCiAJCWNhc2UgMHgxMDZiMDcw
MDogLyogSW50ZWwtYmFzZWQgaU1hYyAqLwogCQkJc3BlYy0+Ym9hcmRfY29uZmlnID0gU1RBQ19J
TUFDX0lOVEVMOwogCQkJYnJlYWs7CisJCWNhc2UgMHgxMDZiMTcwMDogLyogSW50ZWwgaU1hYyAy
MCAqLworCQkJc3BlYy0+Ym9hcmRfY29uZmlnID0gU1RBQ19JTUFDX0lOVEVMXzIwOworCQkJYnJl
YWs7CiAJCX0KIAl9CiAK
------=_Part_31005_3696346.1179606511984
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_31005_3696346.1179606511984--
