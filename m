From: Shunqian Zheng <zhengsq@rock-chips.com>
Subject: Re: [PATCH] ASoC: rt5616: add kcontrol for headphone
	channel switch
Date: Thu, 03 Mar 2016 15:21:26 +0800
Message-ID: <56D7E5F6.7010605@rock-chips.com>
References: <1456910320-6979-1-git-send-email-john.lin@realtek.com>
 <20160302103535.GH18327@sirena.org.uk>
 <14AE6189BDA733429BF8455FEEF632980110FFD1@RTITMBSV02.realtek.com.tw>
Reply-To: zhengsq@rock-chips.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.130])
 by alsa0.perex.cz (Postfix) with ESMTP id 404FC26068F
 for <alsa-devel@alsa-project.org>; Thu,  3 Mar 2016 08:21:34 +0100 (CET)
In-Reply-To: <14AE6189BDA733429BF8455FEEF632980110FFD1@RTITMBSV02.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Lin <john.lin@realtek.com>, Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

Sm9obiwKCk9uIDIwMTblubQwM+aciDAz5pelIDEwOjQ1LCBKb2huIExpbiB3cm90ZToKPj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPj4gRnJvbTogTWFyayBCcm93biBbbWFpbHRvOmJyb29u
aWVAa2VybmVsLm9yZ10KPj4gU2VudDogV2VkbmVzZGF5LCBNYXJjaCAwMiwgMjAxNiA2OjM2IFBN
Cj4+IFRvOiBKb2huIExpbgo+PiBDYzogbGdpcmR3b29kQGdtYWlsLmNvbTsgYWxzYS1kZXZlbEBh
bHNhLXByb2plY3Qub3JnOyBCYXJkIExpYW87IEZsb3ZlOwo+PiBPZGVyIENoaW91OyB6aGVuZ3Nx
QHJvY2stY2hpcHMuY29tCj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIEFTb0M6IHJ0NTYxNjogYWRk
IGtjb250cm9sIGZvciBoZWFkcGhvbmUgY2hhbm5lbCBzd2l0Y2gKPj4KPj4gT24gV2VkLCBNYXIg
MDIsIDIwMTYgYXQgMDU6MTg6NDBQTSArMDgwMCwgSm9obiBMaW4gd3JvdGU6Cj4+Cj4+PiAgIAlT
T0NfRE9VQkxFKCJIUCBQbGF5YmFjayBTd2l0Y2giLCBSVDU2MTZfSFBfVk9MLAo+Pj4gICAJCSAg
IFJUNTYxNl9MX01VVEVfU0ZULCBSVDU2MTZfUl9NVVRFX1NGVCwgMSwgMSksCj4+PiArCVNPQ19E
T1VCTEUoIkhQIENoYW5uZWwgU3dpdGNoIiwgUlQ1NjE2X0hQX1ZPTCwKPj4+ICsJCSAgIFJUNTYx
Nl9WT0xfTF9TRlQsIFJUNTYxNl9WT0xfUl9TRlQsIDEsIDEpLAo+PiBXaGF0IGRvZXMgIkNoYW5u
ZWwgU3dpdGNoIiBtZWFuPyAgSXQgbG9va3MgbGlrZSB0aGlzIGlzIGEgbXV0ZSBjb250cm9sCj4+
IGluIHdoaWNoIGNhc2UgaXQgc2hvaXVsZCBiZSBIUCBQbGF5YmFjayBTd2l0Y2ggb3Igc2ltaWxh
ciBsaWtlIG90aGVyCj4+IG11dGUgY29udHJvbHMuCj4+Cj4gWWVzLCBJdCBpcyBhbm90aGVyIG11
dGUgY29udHJvbCB0aGF0IGlzIG1pc3Npbmcgb24gY3VycmVudCBkcml2ZXIuCj4gVGhpcyBtdXRl
IGNvbnRyb2wgaXMgZm9yIGhlYWRwaG9uZSB2b2x1bWUgbXV0ZS4gSXMgaXQgT0sgdG8gcmVuYW1l
IGl0IHRvCj4gJ0hlYWRwaG9uZSBWb2x1bWUgUGxheWJhY2sgU3dpdGNoJz8KSW4gcnQ1NjE2LmMs
IHRoZXJlIGlzIGFub3RoZXIgY29udHJvbCBuYW1lZCAiT1VUIENoYW5uZWwgU3dpdGNoIi4KWW91
IG1heSB3YW50IHRvIHJlbmFtZSBpdCB0b28uCgotIFNodW5xaWFuCj4KPgo+PiAtLS0tLS1QbGVh
c2UgY29uc2lkZXIgdGhlIGVudmlyb25tZW50IGJlZm9yZSBwcmludGluZyB0aGlzIGUtbWFpbC4K
Pgo+CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxz
YS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9t
YWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
