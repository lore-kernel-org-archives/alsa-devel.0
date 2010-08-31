From: Jie Jiang <jjinfo@nudt.edu.cn>
Subject: Re: Questions about alsa driver for i.Mx27 + wm8974:
 playback time shorter than the original record time
Date: Wed, 01 Sep 2010 00:57:39 +0800
Message-ID: <1283273859.10728.22.camel@UT43>
References: <1282824338.1106.44.camel@UT43>
	<20100826124137.GA3509@opensource.wolfsonmicro.com>
	<1283271700.10728.8.camel@UT43>
	<AANLkTin+mZr75vin9AB0W+zHLXrTtP6UGuAyUSfKpXgE@mail.gmail.com>
Reply-To: jjinfo@nudt.edu.cn
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nudt.edu.cn (mail.nudt.edu.cn [61.187.54.11])
	by alsa0.perex.cz (Postfix) with SMTP id 89398103828
	for <alsa-devel@alsa-project.org>;
	Tue, 31 Aug 2010 18:51:28 +0200 (CEST)
In-Reply-To: <AANLkTin+mZr75vin9AB0W+zHLXrTtP6UGuAyUSfKpXgE@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Randolph Chung <rchung42@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, s.hauer@pengutronix.de
List-Id: alsa-devel@alsa-project.org

VGhlbiBob3cgYWJvdXQgaW14LXNzaSBkcml2ZXIncyBzdXBwb3J0IGZvciBtb25vIGNhcHR1cmU/
CkRvZXMgYW55Ym9keSBzdWNjZWVkIHRvIGRvIHRoaXM/CgpJIHRyeSB0byBjYXB0dXJlIGFuIGF1
eCBpbnB1dCBpbnRvIGEgbW9ubyB3YXYgZmlsZSwgd2hhdCBJIGdldCBpbiB0aGUKd2F2IGZpbGUg
aXMgbm90IGNvcnJlY3QuIEJ1dCB3aGVuIEkgdHJ5IHRvIHJlY29yZCB3aXRoICJhcmVjb3JkIC1k
IDEwIC1jCjIgLWYgUzE2X0xFIC1yIDgwMDAgLXQgd2F2IGZvb2Jhci53YXYiLCB0aGUgd2F2IGZp
bGUgaXMgbXVjaCBjbG9zZXIgdG8KdGhlIGF1eCBpbnB1dCBhdWRpbywgYWx0aG91Z2ggc3RpbGwg
bm90IHRoZSBleHBlY3RlZCByZXN1bHQuIElzIGl0IHRoZQpzYW1lIHBvc3NpYmxlIHJlYXNvbiB0
aGF0IGFmZmVjdHMgbW9ubyBjaGFubmVsIGNhcHR1cmU/CgpSZWdhcmRzLApKaWUKCgoKCk9uIOS6
jCwgMjAxMC0wOC0zMSBhdCAwOToyMSAtMDcwMCwgUmFuZG9scGggQ2h1bmcgd3JvdGU6Cj4gPgo+
ID4gWWVzLCBpdCBzZWVtcyB0byBiZSB0aGlzIHJlYXNvbiB0aGF0IGNhdXNlcyBwcm9ibGVtLgo+
ID4gV2hlbiBJIHBsYXliYWNrIGEgc3RlcmVvIHdhdiBmaWxlKDhrSHosMTZiaXQsIHN0ZXJlbyks
IGV2ZXJ5dGhpbmcgZ29lcwo+ID4gd2VsbC5CdXQgd2hlbiB0cnlpbmcgdG8gcGxheWJhY2sgYSBt
b25vIHdhdiAoOGtIeiwxNmJpdCwgbW9ubylmaWxlLAo+ID4gcHJvYmxlbSBzdGlsbHMgZXhpc3Qu
Cj4gPgo+ID4gV2hhdCdzIHRoZSBwb3NzaWJsZSByZWFzb24gZm9yIGluY29ycmVjdCBoYW5kbGlu
ZyBvZiBtb25vIGZpbGU/Cj4gPiBIb3cgdG8gc29sdmUgaXQgc28gSSBjYW4gcGxheWJhY2sgbW9u
byBmaWxlIGNvcnJlY3RseT8KPiAKPiBUaGUgaW14LXNzaSBkcml2ZXIgZG9lcyBub3Qgc3VwcG9y
dCBtb25vLWNoYW5uZWwgcGxheWJhY2suIEkndmUgYWxzbwo+IGxvb2tlZCBhdCB0aGlzIGEgYml0
IGJ1dCBjb3VsZG4ndCBxdWl0ZSBmaWd1cmUgaXQgb3V0LiBNYXliZSBTYXNoYQo+IChjYydlZCkg
Y2FuIGdpdmUgc29tZSBwb2ludGVycz8KPiAKPiByYW5kb2xwaAo+IAoKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0
CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qu
b3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
