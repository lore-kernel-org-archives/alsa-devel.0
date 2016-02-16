From: =?UTF-8?q?Andreas=20Irest=C3=A5l?= <andreas.irestal@axis.com>
Subject: [PATCH v2 0/5]  Minor fixes and DT support
Date: Tue, 16 Feb 2016 13:56:40 +0100
Message-ID: <1455627405-18155-1-git-send-email-andire@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 4CEA2260824
 for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2016 13:57:14 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: =?UTF-8?q?Andreas=20Irest=C3=A5l?= <andire@axis.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

VGhpcyBzZXQgb2YgcGF0Y2hlcyBmaXhlcyBzb21lIG1pbm9yIHR5cG9zIGFuZCBhZGRzIERUIHN1
cHBvcnQgZm9yIHRoZQphZGF1MTd4MSBjb2RlYyBkcml2ZXJzLiBJJ3ZlIG9ubHkgYmVlbiBhYmxl
IHRvIHRlc3QgdGhlIDE3NjEgcGFydCBvbgpyZWFsIGhhcmR3YXJlIHNpbmNlIEkgZG9uJ3QgaGF2
ZSBhbnkgYWRhdTE3ODEgaGFyZHdhcmUgYXQgdGhlIG1vbWVudC4KCkN1cnJlbnRseSwgcXVpdGUg
YSBsb3Qgb2Ygb3B0aW9ucyBhcmUgcHJvdmlkZWQgdGhyb3VnaCB0aGUgcGxhdGZvcm1fZGF0YQpz
dHJ1Y3QsIHNvIGl0IG1hZGUgc2Vuc2UgcGFyc2luZyB0aGUgRFQgYW5kIGNyZWF0ZSBhIHBsYXRm
b3JtX2RhdGEgc3RydWN0CmZyb20gdGhlc2UgcGFyYW1ldGVycyBub3QgdG8gYnJlYWsgYW55dGhp
bmcuCgpDaGFuZ2VzIHNpbmNlIHYxOgogLSBBZGRlZCB2ZW5kb3IgcHJlZml4ICJhZGksIiB0byBE
VCBwcm9wZXJ0aWVzCiAtIERUIHBhcnNpbmcgbW92ZWQgdG8gbWFpbiBwcm9iZSBmdW5jdGlvbgoK
QW5kcmVhcyBJcmVzdMOlbCAoNSk6CiAgQVNvQzogYWRhdTE3eDE6IEZpeCBpbmNvcnJlY3QgQkNM
SyByYXRpbyBkZWZpbml0aW9ucwogIEFTb0M6IGFkYXUxN3gxOiBDb3JyZWN0IHR5cG9zIGluIGZp
bGUgaGVhZGVycwogIEFTb0M6IGFkYXUxN3gxOiBBZGQgYWRhdTE3eDEgYmluZGluZ3MgZG9jdW1l
bnQKICBBU29DOiBhZGF1MTd4MTogQWRkIGJhc2ljIERUIHN1cHBvcnQgZm9yIGFkYXUxN3gxCiAg
QVNvQzogYWRhdTE3eDE6IFN1cHBvcnQgcGxhdGZvcm0gZGF0YSB2aWEgRFQKCiAuLi4vZGV2aWNl
dHJlZS9iaW5kaW5ncy9zb3VuZC9hZGksYWRhdTE3eDEudHh0ICAgICB8ICA1NSArKysrKysrKysK
IGluY2x1ZGUvZHQtYmluZGluZ3Mvc291bmQvYWRhdTE3eDEuaCAgICAgICAgICAgICAgIHwgIDE0
ICsrKwogaW5jbHVkZS9saW51eC9wbGF0Zm9ybV9kYXRhL2FkYXUxN3gxLmggICAgICAgICAgICAg
fCAgIDIgKy0KIHNvdW5kL3NvYy9jb2RlY3MvYWRhdTE3NjEtaTJjLmMgICAgICAgICAgICAgICAg
ICAgIHwgIDE0ICsrLQogc291bmQvc29jL2NvZGVjcy9hZGF1MTc2MS1zcGkuYyAgICAgICAgICAg
ICAgICAgICAgfCAgMTQgKystCiBzb3VuZC9zb2MvY29kZWNzL2FkYXUxNzYxLmMgICAgICAgICAg
ICAgICAgICAgICAgICB8IDEyOSArKysrKysrKysrKysrKysrKysrKy0KIHNvdW5kL3NvYy9jb2Rl
Y3MvYWRhdTE3ODEtaTJjLmMgICAgICAgICAgICAgICAgICAgIHwgIDEwICsrCiBzb3VuZC9zb2Mv
Y29kZWNzL2FkYXUxNzgxLXNwaS5jICAgICAgICAgICAgICAgICAgICB8ICAxMCArKwogc291bmQv
c29jL2NvZGVjcy9hZGF1MTc4MS5jICAgICAgICAgICAgICAgICAgICAgICAgfCAgNTAgKysrKysr
Ky0KIHNvdW5kL3NvYy9jb2RlY3MvYWRhdTE3eDEuaCAgICAgICAgICAgICAgICAgICAgICAgIHwg
ICA2ICstCiAxMCBmaWxlcyBjaGFuZ2VkLCAyOTYgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMo
LSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
c291bmQvYWRpLGFkYXUxN3gxLnR4dAogY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvZHQtYmlu
ZGluZ3Mvc291bmQvYWRhdTE3eDEuaAoKLS0gCjIuMS40CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRl
dmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWls
bWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
