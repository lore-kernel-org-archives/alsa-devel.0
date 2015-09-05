From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 6/9] drm: bridge/dw_hdmi: adjust pixel clock values in N
 calculation
Date: Sat, 5 Sep 2015 12:44:51 -0700
Message-ID: <CAD=FV=WsKgQRrKNmN+sFwQBCC2XiJLOg-yzg5w6w8n6qk8MjRQ@mail.gmail.com>
References: <20150808160936.GN7557@n2100.arm.linux.org.uk>
 <E1ZO6hc-0003NW-55@rmk-PC.arm.linux.org.uk>
 <CAD=FV=WXjcp-wyH_SKexHJDo8R9Xug4yMAOHFPWPYBgiTyM=PQ@mail.gmail.com>
 <CAD=FV=WnVLiCNYgZ8idpknD==Rw7UaLCY1gky4G0TvwUR-VATw@mail.gmail.com>
 <20150904212401.GI21084@n2100.arm.linux.org.uk>
 <CAD=FV=U7h6b1eR+cva6VywcLP8RL2p5sAMSWc_vzUCg6WfWCYQ@mail.gmail.com>
 <20150905002733.GJ21084@n2100.arm.linux.org.uk>
 <CAD=FV=WR4iJ57FLh1d46-s9Gu-4wW6NdoROx-kNbbA0zFpUo0w@mail.gmail.com>
 <20150905083107.GK21084@n2100.arm.linux.org.uk>
 <CAD=FV=XzPRHE6n-svm=0_9jXUORY5NPzfmgS0Ncp7PXXbqivOw@mail.gmail.com>
 <20150905140136.GM21084@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20150905140136.GM21084@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Jaroslav Kysela <perex@perex.cz>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Mark Brown <broonie@kernel.org>, Yakir Yang <ykk@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

SGksCgpPbiBTYXQsIFNlcCA1LCAyMDE1IGF0IDc6MDEgQU0sIFJ1c3NlbGwgS2luZyAtIEFSTSBM
aW51eAo8bGludXhAYXJtLmxpbnV4Lm9yZy51az4gd3JvdGU6Cj4+IElmIHlvdSBrbm93IHRoZSBh
bnN3ZXIsIGp1c3QgdGVsbCBtZS4gIElmIHlvdSdyZSB0YWxraW5nIGFib3V0IDc0LjI1Cj4+IHZz
LiAzMiBrSHogaXQgaXMgZnVydGhlciBldmlkZW5jZSBvZiB3aGF0IEknbSBzYXlpbmcuICBOb3Rl
IHRoYXQKPj4gcGlja2luZyBvbmx5IG9uZSBvZiB0aGUgdHdvIGxpc3RlZCBDVFMgdmFsdWVzIGFn
YWluIHB1dHMgeW91IGluIGEKPj4gd29yc2UgcG9zaXRpb24gZm9yIHJlZ2VuZXJhdGluZyB0aGUg
cHJvcGVyIGF1ZGlvIGNsb2NrIHRoZW4ganVzdCB1c2luZwo+PiB0aGUgZGVmYXVsdCBOPTQwOTYu
Cj4KPiBObyBpdCBkb2Vzbid0Lgo+Cj4gNzQuMjVNSHovMS4wMDEgKiA0MDk2IC8gKDEyOCAqIDMy
MDAwKSA9IDc0MTc1IChyb3VuZGVkIGRvd24pCj4KPiBOb3cgZG8gdGhlIGNhbGN1YXRpb24uCj4K
PiAoNzQuMjVNSHovMS4wMDEpIC8gNzQxNzUgKiA0MDk2ID0gNDA5NjA0NS41MTEgPT4gMzIwMDAu
MzU1NTZIego+ICAgICAgICAgPT4gZXJyb3Igb2YgMC4wMDExMTElCj4KPiBOb3cgZm9yIHRoZSBj
YWxjdWF0aW9uIHVzaW5nIHRoZSBwcm9zY3JpYmVkIGZpZ3VyZXMuCj4KPiAoNzQuMjVNSHovMS4w
MDEpIC8gMjEwOTM3ICogMTE2NDggPSA0MDk2MDA5LjcwOSA9PiAzMjAwMC4wNzU4NUh6Cj4gICAg
ICAgICA9PiBlcnJvciBvZiAwLjAwMDIzNyUKPgoKV2h5IHdvdWxkIHlvdSByb3VuZCBkb3duPz8/
ICBSb3VuZCB0byB0aGUgY2xvc2VzdC4KCig3NDI1MDAwMCAvIDEuMDAxICogNDA5NikgIC8gKDEy
OCAqIDMyMDAwLikKPT4gNzQxNzUuODI0MTc1ODI0MTgKPT4gNzQxNzYKCig3NDI1MDAwMCAvIDEu
MDAxKSAvIDc0MTc2ICogNDA5NiAvIDEyOAo9PiAzMTk5OS45MjQxNDgzMjc5NDcKClRoYXQncyBh
Y3R1YWxseSB0aGUgc2FtZSBlcnJvciBhcyB5b3VyczogMC4wMDAyMzclCgpZb3UncmUgcmlnaHQu
ICBZb3VycyBpc24ndCB3b3JzZSwgYnV0IGl0J3MgYWxzbyBub3QgYW55IGJldHRlci4KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxp
bmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
