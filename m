From: pl bossart <bossart.nospam@gmail.com>
Subject: [RFC] disabling ALSA period interrupts
Date: Thu, 29 Apr 2010 17:38:50 -0500
Message-ID: <h2l6160a5131004291538w6c7891fbn2db3425846aefd60@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016e644ded6657365048567ca28
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f189.google.com (mail-iw0-f189.google.com
	[209.85.223.189])
	by alsa0.perex.cz (Postfix) with ESMTP id 9A6511038BF
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Apr 2010 00:38:53 +0200 (CEST)
Received: by iwn27 with SMTP id 27so9483034iwn.5
	for <alsa-devel@alsa-project.org>; Thu, 29 Apr 2010 15:38:50 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, General PulseAudio Discussion <pulseaudio-discuss@mail.0pointer.de>
List-Id: alsa-devel@alsa-project.org

--0016e644ded6657365048567ca28
Content-Type: text/plain; charset=ISO-8859-1

Howdy,
When PulseAudio is used and all PCM is routed through PulseAudio
(Fedora, Meego, etc), the notion of ALSA periods isn't very useful.
PulseAudio uses a timer to refill buffers and the period interrupts
are not used at all.

So why not disable them entirely to reduce the number of wakeups? This
is possible with a number of existing DMA controllers. The simple
patch attached shows a proof-of-concept on HDAudio, it's been working
for 5 hours on my Fedora12 laptop without any glitches and powertop
does show _zero_ wakeups from the HDAudio controller (except on
startup). I am told by my colleagues working in Windows environments
that this is what's done on Vista/Windows7 btw. This isn't to say
Windows is great but that artificial generation of not-needed
interrupts is avoidable.

There are probably some cases where you don't want this type of
behavior (broken hardware, legacy code with multiple-buffering,
disabled timer in PulseAudio), so I think it would make sense to
request the disabling of interrupts when hw_params are set, since this
is also the time when period sizes are set. I am aware that some
changes would be needed in pcm_lib.c, where all the error checks are
done. Takashi, Jaroslav, Lennart, what do you think?
Feedback and suggestions welcome.
Cheers
- Pierre

--0016e644ded6657365048567ca28
Content-Type: application/octet-stream;
	name="0001-hda-remove-HDA-interrupts-when-buffer-is-processed.patch"
Content-Disposition: attachment;
	filename="0001-hda-remove-HDA-interrupts-when-buffer-is-processed.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g8m54va00

RnJvbSAxZWRjNDAyZGMwYTFmNDQxMTdiOTEwZTRhNDJjNWY2ZTZiYzZiMjdmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQaWVycmUtTG91aXMgQm9zc2FydCA8cGllcnJlLWxvdWlzLmJv
c3NhcnRAaW50ZWwuY29tPgpEYXRlOiBUaHUsIDI5IEFwciAyMDEwIDE3OjAwOjU5IC0wNTAwClN1
YmplY3Q6IFtQQVRDSF0gW2hkYV0gcmVtb3ZlIEhEQSBpbnRlcnJ1cHRzIHdoZW4gYnVmZmVyIGlz
IHByb2Nlc3NlZAogVGhpcyBwYXRjaCBhc3N1bWVzIGEgdGltZXIgaXMgdXNlZCB0byB3YWtlLXVw
IHRoZSBzeXN0ZW0gYW5kIHJlZmlsbCBidWZmZXJzCiAoYXMgUHVsc2VBdWRpbyBkb2VzKQoKLS0t
CiBjb3JlL3BjbV9saWIuYyAgICAgIHwgICAgMiArKwogcGNpL2hkYS9oZGFfaW50ZWwuYyB8ICAg
MTQgKysrKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgMCBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9jb3JlL3BjbV9saWIuYyBiL2NvcmUvcGNtX2xpYi5j
CmluZGV4IGEyZmY4NjEuLmQxZDVmNzcgMTAwNjQ0Ci0tLSBhL2NvcmUvcGNtX2xpYi5jCisrKyBi
L2NvcmUvcGNtX2xpYi5jCkBAIC00MjAsNiArNDIwLDcgQEAgc3RhdGljIGludCBzbmRfcGNtX3Vw
ZGF0ZV9od19wdHIwKHN0cnVjdCBzbmRfcGNtX3N1YnN0cmVhbSAqc3Vic3RyZWFtLAogCQlod19i
YXNlID0gbmV3X2h3X3B0ciAtIChuZXdfaHdfcHRyICUgcnVudGltZS0+YnVmZmVyX3NpemUpOwog
CX0KICBub19qaWZmaWVzX2NoZWNrOgorI2lmIDAgLy8gc2tpcCB3aGVuIGludGVycnVwdHMgYXJl
IG5vdCBlbmFibGVkCiAJaWYgKGRlbHRhID4gcnVudGltZS0+cGVyaW9kX3NpemUgKyBydW50aW1l
LT5wZXJpb2Rfc2l6ZSAvIDIpIHsKIAkJaHdfcHRyX2Vycm9yKHN1YnN0cmVhbSwKIAkJCSAgICAg
Ikxvc3QgaW50ZXJydXB0cz8gJXMiCkBAIC00MzAsNiArNDMxLDcgQEAgc3RhdGljIGludCBzbmRf
cGNtX3VwZGF0ZV9od19wdHIwKHN0cnVjdCBzbmRfcGNtX3N1YnN0cmVhbSAqc3Vic3RyZWFtLAog
CQkJICAgICAobG9uZyluZXdfaHdfcHRyLAogCQkJICAgICAobG9uZylvbGRfaHdfcHRyKTsKIAl9
CisjZW5kaWYKIAogCWlmIChydW50aW1lLT5zdGF0dXMtPmh3X3B0ciA9PSBuZXdfaHdfcHRyKQog
CQlyZXR1cm4gMDsKZGlmZiAtLWdpdCBhL3BjaS9oZGEvaGRhX2ludGVsLmMgYi9wY2kvaGRhL2hk
YV9pbnRlbC5jCmluZGV4IDhiNjgxNWQuLmM2NDEwNmUgMTAwNjQ0Ci0tLSBhL3BjaS9oZGEvaGRh
X2ludGVsLmMKKysrIGIvcGNpL2hkYS9oZGFfaW50ZWwuYwpAQCAtMTE1OCw2ICsxMTU4LDExIEBA
IHN0YXRpYyBpbnQgc2V0dXBfYmRsZShzdHJ1Y3Qgc25kX3BjbV9zdWJzdHJlYW0gKnN1YnN0cmVh
bSwKIHsKIAl1MzIgKmJkbCA9ICpiZGxwOwogCisjZGVmaW5lIE5PX0lOVEVSUlVQVFMKKyNpZmRl
ZiAgTk9fSU5URVJSVVBUUworICAgIHNuZF9wcmludGsoS0VSTl9FUlIgU0ZYICJwbGItIHNldHVw
X2JkbGU6IGludGVycnVwdHMgZGlzYWJsZWRcbiIpOworI2VuZGlmCisKIAl3aGlsZSAoc2l6ZSA+
IDApIHsKIAkJZG1hX2FkZHJfdCBhZGRyOwogCQlpbnQgY2h1bms7CkBAIC0xMTc2LDcgKzExODEs
MTMgQEAgc3RhdGljIGludCBzZXR1cF9iZGxlKHN0cnVjdCBzbmRfcGNtX3N1YnN0cmVhbSAqc3Vi
c3RyZWFtLAogCQkgKiBvbmx5IHdoZW4gdGhlIHdob2xlIGZyYWdtZW50IGlzIHByb2Nlc3NlZAog
CQkgKi8KIAkJc2l6ZSAtPSBjaHVuazsKKworI2lmZGVmIE5PX0lOVEVSUlVQVFMKKwkJYmRsWzNd
ID0gMDsgLyogbm8gaW50ZXJydXB0cyB3aGVuIGJ1ZmZlciBpcyBwcm9jZXNzZWQgKi8KKyNlbHNl
CiAJCWJkbFszXSA9IChzaXplIHx8ICF3aXRoX2lvYykgPyAwIDogY3B1X3RvX2xlMzIoMHgwMSk7
CisjZW5kaWYKKwogCQliZGwgKz0gNDsKIAkJYXp4X2Rldi0+ZnJhZ3MrKzsKIAkJb2ZzICs9IGNo
dW5rOwpAQCAtMTkzNyw2ICsxOTQ4LDkgQEAgc3RhdGljIHZvaWQgYXp4X2lycV9wZW5kaW5nX3dv
cmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQogCQkJaWYgKGF6eF9wb3NpdGlvbl9vayhjaGlw
LCBhenhfZGV2KSkgewogCQkJCWF6eF9kZXYtPmlycV9wZW5kaW5nID0gMDsKIAkJCQlzcGluX3Vu
bG9jaygmY2hpcC0+cmVnX2xvY2spOworI2lmZGVmIE5PX0lOVEVSUlVQVFMKKwkJCQlzbmRfcHJp
bnRrKEtFUk5fRVJSIFNGWCAicGxiLSBwZXJpb2QgZWxhcHNlZDogVEhJUyBTSE9VTEQgTk9UIEhB
UFBFTiBcbiIpOworI2VuZGlmCiAJCQkJc25kX3BjbV9wZXJpb2RfZWxhcHNlZChhenhfZGV2LT5z
dWJzdHJlYW0pOwogCQkJCXNwaW5fbG9jaygmY2hpcC0+cmVnX2xvY2spOwogCQkJfSBlbHNlCi0t
IAoxLjYuNi4xCgo=
--0016e644ded6657365048567ca28
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0016e644ded6657365048567ca28--
