From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: [[PATCH] ALSA 1/1] Fix alsa-lib to regard 3D control -
 Depth as Playback Controls
Date: Sat, 26 Feb 2011 09:41:38 +0800
Message-ID: <AANLkTikUE8r-DtNMRZiQzc0wyeXczZaJFJSOZvxFdXXn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf3054a38f369a6f049d258c66
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id DA7972439C
	for <alsa-devel@alsa-project.org>; Sat, 26 Feb 2011 02:41:38 +0100 (CET)
Received: by fxm11 with SMTP id 11so2147829fxm.38
	for <alsa-devel@alsa-project.org>; Fri, 25 Feb 2011 17:41:38 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

--20cf3054a38f369a6f049d258c66
Content-Type: text/plain; charset=ISO-8859-1

Fix alsa-lib to regard 3D control - Depth as Playback Controls

This allow those mixer or recording application to find those controls which
are really used for capturing

--20cf3054a38f369a6f049d258c66
Content-Type: application/octet-stream;
	name="0001-Fix-alsa-lib-to-regard-3D-control-Depth-as-Playback-control.patch"
Content-Disposition: attachment;
	filename="0001-Fix-alsa-lib-to-regard-3D-control-Depth-as-Playback-control.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gklv3myj0

RnJvbSAxODI4MmZiMzViZTA3MGRjODVlNTYzZDczZjYzOWZiNTI5ODgyYjliIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYXltb25kIFlhdSA8c3VwZXJxdWFkLnZvcnRleDJAZ21haWwu
Y29tPgpEYXRlOiBTYXQsIDI2IEZlYiAyMDExIDA5OjI0OjQzICswODAwClN1YmplY3Q6IFtbUEFU
Q0hdIEFMU0EgIDEvMV0gRml4IGFsc2EtbGliIHRvIHJlZ2FyZCAzRCBjb250cm9sIC0gRGVwdGgg
YXMgUGxheWJhY2sgQ29udHJvbHMKCgpTaWduZWQtb2ZmLWJ5OiBSYXltb25kIFlhdSA8c3VwZXJx
dWFkLnZvcnRleDJAZ21haWwuY29tPgoKZGlmZiAtLWdpdCBhL3NyYy9taXhlci9zaW1wbGVfbm9u
ZS5jIGIvc3JjL21peGVyL3NpbXBsZV9ub25lLmMKaW5kZXggNDI2ZjJkNy4uMzk1ZTRkNiAxMDA2
NDQKLS0tIGEvc3JjL21peGVyL3NpbXBsZV9ub25lLmMKKysrIGIvc3JjL21peGVyL3NpbXBsZV9u
b25lLmMKQEAgLTkzNyw3ICs5MzcsMTIgQEAgc3RhdGljIGludCBiYXNlX2xlbihjb25zdCBjaGFy
ICpuYW1lLCBzZWxlbV9jdGxfdHlwZV90ICp0eXBlKQogCQkqdHlwZSA9IENUTF9DQVBUVVJFX1JP
VVRFOwogCQlyZXR1cm4gc3RybGVuKG5hbWUpOwogCX0KLQorCWlmIChzdHJzdHIobmFtZSwgIjNE
IENvbnRyb2wiKSA+IDApIHsKKwkJaWYgKHN0cnN0cihuYW1lLCAiRGVwdGgiKSA+IDApIHsKKwkJ
CSp0eXBlID0gQ1RMX1BMQVlCQUNLX1ZPTFVNRTsKKwkJCXJldHVybiBzdHJsZW4obmFtZSk7CisJ
CX0KKwl9CiAJcmV0dXJuIDA7CiB9CiAKLS0gCjEuNi4wLjYKCg==
--20cf3054a38f369a6f049d258c66
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--20cf3054a38f369a6f049d258c66--
