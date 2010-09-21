From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH] ASoC: Prototype s3c64xx_i2s_get_clock()
Date: Tue, 21 Sep 2010 09:29:01 +0900
Message-ID: <AANLkTin37y+CvQExs6eRzqPSS5O0zNL12aDC5nYA3boe@mail.gmail.com>
References: <1285003485-13801-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 07E79245A0
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Sep 2010 02:29:02 +0200 (CEST)
Received: by bwz4 with SMTP id 4so5508009bwz.38
	for <alsa-devel@alsa-project.org>; Mon, 20 Sep 2010 17:29:02 -0700 (PDT)
In-Reply-To: <1285003485-13801-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

T24gVHVlLCBTZXAgMjEsIDIwMTAgYXQgMjoyNCBBTSwgTWFyayBCcm93bgo8YnJvb25pZUBvcGVu
c291cmNlLndvbGZzb25taWNyby5jb20+IHdyb3RlOgo+IFNvIG1hY2hpbmUgZHJpdmVycyBjYW4g
c2VlIHRoZSBkZWNsYXJhdGlvbi4KPgo+IFNpZ25lZC1vZmYtYnk6IE1hcmsgQnJvd24gPGJyb29u
aWVAb3BlbnNvdXJjZS53b2xmc29ubWljcm8uY29tPgo+IC0tLQo+IMKgc291bmQvc29jL3MzYzI0
eHgvczNjNjR4eC1pMnMuaCB8IMKgIMKgMSArCj4gwqAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0
aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9zb3VuZC9zb2MvczNjMjR4
eC9zM2M2NHh4LWkycy5oIGIvc291bmQvc29jL3MzYzI0eHgvczNjNjR4eC1pMnMuaAo+IGluZGV4
IDE5YmQ0NDQuLmRlNDA3NWQgMTAwNjQ0Cj4gLS0tIGEvc291bmQvc29jL3MzYzI0eHgvczNjNjR4
eC1pMnMuaAo+ICsrKyBiL3NvdW5kL3NvYy9zM2MyNHh4L3MzYzY0eHgtaTJzLmgKPiBAQCAtMzYs
NSArMzYsNiBAQCBzdHJ1Y3QgY2xrOwo+IMKgIMKgIMKgIMKgKFNORFJWX1BDTV9GTVRCSVRfUzgg
fCBTTkRSVl9QQ01fRk1UQklUX1MxNl9MRSB8XAo+IMKgIMKgIMKgIMKgIFNORFJWX1BDTV9GTVRC
SVRfUzI0X0xFKQo+Cj4gK3N0cnVjdCBjbGsgKnMzYzY0eHhfaTJzX2dldF9jbG9jayhzdHJ1Y3Qg
c25kX3NvY19kYWkgKmRhaSk7Cj4KPiDCoCNlbmRpZiAvKiBfX1NORF9TT0NfUzNDMjRYWF9TM0M2
NFhYX0kyU19IICovCgpBY2tlZC1ieTogSmFzc2kgQnJhciA8amFzc2kuYnJhckBzYW1zdW5nLmNv
bT4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1k
ZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWls
bWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
