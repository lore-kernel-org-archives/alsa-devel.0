From: Daniel Chen <seven.steps@gmail.com>
Subject: Re: Conexant CX20549 (Venice) PCM volume to loud
Date: Wed, 25 Nov 2009 18:37:36 -0500
Message-ID: <604760770911251537n16a2646cwf7fbd7efd8c6610e@mail.gmail.com>
References: <4B0D5E36.3090502@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636b2bc992afad604793a8b01
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f179.google.com (mail-pz0-f179.google.com
	[209.85.222.179])
	by alsa0.perex.cz (Postfix) with ESMTP id E94E6243EC
	for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2009 00:37:37 +0100 (CET)
Received: by pzk9 with SMTP id 9so144498pzk.16
	for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2009 15:37:36 -0800 (PST)
In-Reply-To: <4B0D5E36.3090502@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Cristian KLEIN <cristiklein@gmail.com>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--001636b2bc992afad604793a8b01
Content-Type: text/plain; charset=UTF-8

Hi,

On Wed, Nov 25, 2009 at 11:41 AM, Cristian KLEIN <cristiklein@gmail.com> wrote:
> Could anybody please have a look at this bug:
> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4792

I've spun the attached patch against current sound-2.6 HEAD. Thanks
for chasing this!

-Dan

--001636b2bc992afad604793a8b01
Content-Type: text/x-diff; charset=US-ASCII;
	name="0001-ALSA-hda-Fix-max-PCM-level-to-0-dB-for-Fujitsu-Sieme.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-hda-Fix-max-PCM-level-to-0-dB-for-Fujitsu-Sieme.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g2gqjpsw0

RnJvbSA3NjcwMzZlZjlmMWMwNWZlMmZjMGU5ZmEyMjZiNGYzMzA3NmU5NzAzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IFdlZCwgMjUgTm92IDIwMDkgMTg6Mjc6MjAgLTA1MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGE6IEZpeCBtYXggUENNIGxldmVsIHRvIDAgZEIgZm9yIEZ1aml0c3UtU2llbWVucyBsYXB0
b3BzIHVzaW5nIENYMjA1NDkgKFZlbmljZSkKCkJ1Z0xpbms6IGh0dHBzOi8vYnVndHJhY2suYWxz
YS1wcm9qZWN0Lm9yZy9hbHNhLWJ1Zy92aWV3LnBocD9pZD00NzkyCgpDcmlzdGlhbiByZXBvcnRl
ZCB0aGF0IHRoZXNlIG1vZGVscyBoYXZlIHJlYWxseSBiYWQgc291bmQgYWJvdmUgNiBkQgphbmQg
cHJvcG9zZWQgdGhlIG9yaWdpbmFsIHBhdGNoLiBJJ3ZlIHVwZGF0ZWQgdGhlIGNvbW1lbnQgdG8g
cmVmbGVjdAp0aGlzIGNoYW5nZS4KClNpZ25lZC1vZmYtYnk6IERhbmllbCBUIENoZW4gPGNyaW1z
dW5AdWJ1bnR1LmNvbT4KUmVwb3J0ZWQtYnk6IENyaXN0aWFuIEtsZWluCi0tLQogc291bmQvcGNp
L2hkYS9wYXRjaF9jb25leGFudC5jIHwgICAgNyArKysrLS0tCiAxIGZpbGVzIGNoYW5nZWQsIDQg
aW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zb3VuZC9wY2kvaGRh
L3BhdGNoX2NvbmV4YW50LmMgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX2NvbmV4YW50LmMKaW5kZXgg
MzZkZDVhNi4uNjA4MTBiYSAxMDA2NDQKLS0tIGEvc291bmQvcGNpL2hkYS9wYXRjaF9jb25leGFu
dC5jCisrKyBiL3NvdW5kL3BjaS9oZGEvcGF0Y2hfY29uZXhhbnQuYwpAQCAtMTE3MSw5ICsxMTcx
LDEwIEBAIHN0YXRpYyBpbnQgcGF0Y2hfY3h0NTA0NShzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYykK
IAogCXN3aXRjaCAoY29kZWMtPnN1YnN5c3RlbV9pZCA+PiAxNikgewogCWNhc2UgMHgxMDNjOgot
CQkvKiBIUCBsYXB0b3AgaGFzIGEgcmVhbGx5IGJhZCBzb3VuZCBvdmVyIDBkQiBvbiBOSUQgMHgx
Ny4KLQkJICogRml4IG1heCBQQ00gbGV2ZWwgdG8gMCBkQgotCQkgKiAob3JpZ2luYWxsIGl0IGhh
cyAweDJiIHN0ZXBzIHdpdGggMGRCIG9mZnNldCAweDE0KQorCWNhc2UgMHgxNzM0OgorCQkvKiBI
UCAmIEZ1aml0c3UtU2llbWVucyBsYXB0b3BzIGhhdmUgcmVhbGx5IGJhZCBzb3VuZCBvdmVyIDBk
QgorCQkgKiBvbiBOSUQgMHgxNy4gRml4IG1heCBQQ00gbGV2ZWwgdG8gMCBkQgorCQkgKiAob3Jp
Z2luYWxseSBpdCBoYXMgMHgyYiBzdGVwcyB3aXRoIDBkQiBvZmZzZXQgMHgxNCkKIAkJICovCiAJ
CXNuZF9oZGFfb3ZlcnJpZGVfYW1wX2NhcHMoY29kZWMsIDB4MTcsIEhEQV9JTlBVVCwKIAkJCQkJ
ICAoMHgxNCA8PCBBQ19BTVBDQVBfT0ZGU0VUX1NISUZUKSB8Ci0tIAoxLjYuMy4zCgo=
--001636b2bc992afad604793a8b01
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--001636b2bc992afad604793a8b01--
