From: Daniel Chen <seven.steps@gmail.com>
Subject: Re: VGN-P11Z_G (hda-intel ALC262) internal microphone
	not working
Date: Thu, 14 Jan 2010 07:03:20 -0500
Message-ID: <604760771001140403l3688ba5cgabce1e2db7d2ab6@mail.gmail.com>
References: <7c16f72a1001071534sd8992e9je69bab0271b491b5@mail.gmail.com>
	<604760771001091656pbd7d0e7v6a3d6f0e7beaa82c@mail.gmail.com>
	<7c16f72a1001091656w13abf157idd1195e0cf5cec7a@mail.gmail.com>
	<604760771001091658t1a86c7f0mb07a6c8b8a36c21f@mail.gmail.com>
	<7c16f72a1001091700m20e0dfc0g704f6b936b39b6d1@mail.gmail.com>
	<604760771001091701m50ebd1f4g92e5633ec4885789@mail.gmail.com>
	<7c16f72a1001091711r73ab04ddr153aef192648ee81@mail.gmail.com>
	<7c16f72a1001130928m4178b21by70f2575470c3e65e@mail.gmail.com>
	<604760771001131641l2689a032xdf76509bd716b9d8@mail.gmail.com>
	<s5hzl4h5gbj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636e0b180500ef0047d1eacf5
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f173.google.com (mail-px0-f173.google.com
	[209.85.216.173])
	by alsa0.perex.cz (Postfix) with ESMTP id 671C81037F1
	for <alsa-devel@alsa-project.org>; Thu, 14 Jan 2010 13:03:22 +0100 (CET)
Received: by pxi3 with SMTP id 3so291151pxi.16
	for <alsa-devel@alsa-project.org>; Thu, 14 Jan 2010 04:03:20 -0800 (PST)
In-Reply-To: <s5hzl4h5gbj.wl%tiwai@suse.de>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, =?UTF-8?Q?Christian_St=C3=B6veken?= <christian.stoeveken@gmail.com>
List-Id: alsa-devel@alsa-project.org

--001636e0b180500ef0047d1eacf5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 14, 2010 at 1:52 AM, Takashi Iwai <tiwai@suse.de> wrote:
> Isn't this with the older driver version before disabling the default
> quirk to sony-assamd model? =C2=A0In the recent version, it would fall
> back to auto model.

Indeed, both of his alsa-info.sh outputs show that he used model=3Dauto
with -driver 1.0.20:
>> working "model=3Dauto":
>> http://www.alsa-project.org/db/?f=3D67f6a692f0ccd70d6893665d36c8b90a51f4=
a577
>>
>> also with "power_save=3D10 power_save_controller=3DN model=3Dauto":
>> http://www.alsa-project.org/db/?f=3D618f4d4ae530957b4b6d2b66751871d4073d=
f685

> Having an entry to ALC262_AUTO is fine. =C2=A0It even reduces a kernel
> message that may wonder user. =C2=A0So here what we have to check lastly
> is whether VAIO Z21MN (104d:9025) that is currently with toshiba-s06
> works with model=3Dauto or not. =C2=A0Once after it's confirmed, we can t=
ake
> all to auto.

Because I don't have access to 0x104d9025 and I don't wish to
introduce a further regression for that model, I've just respun the
patch against current master HEAD adding his SSID with the model=3Dauto
quirk.

Best,
-Dan

--001636e0b180500ef0047d1eacf5
Content-Type: text/x-patch; charset=UTF-8;
	name="0001-PATCH-v2-ALSA-hda-Use-BIOS-autoprobe-for-another-Son.patch"
Content-Disposition: attachment;
	filename="0001-PATCH-v2-ALSA-hda-Use-BIOS-autoprobe-for-another-Son.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g4fhradx0

RnJvbSA4NTU5ZmNhYWFhNTk2NGU3OGM0MWZjZGMyOTU1ZmJhZjM4OTYzMTE2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IFRodSwgMTQgSmFuIDIwMTAgMDY6NTM6MjQgLTA1MDAKU3ViamVjdDogW1BBVENIXSB2Mjog
QUxTQTogaGRhOiBVc2UgQklPUyBhdXRvcHJvYmUgZm9yIGFub3RoZXIgU29ueSBWQUlPIG1vZGVs
Ck1JTUUtVmVyc2lvbjogMS4wCkNvbnRlbnQtVHlwZTogdGV4dC9wbGFpbjsgY2hhcnNldD1VVEYt
OApDb250ZW50LVRyYW5zZmVyLUVuY29kaW5nOiA4Yml0CgpDaHJpc3RpYW4gcmVwb3J0ZWRbMF0g
dGhhdCBoaXMgbGFwdG9wIGRvZXMgbm90IGhhdmUgYXVkaWJsZSBjYXB0dXJlIGJ5CmRlZmF1bHQu
IERlYnVnZ2luZyB0aGUgc3ltcHRvbSByZXZlYWxlZCB0aGF0IGhpcyBtb2RlbCBuZWVkcyB0aGUg
YXV0bwpxdWlyaywgc28gYWRkIGhpcyBTU0lEIHRvIGFsYzI2Ml9jZmdfdGJsW10uCgpbMF0gaHR0
cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9waXBlcm1haWwvYWxzYS1kZXZlbC8yMDEwLUph
bnVhcnkvMDI0MzI3Lmh0bWwKCkNjOiA8c3RhYmxlQGtlcm5lbC5vcmc+ClRlc3RlZC1ieTogQ2hy
aXN0aWFuIFN0w7Z2ZWtlbiA8Y2hyaXN0aWFuLnN0b2V2ZWtlbkBnbWFpbC5jb20+ClNpZ25lZC1v
ZmYtYnk6IERhbmllbCBUIENoZW4gPGNyaW1zdW5AdWJ1bnR1LmNvbT4KLS0tCiBzb3VuZC9wY2kv
aGRhL3BhdGNoX3JlYWx0ZWsuYyB8ICAgIDEgKwogMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlv
bnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc291bmQvcGNpL2hkYS9wYXRjaF9y
ZWFsdGVrLmMgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYwppbmRleCAzMDFiMTQ3Li5j
MDY1YjE3IDEwMDY0NAotLS0gYS9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYworKysgYi9z
b3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYwpAQCAtMTE3NTMsNiArMTE3NTMsNyBAQCBzdGF0
aWMgc3RydWN0IHNuZF9wY2lfcXVpcmsgYWxjMjYyX2NmZ190YmxbXSA9IHsKIAlTTkRfUENJX1FV
SVJLKDB4MTA0ZCwgMHg5MDE2LCAiU29ueSBWQUlPIiwgQUxDMjYyX0FVVE8pLCAvKiBkaWctb25s
eSAqLwogCVNORF9QQ0lfUVVJUksoMHgxMDRkLCAweDkwMjUsICJTb255IFZBSU8gWjIxTU4iLCBB
TEMyNjJfVE9TSElCQV9TMDYpLAogCVNORF9QQ0lfUVVJUksoMHgxMDRkLCAweDkwMzUsICJTb255
IFZBSU8gVkdOLUZXMTcwSiIsIEFMQzI2Ml9BVVRPKSwKKwlTTkRfUENJX1FVSVJLKDB4MTA0ZCwg
MHg5MDM5LCAiU29ueSBWQUlPIFZHTi1QMTFaX0ciLCBBTEMyNjJfQVVUTyksCiAJU05EX1BDSV9R
VUlSSygweDEwNGQsIDB4OTA0NywgIlNvbnkgVkFJTyBUeXBlIEciLCBBTEMyNjJfQVVUTyksCiAj
aWYgMCAvKiBkaXNhYmxlIHRoZSBxdWlyayBzaW5jZSBtb2RlbD1hdXRvIHdvcmtzIGJldHRlciBp
biByZWNlbnQgdmVyc2lvbnMgKi8KIAlTTkRfUENJX1FVSVJLX01BU0soMHgxMDRkLCAweGZmMDAs
IDB4OTAwMCwgIlNvbnkgVkFJTyIsCi0tIAoxLjYuNQoK
--001636e0b180500ef0047d1eacf5
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--001636e0b180500ef0047d1eacf5--
