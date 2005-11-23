From: "Yang, Libin" <libin.yang@intel.com>
Subject: RE: [ALSA - driver 0001563]: No Sound on CybersystemS28 (hda_codec: Unknown model for ALC880, trying auto-probe from BIOS...)
Date: Wed, 23 Nov 2005 13:55:56 +0800
Message-ID: <D4DBC33C8102AB409C7F44B414D99438015BAB13@bjsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C5EFF2.9312A6E1"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from orsfmr002.jf.intel.com (fmr17.intel.com [134.134.136.16])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1A918190
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2005 06:56:18 +0100 (MET)
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
To: Lee Revell <rlrevell@joe-job.com>
Cc: bugtrack@alsa-project.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C5EFF2.9312A6E1
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

Here is the patch file for 1.0.10.=20

The problem is that in the patch_realtek.c file, it should use =
alc880_idx_to_dac() function in the first 'for' loop, not =
alc880_dac_to_idx() in function alc880_auto_fill_dac_nids().

Thanks.

-----Original Message-----
From: alsa-devel-admin@lists.sourceforge.net =
[mailto:alsa-devel-admin@lists.sourceforge.net] On Behalf Of Lee Revell
Sent: 2005=C4=EA11=D4=C223=C8=D5 10:49
To: Yang, Libin
Cc: bugtrack@alsa-project.org; alsa-devel@alsa-project.org
Subject: RE: [Alsa-devel] [ALSA - driver 0001563]: No Sound on =
CybersystemS28 (hda_codec: Unknown model for ALC880, trying auto-probe =
from BIOS...)

On Wed, 2005-11-23 at 10:45 +0800, Yang, Libin wrote:
> I think I have found the reason which may cause the problem. But I =
don't  how to submit the patch or just write the reason here? Thanks. =20

Thanks very much for fixing this.

You can just post the patch here, with the description and Signed-Off-By
line.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=3D7628&alloc_id=3D16845&op=3Dclick
_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

------_=_NextPart_001_01C5EFF2.9312A6E1
Content-Type: application/octet-stream;
	name="rpatch.diff"
Content-Transfer-Encoding: base64
Content-Description: rpatch.diff
Content-Disposition: attachment;
	filename="rpatch.diff"

ZGlmZiAtdXJOIGFsc2EtZHJpdmVyLTEuMC4xMC9hbHNhLWtlcm5lbC9wY2kvaGRhL3BhdGNoX3Jl
YWx0ZWsuYyBteV9hbHNhLWRyaXZlci0xLjAuMTAvYWxzYS1rZXJuZWwvcGNpL2hkYS9wYXRjaF9y
ZWFsdGVrLmMKLS0tIGFsc2EtZHJpdmVyLTEuMC4xMC9hbHNhLWtlcm5lbC9wY2kvaGRhL3BhdGNo
X3JlYWx0ZWsuYwkyMDA1LTExLTAyIDEwOjI2OjQ5LjAwMDAwMDAwMCAtMDgwMAorKysgbXlfYWxz
YS1kcml2ZXItMS4wLjEwL2Fsc2Eta2VybmVsL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jCTIwMDUt
MTEtMjMgMDU6NTI6MzYuMDAwMDAwMDAwIC0wODAwCkBAIC0xODA5LDcgKzE4MDksNyBAQAogCQlu
aWQgPSBjZmctPmxpbmVfb3V0X3BpbnNbaV07CiAJCWlmIChhbGM4ODBfaXNfZml4ZWRfcGluKG5p
ZCkpIHsKIAkJCWludCBpZHggPSBhbGM4ODBfZml4ZWRfcGluX2lkeChuaWQpOwotCQkJc3BlYy0+
bXVsdGlvdXQuZGFjX25pZHNbaV0gPSBhbGM4ODBfZGFjX3RvX2lkeChpZHgpOworCQkJc3BlYy0+
bXVsdGlvdXQuZGFjX25pZHNbaV0gPSBhbGM4ODBfaWR4X3RvX2RhYyhpZHgpOwogCQkJYXNzaWdu
ZWRbaWR4XSA9IDE7CiAJCX0KIAl9CmRpZmYgLXVyTiBhbHNhLWRyaXZlci0xLjAuMTAvc291bmQv
cGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMgbXlfYWxzYS1kcml2ZXItMS4wLjEwL3NvdW5kL3BjaS9o
ZGEvcGF0Y2hfcmVhbHRlay5jCi0tLSBhbHNhLWRyaXZlci0xLjAuMTAvc291bmQvcGNpL2hkYS9w
YXRjaF9yZWFsdGVrLmMJMjAwNS0xMS0wMiAxMDoyNjo0OS4wMDAwMDAwMDAgLTA4MDAKKysrIG15
X2Fsc2EtZHJpdmVyLTEuMC4xMC9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYwkyMDA1LTEx
LTIzIDA1OjUyOjM2LjAwMDAwMDAwMCAtMDgwMApAQCAtMTgwOSw3ICsxODA5LDcgQEAKIAkJbmlk
ID0gY2ZnLT5saW5lX291dF9waW5zW2ldOwogCQlpZiAoYWxjODgwX2lzX2ZpeGVkX3BpbihuaWQp
KSB7CiAJCQlpbnQgaWR4ID0gYWxjODgwX2ZpeGVkX3Bpbl9pZHgobmlkKTsKLQkJCXNwZWMtPm11
bHRpb3V0LmRhY19uaWRzW2ldID0gYWxjODgwX2RhY190b19pZHgoaWR4KTsKKwkJCXNwZWMtPm11
bHRpb3V0LmRhY19uaWRzW2ldID0gYWxjODgwX2lkeF90b19kYWMoaWR4KTsKIAkJCWFzc2lnbmVk
W2lkeF0gPSAxOwogCQl9CiAJfQo=

------_=_NextPart_001_01C5EFF2.9312A6E1--


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
