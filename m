From: Joonyoung Shim <dofmind@gmail.com>
Subject: Re: [PATCH 1/5] ASoC: Remove -dai suffix from Samsung
 DAI devices
Date: Fri, 13 Aug 2010 18:29:46 +0900
Message-ID: <AANLkTikZ=uWbBr-Tmm887HLtgKXbubftyh_NCYRzQ2N5@mail.gmail.com>
References: <1281607342-13127-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<AANLkTinKaUygGxZc+pBg_LdOpvWcEErcf8yCvqfid5CU@mail.gmail.com>
	<4C64E2DB.5020602@samsung.com>
	<CC690F15-7FCE-4BA3-B161-DA7B1216BCC9@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="euc-kr"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51]) by alsa0.perex.cz (Postfix) with ESMTP id 615B3244E7
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Aug 2010 11:29:47 +0200 (CEST)
Received: by qwj9 with SMTP id 9so2644827qwj.38
	for <alsa-devel@alsa-project.org>; Fri, 13 Aug 2010 02:29:46 -0700 (PDT)
In-Reply-To: <CC690F15-7FCE-4BA3-B161-DA7B1216BCC9@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Joonyoung Shim <jy0922.shim@samsung.com>, Jassi Brar <jassisinghbrar@gmail.com>, Seungwhan Youn <claude.youn@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>, Seungwhan Youn <sw.youn@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

MjAxMC84LzEzIE1hcmsgQnJvd24gPGJyb29uaWVAb3BlbnNvdXJjZS53b2xmc29ubWljcm8uY29t
PjoKPiBPbiAxMyBBdWcgMjAxMCwgYXQgMDc6MTQsIEpvb255b3VuZyBTaGltIHdyb3RlOgo+PiBP
biAyMDEwLTA4LTEzIL/AyMQgMjoxMiwgU2V1bmd3aGFuIFlvdW4gd3JvdGU6Cj4+PiBPbiBUaHUs
IEF1ZyAxMiwgMjAxMCBhdCA3OjAyIFBNLCBNYXJrIEJyb3duCj4KPj4+PiBkaWZmIC0tZ2l0IGEv
c291bmQvc29jL3MzYzI0eHgvYXF1aWxhX3dtODk5NC5jIGIvc291bmQvc29jL3MzYzI0eHgvYXF1
aWxhX3dtODk5NC5jCj4+Pj4gaW5kZXggNDRiMDZlOS4uMjM1ZDE5NyAxMDA2NDQKPj4+PiAtLS0g
YS9zb3VuZC9zb2MvczNjMjR4eC9hcXVpbGFfd204OTk0LmMKPj4+PiArKysgYi9zb3VuZC9zb2Mv
czNjMjR4eC9hcXVpbGFfd204OTk0LmMKPj4+PiBAQCAtMjMzLDcgKzIzMyw3IEBAIHN0YXRpYyBz
dHJ1Y3Qgc25kX3NvY19kYWlfbGluayBhcXVpbGFfZGFpW10gPSB7Cj4+Pj4gIHsKPj4+PiAgICAg
ICAgLm5hbWUgPSAiV004OTk0IiwKPj4+PiAgICAgICAgLnN0cmVhbV9uYW1lID0gIldNODk5NCBI
aUZpIiwKPj4+PiAtICAgICAgIC5jcHVfZGFpX25hbWUgPSAiczNjNjR4eC1pMnMtdjQtZGFpIiwK
Pj4+PiArICAgICAgIC5jcHVfZGFpX25hbWUgPSAiczNjNjR4eC1pMnMtdjQiLAo+Cj4+PiBUaGlz
IGFxdWlsYSBib2FyZCBhbHNvIHVzZSBJMlN2NCBmcm9tICdzM2M2NHh4LWkycy12NC5jJywgc28g
SSB0aGluawo+Pj4gaXQnbGwgbm90IHdvcmsgaWYgY3B1X2RhaV9uYW1lIGlzICdzM2M2NHh4LWky
cy12NCcgbm90Cj4+PiAnczNjNjR4eC1paXMtdjQnLgo+Cj4+IEl0IGNvbmZ1c2VkIG1lIGEgbGl0
dGxlIHRvIHVzZSB0d28gbmFtZXMgImlpcyIgYW5kICJpMnMiLiBDYW4gd2UgdW5pZnkgdG8gb25l
Pwo+Cj4gVGhlcmUncyBubyBjaGFuZ2UgYmV0d2VlbiAtaTJzIGFuZCAtaWlzIGludHJvZHVjZWQg
YnkgdGhpcyBwYXRjaCwgYWxsIHRoaXMgcGF0Y2ggZGlkIHdhcyBzdHJpcCB0aGUgLWRhaSBzdWZm
aXggZnJvbSB0aGUgbmFtZXMuIEl0IGxvb2tzIGxpa2UgdGhpcyBpcyBhbiBlcnJvciBpbiB0aGUg
QXF1aWxsYSBkcml2ZXIgd2hpY2ggc2hvdWxkIGJlIGNvcnJlY3RlZC4KCkkgZGlkbid0IG1lYW4g
dG8gdGVsbCBhYm91dCB0aGlzIHBhdGNoLiBJIHdvdWxkIGxpa2UgdG8ganVzdCBzYXkgYWJvdXQK
aTJzIGFuZCBpaXMgbmFtaW5nIG9uIHNhbXN1bmcgcGxhdGZvcm0gZHJpdmVyLgoKVGhhbmtzLgoK
LS0gCi0gSm9vbnlvdW5nIFNoaW0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2pl
Y3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bHNhLWRldmVsCg==
