From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [PATCH 2/3] ASoC: mxs-saif: Store saif state
Date: Fri, 11 Oct 2013 12:31:46 +0200
Message-ID: <20131011123146.73ff30ce@ipc1.ka-ro>
References: <1381486264-1672-1-git-send-email-mpa@pengutronix.de>
 <1381486264-1672-3-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.karo-electronics.de (mail.karo-electronics.de
 [81.173.242.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 7698B265670
 for <alsa-devel@alsa-project.org>; Fri, 11 Oct 2013 12:32:45 +0200 (CEST)
In-Reply-To: <1381486264-1672-3-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

SGksCgo+IFRyaWdnZXIgY29tbWFuZHMgbWF5IGJlIHBhc3NlZCBtdWx0aXBsZSB0aW1lcy4gVG8g
YXZvaWQgZXJyb3JzIHdpdGgKPiBjbGtfZW5hYmxlL2Rpc2FibGUsIHN0b3JlIHRoZSBzYWlmIHN0
YXRlIGFuZCByZXR1cm4gaWYgc2FpZiBpcyBhbHJlYWR5Cj4gcnVubmluZy9zdG9wcGVkLgo+IAo+
IFNpZ25lZC1vZmYtYnk6IE1hcmt1cyBQYXJnbWFubiA8bXBhQHBlbmd1dHJvbml4LmRlPgo+IC0t
LQo+ICBzb3VuZC9zb2MvbXhzL214cy1zYWlmLmMgfCA4ICsrKysrKysrCj4gIHNvdW5kL3NvYy9t
eHMvbXhzLXNhaWYuaCB8IDUgKysrKysKPiAgMiBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25z
KCspCj4gCj4gZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9teHMvbXhzLXNhaWYuYyBiL3NvdW5kL3Nv
Yy9teHMvbXhzLXNhaWYuYwo+IGluZGV4IGI1NmI4YTAuLmM4ZWFkMDEgMTAwNjQ0Cj4gLS0tIGEv
c291bmQvc29jL214cy9teHMtc2FpZi5jCj4gKysrIGIvc291bmQvc29jL214cy9teHMtc2FpZi5j
Cj4gQEAgLTUwMyw2ICs1MDMsOSBAQCBzdGF0aWMgaW50IG14c19zYWlmX3RyaWdnZXIoc3RydWN0
IHNuZF9wY21fc3Vic3RyZWFtICpzdWJzdHJlYW0sIGludCBjbWQsCj4gIAljYXNlIFNORFJWX1BD
TV9UUklHR0VSX1NUQVJUOgo+ICAJY2FzZSBTTkRSVl9QQ01fVFJJR0dFUl9SRVNVTUU6Cj4gIAlj
YXNlIFNORFJWX1BDTV9UUklHR0VSX1BBVVNFX1JFTEVBU0U6Cj4gKwkJaWYgKHNhaWYtPnN0YXRl
ID09IE1YU19TQUlGX1NUQVRFX1JVTk5JTkcpCj4gKwkJCXJldHVybiAwOwo+ICsKPiAgCQlkZXZf
ZGJnKGNwdV9kYWktPmRldiwgInN0YXJ0XG4iKTsKPiAgCj4gIAkJY2xrX2VuYWJsZShtYXN0ZXJf
c2FpZi0+Y2xrKTsKPiBAQCAtNTQzLDYgKzU0Niw3IEBAIHN0YXRpYyBpbnQgbXhzX3NhaWZfdHJp
Z2dlcihzdHJ1Y3Qgc25kX3BjbV9zdWJzdHJlYW0gKnN1YnN0cmVhbSwgaW50IGNtZCwKPiAgCQl9
Cj4gIAo+ICAJCW1hc3Rlcl9zYWlmLT5vbmdvaW5nID0gMTsKPiArCQlzYWlmLT5zdGF0ZSA9IE1Y
U19TQUlGX1NUQVRFX1JVTk5JTkc7Cj4KSXQgc2VlbXMgdG8gbWUgdGhhdCB5b3UgY291bGQgdXNl
IHRoZSBhbHJlYWR5IGV4aXN0aW5nIHZhcmlhYmxlCidvbmdvaW5nJyB0aGF0IGFscmVhZHkgcmVm
bGVjdHMgdGhlIHN0YXRlIGxpa2UgeW91IG5lZWQgaXQuCgoKTG90aGFyIFdhw59tYW5uCi0tIApf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwoKS2EtUm8gZWxlY3Ryb25pY3MgR21iSCB8IFBhc2NhbHN0cmHDn2UgMjIgfCBEIC0gNTIwNzYg
QWFjaGVuClBob25lOiArNDkgMjQwOCAxNDAyLTAgfCBGYXg6ICs0OSAyNDA4IDE0MDItMTAKR2Vz
Y2jDpGZ0c2bDvGhyZXI6IE1hdHRoaWFzIEthdXNzZW4KSGFuZGVsc3JlZ2lzdGVyZWludHJhZzog
QW10c2dlcmljaHQgQWFjaGVuLCBIUkIgNDk5NgoKd3d3Lmthcm8tZWxlY3Ryb25pY3MuZGUgfCBp
bmZvQGthcm8tZWxlY3Ryb25pY3MuZGUKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNh
LXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbHNhLWRldmVsCg==
