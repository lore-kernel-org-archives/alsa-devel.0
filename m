From: pl bossart <bossart.nospam@gmail.com>
Subject: UCM list/set/get
Date: Fri, 28 Jan 2011 11:36:47 -0600
Message-ID: <AANLkTi=pwNpK-c+h_xSkiQG8V8nhLZs-9X8+DceDw0S3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0022150482b7addd4a049aeb821c
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6EEF92433F
	for <alsa-devel@alsa-project.org>; Fri, 28 Jan 2011 18:36:49 +0100 (CET)
Received: by iye19 with SMTP id 19so3063741iye.38
	for <alsa-devel@alsa-project.org>; Fri, 28 Jan 2011 09:36:47 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--0022150482b7addd4a049aeb821c
Content-Type: text/plain; charset=ISO-8859-1

I've been trying to figure out what exactly needs to be filled in UCM
configuration files, and so far it's been a pretty frustrating
experience with alsa-utils/alsaucm :-(

The interactive mode in alsa-utils/alsaucm is broken, I fixed a couple
of segfaults and bad output (patches attached), but so far the only
thing I can do is list the verbs...It looks like
alsa-lib/include/use-case.h and alsa-utils/alsaucm are not aligned,
whenever I query with predefined identifiers alsaucm seg faults or
provides an error message that doesn't help much. This happens with
the latest code.

[ume@plb alsaucm]$ ./alsaucm listcards
  0: AudioPC
    this is my AudioPCI card
  1: SDP4430
    this is my SDP4430 card
  2: TestHDA
    A test HDA card
[ume@plb alsaucm]$ ./alsaucm -c AudioPCI list _verbs
  0: HiFi
    Play and record HiFi quality Music.
  1: Voice
    Full duplex low-power voice call

So far so good. Now the fun begins

[ume@plb alsaucm]$ ./alsaucm -c AudioPCI list _devices
./alsaucm: error failed to get list _devices: No such file or directory
[ume@plb alsaucm]$ ./alsaucm -c AudioPCI set _verb HiFi
ALSA lib main.c:1250:(set_verb_user) error: failed to initialize new
use case: HiFi
./alsaucm: error failed to set _verb=HiFi: No such device
[ume@plb alsaucm]$ ./alsaucm -c AudioPCI get _verb
./alsaucm: error failed to get _verb: No such file or directory

Likewise if the .conf file contains a cset in the default values, then
the parser fails (I took the example from src/ucm/parser.c).
Commenting out the cset is the only solution. What exactly is this
index supposed to mean?
SectionDefaults [
cdev "hw:AudioPCI"
cset "name='Master Playback Switch',index=2 1,1"
]

[ume@plb alsaucm]$ ./alsaucm -c AudioPCI list _verbs
ALSA lib main.c:302:(import_master_config) Unable to execute default sequence
ALSA lib main.c:637:(snd_use_case_mgr_open) error: failed to import
AudioPCI use case configuration -19
./alsaucm: error failed to open sound card AudioPCI: No such device

Ideally I'd like to write an interface between PulseAudio and UCM,
there are existing modules I can reuse to set voice or hifi modes,
depending on what the client roles are. But if I can't make the
examples work I don't think this is going to go anywhere.
-Pierre

--0022150482b7addd4a049aeb821c
Content-Type: application/octet-stream;
	name="0001-ucm-make-verb-comments-optional.patch"
Content-Disposition: attachment;
	filename="0001-ucm-make-verb-comments-optional.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gjhcu4o90

RnJvbSBkYmQ5N2Y0M2E1YmFjZjQwNDI0YTk4NjU1NmU1NTMyNjdiMGFmZGIyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQaWVycmUtTG91aXMgQm9zc2FydCA8cGllcnJlLWxvdWlzLmJv
c3NhcnRAaW50ZWwuY29tPgpEYXRlOiBUaHUsIDI3IEphbiAyMDExIDIzOjE3OjQzIC0wNjAwClN1
YmplY3Q6IFtQQVRDSF0gdWNtOiBtYWtlIHZlcmIgY29tbWVudHMgb3B0aW9uYWwKCmF2b2lkIHNl
ZyBmYXVsdCBpZiBubyBjb21tZW50IGlzIHByb3ZpZGVkCgpTaWduZWQtb2ZmLWJ5OiBQaWVycmUt
TG91aXMgQm9zc2FydCA8cGllcnJlLWxvdWlzLmJvc3NhcnRAaW50ZWwuY29tPgotLS0KIHNyYy91
Y20vcGFyc2VyLmMgfCAgIDExICsrKysrKysrLS0tCiAxIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0
aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zcmMvdWNtL3BhcnNlci5jIGIv
c3JjL3VjbS9wYXJzZXIuYwppbmRleCBmM2E3NWU2Li41NjBjMjI0IDEwMDY0NAotLS0gYS9zcmMv
dWNtL3BhcnNlci5jCisrKyBiL3NyYy91Y20vcGFyc2VyLmMKQEAgLTc3NywxMiArNzc3LDE3IEBA
IHN0YXRpYyBpbnQgcGFyc2VfdmVyYl9maWxlKHNuZF91c2VfY2FzZV9tZ3JfdCAqdWNfbWdyLAog
CUlOSVRfTElTVF9IRUFEKCZ2ZXJiLT5tb2RpZmllcl9saXN0KTsKIAlJTklUX0xJU1RfSEVBRCgm
dmVyYi0+dmFsdWVfbGlzdCk7CiAJbGlzdF9hZGRfdGFpbCgmdmVyYi0+bGlzdCwgJnVjX21nci0+
dmVyYl9saXN0KTsKKyAgICAgICAgaWYgKHVzZV9jYXNlX25hbWUgPT0gTlVMTCApCisgICAgICAg
ICAgICAgICAgcmV0dXJuIC1FSU5WQUw7CiAJdmVyYi0+bmFtZSA9IHN0cmR1cCh1c2VfY2FzZV9u
YW1lKTsKIAlpZiAodmVyYi0+bmFtZSA9PSBOVUxMKQogCQlyZXR1cm4gLUVOT01FTTsKLQl2ZXJi
LT5jb21tZW50ID0gc3RyZHVwKGNvbW1lbnQpOwotCWlmICh2ZXJiLT5jb21tZW50ID09IE5VTEwp
Ci0JCXJldHVybiAtRU5PTUVNOworCisgICAgICAgIGlmIChjb21tZW50ICE9IE5VTEwpIHsKKyAg
ICAgICAgICAgICAgICB2ZXJiLT5jb21tZW50ID0gc3RyZHVwKGNvbW1lbnQpOworICAgICAgICAg
ICAgICAgIGlmICh2ZXJiLT5jb21tZW50ID09IE5VTEwpCisgICAgICAgICAgICAgICAgICAgICAg
ICByZXR1cm4gLUVOT01FTTsKKyAgICAgICAgfQogCiAJLyogb3BlbiBWZXJiIGZpbGUgZm9yIHJl
YWRpbmcgKi8KIAlzbnByaW50ZihmaWxlbmFtZSwgc2l6ZW9mKGZpbGVuYW1lKSwgIiVzLyVzLyVz
IiwKLS0gCjEuNy4zLjIKCg==
--0022150482b7addd4a049aeb821c
Content-Type: application/octet-stream;
	name="0001-alsaucm-fix-list-command-and-output.patch"
Content-Disposition: attachment;
	filename="0001-alsaucm-fix-list-command-and-output.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gjhcxyvv1

RnJvbSBmNDJmNjA3OTcyZjU5Y2NiZDhiZDY3MDM3YjQyMmRiNDhhODI4YzNjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQaWVycmUtTG91aXMgQm9zc2FydCA8cGllcnJlLWxvdWlzLmJv
c3NhcnRAaW50ZWwuY29tPgpEYXRlOiBUaHUsIDI3IEphbiAyMDExIDIzOjE0OjQ0IC0wNjAwClN1
YmplY3Q6IFtQQVRDSF0gYWxzYXVjbTogZml4IGxpc3QgY29tbWFuZCBhbmQgb3V0cHV0CgphZGQg
b25lIGFyZ3VtZW50IHRvIGxpc3QgdG8gYXZvaWQgZXJyb3IgbWVzc2FnZSwgZG8gbm90IGxpc3QK
Y29tbWVudHMgYXMgdmVyYnMKClNpZ25lZC1vZmYtYnk6IFBpZXJyZS1Mb3VpcyBCb3NzYXJ0IDxw
aWVycmUtbG91aXMuYm9zc2FydEBpbnRlbC5jb20+Ci0tLQogYWxzYXVjbS91c2VjYXNlLmMgfCAg
IDEwICsrKysrKystLS0KIDEgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAzIGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Fsc2F1Y20vdXNlY2FzZS5jIGIvYWxzYXVjbS91c2VjYXNl
LmMKaW5kZXggYmI4OTRjNi4uOGEyNTViYSAxMDA2NDQKLS0tIGEvYWxzYXVjbS91c2VjYXNlLmMK
KysrIGIvYWxzYXVjbS91c2VjYXNlLmMKQEAgLTg1LDcgKzg1LDcgQEAgc3RhdGljIHN0cnVjdCBj
bWQgY21kc1tdID0gewogCXsgT01fUkVTRVQsIDAsIDEsICJyZXNldCIgfSwKIAl7IE9NX1JFTE9B
RCwgMCwgMSwgInJlbG9hZCIgfSwKIAl7IE9NX0xJU1RDQVJEUywgMCwgMCwgImxpc3RjYXJkcyIg
fSwKLQl7IE9NX0xJU1QsIDAsIDEsICJsaXN0IiB9LAorCXsgT01fTElTVCwgMSwgMSwgImxpc3Qi
IH0sCiAJeyBPTV9TRVQsIDIsIDEsICJzZXQiIH0sCiAJeyBPTV9HRVQsIDEsIDEsICJnZXQiIH0s
CiAJeyBPTV9HRVRJLCAxLCAxLCAiZ2V0aSIgfSwKQEAgLTIzMiw4ICsyMzIsMTIgQEAgc3RhdGlj
IGludCBkb19vbmUoc3RydWN0IGNvbnRleHQgKmNvbnRleHQsIHN0cnVjdCBjbWQgKmNtZCwgY2hh
ciAqKmFyZ3YpCiAJCX0KIAkJaWYgKGVyciA9PSAwKQogCQkJcHJpbnRmKCIgIGxpc3QgaXMgZW1w
dHlcbiIpOwotCQlmb3IgKGkgPSAwOyBpIDwgZXJyOyBpKyspCi0JCQlwcmludGYoIiAgJWk6ICVz
XG4iLCBpLCBsaXN0W2ldKTsKKwkJZm9yIChpID0gMDsgaSA8IGVyciAvIDI7IGkrKykgeworCQkJ
cHJpbnRmKCIgICVpOiAlc1xuIiwgaSwgbGlzdFtpKjJdKTsKKyAgICAgICAgICAgICAgICAgICAg
ICAgIGlmIChsaXN0W2kqMisxXSkKKwkJCQlwcmludGYoIiAgICAlc1xuIiwgbGlzdFtpKjIrMV0p
OworICAgICAgICAgICAgICAgIH0KKwogCQlzbmRfdXNlX2Nhc2VfZnJlZV9saXN0KGxpc3QsIGVy
cik7CiAJCWJyZWFrOwogCWNhc2UgT01fU0VUOgotLSAKMS43LjMuMgoK
--0022150482b7addd4a049aeb821c
Content-Type: application/octet-stream; name="AudioPCI.conf"
Content-Disposition: attachment; filename="AudioPCI.conf"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gjhcz2t12

Q29tbWVudCAidGhpcyBpcyBteSBBdWRpb1BDSSBjYXJkIgoKU2VjdGlvblVzZUNhc2UuIkhpRmki
IHsKIAkJRmlsZSAiaGlmaSIKIAkJQ29tbWVudCAiUGxheSBhbmQgcmVjb3JkIEhpRmkgcXVhbGl0
eSBNdXNpYy4iCn0KClNlY3Rpb25Vc2VDYXNlLiJWb2ljZSIgewogCQlGaWxlICJ2b2ljZSIKIAkJ
Q29tbWVudCAiRnVsbCBkdXBsZXggbG93LXBvd2VyIHZvaWNlIGNhbGwiCn0KClZhbHVlRGVmYXVs
dHMgewogCVBsYXliYWNrQ1RMICJodzpDQVJEPTAiCiAJQ2FwdHVyZUNUTCAiaHc6Q0FSRD0wIgp9
CgojIFRoaXMgZmlsZSBhbHNvIHN0b3JlIHRoZSBkZWZhdWx0IHNvdW5kIGNhcmQgc3RhdGUuCgpT
ZWN0aW9uRGVmYXVsdHMgWwpjZGV2ICJodzpBdWRpb1BDSSIKI2NzZXQgIm5hbWU9J01hc3RlciBQ
bGF5YmFjayBTd2l0Y2gnLGluZGV4PTIgMSwxIgojY3NldCAibmFtZT0nTWFzdGVyIFBsYXliYWNr
IFZvbHVtZScsaW5kZXg9MiAyNSwyNSIKI2NzZXQgIm5hbWU9J01hc3RlciBNb25vIFBsYXliYWNr
JyxpbmRleD0xIDAiCiNjc2V0ICJuYW1lPSdNYXN0ZXIgTW9ubyBQbGF5YmFjayBWb2x1bWUnLGlu
ZGV4PTEgMCIKI2NzZXQgIm5hbWU9J1BDTSBTd2l0Y2gnLGluZGV4PTIgMSwxIgojY3NldCAibmFt
ZT0nTWFzdGVyIFBsYXliYWNrIFN3aXRjaCcgMSwxIgojY3NldCAibmFtZT0nTWFzdGVyIFBsYXli
YWNrIFZvbHVtZScgMTAsMjUiCiNjc2V0ICJuYW1lPSdNYXN0ZXIgTW9ubyBQbGF5YmFjayBTd2l0
Y2gnIDAiCiNjc2V0ICJuYW1lPSdNYXN0ZXIgTW9ubyBQbGF5YmFjayBWb2x1bWUnIDAiCiNjc2V0
ICJuYW1lPSdQQ00gU3dpdGNoJyAxLDEiCiNjc2V0ICJuYW1lPSdQQ00gVm9sdW1lJyAyNSwyNSIK
I2NzZXQgIm5hbWU9J1BDTSBQbGF5YmFjayBTd2l0Y2gnIDEsMSIKI2NzZXQgIm5hbWU9J1BDTSBD
YXB0dXJlIFN3aXRjaCcgMCwwIgpdCgo=
--0022150482b7addd4a049aeb821c
Content-Type: application/octet-stream; name=hifi
Content-Disposition: attachment; filename=hifi
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gjhdcor73

U2VjdGlvblZlcmIgewoJIyBlbmFibGUgYW5kIGRpc2FibGUgc2VxdWVuY2VzIGFyZSBjb21wdWxz
b3J5CglFbmFibGVTZXF1ZW5jZSBbCgkJY2RldiAiaHc6QXVkaW9QQ0kiCgkJY3NldCAibmFtZT0n
TWFzdGVyIFBsYXliYWNrIFN3aXRjaCcsaW5kZXg9MiAwLDAiCgkJY3NldCAibmFtZT0nTWFzdGVy
IFBsYXliYWNrIFZvbHVtZScsaW5kZXg9MiAyNSwyNSIKCQkjbXNsZWVwIDUwCgkJY3NldCAibmFt
ZT0nTWFzdGVyIFBsYXliYWNrIFN3aXRjaCcsaW5kZXg9MiAxLDEiCgkJY3NldCAibmFtZT0nTWFz
dGVyIFBsYXliYWNrIFZvbHVtZScsaW5kZXg9MiA1MCw1MCIKCV0KCglEaXNhYmxlU2VxdWVuY2Ug
WwoJCWNkZXYgImh3OkF1ZGlvUENJIgoJCWNzZXQgIm5hbWU9J01hc3RlciBQbGF5YmFjayBTd2l0
Y2gnLGluZGV4PTIgMCwwIgoJCWNzZXQgIm5hbWU9J01hc3RlciBQbGF5YmFjayBWb2x1bWUnLGlu
ZGV4PTIgMjUsMjUiCgkJI21zbGVlcCA1MAoJCWNzZXQgIm5hbWU9J01hc3RlciBQbGF5YmFjayBT
d2l0Y2gnLGluZGV4PTIgMSwxIgoJCWNzZXQgIm5hbWU9J01hc3RlciBQbGF5YmFjayBWb2x1bWUn
LGluZGV4PTIgNTAsNTAiCgldCgogICAgICMgT3B0aW9uYWwgdHJhbnNpdGlvbiB2ZXJiCiMgICAg
IFRyYW5zaXRpb25TZXF1ZW5jZS4iVG9DYXNlTmFtZSIgWwojCQltc2xlZXAgMQojICAgICBdCgoJ
IyBPcHRpb25hbCBUUSBhbmQgQUxTQSBQQ01zCglWYWx1ZSB7CgkJVFEgSGlGaQoJCUNhcHR1cmVQ
Q00gImh3OjAiCgkJUGxheWJhY2tQQ00gImh3OjAiCgl9Cn0KClNlY3Rpb25EZXZpY2UuIkhlYWRw
aG9uZXMiLjAgewoJCglFbmFibGVTZXF1ZW5jZSBbCgkJY2RldiAiaHc6QXVkaW9QQ0kiCgkJY3Nl
dCAibmFtZT0nUENNIENhcHR1cmUgU3dpdGNoJyAxLDEiCgldCgoJRGlzYWJsZVNlcXVlbmNlIFsK
CQljZGV2ICJodzpBdWRpb1BDSSIKCQljc2V0ICJuYW1lPSdQQ00gQ2FwdHVyZSBTd2l0Y2gnIDAs
MCIKCV0KCgkjIHRoZSBoYXJkd2FyZSB2b2x1bWUgY29udHJvbHMgZm9yIHRoaXMgZGV2aWNlCglQ
bGF5YmFja1ZvbHVtZSAibmFtZT0nTWFzdGVyIFBsYXliYWNrIFZvbHVtZScsaW5kZXg9MiIKCVBs
YXliYWNrU3dpdGNoICJuYW1lPSdNYXN0ZXIgUGxheWJhY2sgU3dpdGNoJyxpbmRleD0yIgp9Cgo=
--0022150482b7addd4a049aeb821c
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0022150482b7addd4a049aeb821c--
