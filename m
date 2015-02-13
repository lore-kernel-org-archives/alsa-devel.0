From: Joe Turner <joe@oampo.co.uk>
Subject: [PATCH] MS Lifecam HD-5000: Don't attempt to get the
	sample rate
Date: Fri, 13 Feb 2015 19:35:19 +0000
Message-ID: <CA+FkkmZjMYZ_Vr5jr192ccMoYst0UBMTNVJ=tN-z-cBNCqnqOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a113ccb247254df050efd57af
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f172.google.com (mail-ob0-f172.google.com
 [209.85.214.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C323260467
 for <alsa-devel@alsa-project.org>; Fri, 13 Feb 2015 20:35:41 +0100 (CET)
Received: by mail-ob0-f172.google.com with SMTP id nt9so23703595obb.3
 for <alsa-devel@alsa-project.org>; Fri, 13 Feb 2015 11:35:40 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--001a113ccb247254df050efd57af
Content-Type: text/plain; charset=UTF-8

Hi Folks,

This is my first time doing anything kernel-related, so apologies in
advance for any faux-pas which are to follow.  I hope this is at least
going to the correct place!

Currently after setting the sample rate of USB devices the driver tries to
get the sample rate back from the device, to check that the two match up.
The Lifecam doesn't support getting the sample rate, and so this operation
times-out, and we continue regardless.

Because the USB timeout is pretty long this causes issues with some apps,
which begin to doubt the ability of the device to produce audio before the
timeout is up and misbehave in various ways.  See
https://www.google.co.uk/search?q=%22cannot+get+freq+at+ep+0x82%22 for a
range of reports relating to this issue.

This patch adds a quirk so that rather than check the sample rate and
timeout, we don't bother checking at all.

Hope this all looks okay.

Cheers,
Joe

--001a113ccb247254df050efd57af
Content-Type: text/x-patch; charset=US-ASCII; name="lifecam_5000_get_sample_rate.patch"
Content-Disposition: attachment;
	filename="lifecam_5000_get_sample_rate.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_i63z4ty90

ZGlmZiAtdXByTiAtWCBsaW51eC0zLjE4L0RvY3VtZW50YXRpb24vZG9udGRpZmYgbGludXgtMy4x
OC9zb3VuZC91c2IvY2xvY2suYyBsaW51eC0zLjE4LWRldmVsL3NvdW5kL3VzYi9jbG9jay5jCi0t
LSBsaW51eC0zLjE4L3NvdW5kL3VzYi9jbG9jay5jCTIwMTQtMTItMDcgMjI6MjE6MDUuMDAwMDAw
MDAwICswMDAwCisrKyBsaW51eC0zLjE4LWRldmVsL3NvdW5kL3VzYi9jbG9jay5jCTIwMTUtMDIt
MTMgMTg6NDc6NDguMTc5MzYzOTQyICswMDAwCkBAIC0zMDMsNiArMzAzLDEyIEBAIHN0YXRpYyBp
bnQgc2V0X3NhbXBsZV9yYXRlX3YxKHN0cnVjdCBzbmQKIAkJcmV0dXJuIGVycjsKIAl9CiAKKyAg
ICBpZiAoc25kX3VzYl9nZXRfc2FtcGxlX3JhdGVfcXVpcmsoY2hpcCkpIHsKKyAgICAgICAgLyog
RG9uJ3QgY2hlY2sgdGhlIHNhbXBsZSByYXRlIGZvciBkZXZpY2VzIHdoaWNoIHdlIGtub3cgZG9u
J3QKKyAgICAgICAgICogc3VwcG9ydCByZWFkaW5nICovCisgICAgICAgIHJldHVybiAwOworICAg
IH0KKwogCWlmICgoZXJyID0gc25kX3VzYl9jdGxfbXNnKGRldiwgdXNiX3JjdmN0cmxwaXBlKGRl
diwgMCksIFVBQ19HRVRfQ1VSLAogCQkJCSAgIFVTQl9UWVBFX0NMQVNTIHwgVVNCX1JFQ0lQX0VO
RFBPSU5UIHwgVVNCX0RJUl9JTiwKIAkJCQkgICBVQUNfRVBfQ1NfQVRUUl9TQU1QTEVfUkFURSA8
PCA4LCBlcCwKZGlmZiAtdXByTiAtWCBsaW51eC0zLjE4L0RvY3VtZW50YXRpb24vZG9udGRpZmYg
bGludXgtMy4xOC9zb3VuZC91c2IvcXVpcmtzLmMgbGludXgtMy4xOC1kZXZlbC9zb3VuZC91c2Iv
cXVpcmtzLmMKLS0tIGxpbnV4LTMuMTgvc291bmQvdXNiL3F1aXJrcy5jCTIwMTQtMTItMDcgMjI6
MjE6MDUuMDAwMDAwMDAwICswMDAwCisrKyBsaW51eC0zLjE4LWRldmVsL3NvdW5kL3VzYi9xdWly
a3MuYwkyMDE1LTAyLTEzIDE4OjU0OjUyLjI2MjY4NzkyOSArMDAwMApAQCAtMTEwMiw2ICsxMTAy
LDE0IEBAIHZvaWQgc25kX3VzYl9zZXRfZm9ybWF0X3F1aXJrKHN0cnVjdCBzbmQKIAl9CiB9CiAK
K2ludCBzbmRfdXNiX2dldF9zYW1wbGVfcmF0ZV9xdWlyayhzdHJ1Y3Qgc25kX3VzYl9hdWRpbyAq
Y2hpcCkgeworCS8qIE1TIExpZmVjYW0gSEQtNTAwMCBkb2Vzbid0IHN1cHBvcnQgcmVhZGluZyB0
aGUgc2FtcGxlIHJhdGUuICovCisJaWYgKGNoaXAtPnVzYl9pZCA9PSBVU0JfSUQoMHgwNDVFLCAw
eDA3NkQpKSB7CisJCXJldHVybiAxOworCX0KKyAgICByZXR1cm4gMDsKK30KKwogdm9pZCBzbmRf
dXNiX2VuZHBvaW50X3N0YXJ0X3F1aXJrKHN0cnVjdCBzbmRfdXNiX2VuZHBvaW50ICplcCkKIHsK
IAkvKgpkaWZmIC11cHJOIC1YIGxpbnV4LTMuMTgvRG9jdW1lbnRhdGlvbi9kb250ZGlmZiBsaW51
eC0zLjE4L3NvdW5kL3VzYi9xdWlya3MuaCBsaW51eC0zLjE4LWRldmVsL3NvdW5kL3VzYi9xdWly
a3MuaAotLS0gbGludXgtMy4xOC9zb3VuZC91c2IvcXVpcmtzLmgJMjAxNC0xMi0wNyAyMjoyMTow
NS4wMDAwMDAwMDAgKzAwMDAKKysrIGxpbnV4LTMuMTgtZGV2ZWwvc291bmQvdXNiL3F1aXJrcy5o
CTIwMTUtMDItMTMgMTg6NDk6MjQuMDI5MzYxODMwICswMDAwCkBAIC0yMSw2ICsyMSw5IEBAIGlu
dCBzbmRfdXNiX2FwcGx5X2Jvb3RfcXVpcmsoc3RydWN0IHVzYl8KIHZvaWQgc25kX3VzYl9zZXRf
Zm9ybWF0X3F1aXJrKHN0cnVjdCBzbmRfdXNiX3N1YnN0cmVhbSAqc3VicywKIAkJCSAgICAgIHN0
cnVjdCBhdWRpb2Zvcm1hdCAqZm10KTsKIAorCitpbnQgc25kX3VzYl9nZXRfc2FtcGxlX3JhdGVf
cXVpcmsoc3RydWN0IHNuZF91c2JfYXVkaW8gKmNoaXApOworCiBpbnQgc25kX3VzYl9pc19iaWdf
ZW5kaWFuX2Zvcm1hdChzdHJ1Y3Qgc25kX3VzYl9hdWRpbyAqY2hpcCwKIAkJCQkgc3RydWN0IGF1
ZGlvZm9ybWF0ICpmcCk7CiAK
--001a113ccb247254df050efd57af
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--001a113ccb247254df050efd57af--
