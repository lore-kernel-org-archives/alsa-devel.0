From: Huang Tao <huangtao@rock-chips.com>
Subject: Re: [PATCH 2/2] ASoC: add driver for Rockchip RK3xxx
	I2S controller
Date: Wed, 02 Jul 2014 09:01:49 +0800
Message-ID: <53B359FD.3080809@rock-chips.com>
References: <1404203860-30712-1-git-send-email-xjq@rock-chips.com>
 <1404204458-30881-1-git-send-email-xjq@rock-chips.com>
 <20140701170747.GA15028@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.131])
 by alsa0.perex.cz (Postfix) with ESMTP id BB3F2265150
 for <alsa-devel@alsa-project.org>; Wed,  2 Jul 2014 03:01:56 +0200 (CEST)
In-Reply-To: <20140701170747.GA15028@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: yzq@rock-chips.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, heiko@sntech.de, tiwai@suse.de, linux-kernel@vger.kernel.org, zhangqing@rock-chips.com, lgirdwood@gmail.com, robh+dt@kernel.org, kever.yang@rock-chips.com, zyw@rock-chips.com, jianqun <xjq@rock-chips.com>, kfx@rock-chips.com, grant.likely@linaro.org, cf@rock-chips.com, hj@rock-chips.com, zhenfu.fang@rock-chips.com
List-Id: alsa-devel@alsa-project.org

SGksIE1hcms6Cgrkuo4gMjAxNOW5tDA35pyIMDLml6UgMDE6MDcsIE1hcmsgQnJvd24g5YaZ6YGT
Ogo+PiArc3RhdGljIGlubGluZSB2b2lkIGkyc193cml0ZWwoc3RydWN0IHJrX2kyc19kZXYgKmky
cywgdTMyIHZhbHVlLAo+PiA+ICsJCQkgICAgICB1bnNpZ25lZCBpbnQgb2Zmc2V0KQo+PiA+ICt7
Cj4+ID4gKwl3cml0ZWxfcmVsYXhlZCh2YWx1ZSwgaTJzLT5yZWdzICsgb2Zmc2V0KTsKPj4gPiAr
fQo+PiA+ICsKPj4gPiArc3RhdGljIGlubGluZSB1MzIgaTJzX3JlYWRsKHN0cnVjdCBya19pMnNf
ZGV2ICppMnMsIHVuc2lnbmVkIGludCBvZmZzZXQpCj4+ID4gK3sKPj4gPiArCXJldHVybiByZWFk
bF9yZWxheGVkKGkycy0+cmVncyArIG9mZnNldCk7Cj4+ID4gK30KPiBQZXJoYXBzIHVzZSByZWdt
YXA/ICBUaGUgbWFpbiBhZHZhbnRhZ2Ugd291bGQgYmUgdGhlIGRlYnVnCj4gaW5mcmFzdHJ1Y3R1
cmUsIHRob3VnaCB5b3UgY291bGQgYWxzbyB1c2UgX3VwZGF0ZV9iaXRzKCkgdG8gcmVkdWNlIHRo
ZQo+IGFtb3VudCBvZiB0aW1lIHNwZW50IGxvY2tlZC4KPgpBcmUgeW91IHN1cmU/IFRoaXMgaXMg
YSBJMlMgZHJpdmVyLCB3ZSBjYW4gd3JpdGUgdGhlIHJlZ2lzdGVyIGRpcmVjdGx5LApkbyBub3Qg
dGhyb3VnaCBJMkMgb3IgU1BJIGJ1cy4KV3JpdGUgYSByZWdpc3RlciBpcyBvbmx5IGEgZmV3IGlu
c3RydWN0aW9ucyBvbiBBUk0sIGJ1dCB3cml0ZSB0aHJvdWdoCnJlZ21hcCwgaXQgbWF5IHRha2Ug
YSBsb25nIHBhdGguCkkgdGhpbmsgaXQgd2lsbCBqdXN0IGNvbnN1bWUgQ1BVIHBvd2VyIGFuZCBt
YWtlIHRoZSB3aG9sZSB0aGluZyBtb3JlCmNvbXBsZXguCkNvdWxkIHlvdSB0ZWxsIG1lIHdoYXQg
YmVuZWZpdHMgd2UgY2FuIGdldCBpZiB1c2UgcmVnbWFwPyBPciBzb21ldGhpbmcgSQpqdXN0IG1p
c3Npbmc/CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpB
bHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDov
L21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
