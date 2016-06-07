From: Xing Zheng <zhengxing@rock-chips.com>
Subject: Re: [PATCH v3] ASoC: rockchip: Add machine driver for
	MAX98357A/RT5514/DA7219
Date: Tue, 07 Jun 2016 20:47:01 +0800
Message-ID: <5756C245.7010001@rock-chips.com>
References: <1464267742-15312-1-git-send-email-zhengxing@rock-chips.com>
 <20160601144542.GA3835@rob-hp-laptop> <5751912C.6080904@rock-chips.com>
 <20160606235026.GP7510@sirena.org.uk> <5756363F.40208@rock-chips.com>
 <20160607104711.GR7510@sirena.org.uk> <5756B22F.9000105@rock-chips.com>
 <20160607120647.GV7510@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.138])
 by alsa0.perex.cz (Postfix) with ESMTP id C9F522605B8
 for <alsa-devel@alsa-project.org>; Tue,  7 Jun 2016 14:47:26 +0200 (CEST)
In-Reply-To: <20160607120647.GV7510@sirena.org.uk>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, alsa-devel@alsa-project.org, heiko@sntech.de, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, dianders@chromium.org, Liam Girdwood <lgirdwood@gmail.com>, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

SGkgTWFyaywKCk9uIDIwMTblubQwNuaciDA35pelIDIwOjA2LCBNYXJrIEJyb3duIHdyb3RlOgo+
IE9LLCB0aGVuIHRoZSBvcmlnaW5hbCBuYW1lIHByb2JhYmx5IG1ha2VzIHNvbWUgc2Vuc2UgdGhv
dWdoIHJlYWxseQo+IHRoYXQncyBzdWNoIGFuIHVudXN1YWwgZGVzaWduIHRoYXQganVzdCBuYW1p
bmcgaXQgYWZ0ZXIgdGhlIHNwZWNpZmljCj4gYm9hcmQgbWlnaHQgYmUgYmV0dGVyLCBpdCdzIG5v
dCBsaWtlbHkgdG8gc2VlIGFueSByZXVzZSBJJ2QgZ3Vlc3MuClRoZXJlIGFyZSBub3Qgb25seSBv
bmUgdHlwZSBvZiBib2FyZCB3aXRoIHRoaXMgYXVkaW8gY29ubmVjdGlvbiwgc28gSSAKdGhpbmsg
d2UgZG9uJ3QgbmVlZCB0byBhZGQgc3BlY2lmaWMgYm9hcmQgbmFtZS4KClRoZXJlZm9yZSwgSSBp
bnRlbmQgdG8gcmVjb3ZlciBvcmlnaW5hbCBuYW1lIAoocmszMzk5X21heDk4MzU3YV9ydDU1MTRf
ZGE3MjE5LmMpLCBhbmQgZGVzY3JpcHRpb24gbGlrZSB0aGlzOgpzb3VuZCB7CiAgICAgY29tcGF0
aWJsZSA9ICJyb2NrY2hpcCxyazMzOTktbWF4OTgzNTdhLXJ0NTUxNC1kYTcyMTkiOwogICAgIHJv
Y2tjaGlwLGNwdSA9IDwmaTJzMCAmaTJzMCAmaTJzMD47ICAgICAgICAgICAgICAgLy8gbm90ZSAo
d2lsbCBub3QgCmJlIHNlbnQgdG8gdXBzdHJlYW0pOiBJbiBmdXR1cmUsIHdlIG1heSB1c2UgdGhl
IGkyczEgb3IgaTJzMi4uLgogICAgIHJvY2tjaGlwLGNvZGVjID0gPCZtYXg5ODM1N2EgJmhlYWRz
ZXRjb2RlYyAmY29kZWM+Owp9OwoKQ291bGQgeW91IHBsZWFzZSBhZ3JlZSB0byBkbyB0aGlzPwoK
VGhhbmtzLgoKLS0gCi0gWGluZyBaaGVuZwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxz
YS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlz
dGluZm8vYWxzYS1kZXZlbAo=
