From: =?UTF-8?B?U2VyZ2V5?= <sergemp@mail.ru>
Subject: =?utf-8?q?=5BRFC=5D=5BPATCH_0/2=5D_Fix_aplay_and_als?=
 =?utf-8?q?a-lib_write=5Fareas=28=29_freezing_with_100=25_cpu_usage_on_stu?=
 =?utf-8?q?ck_slave_pcm?=
Date: Fri, 13 Jun 2014 10:52:51 +0400
Message-ID: <1402642371.496174944@f39.i.mail.ru>
Reply-To: =?UTF-8?B?U2VyZ2V5?= <sergemp@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from f39.i.mail.ru (f39.i.mail.ru [94.100.178.227])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D86C2616C9
 for <alsa-devel@alsa-project.org>; Fri, 13 Jun 2014 08:52:52 +0200 (CEST)
Received: from mail by f39.i.mail.ru with local (envelope-from
 <sergemp@mail.ru>) id 1WvLM3-0004NH-JJ
 for alsa-devel@alsa-project.org; Fri, 13 Jun 2014 10:52:51 +0400
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?B?YWxzYS1kZXZlbA==?= <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

VGhlc2UgcGF0Y2hlcyBvcmlnaW5hdGUgZnJvbSBgYXBsYXkgLXZ2diAvZGV2L3plcm9gIG5vdCBy
ZXNwb25kaW5nIHRvIEN0cmwrQwp3aGVuIHBsYXlpbmcgdG8gcGx1Z2dlZCAibnVsbCIsIGUuZy4K
wqDCoHBjbS4hZGVmYXVsdCB7CsKgwqDCoMKgdHlwZSBwbHVnCsKgwqDCoMKgc2xhdmUucGNtIHsg
dHlwZSBudWxsIH0KwqDCoMKgwqBzbGF2ZS5mb3JtYXQgUzMyX0xFCsKgwqB9CgpGaXJzdCBwYXRj
aCBmaXhlcyBzbmRfcGNtX3dyaXRlX2FyZWFzKCkgc3R1Y2sgaW4gYSBsb29wIGJlY2F1c2Ugb2Yg
dHJhbnNmZXIKZnVuYygpIGFsd2F5cyByZXR1cm5pbmcgMC4gVGhhdCBjYXVzZWQgYXBwbGljYXRp
b24gY2FsbGluZyBpdCB0byBmcmVlemUuCkluIHRoZSBleGFtcGxlIGFib3ZlIGl0IGhhdmUgZnJv
emVuIGFwbGF5LiBJZiBpdCB3YXMgY2FsbGVkIGJ5IGZpcmVmb3gsCml0IHdvdWxkIGZyZWV6ZSBm
aXJlZm94LgoKSXMgaXQgYSBnb29kIHdheSB0byBmaXggaXQ/IFNob3VsZCBzbmRfcGNtX3JlYWRf
YXJlYXMoKSBiZSBmaXhlZCBsaWtlIHRoYXQgdG9vPwoKU2Vjb25kIHBhdGNoIGZpeGVzIGFwbGF5
IGl0c2VsZiwgbm90IHJldHVybmluZyBmcm9tIHBjbV93cml0ZSgpIGFmdGVyIFNJR0lOVC4KCkFk
ZGl0aW9uYWxseSBhcGxheSBtYXkgcmVzdG9yZSBvcmlnaW5hbCBpbnRlcnJ1cHQgaGFuZGxlciwg
dG8gbWFrZQpzZWNvbmQgQ3RybCtDIHN0b3AgaXQgZm9yIHN1cmUuIEluIGNhc2Ugb2Ygb3RoZXIg
YnVncyBpbiBhbHNhLWxpYiBvcgp0aGlyZC1wYXJ0eSBzbGF2ZSBwY21zIGl0IHNlZW1zIGJldHRl
ciB0aGFuIFNJR2tpbGxpbmcgaXQgbWFudWFsbHkuCgpDb21tZW50cyBhbmQgc3VnZ2VzdGlvbnMg
YXJlIHdlbGNvbWUuCgpSZWdhcmRsZXNzIG9mIHRoZXNlIHBhdGNoZXMnIGZhdGUgbnVsbCBwbHVn
aW4gbXVzdCBiZSBmaXhlZCBvbiBpdHMgb3duLgoKUGF0Y2hlcyAoMik6CsKgwqBwY206IGJyZWFr
IG91dCBvZiBzbmRfcGNtX3dyaXRlX2FyZWFzKCkgaWYgd3JpdGUgZnVuY3Rpb24gcmV0dXJuZWQg
MArCoMKgYXBsYXk6IEVzY2FwZSBmcm9tIHBjbV93cml0ZSgpIHdoZW4gaW5fYWJvcnRpbmcgc3Rh
dGUKCsKgc3JjL3BjbS9wY20uYyB8ICAgIDIgKy0KwqBhcGxheS9hcGxheS5jIHwgICAgMiArLQrC
oDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKLS0gCjEu
Ny4xMC40Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFs
c2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8v
bWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
