From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/5] ASoC: Remove -dai suffix from Samsung
	DAI devices
Date: Fri, 13 Aug 2010 09:59:51 +0100
Message-ID: <CC690F15-7FCE-4BA3-B161-DA7B1216BCC9@opensource.wolfsonmicro.com>
References: <1281607342-13127-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<AANLkTinKaUygGxZc+pBg_LdOpvWcEErcf8yCvqfid5CU@mail.gmail.com>
	<4C64E2DB.5020602@samsung.com>
	(sfid-20100813_071501_882253_5F9EDA3A)
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A00BD103809
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Aug 2010 10:59:53 +0200 (CEST)
In-Reply-To: <4C64E2DB.5020602@samsung.com>
	(sfid-20100813_071501_882253_5F9EDA3A)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassisinghbrar@gmail.com>, Seungwhan Youn <claude.youn@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Seungwhan Youn <sw.youn@samsung.com>
List-Id: alsa-devel@alsa-project.org

T24gMTMgQXVnIDIwMTAsIGF0IDA3OjE0LCBKb29ueW91bmcgU2hpbSB3cm90ZToKPiBPbiAyMDEw
LTA4LTEzIOyYpO2bhCAyOjEyLCBTZXVuZ3doYW4gWW91biB3cm90ZToKPj4gT24gVGh1LCBBdWcg
MTIsIDIwMTAgYXQgNzowMiBQTSwgTWFyayBCcm93bgoKPj4+IGRpZmYgLS1naXQgYS9zb3VuZC9z
b2MvczNjMjR4eC9hcXVpbGFfd204OTk0LmMgYi9zb3VuZC9zb2MvczNjMjR4eC9hcXVpbGFfd204
OTk0LmMKPj4+IGluZGV4IDQ0YjA2ZTkuLjIzNWQxOTcgMTAwNjQ0Cj4+PiAtLS0gYS9zb3VuZC9z
b2MvczNjMjR4eC9hcXVpbGFfd204OTk0LmMKPj4+ICsrKyBiL3NvdW5kL3NvYy9zM2MyNHh4L2Fx
dWlsYV93bTg5OTQuYwo+Pj4gQEAgLTIzMyw3ICsyMzMsNyBAQCBzdGF0aWMgc3RydWN0IHNuZF9z
b2NfZGFpX2xpbmsgYXF1aWxhX2RhaVtdID0gewo+Pj4gIHsKPj4+ICAgICAgICAubmFtZSA9ICJX
TTg5OTQiLAo+Pj4gICAgICAgIC5zdHJlYW1fbmFtZSA9ICJXTTg5OTQgSGlGaSIsCj4+PiAtICAg
ICAgIC5jcHVfZGFpX25hbWUgPSAiczNjNjR4eC1pMnMtdjQtZGFpIiwKPj4+ICsgICAgICAgLmNw
dV9kYWlfbmFtZSA9ICJzM2M2NHh4LWkycy12NCIsCgo+PiBUaGlzIGFxdWlsYSBib2FyZCBhbHNv
IHVzZSBJMlN2NCBmcm9tICdzM2M2NHh4LWkycy12NC5jJywgc28gSSB0aGluawo+PiBpdCdsbCBu
b3Qgd29yayBpZiBjcHVfZGFpX25hbWUgaXMgJ3MzYzY0eHgtaTJzLXY0JyBub3QKPj4gJ3MzYzY0
eHgtaWlzLXY0Jy4KCj4gSXQgY29uZnVzZWQgbWUgYSBsaXR0bGUgdG8gdXNlIHR3byBuYW1lcyAi
aWlzIiBhbmQgImkycyIuIENhbiB3ZSB1bmlmeSB0byBvbmU/CgpUaGVyZSdzIG5vIGNoYW5nZSBi
ZXR3ZWVuIC1pMnMgYW5kIC1paXMgaW50cm9kdWNlZCBieSB0aGlzIHBhdGNoLCBhbGwgdGhpcyBw
YXRjaCBkaWQgd2FzIHN0cmlwIHRoZSAtZGFpIHN1ZmZpeCBmcm9tIHRoZSBuYW1lcy4gSXQgbG9v
a3MgbGlrZSB0aGlzIGlzIGFuIGVycm9yIGluIHRoZSBBcXVpbGxhIGRyaXZlciB3aGljaCBzaG91
bGQgYmUgY29ycmVjdGVkLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5v
cmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2Et
ZGV2ZWwK
