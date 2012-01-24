From: Gustavo Maciel Dias Vieira <gustavo@sagui.org>
Subject: [PATCH] ALSA: hda: set mute led polarity for laptops
 with buggy BIOS based on SSID
Date: Tue, 24 Jan 2012 13:32:51 -0200
Message-ID: <1327419171.4111.27.camel@oberon.sagui.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from horatio.sagui.org (horatio.sagui.org [173.230.138.212])
	by alsa0.perex.cz (Postfix) with ESMTP id C7E5D103A81
	for <alsa-devel@alsa-project.org>; Tue, 24 Jan 2012 16:32:56 +0100 (CET)
Received: from oberon.sagui.org (gw.sor.ufscar.br [200.133.238.2])
	by horatio.sagui.org (Postfix) with ESMTPSA id 5CF73517
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Jan 2012 13:32:53 -0200 (BRST)
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

SFAgbGFwdG9wIG1vZGVscyB3aXRoIGJ1Z2d5IEJJT1MgYXJlIGFwcGFyZW50bHkgZnJlcXVlbnQs
IGluY2x1ZGluZwptYWNoaW5lcyB3aXRoIGRpZmZlcmVudCBjb2RlY3MuIFNldCB0aGUgcG9sYXJp
dHkgb2YgdGhlIG11dGUgbGVkIGJhc2VkCm9uIHRoZSBTU0lEIGFuZCBpbmNsdWRlIGFuIGVudHJ5
IGZvciB0aGUgSFAgTWluaSAxMTAtMzEwMC4KClNpZ25lZC1vZmYtYnk6IEd1c3Rhdm8gTWFjaWVs
IERpYXMgVmllaXJhIDxndXN0YXZvQHNhZ3VpLm9yZz4KLS0tCgpUYWthc2hpLCBpcyB0aGlzIG9r
PwoKUHJlZHJhZywgY2FuIHlvdSB0ZXN0IHRoaXMgcGF0Y2g/CgpBYnJhw6dvcywKR3VzdGF2bwoK
IHNvdW5kL3BjaS9oZGEvcGF0Y2hfc2lnbWF0ZWwuYyB8ICAgIDkgKysrKysrKystCiAxIGZpbGVz
IGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9z
b3VuZC9wY2kvaGRhL3BhdGNoX3NpZ21hdGVsLmMgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX3NpZ21h
dGVsLmMKaW5kZXggMzM2Y2ZjZC4uOTQ4ZjBiZSAxMDA2NDQKLS0tIGEvc291bmQvcGNpL2hkYS9w
YXRjaF9zaWdtYXRlbC5jCisrKyBiL3NvdW5kL3BjaS9oZGEvcGF0Y2hfc2lnbWF0ZWwuYwpAQCAt
NDg3MCw3ICs0ODcwLDE0IEBAIHN0YXRpYyBpbnQgZmluZF9tdXRlX2xlZF9jZmcoc3RydWN0IGhk
YV9jb2RlYyAqY29kZWMsIGludCBkZWZhdWx0X3BvbGFyaXR5KQogCQkJLyogQklPUyBidWc6IHVu
ZmlsbGVkIE9FTSBzdHJpbmcgKi8KIAkJCWlmIChzdHJzdHIoZGV2LT5uYW1lLCAiSFBfTXV0ZV9M
RURfUF9HIikpIHsKIAkJCQlzZXRfaHBfbGVkX2dwaW8oY29kZWMpOwotCQkJCXNwZWMtPmdwaW9f
bGVkX3BvbGFyaXR5ID0gMTsKKwkJCQlzd2l0Y2ggKGNvZGVjLT5zdWJzeXN0ZW1faWQpIHsKKwkJ
CQljYXNlIDB4MTAzYzE0OGE6CisJCQkJCXNwZWMtPmdwaW9fbGVkX3BvbGFyaXR5ID0gMDsKKwkJ
CQkJYnJlYWs7CisJCQkJZGVmYXVsdDoKKwkJCQkJc3BlYy0+Z3Bpb19sZWRfcG9sYXJpdHkgPSAx
OworCQkJCQlicmVhazsKKwkJCQl9CiAJCQkJcmV0dXJuIDE7CiAJCQl9CiAJCX0KLS0gCjEuNy43
LjUKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNh
LWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21h
aWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
