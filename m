From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [PATCH] ASoC: kirkwood: cleanup the external clock
	probe
Date: Mon, 21 Oct 2013 10:28:34 +0200
Message-ID: <20131021102834.768c0887@armhf>
References: <20131021094613.2a07bd79@armhf>
 <20131021080657.GU25034@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
 by alsa0.perex.cz (Postfix) with ESMTP id 0516A2655F3
 for <alsa-devel@alsa-project.org>; Mon, 21 Oct 2013 10:28:19 +0200 (CEST)
In-Reply-To: <20131021080657.GU25034@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, Mark Brown <broonie@kernel.org>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org

T24gTW9uLCAyMSBPY3QgMjAxMyAwOTowNjo1NyArMDEwMApSdXNzZWxsIEtpbmcgLSBBUk0gTGlu
dXggPGxpbnV4QGFybS5saW51eC5vcmcudWs+IHdyb3RlOgoKPiBPbiBNb24sIE9jdCAyMSwgMjAx
MyBhdCAwOTo0NjoxM0FNICswMjAwLCBKZWFuLUZyYW5jb2lzIE1vaW5lIHdyb3RlOgo+ID4gVGhp
cyBwYXRjaCBjaGVja3MgdGhlIHJldHVybiB2YWx1ZSBvZiB0aGUgY2xrX3ByZXBhcmVfZW5hYmxl
IG9mIHRoZQo+ID4gZXh0ZXJuYWwgY2xvY2sgYW5kIHJlbW92ZXMgdGhlIHRlc3QgYWJvdXQgYSBz
YW1lIGludGVybmFsIGFuZCBleHRlcm5hbAo+ID4gY2xvY2sgd2hpY2ggd291bGQgcXVpdGUgbmV2
ZXIgb2NjdXIgYW5kIHdvbid0IHdvcmsgaW4gbW9zdCBjYXNlcwo+ID4gaXQgd291bGQgb2NjdXIu
Cj4gCj4gTkFLLiAgSXQgY2FuIG9jY3VyLgoKSW4gd2hpY2ggY2FzZT8gQW5kLCB3aGF0IHdvdWxk
IGJlIHRoZSByaWdodCB0cmVhdG1lbnQ/CgotLSAKS2VuIGFyIGMnaGVudGHDsQl8CSAgICAgICoq
IEJyZWl6aCBoYSBMaW51eCBhdGF2ISAqKgpKZWYJCXwJCWh0dHA6Ly9tb2luZWpmLmZyZWUuZnIv
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2
ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1h
bi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
