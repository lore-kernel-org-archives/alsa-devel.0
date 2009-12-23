From: pl bossart <bossart.nospam@gmail.com>
Subject: Duplicate wake-ups in pcm_lib.c
Date: Wed, 23 Dec 2009 14:28:41 -0600
Message-ID: <6160a5130912231228g29669e4ctfef9ea8f42633120@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00151748e89213dc57047b6b2b9c
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f53.google.com (mail-pw0-f53.google.com
	[209.85.160.53])
	by alsa0.perex.cz (Postfix) with ESMTP id DCCC610381D
	for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2009 21:28:42 +0100 (CET)
Received: by pwi18 with SMTP id 18so17499337pwi.32
	for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2009 12:28:41 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Lennart Poettering <lennart@poettering.net>
List-Id: alsa-devel@alsa-project.org

--00151748e89213dc57047b6b2b9c
Content-Type: text/plain; charset=ISO-8859-1

Thanks to Takashi's advice, I managed to find out the reason why I was
seeing null events returned by poll(). This could explain why
PulseAudio doesn't seem to sleep much. It turns out that we have two
calls to wakeup() in pcm_lib.c, and a nice race condition it seems.
See the log below.

A wake-up is generated during the period interrupt, and a second
wake-up is generated during the write loop, after the application was
awaken but just before the pointers are updated. This second wake-up
shouldn't exist, since the write loop actually fills the ring buffer.
By the time the second wake-up is actually handled, there's really no
space left in the buffer and a null event is generated; it'll wake-up
the application a second time for nothing. Maybe we should move the
call to snd_pcm_update_hw_ptr() after the transfer took place?

Can anyone apply the attached patches (only adds printks) and confirm
this issue on their platforms? That would be very useful.
Happy holidays everyone
- Pierre


alsa-lib/test/pcm --verbose -Dhw -c2 -r48000 -f440  --method write_and_poll

[  371.369865] snd_intel8x0_interrupt
[  371.369876]  snd_intel8x0_update
[  371.369884] snd_pcm_period_elapsed
[  371.369890]  snd_pcm_update_hw_ptr_interrupt
[  371.369900]    snd_pcm_update_hw_ptr_post
[  371.369909]     wakeup in snd_pcm_update_hw_ptr_post
sound/core/pcm_lib.c: 214, avail 8194, avail_min 8192
[  371.369935] ALSA: poll event  POLLOUT|POLLWRNORM, avail 8194 avail_min 8192
[  371.375449] snd_pcm_lib_write1: in
[  371.375457] snd_pcm_lib_write1 loop
[  371.375462]  snd_pcm_update_hw_ptr
[  371.375472]    snd_pcm_update_hw_ptr_post
[  371.375481]     wakeup in snd_pcm_update_hw_ptr_post
sound/core/pcm_lib.c: 214, avail 8462, avail_min 8192

>>Between these two points, the appl_ptr is updated, and there's no space left in the buffer. The wake-up is generated too early.

[  371.375514] snd_pcm_lib_write1: out
[  371.375524] ALSA: null poll event, avail 270 avail_min 8192
[  371.540532] snd_intel8x0_interrupt
[  371.540542]  snd_intel8x0_update
[  371.540551] snd_pcm_period_elapsed
[  371.540556]  snd_pcm_update_hw_ptr_interrupt
[  371.540566]    snd_pcm_update_hw_ptr_post
[  371.540575]     wakeup in snd_pcm_update_hw_ptr_post
sound/core/pcm_lib.c: 214, avail 8194, avail_min 8192
[  371.540601] ALSA: poll event  POLLOUT|POLLWRNORM, avail 8194 avail_min 8192
[  371.543734] snd_pcm_lib_write1: in
[  371.543741] snd_pcm_lib_write1 loop
[  371.543746]  snd_pcm_update_hw_ptr
[  371.543755]    snd_pcm_update_hw_ptr_post
[  371.543764]     wakeup in snd_pcm_update_hw_ptr_post
sound/core/pcm_lib.c: 214, avail 8347, avail_min 8192
[  371.543797] snd_pcm_lib_write1: out
[  371.543807] ALSA: null poll event, avail 155 avail_min 8192

--00151748e89213dc57047b6b2b9c
Content-Type: text/x-patch; charset=US-ASCII; name="core_pcm.patch"
Content-Disposition: attachment; filename="core_pcm.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g3kjqecu0

ZGlmZiAtLWdpdCBhL3NvdW5kL2NvcmUvcGNtX2xpYi5jIGIvc291bmQvY29yZS9wY21fbGliLmMK
aW5kZXggMzBmNDEwOC4uZDZmODMxZiAxMDA2NDQKLS0tIGEvc291bmQvY29yZS9wY21fbGliLmMK
KysrIGIvc291bmQvY29yZS9wY21fbGliLmMKQEAgLTE5MSw2ICsxOTEsOCBAQCBzdGF0aWMgaW50
IHNuZF9wY21fdXBkYXRlX2h3X3B0cl9wb3N0KHN0cnVjdCBzbmRfcGNtX3N1YnN0cmVhbSAqc3Vi
c3RyZWFtLAogewogCXNuZF9wY21fdWZyYW1lc190IGF2YWlsOwogCisgICAgICAgIHByaW50ayhL
RVJOX0VSUiAiICAgc25kX3BjbV91cGRhdGVfaHdfcHRyX3Bvc3QiKTsKKyAgICAgICAgCiAJaWYg
KHN1YnN0cmVhbS0+c3RyZWFtID09IFNORFJWX1BDTV9TVFJFQU1fUExBWUJBQ0spCiAJCWF2YWls
ID0gc25kX3BjbV9wbGF5YmFja19hdmFpbChydW50aW1lKTsKIAllbHNlCkBAIC0yMDgsOCArMjEw
LDEwIEBAIHN0YXRpYyBpbnQgc25kX3BjbV91cGRhdGVfaHdfcHRyX3Bvc3Qoc3RydWN0IHNuZF9w
Y21fc3Vic3RyZWFtICpzdWJzdHJlYW0sCiAJCQlyZXR1cm4gLUVQSVBFOwogCQl9CiAJfQotCWlm
IChhdmFpbCA+PSBydW50aW1lLT5jb250cm9sLT5hdmFpbF9taW4pCisJaWYgKGF2YWlsID49IHJ1
bnRpbWUtPmNvbnRyb2wtPmF2YWlsX21pbikgeworICAgICAgICAgICAgICAgIHByaW50ayhLRVJO
X0VSUiAiICAgIHdha2V1cCBpbiBzbmRfcGNtX3VwZGF0ZV9od19wdHJfcG9zdCAlczogJWQsIGF2
YWlsICVkLCBhdmFpbF9taW4gJWQiLF9fRklMRV9fLF9fTElORV9fLGF2YWlsLHJ1bnRpbWUtPmNv
bnRyb2wtPmF2YWlsX21pbiApOwogCQl3YWtlX3VwKCZydW50aW1lLT5zbGVlcCk7CisgICAgICAg
IH0KIAlyZXR1cm4gMDsKIH0KIApAQCAtMjMxLDYgKzIzNSw4IEBAIHN0YXRpYyBpbnQgc25kX3Bj
bV91cGRhdGVfaHdfcHRyX2ludGVycnVwdChzdHJ1Y3Qgc25kX3BjbV9zdWJzdHJlYW0gKnN1YnN0
cmVhbSkKIAlzbmRfcGNtX3NmcmFtZXNfdCBoZGVsdGEsIGRlbHRhOwogCXVuc2lnbmVkIGxvbmcg
amRlbHRhOwogCisgICAgICAgIHByaW50ayhLRVJOX0VSUiAiIHNuZF9wY21fdXBkYXRlX2h3X3B0
cl9pbnRlcnJ1cHQiKTsKKyAgICAgICAgCiAJb2xkX2h3X3B0ciA9IHJ1bnRpbWUtPnN0YXR1cy0+
aHdfcHRyOwogCXBvcyA9IHNuZF9wY21fdXBkYXRlX2h3X3B0cl9wb3Moc3Vic3RyZWFtLCBydW50
aW1lKTsKIAlpZiAocG9zID09IFNORFJWX1BDTV9QT1NfWFJVTikgewpAQCAtMzYzLDYgKzM2OSw4
IEBAIGludCBzbmRfcGNtX3VwZGF0ZV9od19wdHIoc3RydWN0IHNuZF9wY21fc3Vic3RyZWFtICpz
dWJzdHJlYW0pCiAJc25kX3BjbV9zZnJhbWVzX3QgZGVsdGE7CiAJdW5zaWduZWQgbG9uZyBqZGVs
dGE7CiAKKyAgICAgICAgcHJpbnRrKEtFUk5fRVJSICIgc25kX3BjbV91cGRhdGVfaHdfcHRyIik7
CisgICAgICAgIAogCW9sZF9od19wdHIgPSBydW50aW1lLT5zdGF0dXMtPmh3X3B0cjsKIAlwb3Mg
PSBzbmRfcGNtX3VwZGF0ZV9od19wdHJfcG9zKHN1YnN0cmVhbSwgcnVudGltZSk7CiAJaWYgKHBv
cyA9PSBTTkRSVl9QQ01fUE9TX1hSVU4pIHsKQEAgLTE2MzQsNiArMTY0Miw4IEBAIHZvaWQgc25k
X3BjbV9wZXJpb2RfZWxhcHNlZChzdHJ1Y3Qgc25kX3BjbV9zdWJzdHJlYW0gKnN1YnN0cmVhbSkK
IAlzdHJ1Y3Qgc25kX3BjbV9ydW50aW1lICpydW50aW1lOwogCXVuc2lnbmVkIGxvbmcgZmxhZ3M7
CiAKKyAgICAgICAgcHJpbnRrKEtFUk5fRVJSICJzbmRfcGNtX3BlcmlvZF9lbGFwc2VkIik7Cisg
ICAgICAgIAogCWlmIChQQ01fUlVOVElNRV9DSEVDSyhzdWJzdHJlYW0pKQogCQlyZXR1cm47CiAJ
cnVudGltZSA9IHN1YnN0cmVhbS0+cnVudGltZTsKQEAgLTE3NTYsNiArMTc2Niw4IEBAIHN0YXRp
YyBzbmRfcGNtX3NmcmFtZXNfdCBzbmRfcGNtX2xpYl93cml0ZTEoc3RydWN0IHNuZF9wY21fc3Vi
c3RyZWFtICpzdWJzdHJlYW0sCiAJc25kX3BjbV91ZnJhbWVzX3Qgb2Zmc2V0ID0gMDsKIAlpbnQg
ZXJyID0gMDsKIAorICAgICAgICBwcmludGsoS0VSTl9FUlIgInNuZF9wY21fbGliX3dyaXRlMTog
aW4iKTsKKyAgICAgICAgCiAJaWYgKHNpemUgPT0gMCkKIAkJcmV0dXJuIDA7CiAKQEAgLTE3ODAs
OCArMTc5MiwxMCBAQCBzdGF0aWMgc25kX3BjbV9zZnJhbWVzX3Qgc25kX3BjbV9saWJfd3JpdGUx
KHN0cnVjdCBzbmRfcGNtX3N1YnN0cmVhbSAqc3Vic3RyZWFtLAogCQlzbmRfcGNtX3VmcmFtZXNf
dCBmcmFtZXMsIGFwcGxfcHRyLCBhcHBsX29mczsKIAkJc25kX3BjbV91ZnJhbWVzX3QgYXZhaWw7
CiAJCXNuZF9wY21fdWZyYW1lc190IGNvbnQ7Ci0JCWlmIChydW50aW1lLT5zdGF0dXMtPnN0YXRl
ID09IFNORFJWX1BDTV9TVEFURV9SVU5OSU5HKQotCQkJc25kX3BjbV91cGRhdGVfaHdfcHRyKHN1
YnN0cmVhbSk7CisJCWlmIChydW50aW1lLT5zdGF0dXMtPnN0YXRlID09IFNORFJWX1BDTV9TVEFU
RV9SVU5OSU5HKSB7CisgICAgICAgICAgICAgICAgICAgIHByaW50ayhLRVJOX0VSUiAic25kX3Bj
bV9saWJfd3JpdGUxIGxvb3AiKTsKKyAgICAgICAgICAgICAgICAgICAgc25kX3BjbV91cGRhdGVf
aHdfcHRyKHN1YnN0cmVhbSk7CisgICAgICAgICAgICAgICAgfQogCQlhdmFpbCA9IHNuZF9wY21f
cGxheWJhY2tfYXZhaWwocnVudGltZSk7CiAJCWlmICghYXZhaWwpIHsKIAkJCWlmIChub25ibG9j
aykgewpAQCAtMTgzNiw2ICsxODUwLDcgQEAgc3RhdGljIHNuZF9wY21fc2ZyYW1lc190IHNuZF9w
Y21fbGliX3dyaXRlMShzdHJ1Y3Qgc25kX3BjbV9zdWJzdHJlYW0gKnN1YnN0cmVhbSwKICBfZW5k
X3VubG9jazoKIAlzbmRfcGNtX3N0cmVhbV91bmxvY2tfaXJxKHN1YnN0cmVhbSk7CiAgX2VuZDoK
KyAgICAgICAgcHJpbnRrKEtFUk5fRVJSICJzbmRfcGNtX2xpYl93cml0ZTE6IG91dCIpOwogCXJl
dHVybiB4ZmVyID4gMCA/IChzbmRfcGNtX3NmcmFtZXNfdCl4ZmVyIDogZXJyOwogfQogCkBAIC0x
OTk4LDcgKzIwMTMsMTAgQEAgc3RhdGljIHNuZF9wY21fc2ZyYW1lc190IHNuZF9wY21fbGliX3Jl
YWQxKHN0cnVjdCBzbmRfcGNtX3N1YnN0cmVhbSAqc3Vic3RyZWFtLAogCQlzbmRfcGNtX3VmcmFt
ZXNfdCBhdmFpbDsKIAkJc25kX3BjbV91ZnJhbWVzX3QgY29udDsKIAkJaWYgKHJ1bnRpbWUtPnN0
YXR1cy0+c3RhdGUgPT0gU05EUlZfUENNX1NUQVRFX1JVTk5JTkcpCi0JCQlzbmRfcGNtX3VwZGF0
ZV9od19wdHIoc3Vic3RyZWFtKTsKKyAgICAgICAgICAgICAgICB7CisgICAgICAgICAgICAgICAg
ICAgIHByaW50ayhLRVJOX0VSUiAic25kX3BjbV9saWJfcmVhZDEgbG9vcCIpOworICAgICAgICAg
ICAgICAgICAgICBzbmRfcGNtX3VwZGF0ZV9od19wdHIoc3Vic3RyZWFtKTsKKyAgICAgICAgICAg
ICAgICB9CiAJCWF2YWlsID0gc25kX3BjbV9jYXB0dXJlX2F2YWlsKHJ1bnRpbWUpOwogCQlpZiAo
IWF2YWlsKSB7CiAJCQlpZiAocnVudGltZS0+c3RhdHVzLT5zdGF0ZSA9PQpkaWZmIC0tZ2l0IGEv
c291bmQvY29yZS9wY21fbmF0aXZlLmMgYi9zb3VuZC9jb3JlL3BjbV9uYXRpdmUuYwppbmRleCAy
OWFiNDZhLi4wNDgwNTJhIDEwMDY0NAotLS0gYS9zb3VuZC9jb3JlL3BjbV9uYXRpdmUuYworKysg
Yi9zb3VuZC9jb3JlL3BjbV9uYXRpdmUuYwpAQCAtMjkwMywxMyArMjkwMywxNiBAQCBzdGF0aWMg
dW5zaWduZWQgaW50IHNuZF9wY21fcGxheWJhY2tfcG9sbChzdHJ1Y3QgZmlsZSAqZmlsZSwgcG9s
bF90YWJsZSAqIHdhaXQpCiAJY2FzZSBTTkRSVl9QQ01fU1RBVEVfUEFVU0VEOgogCQlpZiAoYXZh
aWwgPj0gcnVudGltZS0+Y29udHJvbC0+YXZhaWxfbWluKSB7CiAJCQltYXNrID0gUE9MTE9VVCB8
IFBPTExXUk5PUk07CisgICAgICAgICAgICAgICAgICAgICAgICBwcmludGsoS0VSTl9FUlIgIkFM
U0E6IHBvbGwgZXZlbnQgIFBPTExPVVR8UE9MTFdSTk9STSwgYXZhaWwgJWQgYXZhaWxfbWluICVk
IixhdmFpbCxydW50aW1lLT5jb250cm9sLT5hdmFpbF9taW4gKTsKIAkJCWJyZWFrOwogCQl9Cisg
ICAgICAgICAgICAgICAgcHJpbnRrKEtFUk5fRVJSICJBTFNBOiBudWxsIHBvbGwgZXZlbnQsIGF2
YWlsICVkIGF2YWlsX21pbiAlZCIsYXZhaWwscnVudGltZS0+Y29udHJvbC0+YXZhaWxfbWluICk7
CiAJCS8qIEZhbGwgdGhyb3VnaCAqLwogCWNhc2UgU05EUlZfUENNX1NUQVRFX0RSQUlOSU5HOgog
CQltYXNrID0gMDsKIAkJYnJlYWs7CiAJZGVmYXVsdDoKKyAgICAgICAgICAgICAgICBwcmludGso
S0VSTl9FUlIgIkFMU0E6IGRlZmF1bHQsIGF2YWlsICVkIGF2YWlsX21pbiAlZCIsYXZhaWwscnVu
dGltZS0+Y29udHJvbC0+YXZhaWxfbWluICk7CiAJCW1hc2sgPSBQT0xMT1VUIHwgUE9MTFdSTk9S
TSB8IFBPTExFUlI7CiAJCWJyZWFrOwogCX0K
--00151748e89213dc57047b6b2b9c
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--00151748e89213dc57047b6b2b9c--
