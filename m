From: =?UTF-8?q?Andreas=20Irest=C3=A5l?= <andreas.irestal@axis.com>
Subject: [PATCH 0/4] ASoC: adau17x1: Minor fixes and DT support
Date: Tue,  2 Feb 2016 15:31:46 +0100
Message-ID: <1454423510-1330-1-git-send-email-andire@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F96B26523B
 for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2016 15:32:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by bes.se.axis.com (Postfix) with ESMTP id 62BB32E309
 for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2016 15:32:31 +0100 (CET)
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
 by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id w2iq8zBvhCVn for <alsa-devel@alsa-project.org>;
 Tue,  2 Feb 2016 15:32:27 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
 by bes.se.axis.com (Postfix) with ESMTP id 528692E342
 for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2016 15:32:27 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
 by postfix.imss71 (Postfix) with ESMTP id 24781167A
 for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2016 15:32:27 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
 by boulder.se.axis.com (Postfix) with ESMTP id 1650DC1E
 for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2016 15:32:27 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: =?UTF-8?q?Andreas=20Irest=C3=A5l?= <andire@axis.com>
List-Id: alsa-devel@alsa-project.org

VGhpcyBzZXQgb2YgcGF0Y2hlcyBmaXhlcyBzb21lIG1pbm9yIHR5cG9zIGFuZCBhZGRzIERUIHN1
cHBvcnQgZm9yIHRoZQphZGF1MTd4MSBjb2RlYyBkcml2ZXJzLiBJJ3ZlIG9ubHkgYmVlbiBhYmxl
IHRvIHRlc3QgdGhlIDE3NjEgcGFydCBvbgpyZWFsIGhhcmR3YXJlIHNpbmNlIEkgZG9uJ3QgaGF2
ZSBhbnkgYWRhdTE3ODEgaGFyZHdhcmUgYXQgdGhlIG1vbWVudC4KCkN1cnJlbnRseSwgcXVpdGUg
YSBsb3Qgb2Ygb3B0aW9ucyBhcmUgcHJvdmlkZWQgdGhyb3VnaCB0aGUgcGxhdGZvcm1fZGF0YQpz
dHJ1Y3QsIHNvIGl0IG1hZGUgc2Vuc2UgcGFyc2luZyB0aGUgRFQgYW5kIGNyZWF0ZSBhIHBsYXRm
b3JtX2RhdGEgc3RydWN0CmZyb20gdGhlc2UgcGFyYW1ldGVycyBub3QgdG8gYnJlYWsgYW55dGhp
bmcuIEkndmUgcGVla2VkIGF0IGEgZmV3IG90aGVyCmRyaXZlcnMgYW5kIHRoZSBUSSB0bHYzMjBh
aWMzMXh4IGRyaXZlciB3b3JrcyB0aGlzIHdheSBhcyB3ZWxsLgoKQW5kcmVhcyBJcmVzdMOlbCAo
NCk6CiAgQVNvQzogYWRhdTE3eDE6IEZpeCBpbmNvcnJlY3QgQkNMSyByYXRpbyBkZWZpbml0aW9u
cwogIEFTb2M6IGFkYXUxN3gxOiBDb3JyZWN0IHR5cG9zIGluIGZpbGUgaGVhZGVycwogIEFTb0M6
IGFkYXUxN3gxOiBBZGQgYmFzaWMgRFQgc3VwcG9ydCBmb3IgYWRhdTE3eDEKICBBU29DOiBhZGF1
MTd4MTogQWRkIG9wdGlvbiB0byBwcm92aWRlIHBsYXRmb3JtIGRhdGEgdmlhIERUCgogLi4uL2Rl
dmljZXRyZWUvYmluZGluZ3Mvc291bmQvYWRpLGFkYXUxN3gxLnR4dCAgICAgfCAgNTQgKysrKysr
KysrCiBpbmNsdWRlL2R0LWJpbmRpbmdzL3NvdW5kL2FkYXUxN3gxLmggICAgICAgICAgICAgICB8
ICAxNCArKysKIGluY2x1ZGUvbGludXgvcGxhdGZvcm1fZGF0YS9hZGF1MTd4MS5oICAgICAgICAg
ICAgIHwgICAyICstCiBzb3VuZC9zb2MvY29kZWNzL2FkYXUxNzYxLWkyYy5jICAgICAgICAgICAg
ICAgICAgICB8ICAxNCArKy0KIHNvdW5kL3NvYy9jb2RlY3MvYWRhdTE3NjEtc3BpLmMgICAgICAg
ICAgICAgICAgICAgIHwgIDE0ICsrLQogc291bmQvc29jL2NvZGVjcy9hZGF1MTc2MS5jICAgICAg
ICAgICAgICAgICAgICAgICAgfCAxMzMgKysrKysrKysrKysrKysrKysrKystCiBzb3VuZC9zb2Mv
Y29kZWNzL2FkYXUxNzgxLWkyYy5jICAgICAgICAgICAgICAgICAgICB8ICAxMCArKwogc291bmQv
c29jL2NvZGVjcy9hZGF1MTc4MS1zcGkuYyAgICAgICAgICAgICAgICAgICAgfCAgMTAgKysKIHNv
dW5kL3NvYy9jb2RlY3MvYWRhdTE3ODEuYyAgICAgICAgICAgICAgICAgICAgICAgIHwgIDU5ICsr
KysrKysrLQogc291bmQvc29jL2NvZGVjcy9hZGF1MTd4MS5oICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgIDYgKy0KIDEwIGZpbGVzIGNoYW5nZWQsIDMwOCBpbnNlcnRpb25zKCspLCA4IGRlbGV0
aW9ucygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9zb3VuZC9hZGksYWRhdTE3eDEudHh0CiBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9k
dC1iaW5kaW5ncy9zb3VuZC9hZGF1MTd4MS5oCgotLSAKMi4xLjQKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFs
c2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3Jn
L21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
