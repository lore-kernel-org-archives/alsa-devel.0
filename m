From: Wei Ni <wni@nvidia.com>
Subject: [PATCH]Add support for more the 8 streams
Date: Tue, 26 Jan 2010 17:32:08 +0800
Message-ID: <6B4D417B830BC44B8026029FD256F7F1BFEAFA4033@HKMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_004_6B4D417B830BC44B8026029FD256F7F1BFEAFA4033HKMAIL01nvidi_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 0AF8424389
	for <alsa-devel@alsa-project.org>; Tue, 26 Jan 2010 10:35:35 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Takashi Iwai' <tiwai@suse.de>
Cc: 'akpm' <akpm@linux-foundation.org>, 'alsa-devel' <alsa-devel@alsa-project.org>, 'linux-kernel' <linux-kernel@vger.kernel.org>, 'Pavel Hofman' <pavel.hofman@insite.cz>
List-Id: alsa-devel@alsa-project.org

--_004_6B4D417B830BC44B8026029FD256F7F1BFEAFA4033HKMAIL01nvidi_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi, Takashi
When I develop the hdmi audio driver on my new chipset, I found a bug in =
the hda_intel.c
It use azx_readb/azx_writeb to read/write SIE, so it just support 8 strea=
ms.
The new HAD controller has more than 8 streams, so I think it should use =
azx_readl/azx_writel.

I attached the patch file, please check it.



Thanks
Wei.


-------------------------------------------------------------------------=
----------
This email message is for the sole use of the intended recipient(s) and m=
ay contain
confidential information.  Any unauthorized review, use, disclosure or di=
stribution
is prohibited.  If you are not the intended recipient, please contact the=
=20sender by
reply email and destroy all copies of the original message.
-------------------------------------------------------------------------=
----------

--_004_6B4D417B830BC44B8026029FD256F7F1BFEAFA4033HKMAIL01nvidi_
Content-Type: application/octet-stream;
	name="0001-Add-support-for-more-the-8-streams.patch"
Content-Description: 0001-Add-support-for-more-the-8-streams.patch
Content-Disposition: attachment;
	filename="0001-Add-support-for-more-the-8-streams.patch"; size=1580;
	creation-date="Tue, 26 Jan 2010 17:22:58 GMT";
	modification-date="Tue, 26 Jan 2010 17:22:58 GMT"
Content-Transfer-Encoding: base64

RnJvbSBlYTc0MmU4Y2U2ZjA3ZmFmMGFmM2ViM2FjZWQ3ZWQzZWNjNzBlNDY3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBXZWkgTmkgPHduaUBudmlkaWEuY29tPgpEYXRlOiBUdWUsIDI2
IEphbiAyMDEwIDE1OjU5OjMzICswODAwClN1YmplY3Q6IFtQQVRDSF0gQWRkIHN1cHBvcnQgZm9y
IG1vcmUgdGhlIDggc3RyZWFtcwoKSW4gYXp4X3N0cmVhbV9zdGFydCgpIGFuZCBhenhfc3RyZWFt
X3N0b3AoKSwKaXQgdXNlIGF6eF9yZWFkYi9henhfd3JpdGViIHRvIHJlYWQvd3JpdGUgU0lFLApp
dCBqdXN0IGVuYWJsZS9kaXNhYmxlIDggc3RyZWFtcy4KQnV0IGFjY29yZGluZyB0byB0aGUgSERB
IHNwZWMsIGl0IHN1cHBvcnQgMzAgc3RyZWFtcywKYW5kIHRoZSBuZXcgSERBIGNvbnRyb2xsZXIg
d2lsbCBzdXBwb3J0IG1vcmUgdGhlbiA4CnN0cmVhbXMuIFNvIHdlIHNob3VsZCB1c2UgYXp4X3Jl
YWRsL2F6eF93cml0ZWwgdG8KcmVhZC93cml0ZSBTSUUuCgpTaWduZWQtb2ZmLWJ5OiBXZWkgTmkg
PHduaUBudmlkaWEuY29tPgotLS0KIHNvdW5kL3BjaS9oZGEvaGRhX2ludGVsLmMgfCAgICA4ICsr
KystLS0tCiAxIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9zb3VuZC9wY2kvaGRhL2hkYV9pbnRlbC5jIGIvc291bmQvcGNpL2hkYS9o
ZGFfaW50ZWwuYwppbmRleCA2ZDMzMWM0Li42ZWVlZmRhIDEwMDY0NAotLS0gYS9zb3VuZC9wY2kv
aGRhL2hkYV9pbnRlbC5jCisrKyBiL3NvdW5kL3BjaS9oZGEvaGRhX2ludGVsLmMKQEAgLTk1NCw4
ICs5NTQsOCBAQCBzdGF0aWMgdm9pZCBhenhfc3RyZWFtX3N0YXJ0KHN0cnVjdCBhenggKmNoaXAs
IHN0cnVjdCBhenhfZGV2ICphenhfZGV2KQogCWF6eF9kZXYtPmluc3VmZmljaWVudCA9IDE7CiAK
IAkvKiBlbmFibGUgU0lFICovCi0JYXp4X3dyaXRlYihjaGlwLCBJTlRDVEwsCi0JCSAgIGF6eF9y
ZWFkYihjaGlwLCBJTlRDVEwpIHwgKDEgPDwgYXp4X2Rldi0+aW5kZXgpKTsKKwlhenhfd3JpdGVs
KGNoaXAsIElOVENUTCwKKwkJICAgYXp4X3JlYWRsKGNoaXAsIElOVENUTCkgfCAoMSA8PCBhenhf
ZGV2LT5pbmRleCkpOwogCS8qIHNldCBETUEgc3RhcnQgYW5kIGludGVycnVwdCBtYXNrICovCiAJ
YXp4X3NkX3dyaXRlYihhenhfZGV2LCBTRF9DVEwsIGF6eF9zZF9yZWFkYihhenhfZGV2LCBTRF9D
VEwpIHwKIAkJICAgICAgU0RfQ1RMX0RNQV9TVEFSVCB8IFNEX0lOVF9NQVNLKTsKQEAgLTk3NCw4
ICs5NzQsOCBAQCBzdGF0aWMgdm9pZCBhenhfc3RyZWFtX3N0b3Aoc3RydWN0IGF6eCAqY2hpcCwg
c3RydWN0IGF6eF9kZXYgKmF6eF9kZXYpCiB7CiAJYXp4X3N0cmVhbV9jbGVhcihjaGlwLCBhenhf
ZGV2KTsKIAkvKiBkaXNhYmxlIFNJRSAqLwotCWF6eF93cml0ZWIoY2hpcCwgSU5UQ1RMLAotCQkg
ICBhenhfcmVhZGIoY2hpcCwgSU5UQ1RMKSAmIH4oMSA8PCBhenhfZGV2LT5pbmRleCkpOworCWF6
eF93cml0ZWwoY2hpcCwgSU5UQ1RMLAorCQkgICBhenhfcmVhZGwoY2hpcCwgSU5UQ1RMKSAmIH4o
MSA8PCBhenhfZGV2LT5pbmRleCkpOwogfQogCiAKLS0gCjEuNS42Cgo=

--_004_6B4D417B830BC44B8026029FD256F7F1BFEAFA4033HKMAIL01nvidi_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--_004_6B4D417B830BC44B8026029FD256F7F1BFEAFA4033HKMAIL01nvidi_--
