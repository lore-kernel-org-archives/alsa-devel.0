From: "Alexander Indenbaum" <alexander.indenbaum@gmail.com>
Subject: External PCM IO Plugin development
Date: Wed, 2 Apr 2008 18:27:13 +0300
Message-ID: <cab05a880804020827w4fcf189er7c387c60d1f483a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_2715_21985588.1207150033454"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.224])
	by alsa0.perex.cz (Postfix) with ESMTP id 85728244B5
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Apr 2008 17:27:15 +0200 (CEST)
Received: by wr-out-0506.google.com with SMTP id 50so1974694wri.2
	for <alsa-devel@alsa-project.org>; Wed, 02 Apr 2008 08:27:14 -0700 (PDT)
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
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

------=_Part_2715_21985588.1207150033454
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Takashi & alsa-devel,

I am playing with embedded Linux box based on kernel 2.4.36. Our box
is equipped with proprietary chip which allows PCM playback using user
space DMA pool API.  My target is to enable audio playback for ALSA
clients by redirecting PCM stream into proprietary chip. I did a
little RTFM and with a lot of help from this list discovered that
fortunately ALSA expendable architecture allows such things as a part
of PCM External Plugin SDK.

So I downloaded and installed following ALSA 1.0.16 distribution components:
- driver configured with "./configure  --with-cards=seq-dummy,dummy
--with-kernel=/path/to/my/linux-2.4.36"
- lib configured with "./configure --with-pcm-plugins=all"

I looked at Jack IO plugin at plugins and started with skeleton plugin
of my own: pcm_sigma.c (attached).
I hope to redirect PCM into my plugin using following /etc/asound.conf
=============
pcm.!default {
        type sigma
}
=============

What I see when I fire ALSA client ( friefox with YouTube flash ) that ALSA
1. loads/links my module: ALSA lib dlmisc.c:51:(snd_dlopen) snd_dlopen
name = (/usr/lib/alsa-lib/libasound_module_pcm_sigma.so)
2. calls open interface of the module: _snd_pcm_sigma_open @ pcm_sigma.c:118

snd_pcm_sigma_open @ pcm_sigma.c:86
3. calls close interface of the module: snd_pcm_sigma_close @ pcm_sigma.c:23
4. goto 2

So basically what I see is an infinite open/close loop without any
call to other interfaces of the module. I hoped to get my hands on PCM
stream and start to push it into our proprietary chip :(.

QUESTIONS:
Is my PCM IO Plugin approach correct?
Is my configuration (/etc/asound.conf) correct?
Is my implemention of PCM IO plugin interface correct? Should I
implement additional methods?
What do you think causes infinite open/close loop?

Thank you for your help,
Alexander Indenbaum

------=_Part_2715_21985588.1207150033454
Content-Type: text/x-csrc; name=pcm_sigma.c
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fek1xzkc0
Content-Disposition: attachment; filename=pcm_sigma.c

I2luY2x1ZGUgPGFzb3VuZGxpYi5oPgojaW5jbHVkZSA8cGNtX2V4dGVybmFsLmg+CgojZGVmaW5l
IFRSQUNFKCkgZnByaW50ZihzdGRlcnIsICIlcyBAICVzOiVkXG4iLCBfX0ZVTkNUSU9OX18sIF9f
RklMRV9fLCBfX0xJTkVfXykKI2RlZmluZSBVTlVTRURfQVJHUyhhcmdzKSAgZG8ge30gd2hpbGUg
KChhcmdzKSAmJiAhKGFyZ3MpKQoKdHlwZWRlZiBzdHJ1Y3QgewoJc25kX3BjbV9pb3BsdWdfdCAg
aW87CiAgICAgICAgLy8gc3RhdGUKfSBzbmRfcGNtX3NpZ21hX3Q7CgpzdGF0aWMgdm9pZCBzbmRf
cGNtX3NpZ21hX2ZyZWUoc25kX3BjbV9zaWdtYV90ICpzaWdtYSkKewoJaWYgKHNpZ21hKSB7CgkJ
ZnJlZShzaWdtYSk7Cgl9Cn0KCgpzdGF0aWMgaW50IHNuZF9wY21fc2lnbWFfY2xvc2Uoc25kX3Bj
bV9pb3BsdWdfdCAqaW8pCnsKCXNuZF9wY21fc2lnbWFfdCAqc2lnbWE7CglUUkFDRSgpOwoKCXNp
Z21hID0gaW8tPnByaXZhdGVfZGF0YTsKCXNuZF9wY21fc2lnbWFfZnJlZShzaWdtYSk7CglyZXR1
cm4gMDsKfQoKc3RhdGljIHNuZF9wY21fc2ZyYW1lc190IHNuZF9wY21fc2lnbWFfcG9pbnRlcihz
bmRfcGNtX2lvcGx1Z190ICppbykKewoJVU5VU0VEX0FSR1MoaW8pOwogICAgCVRSQUNFKCk7CgoJ
cmV0dXJuIDA7Cn0KCnN0YXRpYyBpbnQgc25kX3BjbV9zaWdtYV9wcmVwYXJlKHNuZF9wY21faW9w
bHVnX3QgKmlvKQp7CglVTlVTRURfQVJHUyhpbyk7CiAgICAJVFJBQ0UoKTsKCXJldHVybiAwOwp9
CgpzdGF0aWMgaW50IHNuZF9wY21fc2lnbWFfc3RhcnQoc25kX3BjbV9pb3BsdWdfdCAqaW8pCnsK
CVVOVVNFRF9BUkdTKGlvKTsKICAgIAlUUkFDRSgpOwoJcmV0dXJuIDA7Cn0KCnN0YXRpYyBpbnQg
c25kX3BjbV9zaWdtYV9zdG9wKHNuZF9wY21faW9wbHVnX3QgKmlvKQp7CglVTlVTRURfQVJHUyhp
byk7CiAgICAJVFJBQ0UoKTsKCXJldHVybiAwOwp9CgpzdGF0aWMgc25kX3BjbV9zZnJhbWVzX3Qg
c25kX3BjbV9zaWdtYV90cmFuc2ZlcihzbmRfcGNtX2lvcGx1Z190ICppbywKCQkJCQkJY29uc3Qg
c25kX3BjbV9jaGFubmVsX2FyZWFfdCAqYXJlYXMsCgkJCQkJCXNuZF9wY21fdWZyYW1lc190IG9m
ZnNldCwKCQkJCQkJc25kX3BjbV91ZnJhbWVzX3Qgc2l6ZSkKewoJVU5VU0VEX0FSR1MoaW8gJiYg
YXJlYXMgJiYgb2Zmc2V0ICYmIHNpemUpOwogICAgCVRSQUNFKCk7CglyZXR1cm4gMDsKfQoKc3Rh
dGljIHNuZF9wY21faW9wbHVnX2NhbGxiYWNrX3Qgc2lnbWFfcGNtX2NhbGxiYWNrID0gewoJLmNs
b3NlID0gc25kX3BjbV9zaWdtYV9jbG9zZSwKCS5zdGFydCA9IHNuZF9wY21fc2lnbWFfc3RhcnQs
Cgkuc3RvcCA9IHNuZF9wY21fc2lnbWFfc3RvcCwKCS5wb2ludGVyID0gc25kX3BjbV9zaWdtYV9w
b2ludGVyLAoJLnByZXBhcmUgPSBzbmRfcGNtX3NpZ21hX3ByZXBhcmUsCgkudHJhbnNmZXIgPSBz
bmRfcGNtX3NpZ21hX3RyYW5zZmVyCn07CgpzdGF0aWMgaW50IHNuZF9wY21fc2lnbWFfb3Blbihz
bmRfcGNtX3QgKipwY21wLCBjb25zdCBjaGFyICpuYW1lLAoJCQkgICAgIHNuZF9jb25maWdfdCAq
cGxheWJhY2tfY29uZiwKCQkJICAgICBzbmRfY29uZmlnX3QgKmNhcHR1cmVfY29uZiwKCQkJICAg
ICBzbmRfcGNtX3N0cmVhbV90IHN0cmVhbSwgaW50IG1vZGUpCnsKCWludCBlcnI7CglzbmRfcGNt
X3NpZ21hX3QgKnNpZ21hOwoKICAgIAlUUkFDRSgpOwoKCVVOVVNFRF9BUkdTKHBjbXAgJiYgcGxh
eWJhY2tfY29uZiAmJiBjYXB0dXJlX2NvbmYpOwoJc2lnbWEgPSBjYWxsb2MoMSwgc2l6ZW9mKCpz
aWdtYSkpOwoJaWYgKCFzaWdtYSkKCQlyZXR1cm4gLUVOT01FTTsKCglzaWdtYS0+aW8udmVyc2lv
biA9IFNORF9QQ01fSU9QTFVHX1ZFUlNJT047CglzaWdtYS0+aW8ubmFtZSA9ICJBTFNBIDwtPiBT
SUdNQSBQQ00gSS9PIFBsdWdpbiI7CglzaWdtYS0+aW8uY2FsbGJhY2sgPSAmc2lnbWFfcGNtX2Nh
bGxiYWNrOwoJc2lnbWEtPmlvLnByaXZhdGVfZGF0YSA9IHNpZ21hOwoKCWVyciA9IHNuZF9wY21f
aW9wbHVnX2NyZWF0ZSgmc2lnbWEtPmlvLCBuYW1lLCBzdHJlYW0sIG1vZGUpOwoJaWYgKGVyciA8
IDApIHsKCQlzbmRfcGNtX3NpZ21hX2ZyZWUoc2lnbWEpOwoJCXJldHVybiBlcnI7Cgl9CgoJKnBj
bXAgPSBzaWdtYS0+aW8ucGNtOwoKCXJldHVybiAwOwp9CgoKU05EX1BDTV9QTFVHSU5fREVGSU5F
X0ZVTkMoc2lnbWEpCnsKCXNuZF9jb25maWdfaXRlcmF0b3JfdCBpLCBuZXh0OwoJc25kX2NvbmZp
Z190ICpwbGF5YmFja19jb25mID0gTlVMTDsKCXNuZF9jb25maWdfdCAqY2FwdHVyZV9jb25mID0g
TlVMTDsKCWludCBlcnI7CgkKCVVOVVNFRF9BUkdTKHJvb3QpOwogICAgCVRSQUNFKCk7CgoJc25k
X2NvbmZpZ19mb3JfZWFjaChpLCBuZXh0LCBjb25mKSB7CgkJc25kX2NvbmZpZ190ICpuID0gc25k
X2NvbmZpZ19pdGVyYXRvcl9lbnRyeShpKTsKCQljb25zdCBjaGFyICppZDsKCQlpZiAoc25kX2Nv
bmZpZ19nZXRfaWQobiwgJmlkKSA8IDApCgkJCWNvbnRpbnVlOwoJCWlmIChzdHJjbXAoaWQsICJj
b21tZW50IikgPT0gMCB8fCBzdHJjbXAoaWQsICJ0eXBlIikgPT0gMCkKCQkJY29udGludWU7CgkJ
LyoKCQlpZiAoc3RyY21wKGlkLCAicGxheWJhY2tfcG9ydHMiKSA9PSAwKSB7CgkJCWlmIChzbmRf
Y29uZmlnX2dldF90eXBlKG4pICE9IFNORF9DT05GSUdfVFlQRV9DT01QT1VORCkgewoJCQkJU05E
RVJSKCJJbnZhbGlkIHR5cGUgZm9yICVzIiwgaWQpOwoJCQkJcmV0dXJuIC1FSU5WQUw7CgkJCX0K
CQkJcGxheWJhY2tfY29uZiA9IG47CgkJCWNvbnRpbnVlOwoJCX0KCQlpZiAoc3RyY21wKGlkLCAi
Y2FwdHVyZV9wb3J0cyIpID09IDApIHsKCQkJaWYgKHNuZF9jb25maWdfZ2V0X3R5cGUobikgIT0g
U05EX0NPTkZJR19UWVBFX0NPTVBPVU5EKSB7CgkJCQlTTkRFUlIoIkludmFsaWQgdHlwZSBmb3Ig
JXMiLCBpZCk7CgkJCQlyZXR1cm4gLUVJTlZBTDsKCQkJfQoJCQljYXB0dXJlX2NvbmYgPSBuOwoJ
CQljb250aW51ZTsKCQl9CgkJKi8KCQlTTkRFUlIoIlVua25vd24gZmllbGQgJXMiLCBpZCk7CgkJ
cmV0dXJuIC1FSU5WQUw7Cgl9CgoJZXJyID0gc25kX3BjbV9zaWdtYV9vcGVuKHBjbXAsIG5hbWUs
IHBsYXliYWNrX2NvbmYsIGNhcHR1cmVfY29uZiwgc3RyZWFtLCBtb2RlKTsKCglyZXR1cm4gZXJy
Owp9CgpTTkRfUENNX1BMVUdJTl9TWU1CT0woc2lnbWEpOwo=
------=_Part_2715_21985588.1207150033454
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_2715_21985588.1207150033454--
