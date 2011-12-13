From: Gustavo Maciel Dias Vieira <gustavo@sagui.org>
Subject: [PATCH v2] ALSA: hda: fix mute led polarity for HP
 laptops with buggy BIOS
Date: Tue, 13 Dec 2011 11:47:22 -0200
Message-ID: <1323784042.4529.7.camel@oberon.sagui.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from horatio.sagui.org (horatio.sagui.org [173.230.138.212])
	by alsa0.perex.cz (Postfix) with ESMTP id 30F78103B48
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2011 14:47:31 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

U29tZSBIUCBsYXB0b3AgbW9kZWxzIGRvIG5vdCBoYXZlIGEgcHJvcGVybHkgZmlsbGVkIE9FTSBz
dHJpbmcgdXNlZAp0byBzZXQgdGhlIGdwaW8gYW5kIHBvbGFyaXR5IG9mIHRoZSBtdXRlIGxlZC4g
TWFrZSB0aGUgbXV0ZSBsZWQKY29uZmlndXJhdGlvbiB3b3JrIGZvciB0aGlzIGNhc2UuCgpTaWdu
ZWQtb2ZmLWJ5OiBHdXN0YXZvIE1hY2llbCBEaWFzIFZpZWlyYSA8Z3VzdGF2b0BzYWd1aS5vcmc+
Ci0tLQoKRW0gU2VnLCAyMDExLTEyLTEyIMOgcyAxNzoxMCArMDEwMCwgVGFrYXNoaSBJd2FpIGVz
Y3JldmV1Ogo+IAo+IFllcywgc3Vic3l0ZW1faWQgY2FuIGJlIHVzZWQuICBPVE9ILCBJIGd1ZXNz
IEhQX011dGVfTEVEX1BfRyBjaGVjawo+IHdvdWxkIGJlIGVhc2llciBhbmQgbWF5IGNvdmVyIG1v
cmUgbWFjaGluZXMuICBTbywgSSBwcmVmZXIgdGhlCj4gbGF0dGVyLgo+IAoKSXMgdGhpcyBvaz8K
Ckluc3RlYWQgb2Ygc2V0dGluZyBwb2xhcml0eSB0byAxLCBJIGNhbiBzZWxlY3QgaXQgYnkgc3Vi
c3lzdGVtX2lkIGxpc3QuCgpBYnJhw6dvcywKR3VzdGF2bwoKIHNvdW5kL3BjaS9oZGEvcGF0Y2hf
c2lnbWF0ZWwuYyB8ICAgIDYgKysrKysrCiAxIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygr
KSwgMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zb3VuZC9wY2kvaGRhL3BhdGNoX3NpZ21h
dGVsLmMgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX3NpZ21hdGVsLmMKaW5kZXggZWViMjVkNTIuLjYx
NjY3OGYgMTAwNjQ0Ci0tLSBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hfc2lnbWF0ZWwuYworKysgYi9z
b3VuZC9wY2kvaGRhL3BhdGNoX3NpZ21hdGVsLmMKQEAgLTQ5MjksNiArNDkyOSwxMiBAQCBzdGF0
aWMgaW50IGZpbmRfbXV0ZV9sZWRfZ3BpbyhzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYywgaW50IGRl
ZmF1bHRfcG9sYXJpdHkpCiAJCQkJc2V0X2hwX2xlZF9ncGlvKGNvZGVjKTsKIAkJCQlyZXR1cm4g
MTsKIAkJCX0KKwkJCS8qIEJJT1MgYnVnOiB1bmZpbGxlZCBPRU0gc3RyaW5nICovCisJCQlpZiAo
c3Ryc3RyKGRldi0+bmFtZSwgIkhQX011dGVfTEVEX1BfRyIpKSB7CisJCQkJc2V0X2hwX2xlZF9n
cGlvKGNvZGVjKTsKKwkJCQlzcGVjLT5ncGlvX2xlZF9wb2xhcml0eSA9IDE7CisJCQkJcmV0dXJu
IDE7CisJCQl9CiAJCX0KIAogCQkvKgotLSAKMS43LjcuMwoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1k
ZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
