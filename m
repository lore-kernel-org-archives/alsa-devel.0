From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [RFC] ASoC: Add machine driver for i.MX SGTL500
 based boards
Date: Wed, 6 Jul 2011 13:07:21 -0300
Message-ID: <CAOMZO5B8Pd5h-cknaSqb30TAY3JUae6a0wVbRrQey4K9yTdU0A@mail.gmail.com>
References: <1309804915-27544-1-git-send-email-fabio.estevam@freescale.com>
	<20110704192322.GB32624@opensource.wolfsonmicro.com>
	<CAOMZO5Cxsg5Z=PkWwkowEG=e_D5G=zM+ZHEDQ8NHYQCSsHv9vw@mail.gmail.com>
	<20110705232537.GA9452@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 7597324362
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Jul 2011 18:07:24 +0200 (CEST)
Received: by gyc15 with SMTP id 15so39504gyc.38
	for <alsa-devel@alsa-project.org>; Wed, 06 Jul 2011 09:07:21 -0700 (PDT)
In-Reply-To: <20110705232537.GA9452@opensource.wolfsonmicro.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, lrg@ti.com, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

T24gVHVlLCBKdWwgNSwgMjAxMSBhdCA4OjI1IFBNLCBNYXJrIEJyb3duCjxicm9vbmllQG9wZW5z
b3VyY2Uud29sZnNvbm1pY3JvLmNvbT4gd3JvdGU6Cj4gT24gVHVlLCBKdWwgMDUsIDIwMTEgYXQg
MDY6NTY6NDVQTSAtMDMwMCwgRmFiaW8gRXN0ZXZhbSB3cm90ZToKPgo+PiAsYnV0IGFwbGF5IGlz
IGZhaWxpbmc6Cj4KPj4gcm9vdEBmcmVlc2NhbGUgL2hvbWUkIGFwbGF5IHRvbmUud2F2Cj4+IFBs
YXlpbmcgV0FWRSAndG9uZS53YXYnIDogU2lnbmVkIDE2IGJpdCBMaXR0bGUgRW5kaWFuLCBSYXRl
IDQ0Cj4+IDEwMCBIeiwgU3RlcmVvCj4+IGFzb2M6IHBsYXRmb3JtIGlteC1wY20tYXVkaW8uMCBo
dyBwYXJhbXMgZmFpbGVkCj4+IGFwbGF5OiBzZXRfcGFyYW1zOjk1OTogVW5hYmxlIHRvIGluc3Rh
bGwgaHcgcGFyYW1zOgo+Cj4gU28gdGhlIGVycm9yIG1lc3NhZ2Ugc2F5cyB0aGF0IGlteC1wY20t
YXVkaW8uMCBod19wYXJhbXMoKSBkb2Vzbid0Cj4gc3VwcG9ydCB0aGUgZm9ybWF0IHlvdSdyZSB0
cnlpbmcgdG8gcGxheS4gwqBZb3Ugc2hvdWxkIGNoZWNrIHRoZSBjb2RlIHRvCj4gc2VlIHdoeSBp
dCdzIHJldHVybmluZyBhbiBlcnJvci4KClRoZSBlcnJvciBpcyBjb21pbmcgZnJvbSAgZG1hX3Jl
cXVlc3RfY2hhbm5lbCBpbnNpZGUgaW14X3NzaV9kbWFfYWxsb2MKZnVuY3Rpb24gaW4Kc291bmQv
c29jL2lteC1wY20tZG1hLW14Mi5jOgoKCmlwcnRkLT5kbWFfY2hhbiA9IGRtYV9yZXF1ZXN0X2No
YW5uZWwobWFzaywgZmlsdGVyLCBpcHJ0ZCk7CglpZiAoIWlwcnRkLT5kbWFfY2hhbikKCQlyZXR1
cm4gLUVJTlZBTDsKClNhc2NoYSwKCldvdWxkIHlvdSBoYXZlIGFueSBzdWdnZXN0aW9uIGFzIHRv
IHdodCB0aGUgZG1hX3JlcXVlc3RfY2hhbm5lbCBmYWlscz8KClRoYW5rcywKCkZhYmlvIEVzdGV2
YW0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1k
ZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWls
bWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
