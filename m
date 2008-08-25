From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Sound Blaster Audigy (snd_ca0106 Creative Labs|SB
 Audigy LS): How to use the mixer?
Date: Mon, 25 Aug 2008 09:13:16 +0100
Message-ID: <g8tpis$ddd$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060606010101030703040604"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 94A89245CA
	for <alsa-devel@alsa-project.org>;
	Mon, 25 Aug 2008 10:13:29 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KXXCa-0000hW-Cb
	for alsa-devel@alsa-project.org; Mon, 25 Aug 2008 08:13:28 +0000
Received: from 80-192-67-147.cable.ubr10.edin.blueyonder.co.uk
	([80.192.67.147]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 25 Aug 2008 08:13:28 +0000
Received: from gmane by 80-192-67-147.cable.ubr10.edin.blueyonder.co.uk with
	local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 25 Aug 2008 08:13:28 +0000
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

This is a multi-part message in MIME format.
--------------060606010101030703040604
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Just trying to help a user with a problem and it seems to be down to the
fact that his SB Audigy LS does not have a "Master" or "PCM" mixer control.

I asked Lennart about this and he told that Takashi said he wanted to 
make sure that all devices have at least a Master vol control.

This one doesn't!

Please let me know what you need in order to fix this.

This is with 1.0.17... I can't see anything in the changelog that would 
suggest this is fixed in the 1.0.18rc1.

Please let me know if you need e.g. PCI ids etc. as I can ask the user 
to provide these.

Col



-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
    Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
    Mandriva Linux Contributor [http://www.mandriva.com/]
    PulseAudio Hacker [http://www.pulseaudio.org/]
    Trac Hacker [http://trac.edgewall.org/]


--------------060606010101030703040604
Content-Type: text/plain;
 name="amixer.txt"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="amixer.txt"

U2ltcGxlIG1peGVyIGNvbnRyb2wgJ0xpbmUgaW4nLDAKICBDYXBhYmlsaXRpZXM6IGN2b2x1
bWUKICBDYXB0dXJlIGNoYW5uZWxzOiBGcm9udCBMZWZ0IC0gRnJvbnQgUmlnaHQKICBMaW1p
dHM6IENhcHR1cmUgMCAtIDI1NQogIEZyb250IExlZnQ6IENhcHR1cmUgMjU1IFsxMDAlXSBb
MjQuMDBkQl0KICBGcm9udCBSaWdodDogQ2FwdHVyZSAyNTUgWzEwMCVdIFsyNC4wMGRCXQpT
aW1wbGUgbWl4ZXIgY29udHJvbCAnTWljJywwCiAgQ2FwYWJpbGl0aWVzOiBjdm9sdW1lCiAg
Q2FwdHVyZSBjaGFubmVsczogRnJvbnQgTGVmdCAtIEZyb250IFJpZ2h0CiAgTGltaXRzOiBD
YXB0dXJlIDAgLSAyNTUKICBGcm9udCBMZWZ0OiBDYXB0dXJlIDI1NSBbMTAwJV0gWzI0LjAw
ZEJdCiAgRnJvbnQgUmlnaHQ6IENhcHR1cmUgMjU1IFsxMDAlXSBbMjQuMDBkQl0KU2ltcGxl
IG1peGVyIGNvbnRyb2wgJ1Bob25lJywwCiAgQ2FwYWJpbGl0aWVzOiBjdm9sdW1lCiAgQ2Fw
dHVyZSBjaGFubmVsczogRnJvbnQgTGVmdCAtIEZyb250IFJpZ2h0CiAgTGltaXRzOiBDYXB0
dXJlIDAgLSAyNTUKICBGcm9udCBMZWZ0OiBDYXB0dXJlIDIwNyBbODElXSBbMC4wMGRCXQog
IEZyb250IFJpZ2h0OiBDYXB0dXJlIDIwNyBbODElXSBbMC4wMGRCXQpTaW1wbGUgbWl4ZXIg
Y29udHJvbCAnSUVDOTU4JywwCiAgQ2FwYWJpbGl0aWVzOiBwc3dpdGNoIHBzd2l0Y2gtam9p
bmVkCiAgUGxheWJhY2sgY2hhbm5lbHM6IE1vbm8KICBNb25vOiBQbGF5YmFjayBbb25dClNp
bXBsZSBtaXhlciBjb250cm9sICdJRUM5NTggQ2VudGVyL0xGRScsMAogIENhcGFiaWxpdGll
czogcHZvbHVtZQogIFBsYXliYWNrIGNoYW5uZWxzOiBGcm9udCBMZWZ0IC0gRnJvbnQgUmln
aHQKICBMaW1pdHM6IFBsYXliYWNrIDAgLSAyNTUKICBNb25vOgogIEZyb250IExlZnQ6IFBs
YXliYWNrIDI1NSBbMTAwJV0gWzEyLjAwZEJdCiAgRnJvbnQgUmlnaHQ6IFBsYXliYWNrIDI1
NSBbMTAwJV0gWzEyLjAwZEJdClNpbXBsZSBtaXhlciBjb250cm9sICdJRUM5NTggRnJvbnQn
LDAKICBDYXBhYmlsaXRpZXM6IHB2b2x1bWUKICBQbGF5YmFjayBjaGFubmVsczogRnJvbnQg
TGVmdCAtIEZyb250IFJpZ2h0CiAgTGltaXRzOiBQbGF5YmFjayAwIC0gMjU1CiAgTW9ubzoK
ICBGcm9udCBMZWZ0OiBQbGF5YmFjayAyNTUgWzEwMCVdIFsxMi4wMGRCXQogIEZyb250IFJp
Z2h0OiBQbGF5YmFjayAyNTUgWzEwMCVdIFsxMi4wMGRCXQpTaW1wbGUgbWl4ZXIgY29udHJv
bCAnSUVDOTU4IFJlYXInLDAKICBDYXBhYmlsaXRpZXM6IHB2b2x1bWUKICBQbGF5YmFjayBj
aGFubmVsczogRnJvbnQgTGVmdCAtIEZyb250IFJpZ2h0CiAgTGltaXRzOiBQbGF5YmFjayAw
IC0gMjU1CiAgTW9ubzoKICBGcm9udCBMZWZ0OiBQbGF5YmFjayAyNTUgWzEwMCVdIFsxMi4w
MGRCXQogIEZyb250IFJpZ2h0OiBQbGF5YmFjayAyNTUgWzEwMCVdIFsxMi4wMGRCXQpTaW1w
bGUgbWl4ZXIgY29udHJvbCAnSUVDOTU4IFVua25vd24nLDAKICBDYXBhYmlsaXRpZXM6IHB2
b2x1bWUKICBQbGF5YmFjayBjaGFubmVsczogRnJvbnQgTGVmdCAtIEZyb250IFJpZ2h0CiAg
TGltaXRzOiBQbGF5YmFjayAwIC0gMjU1CiAgTW9ubzoKICBGcm9udCBMZWZ0OiBQbGF5YmFj
ayAyNTUgWzEwMCVdIFsxMi4wMGRCXQogIEZyb250IFJpZ2h0OiBQbGF5YmFjayAyNTUgWzEw
MCVdIFsxMi4wMGRCXQpTaW1wbGUgbWl4ZXIgY29udHJvbCAnQXV4JywwCiAgQ2FwYWJpbGl0
aWVzOiBjdm9sdW1lCiAgQ2FwdHVyZSBjaGFubmVsczogRnJvbnQgTGVmdCAtIEZyb250IFJp
Z2h0CiAgTGltaXRzOiBDYXB0dXJlIDAgLSAyNTUKICBGcm9udCBMZWZ0OiBDYXB0dXJlIDIw
NyBbODElXSBbMC4wMGRCXQogIEZyb250IFJpZ2h0OiBDYXB0dXJlIDIwNyBbODElXSBbMC4w
MGRCXQpTaW1wbGUgbWl4ZXIgY29udHJvbCAnQW5hbG9nIENlbnRlci9MRkUnLDAKICBDYXBh
YmlsaXRpZXM6IHB2b2x1bWUgcHN3aXRjaCBwc3dpdGNoLWpvaW5lZAogIFBsYXliYWNrIGNo
YW5uZWxzOiBGcm9udCBMZWZ0IC0gRnJvbnQgUmlnaHQKICBMaW1pdHM6IFBsYXliYWNrIDAg
LSAyNTUKICBNb25vOgogIEZyb250IExlZnQ6IFBsYXliYWNrIDI1NSBbMTAwJV0gWzEyLjAw
ZEJdIFtvbl0KICBGcm9udCBSaWdodDogUGxheWJhY2sgMjU1IFsxMDAlXSBbMTIuMDBkQl0g
W29uXQpTaW1wbGUgbWl4ZXIgY29udHJvbCAnQW5hbG9nIEZyb250JywwCiAgQ2FwYWJpbGl0
aWVzOiBwdm9sdW1lIHBzd2l0Y2ggcHN3aXRjaC1qb2luZWQKICBQbGF5YmFjayBjaGFubmVs
czogRnJvbnQgTGVmdCAtIEZyb250IFJpZ2h0CiAgTGltaXRzOiBQbGF5YmFjayAwIC0gMjU1
CiAgTW9ubzoKICBGcm9udCBMZWZ0OiBQbGF5YmFjayAyNTUgWzEwMCVdIFsxMi4wMGRCXSBb
b25dCiAgRnJvbnQgUmlnaHQ6IFBsYXliYWNrIDI1NSBbMTAwJV0gWzEyLjAwZEJdIFtvbl0K
U2ltcGxlIG1peGVyIGNvbnRyb2wgJ0FuYWxvZyBSZWFyJywwCiAgQ2FwYWJpbGl0aWVzOiBw
dm9sdW1lIHBzd2l0Y2ggcHN3aXRjaC1qb2luZWQKICBQbGF5YmFjayBjaGFubmVsczogRnJv
bnQgTGVmdCAtIEZyb250IFJpZ2h0CiAgTGltaXRzOiBQbGF5YmFjayAwIC0gMjU1CiAgTW9u
bzoKICBGcm9udCBMZWZ0OiBQbGF5YmFjayAyNTUgWzEwMCVdIFsxMi4wMGRCXSBbb25dCiAg
RnJvbnQgUmlnaHQ6IFBsYXliYWNrIDI1NSBbMTAwJV0gWzEyLjAwZEJdIFtvbl0KU2ltcGxl
IG1peGVyIGNvbnRyb2wgJ0FuYWxvZyBTaWRlJywwCiAgQ2FwYWJpbGl0aWVzOiBwdm9sdW1l
IHBzd2l0Y2ggcHN3aXRjaC1qb2luZWQKICBQbGF5YmFjayBjaGFubmVsczogRnJvbnQgTGVm
dCAtIEZyb250IFJpZ2h0CiAgTGltaXRzOiBQbGF5YmFjayAwIC0gMjU1CiAgTW9ubzoKICBG
cm9udCBMZWZ0OiBQbGF5YmFjayAyNTUgWzEwMCVdIFsxMi4wMGRCXSBbb25dCiAgRnJvbnQg
UmlnaHQ6IFBsYXliYWNrIDI1NSBbMTAwJV0gWzEyLjAwZEJdIFtvbl0KU2ltcGxlIG1peGVy
IGNvbnRyb2wgJ0FuYWxvZyBTb3VyY2UnLDAKICBDYXBhYmlsaXRpZXM6IGNlbnVtCiAgSXRl
bXM6ICdQaG9uZScgJ01pYycgJ0xpbmUgaW4nICdBdXgnCiAgSXRlbTA6ICdMaW5lIGluJwpT
aW1wbGUgbWl4ZXIgY29udHJvbCAnQ0FQVFVSRSBmZWVkYmFjaycsMAogIENhcGFiaWxpdGll
czogcHZvbHVtZQogIFBsYXliYWNrIGNoYW5uZWxzOiBGcm9udCBMZWZ0IC0gRnJvbnQgUmln
aHQKICBMaW1pdHM6IFBsYXliYWNrIDAgLSAyNTUKICBNb25vOgogIEZyb250IExlZnQ6IFBs
YXliYWNrIDI1NSBbMTAwJV0gWzEyLjAwZEJdCiAgRnJvbnQgUmlnaHQ6IFBsYXliYWNrIDI1
NSBbMTAwJV0gWzEyLjAwZEJdClNpbXBsZSBtaXhlciBjb250cm9sICdEaWdpdGFsIFNvdXJj
ZScsMAogIENhcGFiaWxpdGllczogY2VudW0KICBJdGVtczogJ0lFQzk1OCBvdXQnICdpMnMg
bWl4ZXIgb3V0JyAnSUVDOTU4IGluJyAnaTJzIGluJyAnQUM5NyBpbicgJ1NSQyBvdXQnCiAg
SXRlbTA6ICdpMnMgaW4nClNpbXBsZSBtaXhlciBjb250cm9sICdTaGFyZWQgTWljL0xpbmUg
aW4nLDAKICBDYXBhYmlsaXRpZXM6IGNlbnVtCiAgSXRlbXM6ICdMaW5lIGluJyAnTWljIGlu
JwogIEl0ZW0wOiAnTGluZSBpbicK
--------------060606010101030703040604
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------060606010101030703040604--
