From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 1/3] ALSA: snd-usb: Accept UAC2 FORMAT_TYPE
 descriptors with bLength > 6
Date: Thu, 4 Aug 2011 16:15:44 +0200
Message-ID: <CACTFLANDa0WSW2waG3KwV_NHRNyYZCRQtz4chQpw37Hhc1UxzA@mail.gmail.com>
References: <1312466188-3428-1-git-send-email-zonque@gmail.com>
	<1312466188-3428-2-git-send-email-zonque@gmail.com>
	<s5h1ux1l18a.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636e1f95adf802204a9ae9dae
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yi0-f51.google.com (mail-yi0-f51.google.com
	[209.85.218.51]) by alsa0.perex.cz (Postfix) with ESMTP id 3104C24467
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Aug 2011 16:15:46 +0200 (CEST)
Received: by yib12 with SMTP id 12so924045yib.38
	for <alsa-devel@alsa-project.org>; Thu, 04 Aug 2011 07:15:45 -0700 (PDT)
In-Reply-To: <s5h1ux1l18a.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, stable@kernel.org
List-Id: alsa-devel@alsa-project.org

--001636e1f95adf802204a9ae9dae
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 4, 2011 at 4:07 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Thu, =A04 Aug 2011 15:56:26 +0200,
> Daniel Mack wrote:
>>
>> The Focusrite Scarlett 18i6 USB has them that way, which is probably a
>> bug. Anyway, the driver should simply ignore this fact.
>>
>> Signed-off-by: Daniel Mack <zonque@gmail.com>
>> Reported-by: Nicolai Krakowiak <nicolai.krakowiak@gmail.com>
>> Cc: stable@kernel.org
>> ---
>> =A0sound/usb/endpoint.c | =A0 =A02 +-
>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
>> index 1eea7e3..1867bbd 100644
>> --- a/sound/usb/endpoint.c
>> +++ b/sound/usb/endpoint.c
>> @@ -352,7 +352,7 @@ int snd_usb_parse_audio_endpoints(struct snd_usb_aud=
io *chip, int iface_no)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (((protocol =3D=3D UAC_VERSION_1) && (fmt=
->bLength < 8)) ||
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((protocol =3D=3D UAC_VERSION_2) && (f=
mt->bLength !=3D 6))) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((protocol =3D=3D UAC_VERSION_2) && (f=
mt->bLength < 6))) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_printk(KERN_ERR "%d:%u:%=
d : invalid UAC_FORMAT_TYPE desc (protocol %d, bLength %d)\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev->=
devnum, iface_no, altno, protocol, fmt->bLength);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>
> This patch isn't applicable to sound git tree. =A0Any missing patch?

Eh, yes, sorry. Had it in my tree but did consider it important
enought to push right now. It's attached.

Thanks,
Daniel

--001636e1f95adf802204a9ae9dae
Content-Type: application/octet-stream;
	name="0001-ALSA-snd-usb-be-more-verbose-about-bogus-UAC_FORMAT_.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-snd-usb-be-more-verbose-about-bogus-UAC_FORMAT_.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gqxt5cwl0

RnJvbSBkZjY1MmJlZDM5MzE4Mjg0NzEyNTNkMjhkZDc2MjhiNWE3NDE0NWEzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgTWFjayA8em9ucXVlQGdtYWlsLmNvbT4KRGF0ZTog
U2F0LCA5IEp1bCAyMDExIDE2OjAyOjQyICswMjAwClN1YmplY3Q6IFtQQVRDSF0gQUxTQTogc25k
LXVzYjogYmUgbW9yZSB2ZXJib3NlIGFib3V0IGJvZ3VzIFVBQ19GT1JNQVRfVFlQRQogZGVzY3Jp
cHRvcnMKClNpZ25lZC1vZmYtYnk6IERhbmllbCBNYWNrIDx6b25xdWVAZ21haWwuY29tPgotLS0K
IHNvdW5kL3VzYi9lbmRwb2ludC5jIHwgICAgNCArKy0tCiAxIGZpbGVzIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zb3VuZC91c2IvZW5kcG9p
bnQuYyBiL3NvdW5kL3VzYi9lbmRwb2ludC5jCmluZGV4IDdjMGQyMWUuLjFlZWE3ZTMgMTAwNjQ0
Ci0tLSBhL3NvdW5kL3VzYi9lbmRwb2ludC5jCisrKyBiL3NvdW5kL3VzYi9lbmRwb2ludC5jCkBA
IC0zNTMsOCArMzUzLDggQEAgaW50IHNuZF91c2JfcGFyc2VfYXVkaW9fZW5kcG9pbnRzKHN0cnVj
dCBzbmRfdXNiX2F1ZGlvICpjaGlwLCBpbnQgaWZhY2Vfbm8pCiAJCX0KIAkJaWYgKCgocHJvdG9j
b2wgPT0gVUFDX1ZFUlNJT05fMSkgJiYgKGZtdC0+Ykxlbmd0aCA8IDgpKSB8fAogCQkgICAgKChw
cm90b2NvbCA9PSBVQUNfVkVSU0lPTl8yKSAmJiAoZm10LT5iTGVuZ3RoICE9IDYpKSkgewotCQkJ
c25kX3ByaW50ayhLRVJOX0VSUiAiJWQ6JXU6JWQgOiBpbnZhbGlkIFVBQ19GT1JNQVRfVFlQRSBk
ZXNjXG4iLAotCQkJCSAgIGRldi0+ZGV2bnVtLCBpZmFjZV9ubywgYWx0bm8pOworCQkJc25kX3By
aW50ayhLRVJOX0VSUiAiJWQ6JXU6JWQgOiBpbnZhbGlkIFVBQ19GT1JNQVRfVFlQRSBkZXNjIChw
cm90b2NvbCAlZCwgYkxlbmd0aCAlZClcbiIsCisJCQkJICAgZGV2LT5kZXZudW0sIGlmYWNlX25v
LCBhbHRubywgcHJvdG9jb2wsIGZtdC0+Ykxlbmd0aCk7CiAJCQljb250aW51ZTsKIAkJfQogCi0t
IAoxLjcuNS40Cgo=
--001636e1f95adf802204a9ae9dae
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--001636e1f95adf802204a9ae9dae--
