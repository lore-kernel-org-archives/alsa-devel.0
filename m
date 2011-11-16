From: Leon Romanovsky <leon@leon.nu>
Subject: Re: [PATCH 2/6] ASoC: alc5632: Fix compile without
	CONFIG_I2C
Date: Wed, 16 Nov 2011 21:11:00 +0200
Message-ID: <CALq1K=KG1cycVrftOHeCYzaY9WoEwVpgt-8HYvTRrpQ=v7yEWw@mail.gmail.com>
References: <1321438023-29660-1-git-send-email-leon@leon.nu>
	<1321438023-29660-3-git-send-email-leon@leon.nu>
	<20111116103521.GA3072@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 2E3202437E
	for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2011 20:11:21 +0100 (CET)
Received: by wwe6 with SMTP id 6so971854wwe.20
	for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2011 11:11:21 -0800 (PST)
In-Reply-To: <20111116103521.GA3072@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCBOb3YgMTYsIDIwMTEgYXQgMTI6MzUsIE1hcmsgQnJvd24KPGJyb29uaWVAb3BlbnNv
dXJjZS53b2xmc29ubWljcm8uY29tPiB3cm90ZToKPiBPbiBXZWQsIE5vdiAxNiwgMjAxMSBhdCAx
MjowNjo1OVBNICswMjAwLCBMZW9uIFJvbWFub3Zza3kgd3JvdGU6Cj4KPj4gKyNpZiBkZWZpbmVk
KENPTkZJR19JMkMpIHx8IGRlZmluZWQoQ09ORklHX0kyQ19NT0RVTEUpCj4+IMKgc3RhdGljIF9f
ZGV2aW5pdCBpbnQgYWxjNTYzMl9pMmNfcHJvYmUoc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCwK
Pj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgY29uc3Qgc3Ry
dWN0IGkyY19kZXZpY2VfaWQgKmlkKQo+PiDCoHsKPj4gQEAgLTEyMDMsMjQgKzEyMDQsMjcgQEAg
c3RhdGljIHN0cnVjdCBpMmNfZHJpdmVyIGFsYzU2MzJfaTJjX2RyaXZlciA9IHsKPj4gwqAgwqAg
wqAgLnJlbW92ZSA9IMKgX19kZXZleGl0X3AoYWxjNTYzMl9pMmNfcmVtb3ZlKSwKPj4gwqAgwqAg
wqAgLmlkX3RhYmxlID0gYWxjNTYzMl9pMmNfdGFibGUsCj4+IMKgfTsKPj4gKyNlbmRpZgo+Cj4g
VGhpcyBpcyBvbmx5IG5lZWRlZCBpZiB0aGUgZHJpdmVyIHN1cHBvcnRzIG1vcmUgdGhhbiBvbmUg
Y29udHJvbAo+IGludGVyZmFjZS4gwqBJZiBpdCBvbmx5IHN1cHBvcnRzIEkyQyB0aGVuIHRoaXMg
c2hvdWxkIGJlIHNvcnRlZCBvdXQgYXQKPiBLY29uZmlnIHN0YWdlLgpJdCBpcyB0aGUgc2FtZSBh
cyB5b3VyIFdNOTA4MSBjb2RlYywgeW91IGhhdmUgZW50cnkgaW4gS2NvbmZpZyBhbmQKQ09ORklH
X0kyQyBpbiB0aGUgY29kZS4KCkFueXdheSB0aGlzIGNvZGVjIGlzIG5vdCB1c2FibGUgd2l0aG91
dCBJMkMsIHNvIHdlIGNhbiBkcm9wIHRoaXMgcGF0Y2guCgo+CgoKCi0tIApMZW9uIFJvbWFub3Zz
a3kgfCBJbmRlcGVuZGVudCBMaW51eCBDb25zdWx0YW50CsKgIMKgIMKgIMKgwqB3d3cubGVvbi5u
dcKgfCBsZW9uQGxlb24ubnUKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qu
b3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNh
LWRldmVsCg==
