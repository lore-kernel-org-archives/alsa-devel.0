From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH] ASoC: Set more meaningful name for
 SMDK64xx WM8580 audio
Date: Mon, 13 Sep 2010 18:16:44 +0900
Message-ID: <AANLkTinjp1-uGs4mqr4OdW5Evb2YniiiEJrfOLwcdxr8@mail.gmail.com>
References: <1284369074-3494-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 24893103827
	for <alsa-devel@alsa-project.org>;
	Mon, 13 Sep 2010 11:16:45 +0200 (CEST)
Received: by wyb32 with SMTP id 32so5840574wyb.38
	for <alsa-devel@alsa-project.org>; Mon, 13 Sep 2010 02:16:44 -0700 (PDT)
In-Reply-To: <1284369074-3494-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Jassi Brar <jassi.brar@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

T24gTW9uLCBTZXAgMTMsIDIwMTAgYXQgNjoxMSBQTSwgTWFyayBCcm93bgo8YnJvb25pZUBvcGVu
c291cmNlLndvbGZzb25taWNyby5jb20+IHdyb3RlOgo+IFNpbmNlIHRoZSBTTURLNjR4eCBib2Fy
ZHMgaGF2ZSB0d28gYXVkaW8gc3Vic3lzdGVtcyB1c2luZyB0aGUgYm9hcmQKPiBuYW1lIGFzIHRo
ZSBjYXJkIG5hbWUgYnkgaXRzZWxmIGlzbid0IHNvIHVzZXIgZnJpZW5kbHkgYXMgaXQgbWlnaHQK
PiBiZS4KPgo+IFNpZ25lZC1vZmYtYnk6IE1hcmsgQnJvd24gPGJyb29uaWVAb3BlbnNvdXJjZS53
b2xmc29ubWljcm8uY29tPgo+IC0tLQo+IMKgc291bmQvc29jL3MzYzI0eHgvc21kazY0eHhfd204
NTgwLmMgfCDCoCDCoDIgKy0KPiDCoDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9zM2MyNHh4L3NtZGs2NHh4
X3dtODU4MC5jIGIvc291bmQvc29jL3MzYzI0eHgvc21kazY0eHhfd204NTgwLmMKPiBpbmRleCA5
MTM2N2Y3Li4wNTJlNDk5IDEwMDY0NAo+IC0tLSBhL3NvdW5kL3NvYy9zM2MyNHh4L3NtZGs2NHh4
X3dtODU4MC5jCj4gKysrIGIvc291bmQvc29jL3MzYzI0eHgvc21kazY0eHhfd204NTgwLmMKPiBA
QCAtMjQyLDcgKzI0Miw3IEBAIHN0YXRpYyBzdHJ1Y3Qgc25kX3NvY19kYWlfbGluayBzbWRrNjR4
eF9kYWlbXSA9IHsKPiDCoH07Cj4KPiDCoHN0YXRpYyBzdHJ1Y3Qgc25kX3NvY19jYXJkIHNtZGs2
NHh4ID0gewo+IC0gwqAgwqAgwqAgLm5hbWUgPSAic21kazY0eHgiLAo+ICsgwqAgwqAgwqAgLm5h
bWUgPSAiU01ESzY0eHggNS4xIiwKPiDCoCDCoCDCoCDCoC5kYWlfbGluayA9IHNtZGs2NHh4X2Rh
aSwKPiDCoCDCoCDCoCDCoC5udW1fbGlua3MgPSBBUlJBWV9TSVpFKHNtZGs2NHh4X2RhaSksCj4g
wqB9OwoKQWNrZWQtYnk6IEphc3NpIEJyYXIgPGphc3NpLmJyYXJAc2Ftc3VuZy5jb20+Cl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFp
bGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNh
LXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
