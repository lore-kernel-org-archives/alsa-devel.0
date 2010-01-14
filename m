From: Daniel Chen <seven.steps@gmail.com>
Subject: Re: VGN-P11Z_G (hda-intel ALC262) internal microphone
	not working
Date: Wed, 13 Jan 2010 19:41:12 -0500
Message-ID: <604760771001131641l2689a032xdf76509bd716b9d8@mail.gmail.com>
References: <7c16f72a1001071534sd8992e9je69bab0271b491b5@mail.gmail.com>
	<604760771001091611m3f7d276flc95be1f70645dae3@mail.gmail.com>
	<7c16f72a1001091652p58f3fe50la9b1431c6f80d781@mail.gmail.com>
	<604760771001091656pbd7d0e7v6a3d6f0e7beaa82c@mail.gmail.com>
	<7c16f72a1001091656w13abf157idd1195e0cf5cec7a@mail.gmail.com>
	<604760771001091658t1a86c7f0mb07a6c8b8a36c21f@mail.gmail.com>
	<7c16f72a1001091700m20e0dfc0g704f6b936b39b6d1@mail.gmail.com>
	<604760771001091701m50ebd1f4g92e5633ec4885789@mail.gmail.com>
	<7c16f72a1001091711r73ab04ddr153aef192648ee81@mail.gmail.com>
	<7c16f72a1001130928m4178b21by70f2575470c3e65e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00504502ad14e061b0047d152479
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f53.google.com (mail-pw0-f53.google.com
	[209.85.160.53])
	by alsa0.perex.cz (Postfix) with ESMTP id CE36F10384E
	for <alsa-devel@alsa-project.org>; Thu, 14 Jan 2010 01:41:14 +0100 (CET)
Received: by pwj3 with SMTP id 3so4360407pwj.32
	for <alsa-devel@alsa-project.org>; Wed, 13 Jan 2010 16:41:13 -0800 (PST)
In-Reply-To: <7c16f72a1001130928m4178b21by70f2575470c3e65e@mail.gmail.com>
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

--00504502ad14e061b0047d152479
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi, Takashi,

On Wed, Jan 13, 2010 at 12:28 PM, Christian St=C3=B6veken
<christian.stoeveken@gmail.com> wrote:
> sorry to get back to you so late - I tried again 5 minutes ago and it is =
now
> working with the false parameter removed (/etc/modules:9: snd-hda-intel
> model=3Dvaio)
>
> working "model=3Dauto":
> http://www.alsa-project.org/db/?f=3D67f6a692f0ccd70d6893665d36c8b90a51f4a=
577
>
> also with "power_save=3D10 power_save_controller=3DN model=3Dauto":
> http://www.alsa-project.org/db/?f=3D618f4d4ae530957b4b6d2b66751871d4073df=
685
>
> I hope this is how you expected it to look like.
> Also the headphones now work correctly.

Attached is a patch against current sound-2.6 master HEAD that:

* adds Christian's SSID to the relevant quirk table,
* prefers BIOS autoprobing for existing Sony VAIO models matching 0x104d90x=
x.

The second change was made to ease backing out the change in case of
regressions.

Best,
-Dan

--00504502ad14e061b0047d152479
Content-Type: text/x-patch; charset=UTF-8;
	name="0001-ALSA-hda-Default-to-BIOS-autoprobe-for-existing-0x10.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-hda-Default-to-BIOS-autoprobe-for-existing-0x10.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g4etdtvg0

RnJvbSAxMzcyNzI0Y2ZiMjRkMzQyYzYwZDk0Y2QxODEwMTE2NDIwOGIwMDQ0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IFdlZCwgMTMgSmFuIDIwMTAgMTk6MjU6MzcgLTA1MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGE6IERlZmF1bHQgdG8gQklPUyBhdXRvcHJvYmUgZm9yIGV4aXN0aW5nIDB4MTA0ZDkweHgg
ZW50cmllcwpNSU1FLVZlcnNpb246IDEuMApDb250ZW50LVR5cGU6IHRleHQvcGxhaW47IGNoYXJz
ZXQ9VVRGLTgKQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzogOGJpdAoKQ2hyaXN0aWFuIHJlcG9y
dGVkWzBdIHRoYXQgaGlzIGxhcHRvcCBkb2VzIG5vdCBoYXZlIGF1ZGlibGUgY2FwdHVyZSBieQpk
ZWZhdWx0LiBEZWJ1Z2dpbmcgdGhlIHN5bXB0b20gcmV2ZWFsZWQgdGhhdCBoaXMgbW9kZWwgbmVl
ZHMgdGhlIGF1dG8KcXVpcmssIHNvIGFkZCBoaXMgU1NJRCB0byBhbGMyNjJfY2ZnX3RibFtdLgoK
U2luY2Ugd2UndmUgYWNjdW11bGF0ZWQgc2V2ZXJhbCAweDEwNGQ5MHh4IGVudHJpZXMgaW4gdGhl
IGFib3ZlIHF1aXJrCnRhYmxlIHRoYXQgY29ycmVzcG9uZCB0byB0aGUgbW9kZWw9YXV0byBxdWly
aywganVzdCBkaXNhYmxlIHRoZW0gYW5kCnRydXN0IHRoZSBCSU9TZXMgZG8gdGhlIHJpZ2h0IHRo
aW5nLgoKWzBdIGh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvcGlwZXJtYWlsL2Fsc2Et
ZGV2ZWwvMjAxMC1KYW51YXJ5LzAyNDMyNy5odG1sCgpUZXN0ZWQtYnk6IENocmlzdGlhbiBTdMO2
dmVrZW4gPGNocmlzdGlhbi5zdG9ldmVrZW5AZ21haWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBEYW5p
ZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+Ci0tLQogc291bmQvcGNpL2hkYS9wYXRjaF9y
ZWFsdGVrLmMgfCAgICAzICsrLQogMSBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMg
Yi9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYwppbmRleCBkZTFjNWZkLi44MzU2YjlmIDEw
MDY0NAotLS0gYS9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYworKysgYi9zb3VuZC9wY2kv
aGRhL3BhdGNoX3JlYWx0ZWsuYwpAQCAtMTE3NTAsMTEgKzExNzUwLDEyIEBAIHN0YXRpYyBzdHJ1
Y3Qgc25kX3BjaV9xdWlyayBhbGMyNjJfY2ZnX3RibFtdID0gewogCVNORF9QQ0lfUVVJUksoMHgx
MDRkLCAweDFmMDAsICJTb255IEFTU0FNRCIsIEFMQzI2Ml9TT05ZX0FTU0FNRCksCiAJU05EX1BD
SV9RVUlSSygweDEwNGQsIDB4ODIwMywgIlNvbnkgVVgtOTAiLCBBTEMyNjJfSElQUE8pLAogCVNO
RF9QQ0lfUVVJUksoMHgxMDRkLCAweDgyMGYsICJTb255IEFTU0FNRCIsIEFMQzI2Ml9TT05ZX0FT
U0FNRCksCisjaWYgMCAvKiBkaXNhYmxlIHRoZSBxdWlyayBzaW5jZSBtb2RlbD1hdXRvIHdvcmtz
IGJldHRlciBpbiByZWNlbnQgdmVyc2lvbnMgKi8KIAlTTkRfUENJX1FVSVJLKDB4MTA0ZCwgMHg5
MDE2LCAiU29ueSBWQUlPIiwgQUxDMjYyX0FVVE8pLCAvKiBkaWctb25seSAqLwogCVNORF9QQ0lf
UVVJUksoMHgxMDRkLCAweDkwMjUsICJTb255IFZBSU8gWjIxTU4iLCBBTEMyNjJfVE9TSElCQV9T
MDYpLAogCVNORF9QQ0lfUVVJUksoMHgxMDRkLCAweDkwMzUsICJTb255IFZBSU8gVkdOLUZXMTcw
SiIsIEFMQzI2Ml9BVVRPKSwKKwlTTkRfUENJX1FVSVJLKDB4MTA0ZCwgMHg5MDM5LCAiU29ueSBW
QUlPIFZHTi1QMTFaX0ciLCBBTEMyNjJfQVVUTyksCiAJU05EX1BDSV9RVUlSSygweDEwNGQsIDB4
OTA0NywgIlNvbnkgVkFJTyBUeXBlIEciLCBBTEMyNjJfQVVUTyksCi0jaWYgMCAvKiBkaXNhYmxl
IHRoZSBxdWlyayBzaW5jZSBtb2RlbD1hdXRvIHdvcmtzIGJldHRlciBpbiByZWNlbnQgdmVyc2lv
bnMgKi8KIAlTTkRfUENJX1FVSVJLX01BU0soMHgxMDRkLCAweGZmMDAsIDB4OTAwMCwgIlNvbnkg
VkFJTyIsCiAJCQkgICBBTEMyNjJfU09OWV9BU1NBTUQpLAogI2VuZGlmCi0tIAoxLjYuNQoK
--00504502ad14e061b0047d152479
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--00504502ad14e061b0047d152479--
