From: "ykk@rock-chips.com" <ykk@rock-chips.com>
Subject: Re: [PATCH 5/6] dt-bindings: Add documentation for
	Rockchip hdmi-audio
Date: Mon, 15 Dec 2014 17:28:12 +0800
Message-ID: <201412151725475801333@rock-chips.com>
References: <1418609494-15820-1-git-send-email-ykk@rock-chips.com>,
 <1418612114-19692-1-git-send-email-ykk@rock-chips.com>,
 <548EA3B9.5080407@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.137])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B51B26044B
 for <alsa-devel@alsa-project.org>; Mon, 15 Dec 2014 10:28:38 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Mark Rutland <mark.rutland@arm.com>, alsa-devel <alsa-devel@alsa-project.org>, Heiko Stuebner <heiko@sntech.de>, devicetree <devicetree@vger.kernel.org>, David Airlie <airlied@linux.ie>, dri-devel <dri-devel@lists.freedesktop.org>, Liam Girdwood <lgirdwood@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Bard Liao <bardliao@realtek.com>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Takashi Iwai <tiwai@suse.de>, linux-rockchip <linux-rockchip@lists.infradead.org>, Grant Likely <grant.likely@linaro.org>, Dylan Reid <dgreid@chromium.org>, Xu Jianqun <jay.xu@rock-chips.com>, Oder Chiou <oder_chiou@realtek.com>, "Zubair.Kakakhel" <Zubair.Kakakhel@imgtec.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jyri Sarha <jsarha@ti.com>, Ben Zhang <benzh@chromium.org>, Rob Herring <robh+dt@kernel.org>, Daniel Kurtz <djkurtz@ch>
List-Id: alsa-devel@alsa-project.org

SGkgbGFyczoNCg0KdGhrcyBmb3IgeW91ciByZXZpZXcsIEkgd2lsbCBtb3ZlIGl0IHRvIGhkbWkg
YXVkaW8gZHJpdmVyLCBnaXZlIHRoZSBjb2RlY19uYW1lICYgY29kZWNfZGFpX25hbWUgYW4gY29u
c3Qgc3RyaW5nLg0KDQpCZXN0IFJlZ2FyZHMuDQoNCg0KWWFuZyBLdWFuS3VhbiB8IFNvZnR3YXJl
IEVuZ2luZWVyIHwgMTUwNjA0MTY3ODMgfCB5a2tAcm9jay1jaGlwcy5jb20NCiANCkZyb206IExh
cnMtUGV0ZXIgQ2xhdXNlbg0KRGF0ZTogMjAxNC0xMi0xNSAxNzowMg0KVG86IFlha2lyIFlhbmcN
CkNDOiBIZWlrbyBTdHVlYm5lcjsgUm9iIEhlcnJpbmc7IFBhd2VsIE1vbGw7IE1hcmsgUnV0bGFu
ZDsgSWFuIENhbXBiZWxsOyBLdW1hciBHYWxhOyBSdXNzZWxsIEtpbmc7IFBoaWxpcHAgWmFiZWw7
IFp1YmFpci5LYWtha2hlbDsgRmFiaW8gRXN0ZXZhbTsgU2hhd24gR3VvOyBkcmktZGV2ZWw7IERh
bmllbCBLdXJ0ejsgU29ubnkgUmFvOyBEeWxhbiBSZWlkOyBYdSBKaWFucXVuOyBTdO+/ve+/vXBo
YW5lIE1hcmNoZXNpbjsgQnJpYW4gQXVzdGluOyBCYXJkIExpYW87IE1heCBGaWxpcHBvdjsgT2Rl
ciBDaGlvdTsgZGV2aWNldHJlZTsgbGludXgta2VybmVsOyBsaW51eC1hcm0ta2VybmVsOyBsaW51
eC1yb2NrY2hpcDsgYWxzYS1kZXZlbDsgQXJuZCBCZXJnbWFubjsgRGF2aWQgQWlybGllOyBTZWFu
IENyb3NzOyBHcmFudCBMaWtlbHk7IEdyZWcgS3JvYWgtSGFydG1hbjsgQmVuIFpoYW5nOyBMaWFt
IEdpcmR3b29kOyBKYXJvc2xhdiBLeXNlbGE7IE1hcmsgQnJvd247IFRha2FzaGkgSXdhaTsgSnly
aSBTYXJoYQ0KU3ViamVjdDogUmU6IFtQQVRDSCA1LzZdIGR0LWJpbmRpbmdzOiBBZGQgZG9jdW1l
bnRhdGlvbiBmb3IgUm9ja2NoaXAgaGRtaS1hdWRpbw0KT24gMTIvMTUvMjAxNCAwMzo1NSBBTSwg
WWFraXIgWWFuZyB3cm90ZToNClsuLi5dDQo+ICstIGNvZGVjLW5hbWU6IHRoZSBkdy1oZG1pIGNv
ZGVjJ3MgZGV2aWNlIG5hbWUNCj4gKy0gY29kZWMtZGFpLW5hbWU6IHRoZSBkdy1oZG1pIGNvZGVj
J3MgZGFpIG5hbWUNCiANClBsZWFzZSB5b3UgcGhhbmRsZXMgZm9yIHRoaXMsIHRoZSBuYW1lcyBh
cmUgTGludXggZHJpdmVyIGFuZCBmcmFtZXdvcmsgDQpzcGVjaWZpYyBkZXRhaWxzLiBUaGF0IHNo
b3VsZCBub3QgbGVhayBpbnRvIHRoZSBEVCBiaW5kaW5ncy4NCiANClsuLl0NCiANCiANCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFp
bGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNh
LXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
