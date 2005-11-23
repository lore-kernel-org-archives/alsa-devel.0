From: "Yang, Libin" <libin.yang@intel.com>
Subject: RE: [ALSA - driver 0001563]: No Sound on	CybersystemS28 (hda_codec: Unknown model for ALC880, trying auto-probe from	BIOS...)
Date: Thu, 24 Nov 2005 00:05:53 +0800
Message-ID: <D4DBC33C8102AB409C7F44B414D99438015BAF52@bjsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C5F047.C7A213A9"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-class: urn:content-classes:message
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Lee Revell <rlrevell@joe-job.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C5F047.C7A213A9
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable


OK. Thank you for your comments. Here is the attachment.=20

-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de]=20
Sent: 2005=C4=EA11=D4=C223=C8=D5 23:51
To: Yang, Libin
Cc: Lee Revell; alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] [ALSA - driver 0001563]: No Sound on =
CybersystemS28 (hda_codec: Unknown model for ALC880, trying auto-probe =
from BIOS...)

At Wed, 23 Nov 2005 23:39:25 +0800,
Yang, Libin wrote:
>=20
>=20
>  This patch is to fix the problem of calculating the nid incorrectly =
when auto-probe for ALC880. The problem to be fixed often behaves with =
such words when using dmesg, 'num_steps =3D 0 for NID=3D0x8' when =
auto-probe for ALC880.
>=20
> The patch contains:
> - alsa-kernel/pci/hda/patch_realtek.c: replace 'alc880_dac_to_idx' =
with 'alc880_idx_to_dac' in function 'alc880_auto_fill_dac_nids()'
>=20
> Signed-off-by: Libin Yang <libin.yang@intel.com>

Thanks, applied to ALSA CVS now.

BTW, your mailer sent the text with quoted-printable encoding.  This
breaks the patch pasted in the text body.  In such a case, fix the
encoding or use an attachment.


Takashi

------_=_NextPart_001_01C5F047.C7A213A9
Content-Type: application/octet-stream;
	name="rpatch.diff"
Content-Transfer-Encoding: base64
Content-Description: rpatch.diff
Content-Disposition: attachment;
	filename="rpatch.diff"

LS0tIGFsc2EtZHJpdmVyLTEuMC4xMC9hbHNhLWtlcm5lbC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsu
YwkyMDA1LTExLTAyIDEwOjI2OjQ5LjAwMDAwMDAwMCAtMDgwMAorKysgbXlfYWxzYS1kcml2ZXIt
MS4wLjEwL2Fsc2Eta2VybmVsL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jCTIwMDUtMTEtMjMgMDU6
NTI6MzYuMDAwMDAwMDAwIC0wODAwCkBAIC0xODA5LDcgKzE4MDksNyBAQAogCQluaWQgPSBjZmct
PmxpbmVfb3V0X3BpbnNbaV07CiAJCWlmIChhbGM4ODBfaXNfZml4ZWRfcGluKG5pZCkpIHsKIAkJ
CWludCBpZHggPSBhbGM4ODBfZml4ZWRfcGluX2lkeChuaWQpOwotCQkJc3BlYy0+bXVsdGlvdXQu
ZGFjX25pZHNbaV0gPSBhbGM4ODBfZGFjX3RvX2lkeChpZHgpOworCQkJc3BlYy0+bXVsdGlvdXQu
ZGFjX25pZHNbaV0gPSBhbGM4ODBfaWR4X3RvX2RhYyhpZHgpOwogCQkJYXNzaWduZWRbaWR4XSA9
IDE7CiAJCX0KIAl9Cg==

------_=_NextPart_001_01C5F047.C7A213A9--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
