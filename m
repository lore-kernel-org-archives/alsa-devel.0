From: jassi brar <jassisinghbrar@gmail.com>
Subject: [PATCH 2/3] ASOC: ATMEL: Getting cpu_dai method change
Date: Mon, 22 Feb 2010 15:59:02 +0900
Message-ID: <1b68c6791002212259kc4c0edav2f9d6c6b0d9b51c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636920a05dc521204802af72c
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id F2E522439E
	for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2010 07:59:02 +0100 (CET)
Received: by vws13 with SMTP id 13so320984vws.38
	for <alsa-devel@alsa-project.org>; Sun, 21 Feb 2010 22:59:02 -0800 (PST)
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

--001636920a05dc521204802af72c
Content-Type: text/plain; charset=UTF-8

[PATCH 2/3] ASOC: ATMEL: Getting cpu_dai method change

Currently only the atmel driver make use of snd_soc_dai.runtime field.
If the dais are to be shared among two or more dai_links, the field
must be got rid of.
So, in atmel driver reach the substream via dai_link->pcm so as to
not depend of snd_soc_dai.runtime field.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/atmel/atmel-pcm.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

--001636920a05dc521204802af72c
Content-Type: application/octet-stream;
	name="0002-ASOC-ATMEL-Getting-cpu_dai-method-change.patch"
Content-Disposition: attachment;
	filename="0002-ASOC-ATMEL-Getting-cpu_dai-method-change.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g5yx4oxq0

RnJvbSA5MGMzYWE4NWUxN2Q0NTMzMDg2Y2M3ZjdjZGUxMDAyN2M1ZDY4OTk2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKYXNzaSBCcmFyIDxqYXNzaS5icmFyQHNhbXN1bmcuY29tPgpE
YXRlOiBGcmksIDE5IEZlYiAyMDEwIDE3OjU0OjIxICswOTAwClN1YmplY3Q6IFtQQVRDSCAyLzNd
IEFTT0M6IEFUTUVMOiBHZXR0aW5nIGNwdV9kYWkgbWV0aG9kIGNoYW5nZQoKQ3VycmVudGx5IG9u
bHkgdGhlIGF0bWVsIGRyaXZlciBtYWtlIHVzZSBvZiBzbmRfc29jX2RhaS5ydW50aW1lIGZpZWxk
LgpJZiB0aGUgZGFpcyBhcmUgdG8gYmUgc2hhcmVkIGFtb25nIHR3byBvciBtb3JlIGRhaV9saW5r
cywgdGhlIGZpZWxkCm11c3QgYmUgZ290IHJpZCBvZi4KU28sIGluIGF0bWVsIGRyaXZlciByZWFj
aCB0aGUgc3Vic3RyZWFtIHZpYSBkYWlfbGluay0+cGNtIHNvIGFzIHRvCm5vdCBkZXBlbmQgb2Yg
c25kX3NvY19kYWkucnVudGltZSBmaWVsZC4KClNpZ25lZC1vZmYtYnk6IEphc3NpIEJyYXIgPGph
c3NpLmJyYXJAc2Ftc3VuZy5jb20+Ci0tLQogc291bmQvc29jL2F0bWVsL2F0bWVsLXBjbS5jIHwg
ICAxMiArKysrKysrKy0tLS0KIDEgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA0IGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9hdG1lbC9hdG1lbC1wY20uYyBiL3Nv
dW5kL3NvYy9hdG1lbC9hdG1lbC1wY20uYwppbmRleCA2N2EzMjkyLi5mZGIyNTUzIDEwMDY0NAot
LS0gYS9zb3VuZC9zb2MvYXRtZWwvYXRtZWwtcGNtLmMKKysrIGIvc291bmQvc29jL2F0bWVsL2F0
bWVsLXBjbS5jCkBAIC00MTcsOCArNDE3LDEwIEBAIHN0YXRpYyB2b2lkIGF0bWVsX3BjbV9mcmVl
X2RtYV9idWZmZXJzKHN0cnVjdCBzbmRfcGNtICpwY20pCiAjaWZkZWYgQ09ORklHX1BNCiBzdGF0
aWMgaW50IGF0bWVsX3BjbV9zdXNwZW5kKHN0cnVjdCBzbmRfc29jX2RhaV9saW5rICpkYWlfbGlu
aykKIHsKLQlzdHJ1Y3Qgc25kX3NvY19kYWkgKmRhaSA9IGRhaV9saW5rLT5jcHVfZGFpOwotCXN0
cnVjdCBzbmRfcGNtX3J1bnRpbWUgKnJ1bnRpbWUgPSBkYWktPnJ1bnRpbWU7CisJc3RydWN0IHNu
ZF9wY20gKnBjbSA9IGRhaV9saW5rLT5wY207CisJc3RydWN0IHNuZF9wY21fc3RyICpzdHJlYW0g
PSAmcGNtLT5zdHJlYW1zWzBdOworCXN0cnVjdCBzbmRfcGNtX3N1YnN0cmVhbSAqc3Vic3RyZWFt
ID0gc3RyZWFtLT5zdWJzdHJlYW07CisJc3RydWN0IHNuZF9wY21fcnVudGltZSAqcnVudGltZSA9
IHN1YnN0cmVhbS0+cnVudGltZTsKIAlzdHJ1Y3QgYXRtZWxfcnVudGltZV9kYXRhICpwcnRkOwog
CXN0cnVjdCBhdG1lbF9wY21fZG1hX3BhcmFtcyAqcGFyYW1zOwogCkBAIC00NDIsOCArNDQ0LDEw
IEBAIHN0YXRpYyBpbnQgYXRtZWxfcGNtX3N1c3BlbmQoc3RydWN0IHNuZF9zb2NfZGFpX2xpbmsg
KmRhaV9saW5rKQogCiBzdGF0aWMgaW50IGF0bWVsX3BjbV9yZXN1bWUoc3RydWN0IHNuZF9zb2Nf
ZGFpX2xpbmsgKmRhaV9saW5rKQogewotCXN0cnVjdCBzbmRfc29jX2RhaSAqZGFpID0gZGFpX2xp
bmstPmNwdV9kYWk7Ci0Jc3RydWN0IHNuZF9wY21fcnVudGltZSAqcnVudGltZSA9IGRhaS0+cnVu
dGltZTsKKwlzdHJ1Y3Qgc25kX3BjbSAqcGNtID0gZGFpX2xpbmstPnBjbTsKKwlzdHJ1Y3Qgc25k
X3BjbV9zdHIgKnN0cmVhbSA9ICZwY20tPnN0cmVhbXNbMF07CisJc3RydWN0IHNuZF9wY21fc3Vi
c3RyZWFtICpzdWJzdHJlYW0gPSBzdHJlYW0tPnN1YnN0cmVhbTsKKwlzdHJ1Y3Qgc25kX3BjbV9y
dW50aW1lICpydW50aW1lID0gc3Vic3RyZWFtLT5ydW50aW1lOwogCXN0cnVjdCBhdG1lbF9ydW50
aW1lX2RhdGEgKnBydGQ7CiAJc3RydWN0IGF0bWVsX3BjbV9kbWFfcGFyYW1zICpwYXJhbXM7CiAK
LS0gCjEuNi4yLjUKCg==
--001636920a05dc521204802af72c
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--001636920a05dc521204802af72c--
