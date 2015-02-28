From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Issues and/or possible bugs in alsa
Date: Sat, 28 Feb 2015 18:00:45 +0800
Message-ID: <CAN8cciYnyLahS2gQ0g0vSaNj+xo=Tz9_FQ9L-WazOb1t5no_kA@mail.gmail.com>
References: <CACui-2k8j3ZWtmvwiE3V5apuQ0g-dn=wN-h4miExDYLLR4diWA@mail.gmail.com>
 <54ED8466.7020102@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a11c30d141d50a50510230fa0
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f170.google.com (mail-ob0-f170.google.com
 [209.85.214.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A6092602AD
 for <alsa-devel@alsa-project.org>; Sat, 28 Feb 2015 11:00:48 +0100 (CET)
Received: by mail-ob0-f170.google.com with SMTP id va2so23087525obc.1
 for <alsa-devel@alsa-project.org>; Sat, 28 Feb 2015 02:00:47 -0800 (PST)
In-Reply-To: <54ED8466.7020102@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Yomi Ogunwumi <abyomi0@gmail.com>
List-Id: alsa-devel@alsa-project.org

--001a11c30d141d50a50510230fa0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

>> Third. This is just a question. Is this :
>> https://bugs.freedesktop.org/show_bug.cgi?id=3D86676 actually a pulseaud=
io
>> bug, or is it an issue with alsa?
>> I'm only asking since Raymond linked something that seemed to belong to
the
>> alsa project.
>>
>
> This is a bug both in ALSA and in PulseAudio.
>
> The ALSA part (from the user viewpoint) is that the softvol plugin does
not reprocess the already-submitted but buffered samples when the volume
changes. But it can't, because that would require an additional thread for
monitoring the software volume changes, and such thread does not exist.
>
> The PulseAudio part of the bug is that it does not deactivate softvols,
even though it can apply volume in software itself. In October 2014, in
Dusseldorf, a general agreement has been reached on the following arguments=
:
>
>  * ALSA has no API to definitely distinguish softvols from other controls=
.
>  * ALSA has the snd_ctl_elem_info_is_user() API function that tells
whether this is a userspace control.
>  * All softvols are userspace controls.
>  * There are other kinds of userspace controls, but they are rare.
>  * If a control is named PCM Playback Volume and is a userspace control,
then it's likely a softvol. Not bulletproof, but a good-enough heuristic.

You can use snd_ctl_elem_info_is_use() to find out the name of those user
space controls of the card and ignore those softvol "PCM playback volume"
and "Digital Capture Volume" controls

>  * On finding a softvol, PulseAudio should set it to 100% (so that it
doesn't eat CPU) and don't touch from that point on.
>
> But nobody has implemented this so far.
>
> The relevant code can be placed in the src/modules/alsa/alsa-mixer.c file
in PulseAudio source tree. I guess that element_probe() is a good place. If
you know C programming, a contribution would be welcome.||
>

state.Generic {
control.1 {
iface CARD
name 'HDMI/DP,pcm=3D3 Jack'
value false
comment {
access read
type BOOLEAN
count 1
}
}
control.2 {
iface MIXER
name 'IEC958 Playback Con Mask'
value
'0fff0000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
00000000000000000000000000000000000000000000000000000'
comment {
access read
type IEC958
count 1
}
}
control.3 {
iface MIXER
name 'IEC958 Playback Pro Mask'
value
'0f000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
00000000000000000000000000000000000000000000000000000'
comment {
access read
type IEC958
count 1
}
}
control.4 {
iface MIXER
name 'IEC958 Playback Default'
value
'04000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
00000000000000000000000000000000000000000000000000000'
comment {
access 'read write'
type IEC958
count 1
}
}
control.5 {
iface MIXER
name 'IEC958 Playback Switch'
value true
comment {
access 'read write'
type BOOLEAN
count 1
}
}
control.6 {
iface PCM
device 3
name ELD
value ''
comment {
access 'read volatile'
type BYTES
count 0
}
}
control.7 {
iface PCM
device 3
name 'Playback Channel Map'
value.0 0
value.1 0
value.2 0
value.3 0
value.4 0
value.5 0
value.6 0
value.7 0
comment {
access 'read write'
type INTEGER
count 8
range '0 - 36'
}
}
control.8 {
iface MIXER
name 'PCM Playback Volume'
value.0 184
value.1 184
comment {
access 'read write user'
type INTEGER
count 2
range '0 - 255'
tlv '0000000100000008ffffec1400000014'
dbmin -5100
dbmax 0
dbvalue.0 -1420
dbvalue.1 -1420
}
}
}

It is strange that your hdmi card have a softvol control ,

Was  the softvol control created when you swap the card number by index=3D1=
,0
?

--001a11c30d141d50a50510230fa0
Content-Type: text/x-csrc; charset=US-ASCII; name="user_ctl.c"
Content-Disposition: attachment; filename="user_ctl.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_i6orhbmi0

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxhbHNhL2Fzb3VuZGxpYi5oPgoKCnN0YXRpYyBj
aGFyICppZF9zdHIoc25kX2N0bF9lbGVtX2lkX3QgKmlkKQp7CglzdGF0aWMgY2hhciBzdHJbMTI4
XTsKCWFzc2VydChpZCk7CglzcHJpbnRmKHN0ciwgIiVpLCVpLCVpLCVzLCVpIiwgCgkJc25kX2N0
bF9lbGVtX2lkX2dldF9pbnRlcmZhY2UoaWQpLAoJCXNuZF9jdGxfZWxlbV9pZF9nZXRfZGV2aWNl
KGlkKSwKCQlzbmRfY3RsX2VsZW1faWRfZ2V0X3N1YmRldmljZShpZCksCgkJc25kX2N0bF9lbGVt
X2lkX2dldF9uYW1lKGlkKSwKCQlzbmRfY3RsX2VsZW1faWRfZ2V0X2luZGV4KGlkKSk7CglyZXR1
cm4gc3RyOwp9CgoKc3RhdGljIGludCBnZXRfY29udHJvbChzbmRfY3RsX3QgKmhhbmRsZSwgc25k
X2N0bF9lbGVtX2lkX3QgKmlkLCBzbmRfY29uZmlnX3QgKnRvcCkKewoJc25kX2N0bF9lbGVtX3Zh
bHVlX3QgKmN0bDsKCXNuZF9jdGxfZWxlbV9pbmZvX3QgKmluZm87CglzbmRfY29uZmlnX3QgKmNv
bnRyb2wsICpjb21tZW50LCAqaXRlbSwgKnZhbHVlOwoJY29uc3QgY2hhciAqczsKCWNoYXIgYnVm
WzI1Nl07Cgl1bnNpZ25lZCBpbnQgaWR4OwoJaW50IGVycjsKCXVuc2lnbmVkIGludCBkZXZpY2Us
IHN1YmRldmljZSwgaW5kZXg7Cgljb25zdCBjaGFyICpuYW1lOwoJc25kX2N0bF9lbGVtX3R5cGVf
dCB0eXBlOwoJdW5zaWduZWQgaW50IGNvdW50OwoJc25kX2N0bF9lbGVtX3ZhbHVlX2FsbG9jYSgm
Y3RsKTsKCXNuZF9jdGxfZWxlbV9pbmZvX2FsbG9jYSgmaW5mbyk7CglzbmRfY3RsX2VsZW1faW5m
b19zZXRfaWQoaW5mbywgaWQpOwoJZXJyID0gc25kX2N0bF9lbGVtX2luZm8oaGFuZGxlLCBpbmZv
KTsKCWlmIChlcnIgPCAwKSB7CgkJZXJyb3IoIkNhbm5vdCByZWFkIGNvbnRyb2wgaW5mbyAnJXMn
OiAlcyIsIGlkX3N0cihpZCksIHNuZF9zdHJlcnJvcihlcnIpKTsKCQlyZXR1cm4gZXJyOwoJfQoK
CWlmICghc25kX2N0bF9lbGVtX2luZm9faXNfcmVhZGFibGUoaW5mbykpCgkJcmV0dXJuIDA7Cglz
bmRfY3RsX2VsZW1fdmFsdWVfc2V0X2lkKGN0bCwgaWQpOwoJZXJyID0gc25kX2N0bF9lbGVtX3Jl
YWQoaGFuZGxlLCBjdGwpOwoJaWYgKGVyciA8IDApIHsKCQllcnJvcigiQ2Fubm90IHJlYWQgY29u
dHJvbCAnJXMnOiAlcyIsIGlkX3N0cihpZCksIHNuZF9zdHJlcnJvcihlcnIpKTsKCQlyZXR1cm4g
ZXJyOwoJfQoKCgl0eXBlID0gc25kX2N0bF9lbGVtX2luZm9fZ2V0X3R5cGUoaW5mbyk7CglkZXZp
Y2UgPSBzbmRfY3RsX2VsZW1faW5mb19nZXRfZGV2aWNlKGluZm8pOwoJc3ViZGV2aWNlID0gc25k
X2N0bF9lbGVtX2luZm9fZ2V0X3N1YmRldmljZShpbmZvKTsKCWluZGV4ID0gc25kX2N0bF9lbGVt
X2luZm9fZ2V0X2luZGV4KGluZm8pOwoJbmFtZSA9IHNuZF9jdGxfZWxlbV9pbmZvX2dldF9uYW1l
KGluZm8pOwoJY291bnQgPSBzbmRfY3RsX2VsZW1faW5mb19nZXRfY291bnQoaW5mbyk7CglzID0g
c25kX2N0bF9lbGVtX3R5cGVfbmFtZSh0eXBlKTsKCglpZiAoc25kX2N0bF9lbGVtX2luZm9faXNf
dXNlcihpbmZvKSkKCQlwcmludGYoIiB1c2VyIGNvbnRyb2wgOiAlcyAtICVzXG4iLCBuYW1lLCBp
ZF9zdHIoaWQpKTsKCgoJcmV0dXJuIDA7Cn0KCgppbnQgbWFpbihpbnQgYXJnYywgY2hhciogYXJn
dltdKQp7CglzbmRfY3RsX3QgKmhhbmRsZTsKCXNuZF9jdGxfY2FyZF9pbmZvX3QgKmluZm87Cglz
bmRfY29uZmlnX3QgKnN0YXRlLCAqY2FyZCwgKmNvbnRyb2w7CglzbmRfY3RsX2VsZW1fbGlzdF90
ICpsaXN0OwoJc25kX2N0bF9lbGVtX2lkX3QgKmVsZW1faWQ7Cgl1bnNpZ25lZCBpbnQgaWR4OwoJ
aW50IGVycjsKCWNoYXIgbmFtZVszMl07Cgl1bnNpZ25lZCBpbnQgY291bnQ7Cgljb25zdCBjaGFy
ICppZDsKCWludCBjYXJkbm87CgoJY2FyZG5vID0gMDsKCXNuZF9jdGxfY2FyZF9pbmZvX2FsbG9j
YSgmaW5mbyk7CglzbmRfY3RsX2VsZW1fbGlzdF9hbGxvY2EoJmxpc3QpOwoJc25kX2N0bF9lbGVt
X2lkX2FsbG9jYSgmZWxlbV9pZCk7CgoJc3ByaW50ZihuYW1lLCAiaHc6JWQiLCBjYXJkbm8pOwoJ
ZXJyID0gc25kX2N0bF9vcGVuKCZoYW5kbGUsIG5hbWUsIFNORF9DVExfUkVBRE9OTFkpOwoJaWYg
KGVyciA8IDApIHsKCQllcnJvcigic25kX2N0bF9vcGVuIGVycm9yOiAlcyIsIHNuZF9zdHJlcnJv
cihlcnIpKTsKCQlyZXR1cm4gZXJyOwoJfQoJZXJyID0gc25kX2N0bF9jYXJkX2luZm8oaGFuZGxl
LCBpbmZvKTsKCWlmIChlcnIgPCAwKSB7CgkJZXJyb3IoInNuZF9jdGxfY2FyZF9pbmZvIGVycm9y
OiAlcyIsIHNuZF9zdHJlcnJvcihlcnIpKTsKCQlnb3RvIF9jbG9zZTsKCX0KCWlkID0gc25kX2N0
bF9jYXJkX2luZm9fZ2V0X2lkKGluZm8pOwoKCWVyciA9IHNuZF9jdGxfZWxlbV9saXN0KGhhbmRs
ZSwgbGlzdCk7CglpZiAoZXJyIDwgMCkgewoJCWVycm9yKCJDYW5ub3QgZGV0ZXJtaW5lIGNvbnRy
b2xzOiAlcyIsIHNuZF9zdHJlcnJvcihlcnIpKTsKCQlnb3RvIF9jbG9zZTsKCX0KCWNvdW50ID0g
c25kX2N0bF9lbGVtX2xpc3RfZ2V0X2NvdW50KGxpc3QpOwoJaWYgKGNvdW50ID09IDApIHsKCQll
cnIgPSAwOwoJCWdvdG8gX2Nsb3NlOwoJfQoJc25kX2N0bF9lbGVtX2xpc3Rfc2V0X29mZnNldChs
aXN0LCAwKTsKCWlmIChzbmRfY3RsX2VsZW1fbGlzdF9hbGxvY19zcGFjZShsaXN0LCBjb3VudCkg
PCAwKSB7CgkJZXJyb3IoIk5vIGVub3VnaCBtZW1vcnkuLi4iKTsKCQlnb3RvIF9jbG9zZTsKCX0K
CWlmICgoZXJyID0gc25kX2N0bF9lbGVtX2xpc3QoaGFuZGxlLCBsaXN0KSkgPCAwKSB7CgkJZXJy
b3IoIkNhbm5vdCBkZXRlcm1pbmUgY29udHJvbHMgKDIpOiAlcyIsIHNuZF9zdHJlcnJvcihlcnIp
KTsKCQlnb3RvIF9mcmVlOwoJfQoJZm9yIChpZHggPSAwOyBpZHggPCBjb3VudDsgKytpZHgpIHsK
CQlzbmRfY3RsX2VsZW1fbGlzdF9nZXRfaWQobGlzdCwgaWR4LCBlbGVtX2lkKTsKCQllcnIgPSBn
ZXRfY29udHJvbChoYW5kbGUsIGVsZW1faWQsIGNvbnRyb2wpOwoJCWlmIChlcnIgPCAwKQoJCQln
b3RvIF9mcmVlOwoJfQkJCgkJCgllcnIgPSAwOwogX2ZyZWU6CglzbmRfY3RsX2VsZW1fbGlzdF9m
cmVlX3NwYWNlKGxpc3QpOwogX2Nsb3NlOgoJc25kX2N0bF9jbG9zZShoYW5kbGUpOwoJcmV0dXJu
IDA7Cn0K
--001a11c30d141d50a50510230fa0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--001a11c30d141d50a50510230fa0--
