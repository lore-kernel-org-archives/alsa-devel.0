From: "Ivan N. Zlatev" <contact@i-nz.net>
Subject: SigmaTel STAC9221 - Mux Amp-Out > 0x02 == microphone
	not working
Date: Sun, 27 May 2007 23:50:35 +0100
Message-ID: <3db1ec7f0705271550n4e61e012l245f888ff34558c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_6928_4454440.1180306235441"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by alsa0.perex.cz (Postfix) with ESMTP id 1B942244D1
	for <alsa-devel@alsa-project.org>;
	Mon, 28 May 2007 00:50:36 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id o2so527838uge
	for <alsa-devel@alsa-project.org>; Sun, 27 May 2007 15:50:35 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

------=_Part_6928_4454440.1180306235441
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I am on an iMac ("*imac-20" model/pinconfig) with a Intel HD card with
the SigmaTel STAC9221 codec. I have attached the inital codec info
after modprobe. I am using Alsa HG. Setting the mux gain to a value >
20 (0x02 Amp-Out value) results a non-working microphone. Steps and
codec diffs as follows:

1) initial - microphone working
2) Mux Gain = 10 - microphone working

 Node 0x12 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
   Amp-Out caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=0
-  Amp-Out vals:  [0x00 0x00]
+  Amp-Out vals:  [0x01 0x01]
   Connection: 7
      0x0e 0x15 0x0f 0x0b* 0x0c 0x0d 0x0a

3) Mux Gain = 20 - microphone working

 Node 0x12 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
   Amp-Out caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=0
-  Amp-Out vals:  [0x01 0x01]
+  Amp-Out vals:  [0x02 0x02]
   Connection: 7
      0x0e 0x15 0x0f 0x0b* 0x0c 0x0d 0x0a


4) Mux Gain = 30 - microphone not working

 Node 0x12 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
   Amp-Out caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=0
-  Amp-Out vals:  [0x02 0x02]
+  Amp-Out vals:  [0x03 0x03]
   Connection: 7
      0x0e 0x15 0x0f 0x0b* 0x0c 0x0d 0x0a


4) Mux Gain = 40 - microphone not working

 Node 0x12 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
   Amp-Out caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=0
-  Amp-Out vals:  [0x03 0x03]
+  Amp-Out vals:  [0x04 0x04]
   Connection: 7
      0x0e 0x15 0x0f 0x0b* 0x0c 0x0d 0x0a

Regards
-- 
Ivan N. Zlatev

Web: http://www.i-nZ.net
"It's all some kind of whacked out conspiracy."

------=_Part_6928_4454440.1180306235441
Content-Type: application/octet-stream; name=codec-info
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f283bjh4
Content-Disposition: attachment; filename="codec-info"

Q29kZWM6IFNpZ21hVGVsIFNUQUM5MjIxIEExCkFkZHJlc3M6IDAKVmVuZG9yIElkOiAweDgzODQ3
NjgwClN1YnN5c3RlbSBJZDogMHgxMDZiMTcwMApSZXZpc2lvbiBJZDogMHgxMDM0MDEKRGVmYXVs
dCBQQ006CiAgICByYXRlcyBbMHg3ZTBdOiA0NDEwMCA0ODAwMCA4ODIwMCA5NjAwMCAxNzY0MDAg
MTkyMDAwCiAgICBiaXRzIFsweGVdOiAxNiAyMCAyNAogICAgZm9ybWF0cyBbMHgxXTogUENNCkRl
ZmF1bHQgQW1wLUluIGNhcHM6IG9mcz0weDAwLCBuc3RlcHM9MHgwZSwgc3RlcHNpemU9MHgwNSwg
bXV0ZT0xCkRlZmF1bHQgQW1wLU91dCBjYXBzOiBvZnM9MHg3ZiwgbnN0ZXBzPTB4N2YsIHN0ZXBz
aXplPTB4MDIsIG11dGU9MQpOb2RlIDB4MDIgW0F1ZGlvIE91dHB1dF0gd2NhcHMgMHhkMGMwNTog
U3RlcmVvIEFtcC1PdXQKICBBbXAtT3V0IGNhcHM6IE4vQQogIEFtcC1PdXQgdmFsczogIFsweDVi
IDB4NWJdCiAgUG93ZXI6IDB4MApOb2RlIDB4MDMgW0F1ZGlvIE91dHB1dF0gd2NhcHMgMHhkMGMw
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
ZQogIFBpbi1jdGxzOiAweDQwOiBPVVQKICBDb25uZWN0aW9uOiAxCiAgICAgMHgwMwpOb2RlIDB4
MGQgW1BpbiBDb21wbGV4XSB3Y2FwcyAweDQwMDE4MTogU3RlcmVvCiAgUGluY2FwIDB4MDgxNzNm
OiBJTiBPVVQgSFAgRGV0ZWN0CiAgUGluIERlZmF1bHQgMHg0MDAwMDBmZDogW04vQV0gTGluZSBP
dXQgYXQgRXh0IE4vQQogICAgQ29ubiA9IFVua25vd24sIENvbG9yID0gVW5rbm93bgogIFBpbi1j
dGxzOiAweDQwOiBPVVQKICBDb25uZWN0aW9uOiAxCiAgICAgMHgwMgpOb2RlIDB4MGUgW1BpbiBD
b21wbGV4XSB3Y2FwcyAweDQwMDA4MTogU3RlcmVvCiAgUGluY2FwIDB4MDgyNDogSU4gRGV0ZWN0
CiAgUGluIERlZmF1bHQgMHg0MDAwMDBmZTogW04vQV0gTGluZSBPdXQgYXQgRXh0IE4vQQogICAg
Q29ubiA9IFVua25vd24sIENvbG9yID0gVW5rbm93bgogIFBpbi1jdGxzOiAweDIwOiBJTgpOb2Rl
IDB4MGYgW1BpbiBDb21wbGV4XSB3Y2FwcyAweDQwMDE4MTogU3RlcmVvCiAgUGluY2FwIDB4MDgz
NzogSU4gT1VUIERldGVjdAogIFBpbiBEZWZhdWx0IDB4MDE4MWUwMjA6IFtKYWNrXSBMaW5lIElu
IGF0IEV4dCBSZWFyCiAgICBDb25uID0gMS84LCBDb2xvciA9IFdoaXRlCiAgUGluLWN0bHM6IDB4
MjA6IElOCiAgQ29ubmVjdGlvbjogMQogICAgIDB4MDUKTm9kZSAweDEwIFtQaW4gQ29tcGxleF0g
d2NhcHMgMHg0MDAzMDE6IFN0ZXJlbyBEaWdpdGFsCiAgUGluY2FwIDB4MDgxMDogT1VUCiAgUGlu
IERlZmF1bHQgMHgxMTQ1ZTIzMDogW0phY2tdIFNQRElGIE91dCBhdCBJbnQgUmVhcgogICAgQ29u
biA9IE9wdGljYWwsIENvbG9yID0gV2hpdGUKICBQaW4tY3RsczogMHg0MDogT1VUCiAgQ29ubmVj
dGlvbjogMwogICAgIDB4MDgqIDB4MTcgMHgxOQpOb2RlIDB4MTEgW1BpbiBDb21wbGV4XSB3Y2Fw
cyAweDQzMDY4MTogU3RlcmVvIERpZ2l0YWwKICBQaW5jYXAgMHgwODEwMDI0OiBJTiBFQVBEIERl
dGVjdAogIFBpbiBEZWZhdWx0IDB4MTFjNWUyNDA6IFtKYWNrXSBTUERJRiBJbiBhdCBJbnQgUmVh
cgogICAgQ29ubiA9IE9wdGljYWwsIENvbG9yID0gV2hpdGUKICBQaW4tY3RsczogMHgyMDogSU4K
ICBQb3dlcjogMHgwCk5vZGUgMHgxMiBbQXVkaW8gU2VsZWN0b3JdIHdjYXBzIDB4MzAwMTBkOiBT
dGVyZW8gQW1wLU91dAogIEFtcC1PdXQgY2Fwczogb2ZzPTB4MDAsIG5zdGVwcz0weDA0LCBzdGVw
c2l6ZT0weDI3LCBtdXRlPTAKICBBbXAtT3V0IHZhbHM6ICBbMHgwMCAweDAwXQogIENvbm5lY3Rp
b246IDcKICAgICAweDBlIDB4MTUgMHgwZiAweDBiKiAweDBjIDB4MGQgMHgwYQpOb2RlIDB4MTMg
W0F1ZGlvIFNlbGVjdG9yXSB3Y2FwcyAweDMwMDEwZDogU3RlcmVvIEFtcC1PdXQKICBBbXAtT3V0
IGNhcHM6IG9mcz0weDAwLCBuc3RlcHM9MHgwNCwgc3RlcHNpemU9MHgyNywgbXV0ZT0wCiAgQW1w
LU91dCB2YWxzOiAgWzB4MDAgMHgwMF0KICBDb25uZWN0aW9uOiA3CiAgICAgMHgwZSAweDE1IDB4
MGYgMHgwYiogMHgwYyAweDBkIDB4MGEKTm9kZSAweDE0IFtCZWVwIEdlbmVyYXRvciBXaWRnZXRd
IHdjYXBzIDB4NzAwMDBjOiBNb25vIEFtcC1PdXQKICBBbXAtT3V0IGNhcHM6IG9mcz0weDAzLCBu
c3RlcHM9MHgwMywgc3RlcHNpemU9MHgxNywgbXV0ZT0wCiAgQW1wLU91dCB2YWxzOiAgWzB4MDBd
Ck5vZGUgMHgxNSBbUGluIENvbXBsZXhdIHdjYXBzIDB4NDAwMDAxOiBTdGVyZW8KICBQaW5jYXAg
MHgwODIwOiBJTgogIFBpbiBEZWZhdWx0IDB4NDAwMDAwZmM6IFtOL0FdIExpbmUgT3V0IGF0IEV4
dCBOL0EKICAgIENvbm4gPSBVbmtub3duLCBDb2xvciA9IFVua25vd24KICBQaW4tY3RsczogMHgw
MDoKTm9kZSAweDE2IFtWb2x1bWUgS25vYiBXaWRnZXRdIHdjYXBzIDB4NjAwMDAwOiBNb25vCk5v
ZGUgMHgxNyBbQXVkaW8gU2VsZWN0b3JdIHdjYXBzIDB4MzAwOTAzOiBTdGVyZW8gQW1wLUluCiAg
QW1wLUluIGNhcHM6IE4vQQogIEFtcC1JbiB2YWxzOiAgWzB4MGUgMHgwZV0KICBDb25uZWN0aW9u
OiAxCiAgICAgMHgxMgpOb2RlIDB4MTggW0F1ZGlvIFNlbGVjdG9yXSB3Y2FwcyAweDMwMDkwMzog
U3RlcmVvIEFtcC1JbgogIEFtcC1JbiBjYXBzOiBOL0EKICBBbXAtSW4gdmFsczogIFsweDgwIDB4
ODBdCiAgQ29ubmVjdGlvbjogMQogICAgIDB4MTMKTm9kZSAweDE5IFtWZW5kb3IgRGVmaW5lZCBX
aWRnZXRdIHdjYXBzIDB4ZjMwMjAxOiBTdGVyZW8gRGlnaXRhbApOb2RlIDB4MWEgW0F1ZGlvIE91
dHB1dF0gd2NhcHMgMHgzMDIwMTogU3RlcmVvIERpZ2l0YWwKTm9kZSAweDFiIFtQaW4gQ29tcGxl
eF0gd2NhcHMgMHg0MDAzMDE6IFN0ZXJlbyBEaWdpdGFsCiAgUGluY2FwIDB4MDgxMDogT1VUCiAg
UGluIERlZmF1bHQgMHg0MDAwMDBmYjogW04vQV0gTGluZSBPdXQgYXQgRXh0IE4vQQogICAgQ29u
biA9IFVua25vd24sIENvbG9yID0gVW5rbm93bgogIFBpbi1jdGxzOiAweDAwOgogIENvbm5lY3Rp
b246IDEKICAgICAweDFhCg==
------=_Part_6928_4454440.1180306235441
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_6928_4454440.1180306235441--
