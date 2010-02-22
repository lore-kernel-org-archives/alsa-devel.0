From: jassi brar <jassisinghbrar@gmail.com>
Subject: [PATCH 3/3] ASOC: SND_SOC_DAI: Get rid of 'runtime'
	field
Date: Mon, 22 Feb 2010 16:00:20 +0900
Message-ID: <1b68c6791002212300x1530920dq3aaf7db35cecc02d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016e6471a868d010304802afcb4
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id AC68B243A1
	for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2010 08:00:21 +0100 (CET)
Received: by vws13 with SMTP id 13so321349vws.38
	for <alsa-devel@alsa-project.org>; Sun, 21 Feb 2010 23:00:21 -0800 (PST)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

--0016e6471a868d010304802afcb4
Content-Type: text/plain; charset=UTF-8

[PATCH 3/3] ASOC: SND_SOC_DAI: Get rid of 'runtime' field

In order for having snd_soc_dai's shared among two or more dai_links,
remove the relatively global 'runtime' field from the 'struct snd_soc_dai'

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 include/sound/soc-dai.h |    1 -
 sound/soc/soc-core.c    |    2 --
 2 files changed, 0 insertions(+), 3 deletions(-)

--0016e6471a868d010304802afcb4
Content-Type: application/octet-stream;
	name="0003-ASOC-SND_SOC_DAI-Get-rid-of-unused-runtime-paramet.patch"
Content-Disposition: attachment;
	filename="0003-ASOC-SND_SOC_DAI-Get-rid-of-unused-runtime-paramet.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g5yx6ucq0

RnJvbSAyMWQ0ZDI4NjgyNGNhOWRkYzlhN2IzZmZhZjM2MTA3OTJhM2ZlMmY0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKYXNzaSBCcmFyIDxqYXNzaS5icmFyQHNhbXN1bmcuY29tPgpE
YXRlOiBGcmksIDE5IEZlYiAyMDEwIDE3OjU5OjQxICswOTAwClN1YmplY3Q6IFtQQVRDSCAzLzNd
IEFTT0M6IFNORF9TT0NfREFJOiBHZXQgcmlkIG9mICdydW50aW1lJyBmaWVsZAoKSW4gb3JkZXIg
Zm9yIGhhdmluZyBzbmRfc29jX2RhaSdzIHNoYXJlZCBhbW9uZyB0d28gb3IgbW9yZSBkYWlfbGlu
a3MsCnJlbW92ZSB0aGUgcmVsYXRpdmVseSBnbG9iYWwgJ3J1bnRpbWUnIGZpZWxkIGZyb20gdGhl
ICdzdHJ1Y3Qgc25kX3NvY19kYWknCgpTaWduZWQtb2ZmLWJ5OiBKYXNzaSBCcmFyIDxqYXNzaS5i
cmFyQHNhbXN1bmcuY29tPgotLS0KIGluY2x1ZGUvc291bmQvc29jLWRhaS5oIHwgICAgMSAtCiBz
b3VuZC9zb2Mvc29jLWNvcmUuYyAgICB8ICAgIDIgLS0KIDIgZmlsZXMgY2hhbmdlZCwgMCBpbnNl
cnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvc291bmQvc29j
LWRhaS5oIGIvaW5jbHVkZS9zb3VuZC9zb2MtZGFpLmgKaW5kZXggMDYxZjE2ZC4uMjBkZTBiYyAx
MDA2NDQKLS0tIGEvaW5jbHVkZS9zb3VuZC9zb2MtZGFpLmgKKysrIGIvaW5jbHVkZS9zb3VuZC9z
b2MtZGFpLmgKQEAgLTIxNSw3ICsyMTUsNiBAQCBzdHJ1Y3Qgc25kX3NvY19kYWkgewogCXVuc2ln
bmVkIGludCBzeW1tZXRyaWNfcmF0ZXM6MTsKIAogCS8qIERBSSBydW50aW1lIGluZm8gKi8KLQlz
dHJ1Y3Qgc25kX3BjbV9ydW50aW1lICpydW50aW1lOwogCXN0cnVjdCBzbmRfc29jX2NvZGVjICpj
b2RlYzsKIAl1bnNpZ25lZCBpbnQgYWN0aXZlOwogCXVuc2lnbmVkIGNoYXIgcG9wX3dhaXQ6MTsK
ZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9zb2MtY29yZS5jIGIvc291bmQvc29jL3NvYy1jb3JlLmMK
aW5kZXggNTI0YTg1YS4uMTIxNWEwZSAxMDA2NDQKLS0tIGEvc291bmQvc29jL3NvYy1jb3JlLmMK
KysrIGIvc291bmQvc29jL3NvYy1jb3JlLmMKQEAgLTQ1OSw3ICs0NTksNiBAQCBzdGF0aWMgaW50
IHNvY19wY21fb3BlbihzdHJ1Y3Qgc25kX3BjbV9zdWJzdHJlYW0gKnN1YnN0cmVhbSkKIAllbHNl
CiAJCWNwdV9kYWktPmNhcHR1cmUuYWN0aXZlID0gY29kZWNfZGFpLT5jYXB0dXJlLmFjdGl2ZSA9
IDE7CiAJY3B1X2RhaS0+YWN0aXZlID0gY29kZWNfZGFpLT5hY3RpdmUgPSAxOwotCWNwdV9kYWkt
PnJ1bnRpbWUgPSBydW50aW1lOwogCWNhcmQtPmNvZGVjLT5hY3RpdmUrKzsKIAltdXRleF91bmxv
Y2soJnBjbV9tdXRleCk7CiAJcmV0dXJuIDA7CkBAIC01NTksNyArNTU4LDYgQEAgc3RhdGljIGlu
dCBzb2NfY29kZWNfY2xvc2Uoc3RydWN0IHNuZF9wY21fc3Vic3RyZWFtICpzdWJzdHJlYW0pCiAK
IAlpZiAocGxhdGZvcm0tPnBjbV9vcHMtPmNsb3NlKQogCQlwbGF0Zm9ybS0+cGNtX29wcy0+Y2xv
c2Uoc3Vic3RyZWFtKTsKLQljcHVfZGFpLT5ydW50aW1lID0gTlVMTDsKIAogCWlmIChzdWJzdHJl
YW0tPnN0cmVhbSA9PSBTTkRSVl9QQ01fU1RSRUFNX1BMQVlCQUNLKSB7CiAJCS8qIHN0YXJ0IGRl
bGF5ZWQgcG9wIHdxIGhlcmUgZm9yIHBsYXliYWNrIHN0cmVhbXMgKi8KLS0gCjEuNi4yLjUKCg==
--0016e6471a868d010304802afcb4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0016e6471a868d010304802afcb4--
