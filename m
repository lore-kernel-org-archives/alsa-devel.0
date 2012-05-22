From: =?utf-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?= <benoit.thebaudeau@advansee.com>
Subject: Re: [PATCH] alsa-lib/tlv: fix handling of raw
	value	ranges
Date: Tue, 22 May 2012 18:06:34 +0200 (CEST)
Message-ID: <1666726176.1119743.1337702794239.JavaMail.root@advansee.com>
References: <s5hbolg8uyp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_1119741_375883953.1337702794237"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from zose-mta14.web4all.fr (zose-mta14.web4all.fr [88.190.236.157])
	by alsa0.perex.cz (Postfix) with ESMTP id A6F8924634
	for <alsa-devel@alsa-project.org>;
	Tue, 22 May 2012 18:02:30 +0200 (CEST)
In-Reply-To: <s5hbolg8uyp.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

------=_Part_1119741_375883953.1337702794237
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

Takashi Iwai wrote:
> It's OK to put an attachment, but I failed to apply it.
> Please check the patch you sent can be really applied cleanly to
> alsa-lib git tree.

My copy/paste damaged tabs. Hopefully, this should now work.

Regards,
Beno=C3=AEt
------=_Part_1119741_375883953.1337702794237
Content-Type: text/x-patch; name=improve-tlv-raw-val-robustness.patch
Content-Disposition: attachment;
 filename=improve-tlv-raw-val-robustness.patch
Content-Transfer-Encoding: base64

YWxzYS1saWIvdGx2OiBpbXByb3ZlIHJvYnVzdG5lc3Mgb2YgcmF3IHZhbHVlIHJhbmdlcwoKc25k
X3Rsdl9jb252ZXJ0X2Zyb21fZEIoKSByZWxpZXMgb24gcmFuZ2VtaW4vbWF4IGJsaW5kbHkuIFNp
bmNlIHRoaXMgZnVuY3Rpb24gaXMKZXhwb3J0ZWQsIGl0IGlzIGJldHRlciBmb3Igcm9idXN0bmVz
cyBhbmQgY29uc2lzdGVuY3kgdG8gcGFyc2UgdGhlIHJhbmdlCnByb3Blcmx5LCB3aGljaCB0aGlz
IHBhdGNoIGRvZXMuCgpTaWduZWQtb2ZmLWJ5OiBCZW5v7nQgVGjpYmF1ZGVhdSA8YmVub2l0LnRo
ZWJhdWRlYXVAYWR2YW5zZWUuY29tPgoKLS0tIGFsc2EtbGliL3NyYy9jb250cm9sL3Rsdi5jCisr
KyBhbHNhLWxpYi9zcmMvY29udHJvbC90bHYuYwpAQCAtMjkxLDQxICsyOTEsMzcgQEAgaW50IHNu
ZF90bHZfY29udmVydF9mcm9tX2RCKHVuc2lnbmVkIGludAogewogCXN3aXRjaCAodGx2WzBdKSB7
CiAJY2FzZSBTTkRfQ1RMX1RMVlRfREJfUkFOR0U6IHsKLQkJbG9uZyBkYm1pbiwgZGJtYXgsIHBy
ZXZfcmFuZ2VtYXg7CisJCWxvbmcgZGJtaW4sIGRibWF4LCBwcmV2X3N1Ym1heDsKIAkJdW5zaWdu
ZWQgaW50IHBvcywgbGVuOwogCQlsZW4gPSBpbnRfaW5kZXgodGx2WzFdKTsKLQkJaWYgKGxlbiA+
IE1BWF9UTFZfUkFOR0VfU0laRSkKKwkJaWYgKGxlbiA8IDYgfHwgbGVuID4gTUFYX1RMVl9SQU5H
RV9TSVpFKQogCQkJcmV0dXJuIC1FSU5WQUw7Ci0JCWlmIChzbmRfdGx2X2dldF9kQl9yYW5nZSh0
bHYsIHJhbmdlbWluLCByYW5nZW1heCwKLQkJCQkJICZkYm1pbiwgJmRibWF4KSkKLQkJCXJldHVy
biAtRUlOVkFMOwotCQlpZiAoZGJfZ2FpbiA8PSBkYm1pbikgewotCQkJKnZhbHVlID0gcmFuZ2Vt
aW47Ci0JCQlyZXR1cm4gMDsKLQkJfSBlbHNlIGlmIChkYl9nYWluID49IGRibWF4KSB7Ci0JCQkq
dmFsdWUgPSByYW5nZW1heDsKLQkJCXJldHVybiAwOwotCQl9CiAJCXBvcyA9IDI7Ci0JCXByZXZf
cmFuZ2VtYXggPSAwOworCQlwcmV2X3N1Ym1heCA9IDA7CiAJCXdoaWxlIChwb3MgKyA0IDw9IGxl
bikgewotCQkJcmFuZ2VtaW4gPSAoaW50KXRsdltwb3NdOwotCQkJcmFuZ2VtYXggPSAoaW50KXRs
dltwb3MgKyAxXTsKKwkJCWxvbmcgc3VibWluLCBzdWJtYXg7CisJCQlzdWJtaW4gPSAoaW50KXRs
dltwb3NdOworCQkJc3VibWF4ID0gKGludCl0bHZbcG9zICsgMV07CisJCQlpZiAocmFuZ2VtYXgg
PCBzdWJtYXgpCisJCQkJc3VibWF4ID0gcmFuZ2VtYXg7CiAJCQlpZiAoIXNuZF90bHZfZ2V0X2RC
X3JhbmdlKHRsdiArIHBvcyArIDIsCi0JCQkJCQkgIHJhbmdlbWluLCByYW5nZW1heCwKKwkJCQkJ
CSAgc3VibWluLCBzdWJtYXgsCiAJCQkJCQkgICZkYm1pbiwgJmRibWF4KSAmJgogCQkJICAgIGRi
X2dhaW4gPj0gZGJtaW4gJiYgZGJfZ2FpbiA8PSBkYm1heCkKIAkJCQlyZXR1cm4gc25kX3Rsdl9j
b252ZXJ0X2Zyb21fZEIodGx2ICsgcG9zICsgMiwKLQkJCQkJCQkgICAgICAgcmFuZ2VtaW4sIHJh
bmdlbWF4LAorCQkJCQkJCSAgICAgICBzdWJtaW4sIHN1Ym1heCwKIAkJCQkJCQkgICAgICAgZGJf
Z2FpbiwgdmFsdWUsIHhkaXIpOwogCQkJZWxzZSBpZiAoZGJfZ2FpbiA8IGRibWluKSB7Ci0JCQkJ
KnZhbHVlID0geGRpciA/IHJhbmdlbWluIDogcHJldl9yYW5nZW1heDsKKwkJCQkqdmFsdWUgPSB4
ZGlyIHx8IHBvcyA9PSAyID8gc3VibWluIDogcHJldl9zdWJtYXg7CiAJCQkJcmV0dXJuIDA7CiAJ
CQl9Ci0JCQlwcmV2X3JhbmdlbWF4ID0gcmFuZ2VtYXg7CisJCQlwcmV2X3N1Ym1heCA9IHN1Ym1h
eDsKKwkJCWlmIChyYW5nZW1heCA9PSBzdWJtYXgpCisJCQkJYnJlYWs7CiAJCQlwb3MgKz0gaW50
X2luZGV4KHRsdltwb3MgKyAzXSkgKyA0OwogCQl9Ci0JCXJldHVybiAtRUlOVkFMOworCQkqdmFs
dWUgPSBwcmV2X3N1Ym1heDsKKwkJcmV0dXJuIDA7CiAJfQogCWNhc2UgU05EX0NUTF9UTFZUX0RC
X1NDQUxFOiB7CiAJCWludCBtaW4sIHN0ZXAsIG1heDsK
------=_Part_1119741_375883953.1337702794237
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_1119741_375883953.1337702794237--
