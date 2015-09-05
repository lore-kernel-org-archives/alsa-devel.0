From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 6/9] drm: bridge/dw_hdmi: adjust pixel clock values in N
 calculation
Date: Sat, 5 Sep 2015 06:46:04 -0700
Message-ID: <CAD=FV=XzPRHE6n-svm=0_9jXUORY5NPzfmgS0Ncp7PXXbqivOw@mail.gmail.com>
References: <20150808160936.GN7557@n2100.arm.linux.org.uk>
 <E1ZO6hc-0003NW-55@rmk-PC.arm.linux.org.uk>
 <CAD=FV=WXjcp-wyH_SKexHJDo8R9Xug4yMAOHFPWPYBgiTyM=PQ@mail.gmail.com>
 <CAD=FV=WnVLiCNYgZ8idpknD==Rw7UaLCY1gky4G0TvwUR-VATw@mail.gmail.com>
 <20150904212401.GI21084@n2100.arm.linux.org.uk>
 <CAD=FV=U7h6b1eR+cva6VywcLP8RL2p5sAMSWc_vzUCg6WfWCYQ@mail.gmail.com>
 <20150905002733.GJ21084@n2100.arm.linux.org.uk>
 <CAD=FV=WR4iJ57FLh1d46-s9Gu-4wW6NdoROx-kNbbA0zFpUo0w@mail.gmail.com>
 <20150905083107.GK21084@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20150905083107.GK21084@n2100.arm.linux.org.uk>
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

UnVzc2VsbCwKCk9uIFNhdCwgU2VwIDUsIDIwMTUgYXQgMTozMSBBTSwgUnVzc2VsbCBLaW5nIC0g
QVJNIExpbnV4CjxsaW51eEBhcm0ubGludXgub3JnLnVrPiB3cm90ZToKPiBPbiBGcmksIFNlcCAw
NCwgMjAxNSBhdCAwNzowMzoxMVBNIC0wNzAwLCBEb3VnIEFuZGVyc29uIHdyb3RlOgo+PiBBS0E6
IGp1c3QgcmVwbGFjZSB5b3VyIGVudGlyZSAiY29tcHV0ZV9uIiBmdW5jdGlvbiB3aXRoOgo+Pgo+
PiByZXR1cm4gKDEyOCAqIGZyZXEpIC8gMTAwMDsKPj4KPj4gLi4uYW5kIGl0J3MgMTAwJSBzaW1w
bGVyIF9hbmRfIGdldHMgeW91IGEgKG1hcmdpbmFsbHkpIGJldHRlciByYXRlCj4+IChhc3N1bWlu
ZyB5b3UgcmVhbGx5IGhhdmUgMjIuMTc1MDAwKS4gIElmIGl0IHdhcyBqdXN0IGFib3V0IGEKPj4g
MzIwMDAuMjIyIHZzIDMyMDAwIEknZCBub3QgYmUgc2F5aW5nIGFueXRoaW5nIHJpZ2h0IG5vdy4g
IEl0J3MgYWJvdXQKPj4gYWRkaW5nIGNvbXBsZXhpdHkuCj4KPiBOby4gIEl0IGRvZXNuJ3Qgd29y
ayBmb3IgYWxsIGNhc2VzLiAgRG8gdGhlIGNhbGN1bGF0aW9ucyBmb3IgZXZlcnkKPiBzYW1wbGUg
cmF0ZSBpbiB0aG9zZSB0YWJsZXMgaW4gdGhlIEhETUkgc3BlYywgYW5kIHlvdSdsbCBmaW5kIG91
dAo+IHdoeS4KCklmIHlvdSBrbm93IHRoZSBhbnN3ZXIsIGp1c3QgdGVsbCBtZS4gIElmIHlvdSdy
ZSB0YWxraW5nIGFib3V0IDc0LjI1CnZzLiAzMiBrSHogaXQgaXMgZnVydGhlciBldmlkZW5jZSBv
ZiB3aGF0IEknbSBzYXlpbmcuICBOb3RlIHRoYXQKcGlja2luZyBvbmx5IG9uZSBvZiB0aGUgdHdv
IGxpc3RlZCBDVFMgdmFsdWVzIGFnYWluIHB1dHMgeW91IGluIGEKd29yc2UgcG9zaXRpb24gZm9y
IHJlZ2VuZXJhdGluZyB0aGUgcHJvcGVyIGF1ZGlvIGNsb2NrIHRoZW4ganVzdCB1c2luZwp0aGUg
ZGVmYXVsdCBOPTQwOTYuCgotRG91ZwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cDovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2RyaS1kZXZlbAo=
