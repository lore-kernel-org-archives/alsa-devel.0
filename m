From: Eric Millbrandt <emillbrandt@dekaresearch.com>
Subject: Re: [PATCH 1/1] Do not write to invalid registers
	on	the wm9712.
Date: Wed, 23 Dec 2009 10:00:37 -0500
Message-ID: <0A40042D85E7C84DB443060EC44B3FD308C08371C3@dekaexchange07.deka.local>
References: <1261502938-11137-1-git-send-email-emillbrandt@dekaresearch.com>
	<20091222234628.GB2643@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_0A40042D85E7C84DB443060EC44B3FD308C08371C3dekaexchange0_"
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20091222234628.GB2643@sirena.org.uk>
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
To: 'Mark Brown' <broonie@opensource.wolfsonmicro.com>
Cc: "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patch@alsa-project.org" <patch@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--_002_0A40042D85E7C84DB443060EC44B3FD308C08371C3dekaexchange0_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

...
> This looks like a reasonable fix but it doesn't apply against current
> kernels.  Could you please regenerate it against
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for=
-
> 2.6.33
>

It looks like the legal jargon post-pended to the patch creates grief for g=
it.  I am resubmitting the patch as an attachment so that is will not get m=
angled.

Eric

This e-mail and the information, including any attachments, it contains are=
 intended to be a confidential communication only to the person or entity t=
o whom it is addressed and may contain information that is privileged. If t=
he reader of this message is not the intended recipient, you are hereby not=
ified that any dissemination, distribution or copying of this communication=
 is strictly prohibited. If you have received this communication in error, =
please immediately notify the sender and destroy the original message.

Thank you.

Please consider the environment before printing this email.

--_002_0A40042D85E7C84DB443060EC44B3FD308C08371C3dekaexchange0_
Content-Type: application/octet-stream;
	name="0001-Do-not-write-to-invalid-registers-on-the-wm9712.patch"
Content-Description: 0001-Do-not-write-to-invalid-registers-on-the-wm9712.patch
Content-Disposition: attachment;
	filename="0001-Do-not-write-to-invalid-registers-on-the-wm9712.patch";
	size=1134; creation-date="Wed, 23 Dec 2009 09:45:16 GMT";
	modification-date="Tue, 22 Dec 2009 13:07:16 GMT"
Content-Transfer-Encoding: base64

RnJvbSBhMGY3N2JmODg2ODU0ZmQ0YzA4NDQwNGZkYjRhYzU3OGNkNjhjYzZhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFcmljIE1pbGxicmFuZHQgPGVtaWxsYnJhbmR0QGRla2FyZXNl
YXJjaC5jb20+CkRhdGU6IFR1ZSwgMjIgRGVjIDIwMDkgMTA6MTM6MjQgLTA1MDAKU3ViamVjdDog
W1BBVENIIDEvMV0gRG8gbm90IHdyaXRlIHRvIGludmFsaWQgcmVnaXN0ZXJzIG9uIHRoZSB3bTk3
MTIuCgpUaGlzIHBhdGNoIGZpeGVzIGEgYnVnIHdoZXJlICJ2aXJ0dWFsIiByZWdpc3RlcnMgd2Vy
ZSBiZWluZyB3cml0dGVuIHRvIHRoZQphYzk3IGJ1cy4gIFRoaXMgd2FzIGNhdXNpbmcgdW5yZWxh
dGVkIHJlZ2lzdGVycyB0byBiZWNvbWUgY29ycnVwdGVkIChoZWFkcGhvbmUgMHgwNCwKdG91Y2hz
Y3JlZW4gMHg3OCwgZXRjKS4KClRoaXMgcGF0Y2ggZHVwbGljYXRlcyBwcm90ZWN0aW9uIHRoYXQg
d2FzIGluY2x1ZGVkIGluIHRoZSB3bTk3MTMgZHJpdmVyLgoKU2lnbmVkLW9mZi1ieTogRXJpYyBN
aWxsYnJhbmR0IDxlbWlsbGJyYW5kdEBkZWthcmVzZWFyY2guY29tPgotLS0KIHNvdW5kL3NvYy9j
b2RlY3Mvd205NzEyLmMgfCAgICAzICsrLQogMSBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc291bmQvc29jL2NvZGVjcy93bTk3MTIu
YyBiL3NvdW5kL3NvYy9jb2RlY3Mvd205NzEyLmMKaW5kZXggMGFjMTIxNS4uZTIzN2JmNiAxMDA2
NDQKLS0tIGEvc291bmQvc29jL2NvZGVjcy93bTk3MTIuYworKysgYi9zb3VuZC9zb2MvY29kZWNz
L3dtOTcxMi5jCkBAIC00NjMsNyArNDYzLDggQEAgc3RhdGljIGludCBhYzk3X3dyaXRlKHN0cnVj
dCBzbmRfc29jX2NvZGVjICpjb2RlYywgdW5zaWduZWQgaW50IHJlZywKIHsKIAl1MTYgKmNhY2hl
ID0gY29kZWMtPnJlZ19jYWNoZTsKIAotCXNvY19hYzk3X29wcy53cml0ZShjb2RlYy0+YWM5Nywg
cmVnLCB2YWwpOworCWlmIChyZWcgPCAweDdjKQorCQlzb2NfYWM5N19vcHMud3JpdGUoY29kZWMt
PmFjOTcsIHJlZywgdmFsKTsKIAlyZWcgPSByZWcgPj4gMTsKIAlpZiAocmVnIDwgKEFSUkFZX1NJ
WkUod205NzEyX3JlZykpKQogCQljYWNoZVtyZWddID0gdmFsOwotLSAKMS42LjMuMQoK

--_002_0A40042D85E7C84DB443060EC44B3FD308C08371C3dekaexchange0_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--_002_0A40042D85E7C84DB443060EC44B3FD308C08371C3dekaexchange0_--
