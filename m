From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: amixer cget :Assertion `ctl && info &&
 (info->id.name[0] || info->id.numid)' failed. Aborted
Date: Mon, 10 Oct 2011 09:12:53 +0800
Message-ID: <CAN8cciYsoU9BtF579nLRf1RU7=YY_yDik4RPDmtcfT7fuwGT=A@mail.gmail.com>
References: <CAN8cciZmMsDx+0tX8izFzXpLPpSD2YS==BN=oG0KWFg9rBaxOA@mail.gmail.com>
	<s5hzkhiqj5q.wl%tiwai@suse.de>
	<CAN8ccib5ymF1DLMBLdmO-hc9FtHHJ9nV=kWgQ-zDEJnKQ59f+g@mail.gmail.com>
	<s5hobxvyj78.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001517402888889a3a04aee77dc3
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id EAA07245EE
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Oct 2011 03:12:53 +0200 (CEST)
Received: by eyz10 with SMTP id 10so350163eyz.38
	for <alsa-devel@alsa-project.org>; Sun, 09 Oct 2011 18:12:53 -0700 (PDT)
In-Reply-To: <s5hobxvyj78.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--001517402888889a3a04aee77dc3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

2011/10/5 Takashi Iwai <tiwai@suse.de>:
> At Wed, 5 Oct 2011 15:25:44 +0800,
> Raymond Yau wrote:
>>
>> 2011/10/3 Takashi Iwai <tiwai@suse.de>:
>> > At Sat, 1 Oct 2011 11:30:44 +0800,
>> > Raymond Yau wrote:
>> >>
>> >> There is assertion when specify iface=3DPCM =A0or iface=3DPCM,name=3D=
'' when
>> >> using amixer -c0 cget
>> >>
>> >> according to the synthax
>> >>
>> >> [[iface=3D<iface>,][name=3D'name',][index=3D<index>,][device=3D<devic=
e>,][subdevice=3D<subdevice>]]|[numid=3D<numid>]
>> >>
>> >>
>> >> amixer -c0 cget iface=3DPCM
>> >> amixer: control.c:258: snd_ctl_elem_info: Assertion `ctl && info &&
>> >> (info->id.name[0] || info->id.numid)' failed.
>> >> Aborted
>> >>
>> >> amixer -c0 cget iface=3DPCM,name=3D''
>> >> amixer: control.c:258: snd_ctl_elem_info: Assertion `ctl && info &&
>> >> (info->id.name[0] || info->id.numid)' failed.
>> >> Aborted
>> >
>> > So, the empty string isn't checked before assert(). =A0It's bad.
>> > It must be easy to fix. =A0Care to create and send a patch?
>> >
>> >
>>
>> The syntax seem also wrong.
>>
>> [[iface=3D<iface>,][name=3D'name',][index=3D<index>,][device=3D<device>,=
][subdevice=3Dsubdevice>]]|[numid=3D<numid>]
>>
>>
>> it should be
>> =A0[numid=3D<numid>] |
>> =A0[[iface=3D<iface>,name=3D'name'][,index=3D<index>][,device=3D<device>=
]] |
>> =A0[[iface=3D<iface>,name=3D'name'][,device=3D<device>][,subdevice=3D<su=
bdevice>]]
>>
>> since you cannot specify index and subdevice at the same time
>
> The index and subdevice are different things.
> Typically, the index is set > 0 when multiple elements with the same
> iface and name are present. =A0The subdevice is rather specification of
> the device itself, e.g. PCM substream number.
>
>
> Takashi
>

Please ignore the previous patch

Attach the correct patch which fix the assertion

However it report error when

amixer -c0 cget iface=3DPCM,

amixer -c0 cget iface=3DPCM,name=3D'ITD',

--001517402888889a3a04aee77dc3
Content-Type: application/octet-stream; name="fix_amixer_assert.patch"
Content-Disposition: attachment; filename="fix_amixer_assert.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gtkrms640

ZGlmZiAtLWdpdCBhL2FtaXhlci9hbWl4ZXIuYyBiL2FtaXhlci9hbWl4ZXIuYwppbmRleCA5ZDI4
NTVkLi45OTE2MGJlIDEwMDY0NAotLS0gYS9hbWl4ZXIvYW1peGVyLmMKKysrIGIvYW1peGVyL2Ft
aXhlci5jCkBAIC0xMTIyLDYgKzExMjIsOCBAQCBzdGF0aWMgaW50IHBhcnNlX2NvbnRyb2xfaWQo
Y29uc3QgY2hhciAqc3RyLCBzbmRfY3RsX2VsZW1faWRfdCAqaWQpCiAJCQkJfQogCQkJfQogCQkJ
KnB0ciA9ICdcMCc7CisJCQlpZiAocHRyID09IGJ1ZikKKwkJCQlyZXR1cm4gLUVJTlZBTDsKIAkJ
CXNuZF9jdGxfZWxlbV9pZF9zZXRfbmFtZShpZCwgYnVmKTsKIAkJfSBlbHNlIGlmICghc3RybmNh
c2VjbXAoc3RyLCAiaW5kZXg9IiwgNikpIHsKIAkJCXN0ciArPSA2OwpAQCAtMTE0NSw3ICsxMTQ3
LDEzIEBAIHN0YXRpYyBpbnQgcGFyc2VfY29udHJvbF9pZChjb25zdCBjaGFyICpzdHIsIHNuZF9j
dGxfZWxlbV9pZF90ICppZCkKIAkJCWlmICgqc3RyKQogCQkJCXJldHVybiAtRUlOVkFMOwogCQl9
Ci0JfQkJCQorCX0KKwlpZiAoKihzdHItMSkgPT0gJywnKQorCQlyZXR1cm4gLUVJTlZBTDsKKwlp
ZiAobnVtaWQgPiAwKQorCQlyZXR1cm4gMDsKKwlpZiAoc2l6ZSA9PSAwKQorCQlyZXR1cm4gLUVJ
TlZBTDsKIAlyZXR1cm4gMDsKIH0K
--001517402888889a3a04aee77dc3
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--001517402888889a3a04aee77dc3--
