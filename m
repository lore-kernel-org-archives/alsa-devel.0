From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Subject: Re: How to use hda-verb to detect
Date: Mon, 17 Aug 2009 15:34:18 +0300
Message-ID: <4A894E4A.6060801@pardus.org.tr>
References: <4A89219E.20400@pardus.org.tr>
	<s5hljlieqcn.wl%tiwai@suse.de>	<4A8925D3.2000203@pardus.org.tr>
	<s5hfxbqeplg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090008050103030805000105"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lider.pardus.org.tr (lider.pardus.org.tr [193.140.100.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 1AA8E246CA
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Aug 2009 14:30:45 +0200 (CEST)
In-Reply-To: <s5hfxbqeplg.wl%tiwai@suse.de>
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

This is a multi-part message in MIME format.
--------------090008050103030805000105
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Takashi Iwai wrote On 17-08-2009 12:50:
> At Mon, 17 Aug 2009 12:41:39 +0300,
> Ozan =C3=87a=C4=9Flayan wrote:
>  =20
>> Takashi Iwai wrote On 17-08-2009 12:34:
>>    =20
>>> For SET_UNSOLICITED_ENABLE verb, you need to a value (TAG | AC_USRSP_=
EN).
>>> in the case of above, suppose the tag to be 0x0c, pass 0x8c.
>>>
>>>  =20
>>>      =20
>> Okay I've got the mechanism, thanks.
>>
>> How can I help for fixing HP automuting? setting UNSOLICITED_ENABLE
>> didn't help at all.
>>    =20
>
> The first thing is to identify which pin corresponds to which
> headphone.  I guess each HP jack correspond to an individual pin like
> Dell machines.
>
> Then you can give the correct pin cfg via sysfs or a setup file
> via "patch" module option.
>
>  =20
Seen that I'm not able to find out the matching between pins and jacks
(decided to read the last chapter of HDA spec), I continued to play.
With hp-dv5 I have to following situation:

- Both HP jacks are producing sound but no automuting,
- Internal speaker can be controlled and muted using 'Speaker' mixer
control,
- HP jacks can be controlled and muted using 'Front' mixer control.

Then I tried model=3Ddell-m4-1 :
- Both HP jacks are producing sound, automuting works,
- Internal speaker can be controlled and muted using 'Front' mixer contro=
l,
- HP jacks can be controlled and muted using 'Front' mixer control,
- 'Speaker' control is replaced by 'Headphone' control which is useless,


I took a diff of codec-files in both situations and found out the followi=
ng:
 Analog Loopback: 0x00
 Node 0x0a [Pin Complex] wcaps 0x400181: Stereo
   Pincap 0x0000001c: OUT HP Detect
-  Pin Default 0x0421101f: [Jack] HP Out at Ext Right
-    Conn =3D 1/8, Color =3D Black
-    DefAssociation =3D 0x1, Sequence =3D 0xf
+  Pin Default 0x40f100f0: [N/A] Other at Ext N/A
+    Conn =3D 1/8, Color =3D Unknown
+    DefAssociation =3D 0xf, Sequence =3D 0x0
   Pin-ctls: 0x00:
   Unsolicited: tag=3D01, enabled=3D1
   Connection: 3

I set 0x0a to 0x421101f in user_init_verbs and yes Speaker control
disappears, a useless HP control appears, automuting works. I'm
attaching the complete diff from dell-m4-1 to hp-dv5 model.

--------------090008050103030805000105
Content-Type: text/plain;
 name="codecdiff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="codecdiff"

LS0tIGRlbGwtbTQtMS1wYXJ0bHktd29ya3MJMjAwOS0wOC0xNyAxNToxMjoyMS4xNjYxNDY3
NDcgKzAzMDAKKysrIGhwLWR2NS1idWdneQkyMDA5LTA4LTE3IDE1OjEzOjExLjc3ODAxNDI2
MyArMDMwMApAQCAtMjQsOSArMjQsOSBAQAogQW5hbG9nIExvb3BiYWNrOiAweDAwCiBOb2Rl
IDB4MGEgW1BpbiBDb21wbGV4XSB3Y2FwcyAweDQwMDE4MTogU3RlcmVvCiAgIFBpbmNhcCAw
eDAwMDAwMDFjOiBPVVQgSFAgRGV0ZWN0Ci0gIFBpbiBEZWZhdWx0IDB4MDQyMTEwMWY6IFtK
YWNrXSBIUCBPdXQgYXQgRXh0IFJpZ2h0Ci0gICAgQ29ubiA9IDEvOCwgQ29sb3IgPSBCbGFj
awotICAgIERlZkFzc29jaWF0aW9uID0gMHgxLCBTZXF1ZW5jZSA9IDB4ZgorICBQaW4gRGVm
YXVsdCAweDQwZjEwMGYwOiBbTi9BXSBPdGhlciBhdCBFeHQgTi9BCisgICAgQ29ubiA9IDEv
OCwgQ29sb3IgPSBVbmtub3duCisgICAgRGVmQXNzb2NpYXRpb24gPSAweGYsIFNlcXVlbmNl
ID0gMHgwCiAgIFBpbi1jdGxzOiAweDAwOgogICBVbnNvbGljaXRlZDogdGFnPTAxLCBlbmFi
bGVkPTEKICAgQ29ubmVjdGlvbjogMwpAQCAtMzQsNDkgKzM0LDQ4IEBACiBOb2RlIDB4MGIg
W1BpbiBDb21wbGV4XSB3Y2FwcyAweDQwMDA4MTogU3RlcmVvCiAgIFBpbmNhcCAweDAwMDAx
NzI0OiBJTiBEZXRlY3QKICAgICBWcmVmIGNhcHM6IEhJWiA1MCBHUkQgODAKLSAgUGluIERl
ZmF1bHQgMHgwNGExMTIyMTogW0phY2tdIE1pYyBhdCBFeHQgUmlnaHQKKyAgUGluIERlZmF1
bHQgMHgwMmExMTAyMDogW0phY2tdIE1pYyBhdCBFeHQgRnJvbnQKICAgICBDb25uID0gMS84
LCBDb2xvciA9IEJsYWNrCi0gICAgRGVmQXNzb2NpYXRpb24gPSAweDIsIFNlcXVlbmNlID0g
MHgxCisgICAgRGVmQXNzb2NpYXRpb24gPSAweDIsIFNlcXVlbmNlID0gMHgwCiAgIFBpbi1j
dGxzOiAweDI0OiBJTiBWUkVGXzgwCi0gIFVuc29saWNpdGVkOiB0YWc9MDMsIGVuYWJsZWQ9
MQorICBVbnNvbGljaXRlZDogdGFnPTAxLCBlbmFibGVkPTEKIE5vZGUgMHgwYyBbUGluIENv
bXBsZXhdIHdjYXBzIDB4NDAwMDgxOiBTdGVyZW8KICAgUGluY2FwIDB4MDAwMDE3MjQ6IElO
IERldGVjdAogICAgIFZyZWYgY2FwczogSElaIDUwIEdSRCA4MAotICBQaW4gRGVmYXVsdCAw
eDQwZjAwMGYwOiBbTi9BXSBPdGhlciBhdCBFeHQgTi9BCisgIFBpbiBEZWZhdWx0IDB4NDBm
MDAwZjE6IFtOL0FdIE90aGVyIGF0IEV4dCBOL0EKICAgICBDb25uID0gVW5rbm93biwgQ29s
b3IgPSBVbmtub3duCi0gICAgRGVmQXNzb2NpYXRpb24gPSAweGYsIFNlcXVlbmNlID0gMHgw
CisgICAgRGVmQXNzb2NpYXRpb24gPSAweGYsIFNlcXVlbmNlID0gMHgxCiAgIFBpbi1jdGxz
OiAweDI0OiBJTiBWUkVGXzgwCiAgIFVuc29saWNpdGVkOiB0YWc9MDAsIGVuYWJsZWQ9MAog
Tm9kZSAweDBkIFtQaW4gQ29tcGxleF0gd2NhcHMgMHg0MDAxODE6IFN0ZXJlbwogICBQaW5j
YXAgMHgwMDAwMDAxNDogT1VUIERldGVjdAotICBQaW4gRGVmYXVsdCAweDkwMTcwMTEwOiBb
Rml4ZWRdIFNwZWFrZXIgYXQgSW50IE4vQQorICBQaW4gRGVmYXVsdCAweDkwMTcwMDEwOiBb
Rml4ZWRdIFNwZWFrZXIgYXQgSW50IE4vQQogICAgIENvbm4gPSBBbmFsb2csIENvbG9yID0g
VW5rbm93bgogICAgIERlZkFzc29jaWF0aW9uID0gMHgxLCBTZXF1ZW5jZSA9IDB4MAotICAg
IE1pc2MgPSBOT19QUkVTRU5DRQotICBQaW4tY3RsczogMHgwMDoKKyAgUGluLWN0bHM6IDB4
NDA6IE9VVAogICBVbnNvbGljaXRlZDogdGFnPTBjLCBlbmFibGVkPTEKICAgQ29ubmVjdGlv
bjogMwotICAgICAweDEwKiAweDExIDB4MTcKKyAgICAgMHgxMCAweDExKiAweDE3CiBOb2Rl
IDB4MGUgW1BpbiBDb21wbGV4XSB3Y2FwcyAweDQwMDA4MTogU3RlcmVvCiAgIFBpbmNhcCAw
eDAwMDAxNzI0OiBJTiBEZXRlY3QKICAgICBWcmVmIGNhcHM6IEhJWiA1MCBHUkQgODAKLSAg
UGluIERlZmF1bHQgMHgyM2ExOTAyZTogW0phY2tdIE1pYyBhdCBTZXAgTGVmdAotICAgIENv
bm4gPSAxLzgsIENvbG9yID0gUGluawotICAgIERlZkFzc29jaWF0aW9uID0gMHgyLCBTZXF1
ZW5jZSA9IDB4ZQorICBQaW4gRGVmYXVsdCAweDQwZjEwMGYyOiBbTi9BXSBPdGhlciBhdCBF
eHQgTi9BCisgICAgQ29ubiA9IDEvOCwgQ29sb3IgPSBVbmtub3duCisgICAgRGVmQXNzb2Np
YXRpb24gPSAweGYsIFNlcXVlbmNlID0gMHgyCiAgIFBpbi1jdGxzOiAweDI0OiBJTiBWUkVG
XzgwCiAgIFVuc29saWNpdGVkOiB0YWc9MDQsIGVuYWJsZWQ9MQogTm9kZSAweDBmIFtQaW4g
Q29tcGxleF0gd2NhcHMgMHg0MDAxODE6IFN0ZXJlbwogICBQaW5jYXAgMHgwMDAwMDAxNDog
T1VUIERldGVjdAotICBQaW4gRGVmYXVsdCAweDIzMDE0MjUwOiBbSmFja10gTGluZSBPdXQg
YXQgU2VwIExlZnQKKyAgUGluIERlZmF1bHQgMHgwMjAxNDA0MDogW0phY2tdIExpbmUgT3V0
IGF0IEV4dCBGcm9udAogICAgIENvbm4gPSAxLzgsIENvbG9yID0gR3JlZW4KLSAgICBEZWZB
c3NvY2lhdGlvbiA9IDB4NSwgU2VxdWVuY2UgPSAweDAKKyAgICBEZWZBc3NvY2lhdGlvbiA9
IDB4NCwgU2VxdWVuY2UgPSAweDAKICAgUGluLWN0bHM6IDB4NDA6IE9VVAogICBVbnNvbGlj
aXRlZDogdGFnPTAyLCBlbmFibGVkPTEKICAgQ29ubmVjdGlvbjogMwogICAgICAweDEwKiAw
eDExIDB4MTcKIE5vZGUgMHgxMCBbQXVkaW8gT3V0cHV0XSB3Y2FwcyAweGQwYzA1OiBTdGVy
ZW8gQW1wLU91dCBSL0wKICAgQW1wLU91dCBjYXBzOiBOL0EKLSAgQW1wLU91dCB2YWxzOiAg
WzB4NmEgMHg2YV0KKyAgQW1wLU91dCB2YWxzOiAgWzB4ZWEgMHhlYV0KICAgQ29udmVydGVy
OiBzdHJlYW09NSwgY2hhbm5lbD0wCiAgIFBvd2VyOiBzZXR0aW5nPUQwLCBhY3R1YWw9RDAK
ICAgRGVsYXk6IDEzIHNhbXBsZXMKQEAgLTEyNSwxNyArMTI0LDE4IEBACiAgIEFtcC1JbiBj
YXBzOiBvZnM9MHgwMCwgbnN0ZXBzPTB4MDMsIHN0ZXBzaXplPTB4MjcsIG11dGU9MAogICBB
bXAtSW4gdmFsczogIFsweDAwIDB4MDBdCiAgIFBpbmNhcCAweDAwMDAwMDIwOiBJTgotICBQ
aW4gRGVmYXVsdCAweDkwYTAwMGYwOiBbRml4ZWRdIE1pYyBhdCBJbnQgTi9BCi0gICAgQ29u
biA9IFVua25vd24sIENvbG9yID0gVW5rbm93bgotICAgIERlZkFzc29jaWF0aW9uID0gMHhm
LCBTZXF1ZW5jZSA9IDB4MAorICBQaW4gRGVmYXVsdCAweDkwYTYwMzUwOiBbRml4ZWRdIE1p
YyBhdCBJbnQgTi9BCisgICAgQ29ubiA9IERpZ2l0YWwsIENvbG9yID0gVW5rbm93bgorICAg
IERlZkFzc29jaWF0aW9uID0gMHg1LCBTZXF1ZW5jZSA9IDB4MAorICAgIE1pc2MgPSBOT19Q
UkVTRU5DRQogICBQaW4tY3RsczogMHgyMDogSU4KIE5vZGUgMHgxOSBbUGluIENvbXBsZXhd
IHdjYXBzIDB4NDAwMDBiOiBTdGVyZW8gQW1wLUluCiAgIEFtcC1JbiBjYXBzOiBvZnM9MHgw
MCwgbnN0ZXBzPTB4MDMsIHN0ZXBzaXplPTB4MjcsIG11dGU9MAogICBBbXAtSW4gdmFsczog
IFsweDAwIDB4MDBdCiAgIFBpbmNhcCAweDAwMDAwMDIwOiBJTgotICBQaW4gRGVmYXVsdCAw
eDQwZjAwMGYwOiBbTi9BXSBPdGhlciBhdCBFeHQgTi9BCisgIFBpbiBEZWZhdWx0IDB4NDBm
MDAwZjQ6IFtOL0FdIE90aGVyIGF0IEV4dCBOL0EKICAgICBDb25uID0gVW5rbm93biwgQ29s
b3IgPSBVbmtub3duCi0gICAgRGVmQXNzb2NpYXRpb24gPSAweGYsIFNlcXVlbmNlID0gMHgw
CisgICAgRGVmQXNzb2NpYXRpb24gPSAweGYsIFNlcXVlbmNlID0gMHg0CiAgIFBpbi1jdGxz
OiAweDAwOgogTm9kZSAweDFhIFtBdWRpbyBTZWxlY3Rvcl0gd2NhcHMgMHgzMDAxMGQ6IFN0
ZXJlbyBBbXAtT3V0CiAgIEFtcC1PdXQgY2Fwczogb2ZzPTB4MDAsIG5zdGVwcz0weDAzLCBz
dGVwc2l6ZT0weDI3LCBtdXRlPTAKQEAgLTE1OSwxOCArMTU5LDE5IEBACiAgICAgIDB4MWIq
IDB4MTcgMHgxOCAweDE5CiBOb2RlIDB4MWUgW1BpbiBDb21wbGV4XSB3Y2FwcyAweDQwMDMw
MTogU3RlcmVvIERpZ2l0YWwKICAgUGluY2FwIDB4MDAwMDAwMTA6IE9VVAotICBQaW4gRGVm
YXVsdCAweDRmMDAwMGYwOiBbTi9BXSBMaW5lIE91dCBhdCBFeHQgVU5LTk9XTgotICAgIENv
bm4gPSBVbmtub3duLCBDb2xvciA9IFVua25vd24KLSAgICBEZWZBc3NvY2lhdGlvbiA9IDB4
ZiwgU2VxdWVuY2UgPSAweDAKKyAgUGluIERlZmF1bHQgMHgwMjQ1MTFhMDogW0phY2tdIFNQ
RElGIE91dCBhdCBFeHQgRnJvbnQKKyAgICBDb25uID0gT3B0aWNhbCwgQ29sb3IgPSBCbGFj
aworICAgIERlZkFzc29jaWF0aW9uID0gMHhhLCBTZXF1ZW5jZSA9IDB4MAorICAgIE1pc2Mg
PSBOT19QUkVTRU5DRQogICBQaW4tY3RsczogMHg0MDogT1VUCiAgIENvbm5lY3Rpb246IDEK
ICAgICAgMHgyNAogTm9kZSAweDFmIFtQaW4gQ29tcGxleF0gd2NhcHMgMHg0MDA3MDE6IFN0
ZXJlbyBEaWdpdGFsCiAgIFBpbmNhcCAweDAwMDEwMDEwOiBPVVQgRUFQRAogICBFQVBEIDB4
MDoKLSAgUGluIERlZmF1bHQgMHg0ZjAwMDBmMDogW04vQV0gTGluZSBPdXQgYXQgRXh0IFVO
S05PV04KKyAgUGluIERlZmF1bHQgMHg0MGYwMDBmNTogW04vQV0gT3RoZXIgYXQgRXh0IE4v
QQogICAgIENvbm4gPSBVbmtub3duLCBDb2xvciA9IFVua25vd24KLSAgICBEZWZBc3NvY2lh
dGlvbiA9IDB4ZiwgU2VxdWVuY2UgPSAweDAKKyAgICBEZWZBc3NvY2lhdGlvbiA9IDB4Ziwg
U2VxdWVuY2UgPSAweDUKICAgUGluLWN0bHM6IDB4MDA6CiAgIFBvd2VyOiBzZXR0aW5nPUQw
LCBhY3R1YWw9RDAKICAgQ29ubmVjdGlvbjogMgpAQCAtMTg0LDcgKzE4NSw3IEBACiAgIENv
bm5lY3Rpb246IDEKICAgICAgMHgyNQogTm9kZSAweDIxIFtBdWRpbyBPdXRwdXRdIHdjYXBz
IDB4NDAyMTE6IFN0ZXJlbyBEaWdpdGFsCi0gIENvbnZlcnRlcjogc3RyZWFtPTAsIGNoYW5u
ZWw9MAorICBDb252ZXJ0ZXI6IHN0cmVhbT01LCBjaGFubmVsPTAKICAgRGlnaXRhbDoKICAg
RGlnaXRhbCBjYXRlZ29yeTogMHgwCiAgIFBDTToKQEAgLTE5Myw3ICsxOTQsNyBAQAogICAg
IGZvcm1hdHMgWzB4NV06IFBDTSBBQzMKICAgRGVsYXk6IDQgc2FtcGxlcwogTm9kZSAweDIy
IFtBdWRpbyBPdXRwdXRdIHdjYXBzIDB4NDAyMTE6IFN0ZXJlbyBEaWdpdGFsCi0gIENvbnZl
cnRlcjogc3RyZWFtPTAsIGNoYW5uZWw9MAorICBDb252ZXJ0ZXI6IHN0cmVhbT01LCBjaGFu
bmVsPTAKICAgRGlnaXRhbDoKICAgRGlnaXRhbCBjYXRlZ29yeTogMHgwCiAgIFBDTToK
--------------090008050103030805000105
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------090008050103030805000105--
