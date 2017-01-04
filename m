From: Vishal Thanki <vishalthanki@gmail.com>
Subject: ASoC: fsl_sai: Independent TX and RX master slave
	configuration
Date: Wed, 4 Jan 2017 16:54:39 +0100
Message-ID: <CAC3a_SDR97j8q7wS8up_qpNZOc3Mc0yiWanXF808-ud0_fGxRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=94eb2c1b110296d633054546ce92
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ua0-f178.google.com (mail-ua0-f178.google.com
 [209.85.217.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 157D3267097
 for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2017 16:55:00 +0100 (CET)
Received: by mail-ua0-f178.google.com with SMTP id i68so249207324uad.0
 for <alsa-devel@alsa-project.org>; Wed, 04 Jan 2017 07:55:00 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com, timur@tabi.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--94eb2c1b110296d633054546ce92
Content-Type: text/plain; charset=UTF-8

Hi All,

I am working on a custom board based on i.MX7d SoC from NXP. The
hardware uses SAI (Synchronous Audio Interface) Port 1 of i.MX7d for
playback and recording use cases. The required system configuration
is: SoC should act as I2S master for TX part, and slave for RX part.
However, I could not figure out a clean way to instruct CPU dai driver
(sound/soc/fsl/fsl_sai.c) about different roles for TX and RX of a
same DAI. The .set_fmt DAI op configures the TX and RX registers in
the same manner. In order to achieve the required configuration (TX
master, RX slave), I added a device tree property (i.e.
"fsl,sai-is-rx-slave") and based on that make necessary changes in
.set_fmt DAI operation. Attached is the patch for the same. Is this
the right way to go? Any suggestions would be helpful.

Thanks in advance,
Vishal

--94eb2c1b110296d633054546ce92
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-fsl_sai-Adjust-SAI-RX-configuration.patch"
Content-Disposition: attachment;
	filename="0001-fsl_sai-Adjust-SAI-RX-configuration.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ixj4i3al0

RnJvbSA3YWJjMGY0MmEzMDU4NjQxZWQ1YTZjOWZlZThhNjAyY2I5MmM1OTU5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBWaXNoYWwgVGhhbmtpIDx2aXNoYWx0aGFua2lAZ21haWwuY29t
PgpEYXRlOiBXZWQsIDQgSmFuIDIwMTcgMTY6NTA6MzYgKzAxMDAKU3ViamVjdDogW1BBVENIXSBm
c2xfc2FpOiBBZGp1c3QgU0FJIFJYIGNvbmZpZ3VyYXRpb24KCklmIFNBSSBUWCBhbmQgU0FJIFJY
IGFyZSByZXF1aXJlZCB0byBvcGVyYXRlIGluZGVwZW5kZW50bHksCnRoZSBjbG9jayBzZXR0aW5n
cyAoQkNMSyBhbmQgV1NZTkMpIG5lZWQgdG8gYmUgYWRqdXN0ZWQKYWNjb3JkaW5nbHkuIFRoaXMg
cGF0Y2ggYWRqdXN0IFJYIHNldHRpbmdzIGJhc2VkIG9uIGEgZGV2aWNlCnRyZWUgcHJvcGVybHkg
dmFsdWUuCgpTaWduZWQtb2ZmLWJ5OiBWaXNoYWwgVGhhbmtpIDx2aXNoYWx0aGFua2lAZ21haWwu
Y29tPgotLS0KIHNvdW5kL3NvYy9mc2wvZnNsX3NhaS5jIHwgMTcgKysrKysrKysrKysrKystLS0K
IHNvdW5kL3NvYy9mc2wvZnNsX3NhaS5oIHwgIDEgKwogMiBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNl
cnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9mc2wvZnNs
X3NhaS5jIGIvc291bmQvc29jL2ZzbC9mc2xfc2FpLmMKaW5kZXggOWZhZGY3ZS4uZmQyYWVlNyAx
MDA2NDQKLS0tIGEvc291bmQvc29jL2ZzbC9mc2xfc2FpLmMKKysrIGIvc291bmQvc29jL2ZzbC9m
c2xfc2FpLmMKQEAgLTI4OSw2ICsyODksMTEgQEAgc3RhdGljIGludCBmc2xfc2FpX3NldF9kYWlf
Zm10X3RyKHN0cnVjdCBzbmRfc29jX2RhaSAqY3B1X2RhaSwKIAkJcmV0dXJuIC1FSU5WQUw7CiAJ
fQogCisJaWYgKCF0eCAmJiBzYWktPmlzX3J4X3NsYXZlKSB7CisJCXZhbF9jcjIgJj0gfkZTTF9T
QUlfQ1IyX0JDRF9NU1RSOworCQl2YWxfY3I0ICY9IH5GU0xfU0FJX0NSNF9GU0RfTVNUUjsKKwl9
CisKIAlyZWdtYXBfdXBkYXRlX2JpdHMoc2FpLT5yZWdtYXAsIEZTTF9TQUlfeENSMih0eCksCiAJ
CQkgICBGU0xfU0FJX0NSMl9CQ1AgfCBGU0xfU0FJX0NSMl9CQ0RfTVNUUiwgdmFsX2NyMik7CiAJ
cmVnbWFwX3VwZGF0ZV9iaXRzKHNhaS0+cmVnbWFwLCBGU0xfU0FJX3hDUjQodHgpLApAQCAtNDE5
LDcgKzQyNCw3IEBAIHN0YXRpYyBpbnQgZnNsX3NhaV9od19wYXJhbXMoc3RydWN0IHNuZF9wY21f
c3Vic3RyZWFtICpzdWJzdHJlYW0sCiAJaWYgKHNhaS0+c2xvdF93aWR0aCkKIAkJc2xvdF93aWR0
aCA9IHNhaS0+c2xvdF93aWR0aDsKIAotCWlmICghc2FpLT5pc19zbGF2ZV9tb2RlKSB7CisJaWYg
KCFzYWktPmlzX3NsYXZlX21vZGUgJiYgKHR4IHx8ICFzYWktPmlzX3J4X3NsYXZlKSkgewogCQly
ZXQgPSBmc2xfc2FpX3NldF9iY2xrKGNwdV9kYWksIHR4LAogCQkJCXNsb3RzICogc2xvdF93aWR0
aCAqIHBhcmFtc19yYXRlKHBhcmFtcykpOwogCQlpZiAocmV0KQpAQCAtNTMyLDggKzUzNyw5IEBA
IHN0YXRpYyBpbnQgZnNsX3NhaV90cmlnZ2VyKHN0cnVjdCBzbmRfcGNtX3N1YnN0cmVhbSAqc3Vi
c3RyZWFtLCBpbnQgY21kLAogCQlyZWdtYXBfdXBkYXRlX2JpdHMoc2FpLT5yZWdtYXAsIEZTTF9T
QUlfeENTUih0eCksCiAJCQkJICAgRlNMX1NBSV9DU1JfRlJERSwgRlNMX1NBSV9DU1JfRlJERSk7
CiAKLQkJcmVnbWFwX3VwZGF0ZV9iaXRzKHNhaS0+cmVnbWFwLCBGU0xfU0FJX1JDU1IsCi0JCQkJ
ICAgRlNMX1NBSV9DU1JfVEVSRSwgRlNMX1NBSV9DU1JfVEVSRSk7CisJCWlmICghdHgpCisJCQly
ZWdtYXBfdXBkYXRlX2JpdHMoc2FpLT5yZWdtYXAsIEZTTF9TQUlfUkNTUiwKKwkJCQkJRlNMX1NB
SV9DU1JfVEVSRSwgRlNMX1NBSV9DU1JfVEVSRSk7CiAJCXJlZ21hcF91cGRhdGVfYml0cyhzYWkt
PnJlZ21hcCwgRlNMX1NBSV9UQ1NSLAogCQkJCSAgIEZTTF9TQUlfQ1NSX1RFUkUsIEZTTF9TQUlf
Q1NSX1RFUkUpOwogCkBAIC04OTgsNiArOTA0LDExIEBAIHN0YXRpYyBpbnQgZnNsX3NhaV9wcm9i
ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogCQkJCSAgIE1DTEtfRElSKGluZGV4KSk7
CiAJfQogCisJaWYgKG9mX2ZpbmRfcHJvcGVydHkobnAsICJmc2wsc2FpLWlzLXJ4LXNsYXZlIiwg
TlVMTCkpCisJCXNhaS0+aXNfcnhfc2xhdmUgPSB0cnVlOworCWVsc2UKKwkJc2FpLT5pc19yeF9z
bGF2ZSA9IGZhbHNlOworCiAJc2FpLT5kbWFfcGFyYW1zX3J4LmFkZHIgPSByZXMtPnN0YXJ0ICsg
RlNMX1NBSV9SRFI7CiAJc2FpLT5kbWFfcGFyYW1zX3R4LmFkZHIgPSByZXMtPnN0YXJ0ICsgRlNM
X1NBSV9URFI7CiAJc2FpLT5kbWFfcGFyYW1zX3J4Lm1heGJ1cnN0ID0gRlNMX1NBSV9NQVhCVVJT
VF9SWDsKZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9mc2wvZnNsX3NhaS5oIGIvc291bmQvc29jL2Zz
bC9mc2xfc2FpLmgKaW5kZXggZDllZDdiZS4uMGZlZmQ1MiAxMDA2NDQKLS0tIGEvc291bmQvc29j
L2ZzbC9mc2xfc2FpLmgKKysrIGIvc291bmQvc29jL2ZzbC9mc2xfc2FpLmgKQEAgLTEzOCw2ICsx
MzgsNyBAQCBzdHJ1Y3QgZnNsX3NhaSB7CiAJYm9vbCBpc19zbGF2ZV9tb2RlOwogCWJvb2wgaXNf
bHNiX2ZpcnN0OwogCWJvb2wgaXNfZHNwX21vZGU7CisJYm9vbCBpc19yeF9zbGF2ZTsKIAlib29s
IHNhaV9vbl9pbXg7CiAJYm9vbCBzeW5jaHJvbm91c1syXTsKIAotLSAKMi40LjExCgo=
--94eb2c1b110296d633054546ce92
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--94eb2c1b110296d633054546ce92--
