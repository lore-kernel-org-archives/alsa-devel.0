From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 6/9] drm: bridge/dw_hdmi: adjust pixel clock values in N
 calculation
Date: Sat, 5 Sep 2015 06:50:07 -0700
Message-ID: <CAD=FV=UH85ST+F0mi2EEeOMFB8iSyzLUx7P8uFWf6dDUG2yGOQ@mail.gmail.com>
References: <20150808160936.GN7557@n2100.arm.linux.org.uk>
 <E1ZO6hc-0003NW-55@rmk-PC.arm.linux.org.uk>
 <CAD=FV=WXjcp-wyH_SKexHJDo8R9Xug4yMAOHFPWPYBgiTyM=PQ@mail.gmail.com>
 <CAD=FV=WnVLiCNYgZ8idpknD==Rw7UaLCY1gky4G0TvwUR-VATw@mail.gmail.com>
 <20150904212401.GI21084@n2100.arm.linux.org.uk>
 <CAD=FV=U7h6b1eR+cva6VywcLP8RL2p5sAMSWc_vzUCg6WfWCYQ@mail.gmail.com>
 <20150905002733.GJ21084@n2100.arm.linux.org.uk>
 <CAD=FV=WR4iJ57FLh1d46-s9Gu-4wW6NdoROx-kNbbA0zFpUo0w@mail.gmail.com>
 <20150905083422.GL21084@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20150905083422.GL21084@n2100.arm.linux.org.uk>
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

UnVzc2VsbCwKCk9uIFNhdCwgU2VwIDUsIDIwMTUgYXQgMTozNCBBTSwgUnVzc2VsbCBLaW5nIC0g
QVJNIExpbnV4CjxsaW51eEBhcm0ubGludXgub3JnLnVrPiB3cm90ZToKPiBPbiBGcmksIFNlcCAw
NCwgMjAxNSBhdCAwNzowMzoxMVBNIC0wNzAwLCBEb3VnIEFuZGVyc29uIHdyb3RlOgo+PiBUaGVu
IHBlcmhhcHMgeW91IHNob3VsZG4ndCBiZSB1c2luZyBhIHN3aXRjaCBzdGF0ZW1lbnQuICBZb3Ug
d29uJ3QKPj4gY2F0Y2ggYWxsIHZhbHVlcyB0aGF0IGFyZSB3aXRoaW4gLjA1JSBvZiAoMjUuMiAv
IDEuMDAxKS4KPgo+IE5vLgo+Cj4gVGhlIGNsb2NrIHJhdGVzIHlvdSBnZXQgdWx0aW1hdGVseSBj
b21lIGZyb20gdGhlIEVESUQgdmlhIGVpdGhlciB0aGUKPiBkZXRhaWxlZCB0aW1pbmcgbW9kZXMg
b3IgZnJvbSB0aGUgQ0VBIG1vZGUgSURzLCB3aGljaCBhcmUgdGhlbiBsb29rZWQKPiB1cCBpbiB0
YWJsZXMgaW4gdGhlIERSTSBFRElEIHBhcnNpbmcgY29kZS4KCkkgZ3Vlc3MgaW4gbXkgY2FzZSB0
aGUgKG5vbi11cHN0ZXJhbSkgY29kZSBpcyBhZGp1c3RpbmcgdGhlIGNsb2NrIGluCmZpeHVwX21v
ZGUuICBJdCdzIG5vIGxvbmdlciBzb21ldGhpbmcgYmFzZWQgb24gdGhlIEVESUQuICBQZXJoYXBz
IHRoZQpmYXVsdCBpZiB0aGVyZSwgYnV0Li4uCgoKPiBFaXRoZXIgd2F5LCB5b3Ugd2lsbCBlbmQg
dXAgd2l0aCAyNTE3NSBhbmQgbm90IDI1MTcwIG9yIHNvbWV0aGluZwo+IHN0cmFuZ2UgYmFzZWQg
b24gd2hhdCB0aGUgcGxhdGZvcm0gZG9lcy4KCkkgd2FzIHRhbGtpbmcgdG8gc29tZW9uZSBlbHNl
IGFib3V0IHRoaXMgYW5kIEkgZ3Vlc3MgdGhlIHF1ZXN0aW9uIGlzCndoZXRoZXIgeW91IHNob3Vs
ZCBiZSBzZW5kaW5nIGEgTi9DVFMgZm9yIGF1ZGlvIGJhc2VkIG9uIHRoZQp0aGVvcmV0aWNhbCBv
ciB0aGUgYWN0dWFsIGNsb2NrLgoKSWYgeW91IGFyZSBzdXBwb3NlZCB0byBkbyBjYWxjdWxhdGlv
bnMgYmFzZWQgb24gdGhlIHRoZW9yZXRpY2FsIGNsb2NrCnRoZW4geW91J3JlIHJpZ2h0LiAgSWYg
eW91IGFyZSBzdXBwb3NlZCB0byBkbyBjYWxjdWxhdGlvbnMgYmFzZWQgb24KdGhlIGFjdHVhbCBj
bG9jayB0aGVuIEknbSBub3Qgc28gc3VyZS4KCk5vdGUgdGhhdDoKKiBJIGJlbGlldmUgdGhhdCB5
b3UnbGwgZ2V0IGJldHRlciBhdWRpbyBpZiB5b3UgdXNlIHRoZSBhY3R1YWwgY2xvY2suCgoqIElm
IHlvdXIgYWN0dWFsIGNsb2NrIGlzIGFuIGludGVncmFsIG51bWJlciBvZiBrSHosIHRoZSBjYWxj
dWxhdGlvbnMKYXJlIHNpbXBsZXIgYnkgdXNpbmcgdGhlIGFjdHVhbCBjbG9jay4KCgotRG91Zwpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwg
bWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cDovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
