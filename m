From: cee1 <fykcee1@gmail.com>
Subject: Re: Adjust volume may cause audio playback corruption
Date: Sun, 27 May 2012 17:16:03 +0800
Message-ID: <CAGXxSxUafdPiHyhTZw4AJu-78SM4D0TmRJ3A_p1FTqEhmqXZ4A@mail.gmail.com>
References: <CAGXxSxUxFbC3mGWa-pbUKrzUqsBbvoQ5PmXNrKfL2W_BXyv1_A@mail.gmail.com>
	<CAGXxSxWSD+c9tnJHsKVDJYhq=AkY4KfefZgPj6rtgQozzFjuiQ@mail.gmail.com>
	<CAGXxSxUYWLyRZ1BEz53TRY9aE-CPPxSRoZeNGE5QTsOKP=B+Gg@mail.gmail.com>
	<4FB54BF6.3000901@ladisch.de>
	<CAGXxSxUC54kb8pmDXuRGjRVbQ465v9M0n8_rO-Z4cYUpnzLz+A@mail.gmail.com>
	<CAGXxSxXyfk5vNx3yfwLNPuGdWAwEPQU2FGV8dVKV=pLYrJJbbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=047d7b1601f138137504c1010e11
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 70A36103B49
	for <alsa-devel@alsa-project.org>;
	Sun, 27 May 2012 11:16:26 +0200 (CEST)
Received: by dajt11 with SMTP id t11so3626221daj.38
	for <alsa-devel@alsa-project.org>; Sun, 27 May 2012 02:16:24 -0700 (PDT)
In-Reply-To: <CAGXxSxXyfk5vNx3yfwLNPuGdWAwEPQU2FGV8dVKV=pLYrJJbbg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "pulseaudio-discuss@lists.freedesktop.org" <pulseaudio-discuss@lists.freedesktop.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--047d7b1601f138137504c1010e11
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

2012/5/18 cee1 <fykcee1@gmail.com>:
> 2012/5/18 cee1 <fykcee1@gmail.com>:
>> =E5=9C=A8 2012=E5=B9=B45=E6=9C=8818=E6=97=A5=E6=98=9F=E6=9C=9F=E4=BA=94=
=EF=BC=8CClemens Ladisch =E5=86=99=E9=81=93=EF=BC=9A
>>
>>> cee1 wrote:
>>> > We've found a way the can reproduce the problem more quickly on our
>>> > product:
>>> > 1. do audio playback
>>> > 2. alsamixer, select 'Master', press 'm' and hold for a while.
>>> >
>>> > Then release 'm', playback corrupts(sounds similar to
>>> > http://dev.lemote.com/files/upload/software/PA-apc/corrupted_sound.og=
g).
I've written a small program[1] that will let PA mute/unmute repeatedly.

I find the problem is something to do with rewind_safeguard, If I
adjust rewind_safeguard to eighth of the original value, it can also
be easily reproduced through pa-mute-test.c on the AMD turion 64 x2
board in ubuntu 12.04:
--- a/src/modules/alsa/alsa-sink.c
+++ b/src/modules/alsa/alsa-sink.c
@@ -86,8 +86,8 @@

 #define VOLUME_ACCURACY (PA_VOLUME_NORM/100)  /* don't require volume
adjustments to be perfectly correct. do

-#define DEFAULT_REWIND_SAFEGUARD_BYTES (256U) /* 1.33ms @48kHz, we'll
never rewind less than this */
-#define DEFAULT_REWIND_SAFEGUARD_USEC (1330) /* 1.33ms, depending on
channels/rate/sample we may rewind more
+#define DEFAULT_REWIND_SAFEGUARD_BYTES (32U) /* 1.33ms @48kHz, we'll
never rewind less than this */
+#define DEFAULT_REWIND_SAFEGUARD_USEC (166) /* 1.33ms, depending on
channels/rate/sample we may rewind more t

 struct userdata {
     pa_core *core;

Should we calculate limit_nbytes considering tsched_watermark?
e.g.(which works on our platform)
@@ -1614,7 +1614,7 @@ static int process_rewind(struct userdata *u) {
     unused_nbytes =3D (size_t) unused * u->frame_size;

     /* make sure rewind doesn't go too far, can cause issues with DMAs */
-    unused_nbytes +=3D u->rewind_safeguard;
+    unused_nbytes +=3D u->tsched_watermark;

     if (u->hwbuf_size > unused_nbytes)
         limit_nbytes =3D u->hwbuf_size - unused_nbytes;


----
[1]. See pa-mute-test.c in attachment, using build.sh to build it.


Regards,
-- cee1

--047d7b1601f138137504c1010e11
Content-Type: text/x-csrc; charset=US-ASCII; name="pa-mute-test.c"
Content-Disposition: attachment; filename="pa-mute-test.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h2pv6esn0

I2luY2x1ZGUgPGdsaWIuaD4KI2luY2x1ZGUgPHB1bHNlL3B1bHNlYXVkaW8uaD4KI2luY2x1ZGUg
PHB1bHNlL2dsaWItbWFpbmxvb3AuaD4KCiNkZWZpbmUgSU5URVJWQUwgMTI1CiNkZWZpbmUgVEVT
VF9OUiAgKCgxMDAwL0lOVEVSVkFMKSozNjAwKjcyVUwpCgpzdHJ1Y3QgY29udGV4dHsKCXBhX2Nv
bnRleHQgKnBhX2N4dDsKCUdNYWluTG9vcCAqbWFpbl9sb29wOwp9OwoKZ2Jvb2xlYW4gc2V0X211
dGVfdW5tdXRlKHN0cnVjdCBjb250ZXh0ICpjeHQpCnsKCXN0YXRpYyBnYm9vbGVhbiBtdXRlID0g
VFJVRTsKCXN0YXRpYyBnaW50IGNvdW50ID0gMDsKCXBhX29wZXJhdGlvbiAqbzsKCgltdXRlID0g
IW11dGU7Cgljb3VudCsrOwoKCW8gPSBwYV9jb250ZXh0X3NldF9zaW5rX211dGVfYnlfaW5kZXgo
Y3h0LT5wYV9jeHQsIDAsIG11dGUsIE5VTEwsIE5VTEwpOwoJaWYgKG8gPT0gTlVMTCkgewoJCWdf
d2FybmluZyAoInBhX2NvbnRleHRfc2V0X3NpbmtfbXV0ZV9ieV9pbmRleCgpIGZhaWxlZDogJXMi
LCBwYV9zdHJlcnJvcihwYV9jb250ZXh0X2Vycm5vKGN4dC0+cGFfY3h0KSkpOwoJCWdfbWFpbl9x
dWl0KGN4dC0+bWFpbl9sb29wKTsKCQlyZXR1cm4gRkFMU0U7Cgl9IAoKCWlmIChjb3VudCA9PSBU
RVNUX05SKSB7CgkJZ19wcmludCgiTWF4IHRlc3QgbnVtYmVyKD0lbHUpIHJlYWNoZWQsIHF1aXQu
XG4iLCBURVNUX05SKTsKCQlnX21haW5fcXVpdChjeHQtPm1haW5fbG9vcCk7CgkJcmV0dXJuIEZB
TFNFOwoJfQoKCWdfcHJpbnQoIlxyJTEwZDpcdHNldCB0byAlNnMiLCBjb3VudCwgbXV0ZSA/ICJt
dXRlIjoidW5tdXRlIik7CglwYV9vcGVyYXRpb25fdW5yZWYobyk7CglyZXR1cm4gVFJVRTsKfQoK
aW50IG1haW4oKQp7CglzdHJ1Y3QgY29udGV4dCBjeHQ7CglwYV9nbGliX21haW5sb29wICpwYV9t
YWluX2xvb3A7CglpbnQgcjsKCglwYV9tYWluX2xvb3AgPSBwYV9nbGliX21haW5sb29wX25ldyhO
VUxMKTsKCWN4dC5wYV9jeHQgPSBwYV9jb250ZXh0X25ldyhwYV9nbGliX21haW5sb29wX2dldF9h
cGkocGFfbWFpbl9sb29wKSwgIm11dGUtYXV0b211dGUtdGVzdCIpOyAKCWN4dC5tYWluX2xvb3Ag
PSBnX21haW5fbG9vcF9uZXcoTlVMTCwgRkFMU0UpOwoKCXIgPSBwYV9jb250ZXh0X2Nvbm5lY3Qo
Y3h0LnBhX2N4dCwgTlVMTCwgMCwgTlVMTCk7CgoJaWYgKHIpIHsKCQlnX3ByaW50KCJGYWlsZWQg
dG8gY29ubmVjdCBQQSBzZXJ2ZXIuXG4iKTsKCQlleGl0KDMpOwoJfQoKCWdfdGltZW91dF9hZGQo
SU5URVJWQUwsIChHU291cmNlRnVuYykgc2V0X211dGVfdW5tdXRlLCAmY3h0KTsKCglnX21haW5f
bG9vcF9ydW4oY3h0Lm1haW5fbG9vcCk7CgoJcmV0dXJuIDA7Cn0K
--047d7b1601f138137504c1010e11
Content-Type: application/x-sh; name="build.sh"
Content-Disposition: attachment; filename="build.sh"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h2pv6nba1

IyEvYmluL2Jhc2gKCnNldCAtZQpleHBvcnQgUEtGX0NPTkZJR19QQVRIPS91c3IvbGliL2kzODYt
bGludXgtZ251L3BrZ2NvbmZpZwpjYyBwYS1tdXRlLXRlc3QuYyBgcGtnLWNvbmZpZyAtLWNmbGFn
cyAtLWxpYnMgZ2xpYi0yLjAgbGlicHVsc2UgbGlicHVsc2UtbWFpbmxvb3AtZ2xpYmAgLW8gcGEt
bXV0ZS10ZXN0Cg==
--047d7b1601f138137504c1010e11
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--047d7b1601f138137504c1010e11--
