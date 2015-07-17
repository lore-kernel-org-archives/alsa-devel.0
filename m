From: zhengxing <zhengxing@rock-chips.com>
Subject: Re: [PATCH 1/2] ASoC: rockchip: Add machine driver for
	max98090 codec
Date: Fri, 17 Jul 2015 10:17:25 +0800
Message-ID: <55A865B5.7020609@rock-chips.com>
References: <1436930143-31361-1-git-send-email-zhengxing@rock-chips.com>
 <1436930143-31361-2-git-send-email-zhengxing@rock-chips.com>
 <1437033944.27428.11.camel@tiscali.nl> <20150716110032.GU11162@sirena.org.uk>
 <1437047261.28351.6.camel@tiscali.nl> <20150716125529.GG4039@sirena.org.uk>
 <1437056116.28351.19.camel@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.135])
 by alsa0.perex.cz (Postfix) with ESMTP id CD92F26062E
 for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2015 04:23:34 +0200 (CEST)
In-Reply-To: <1437056116.28351.19.camel@tiscali.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: alsa-devel@alsa-project.org, heiko@sntech.de, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, dianders@chromium.org, Liam Girdwood <lgirdwood@gmail.com>, linux-rockchip@lists.infradead.org, Mark Brown <broonie@kernel.org>, dgreid@chromium.org, sonnyrao@chromium.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

SGkgUGF1bCwKT24gMjAxNeW5tDA35pyIMTbml6UgMjI6MTUsIFBhdWwgQm9sbGUgd3JvdGU6Cj4K
PiBUaGF0J3MgZXhhY3RseSBob3cgSSB1bmRlcnN0b29kIE1PRFVMRV9BTElBUygpIHRvIHdvcmsu
Cj4KPiBBbmQgaXQgd29ya3MsIGluIHNob3J0LCBiZWNhdXNlIGEgcGxhdGZvcm0gZGV2aWNlIGZp
cmVzIGEKPiAiTU9EQUxJQVM9cGxhdGZvcm06Wy4uLl0iIHVldmVudCB3aGVuIGl0J3MgY3JlYXRl
ZC4gQW5kIHVzZXJzcGFjZSB1c2VzCj4gdGhhdCB1ZXZlbnQgdG8gbG9hZCB0aGUgbW9kdWxlIGNh
cnJ5aW5nIHRoYXQgYWxpYXMuCj4KPiBMZXQncyBwdXQgaXQgdGhpcyB3YXMuIElmIG9uZSBkb2Vz
Cj4gICAgICBzdWRvIGZpbmQgL3N5cyAtcGVybSAtbz1yIC1uYW1lIHVldmVudCAtZXhlYyBncmVw
IC1IIE1PREFMSUFTPXBsYXRmb3JtOiB7fSBcOwo+Cj4gb3IKPiAgICAgIHN1ZG8gZmluZCAvc3lz
IC1wZXJtIC1vPXIgLW5hbWUgbW9kYWxpYXMgLWV4ZWMgZ3JlcCAtSCBwbGF0Zm9ybToge30gXDsK
Pgo+IChib3RoIGxpc3RzIHNob3VsZCBiZSBzaW1pbGFyKQo+Cj4gb24gdGhlIHN5c3RlbXMgdGhp
cyBwYXRjaCBpcyB0YXJnZXRpbmcsIHdpbGwKPiAgICAgcGxhdGZvcm06cm9ja2NoaXAtc25kLW1h
eDk4MDkwCj4KPiB0aGVuIHNob3cgdXA/Cj4KPiBUaGFua3MsCj4KPgo+IFBhdWwgQm9sbGUKPgpU
aGFuayB5b3UgZm9yIHlvdXIgcGF0aWVuY2UgYW5kIGRldGFpbGVkIGV4cGxhbmF0aW9uLgpJIHRl
c3RlZCB5b3VyIHR3byB3YXlzIGFuZCBkaWRuJ3QgZmluZCB0aGUgCiJwbGF0Zm9ybTpyb2NrY2hp
cC1zbmQtbWF4OTgwOTAiIGluIG15IGRldmljZShrZXJuZWwgdjMuMTQpLCBhbmQgdGhlIApkcml2
ZXIgcGF0aCBpczoKbG9jYWxob3N0IHJvY2tjaGlwLXNuZC1tYXg5ODA5MCAjIHB3ZAovc3lzL2J1
cy9wbGF0Zm9ybS9kcml2ZXJzL3JvY2tjaGlwLXNuZC1tYXg5ODA5MAoKVGhhbmtzLgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWls
aW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2Et
cHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
