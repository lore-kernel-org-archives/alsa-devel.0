From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH v2] ASoC: OMAP: Don't try to set
	unsupported OMAP_DMA_DATA_BURST_16 on OMAP1
Date: Thu, 5 Nov 2009 19:03:43 +0100
Message-ID: <200911051903.46185.jkrzyszt@tis.icnet.pl>
References: <200910212035.42245.jkrzyszt@tis.icnet.pl>
	<200910212310.05087.jkrzyszt@tis.icnet.pl>
	<20091022105040.GA18862@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from d1.icnet.pl (d1.icnet.pl [212.160.220.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 6FE18103965
	for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2009 19:04:10 +0100 (CET)
In-Reply-To: <20091022105040.GA18862@rakim.wolfsonmicro.main>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jhnikula@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

VGh1cnNkYXkgMjIgT2N0b2JlciAyMDA5IDEyOjUwOjQwIE1hcmsgQnJvd24gbmFwaXNhxYIoYSk6
Cj4gT24gV2VkLCBPY3QgMjEsIDIwMDkgYXQgMTE6MTA6MDNQTSArMDIwMCwgSmFudXN6IEtyenlz
enRvZmlrIHdyb3RlOgo+ID4gV2VkbmVzZGF5IDIxIE9jdG9iZXIgMjAwOSAyMToxNjowNyBKYXJr
a28gTmlrdWxhIG5hcGlzYcWCKGEpOgo+ID4gPiBJIHdvdWxkIGhhdmUgaW1wbGVtZW50ZWQgdGhp
cyBieSAiaWYgKCFjcHVfY2xhc3NfaXNfb21hcDEoKSkKPiA+ID4gey4uLl9idXJzdF9tb2RlfSIg
Zm9yIG1ha2luZyBzdXJlIHRoYXQgbm8gbmV3IE9NQVAxIGVycm9yIGlzIGludHJvZHVjZWQKPiA+
ID4gaW4gdGhlIGZ1dHVyZSBpZiB0aGVyZSBpcyBuZWVkIHRvIGFkZCBzb21lIGNvbW1vbiBzdHVm
ZiBhZnRlciB0aG9zZQo+ID4gPiBidXJzdF9tb2RlIGNhbGxzIGFuZCBwcm9iYWJseSBjb21waWxl
ciBjYW4gYmV0dGVyIG9wdGltaXplIGF3YXkgdGhvc2UKPiA+ID4gYnVyc3RfbW9kZSBjYWxscyBm
b3IgT01BUDEgYnVpbGRzLgo+ID4KPiA+IFllcywgeW91J3JlIHJpZ2h0Lgo+ID4KPiA+IC0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4KPiBBcHBsaWVkLCB0aGFua3MuICBGb3IgZWFzZSBvZiB1
c2Ugd2l0aCB0b29scyBsaWtlIGdpdCBhbSBpdCdzIG5pY2VyIGlmCj4geW91IGNhbiBpbmNsdWRl
IHRleHQgbGlrZSB0aGUgYWJvdmUgd2hpY2ggc2hvdWxkbid0IGJlIGluIHRoZSBhY3R1YWwKPiBj
b21taXQgbG9nIGFmdGVyIHRoZSAtLS0gKHdoZXJlIHRoZSBkaWZmc3RhdCBlbmRzIHVwKS4KCk1h
cmssIEphcmtrbywKClNob3VsZG4ndCB0aGlzIG9uZSBnbyBpbnRvIDIuNi4zMiBhcyBhIGZpeD8g
SXQgY29ycmVjdHMgdGhlIHByb2JsZW0gb2YgQVNvQyAKbm90IHdvcmtpbmcgb24gT01BUDEgYXQg
YWxsLiBJIGNhbid0IHNlZSBpdCBpbiAtcmM2LgoKVGhhbmtzLApKYW51c3oKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBs
aXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2pl
Y3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
