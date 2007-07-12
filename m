From: "Claudio Matsuoka" <cmatsuoka@gmail.com>
Subject: Re: [PATCH] LG LW line-in capture
Date: Thu, 12 Jul 2007 17:17:40 -0300
Message-ID: <5f52f6d70707121317l52d63d76xd2070f37d253faa8@mail.gmail.com>
References: <5f52f6d70707121315o35bf2519i40ec920a5f117a9a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_20402_27458499.1184271460998"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.188])
	by alsa0.perex.cz (Postfix) with ESMTP id 10432103829
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Jul 2007 22:17:42 +0200 (CEST)
Received: by nf-out-0910.google.com with SMTP id b21so16652nfd
	for <alsa-devel@alsa-project.org>; Thu, 12 Jul 2007 13:17:41 -0700 (PDT)
In-Reply-To: <5f52f6d70707121315o35bf2519i40ec920a5f117a9a@mail.gmail.com>
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

------=_Part_20402_27458499.1184271460998
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 7/12/07, Claudio Matsuoka <cmatsuoka@gmail.com> wrote:

> This patch adds line-in capture to LG LW (ALC880 codec). Tested with LW20.
>

And it will work even better with the actual patch attached ;)

------=_Part_20402_27458499.1184271460998
Content-Type: text/x-diff;
	name=0010-ALSA-hda-codec-Add-LG-LW20-line-in-capture-sourc.patch;
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f41omcuc
Content-Disposition: attachment; filename="0010-ALSA-hda-codec-Add-LG-LW20-line-in-capture-sourc.patch"

RnJvbSAwYTM4NzQyOTdjMTg0N2QwYjcyNTJiNTFmMjlhZGRhZTFlMWIzMzI4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDbGF1ZGlvIE1hdHN1b2thIDxjbWF0c3Vva2FAZ21haWwuY29t
PgpEYXRlOiBUaHUsIDEyIEp1bCAyMDA3IDEyOjQzOjQzIC0wMzAwClN1YmplY3Q6IFtQQVRDSF0g
W0FMU0FdIGhkYS1jb2RlYyAtIEFkZCBMRyBMVzIwIGxpbmUtaW4gY2FwdHVyZSBzb3VyY2UKCkFk
ZCBsaW5lLWluIHRvIHRoZSBsaXN0IG9mIExHIExXMjAgY2FwdHVyZSBzb3VyY2VzLiBBbHNvIGZp
eCB0aGUgTEcgTFcKcGluIGFzc2lnbm1lbnQgbGlzdCBjb21tZW50LgoKU2lnbmVkLW9mZi1ieTog
Q2xhdWRpbyBNYXRzdW9rYSA8Y21hdHN1b2thQGdtYWlsLmNvbT4KLS0tCiBzb3VuZC9wY2kvaGRh
L3BhdGNoX3JlYWx0ZWsuYyB8ICAgIDkgKysrKystLS0tCiAxIGZpbGVzIGNoYW5nZWQsIDUgaW5z
ZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zb3VuZC9wY2kvaGRhL3Bh
dGNoX3JlYWx0ZWsuYyBiL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jCmluZGV4IGFkMmI0
MjAuLjI2NDYyYzQgMTAwNjQ0Ci0tLSBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jCisr
KyBiL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jCkBAIC0xODgwLDE3ICsxODgwLDE4IEBA
IHN0YXRpYyB2b2lkIGFsYzg4MF9sZ191bnNvbF9ldmVudChzdHJ1Y3QgaGRhX2NvZGVjICpjb2Rl
YywgdW5zaWduZWQgaW50IHJlcykKICAqIFBpbiBhc3NpZ25tZW50OgogICogICBTcGVha2VyLW91
dDogMHgxNAogICogICBNaWMtSW46IDB4MTgKLSAqICAgQnVpbHQtaW4gTWljLUluOiAweDE5ICg/
KQotICogICBIUC1PdXQ6IDB4MWIKKyAqICAgQnVpbHQtaW4gTWljLUluOiAweDE5CisgKiAgIExp
bmUtSW46IDB4MWIKKyAqICAgSFAtT3V0OiAweDFhCiAgKiAgIFNQRElGLU91dDogMHgxZQogICov
CiAKLS8qIHNlZW1zIGFuYWxvZyBDRCBpcyBub3Qgd29ya2luZyAqLwogc3RhdGljIHN0cnVjdCBo
ZGFfaW5wdXRfbXV4IGFsYzg4MF9sZ19sd19jYXB0dXJlX3NvdXJjZSA9IHsKLQkubnVtX2l0ZW1z
ID0gMiwKKwkubnVtX2l0ZW1zID0gMywKIAkuaXRlbXMgPSB7CiAJCXsgIk1pYyIsIDB4MCB9LAog
CQl7ICJJbnRlcm5hbCBNaWMiLCAweDEgfSwKKwkJeyAiTGluZSBJbiIsIDB4MiB9LAogCX0sCiB9
OwogCi0tIAoxLjUuMi4zCgo=
------=_Part_20402_27458499.1184271460998
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_20402_27458499.1184271460998--
