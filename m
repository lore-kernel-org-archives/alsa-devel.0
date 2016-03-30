From: Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [PATCH 1/3 v2] drm/i2c/adv7511: Add audio support
Date: Wed, 30 Mar 2016 10:58:42 +0100
Message-ID: <CACvgo53rc2DhQdJUZJB5Lsj57vJGytU7GKqp-O_YZvzH7Df1XA@mail.gmail.com>
References: <cover.1459174494.git.joabreu@synopsys.com>
 <15b1936d307912ba12df7fa09ec3a7a80ac5fcef.1459174494.git.joabreu@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <15b1936d307912ba12df7fa09ec3a7a80ac5fcef.1459174494.git.joabreu@synopsys.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Jose Abreu <Jose.Abreu@synopsys.com>
Cc: Jon Medhurst <tixy@linaro.org>, Mark Rutland <mark.rutland@arm.com>, alsa-devel@alsa-project.org, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, ML dri-devel <dri-devel@lists.freedesktop.org>, lgirdwood@gmail.com, yitian.bu@tangramtek.com, wsa+renesas@sang-engineering.com, laurent.pinchart+renesas@ideasonboard.com, tiwai@suse.com, nariman@opensource.wolfsonmicro.com, linux-snps-arc@lists.infradead.org, devicetree <devicetree@vger.kernel.org>, Maruthi.Bayyavarapu@amd.com, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Vineet.Gupta1@synopsys.com, buyitian@gmail.com, Rob Herring <robh+dt@kernel.org>, perex@perex.cz, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, broonie@kernel.org, Kumar Gala <galak@codeaurora.org>, Alex Deucher <alexander.deucher@amd.com>, CARLOS.PALMINHA@synopsys.com
List-Id: alsa-devel@alsa-project.org

SGkgSm9zZSwKCk9uIDI4IE1hcmNoIDIwMTYgYXQgMTU6MzYsIEpvc2UgQWJyZXUgPEpvc2UuQWJy
ZXVAc3lub3BzeXMuY29tPiB3cm90ZToKPiBUaGlzIHBhdGNoIGFkZHMgYXVkaW8gc3VwcG9ydCBm
b3IgdGhlIEFEVjc1MTEgSERNSSB0cmFuc21pdHRlcgo+IHVzaW5nIEFMU0EgU29DLgo+Cj4gVGhl
IGNvZGUgd2FzIHBvcnRlZCBmcm9tIEFuYWxvZyBEZXZpY2VzIGxpbnV4IHRyZWUgZnJvbQo+IGNv
bW1pdCAxNzcwYzRhMWUzMmIgKCJNZXJnZSByZW1vdGUtdHJhY2tpbmcgYnJhbmNoCj4gJ3hpbGlu
eC9tYXN0ZXInIGludG8geGNvbW1fenlucSIpLCB3aGljaCBpcyBhdmFpbGFibGUgYXQ6Cj4gICAg
ICAgICAtIGh0dHBzOi8vZ2l0aHViLmNvbS9hbmFsb2dkZXZpY2VzaW5jL2xpbnV4Lwo+Cj4gVGhl
IG1haW4gY29yZSBmaWxlIHdhcyByZW5hbWVkIGZyb20gYWR2NzUxMS5jIHRvIGFkdjc1MTFfY29y
ZS5jCj4gc28gdGhhdCBhdWRpbyBhbmQgdmlkZW8gY29tcGlsZSBpbnRvIGEgc2luZ2xlIGFkdjc1
MTEua28gbW9kdWxlCj4gYW5kIHRvIGtlZXAgdXAgd2l0aCBBbmFsb2cgRGV2aWNlcyBrZXJuZWwg
dHJlZS4KPgo+IFRoZSBhdWRpbyBjYW4gYmUgZGlzYWJsZWQgdXNpbmcgbWVudS1jb25maWcgc28g
aXQgaXMgcG9zc2libGUKPiB0byB1c2Ugb25seSB2aWRlbyBtb2RlLgo+Cj4gVGhlIEhETUkgbW9k
ZSBpcyBhdXRvbWF0aWNhbGx5IHN0YXJ0ZWQgYXQgYm9vdCBhbmQgdGhlIGF1ZGlvCj4gKHdoZW4g
ZW5hYmxlZCkgcmVnaXN0ZXJzIGFzIGEgY29kZWMgaW50byBBTFNBLgo+Cj4gU1BESUYgREFJIGZv
cm1hdCB3YXMgYWxzbyBhZGRlZCB0byBBU29DIGFzIGl0IGlzIHJlcXVpcmVkCj4gYnkgYWR2NzUx
MSBhdWRpby4KPgo+IFNpZ25lZC1vZmYtYnk6IEpvc2UgQWJyZXUgPGpvYWJyZXVAc3lub3BzeXMu
Y29tPgo+IC0tLQo+Cj4gTm8gY2hhbmdlcyB2MSAtPiB2Mi4KPgo+ICBkcml2ZXJzL2dwdS9kcm0v
aTJjL0tjb25maWcgICAgICAgICB8ICAgMTEgKwo+ICBkcml2ZXJzL2dwdS9kcm0vaTJjL01ha2Vm
aWxlICAgICAgICB8ICAgIDIgKwo+ICBkcml2ZXJzL2dwdS9kcm0vaTJjL2Fkdjc1MTEuYyAgICAg
ICB8IDEwMjQgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiAgZHJpdmVycy9n
cHUvZHJtL2kyYy9hZHY3NTExLmggICAgICAgfCAgIDQxICsrCj4gIGRyaXZlcnMvZ3B1L2RybS9p
MmMvYWR2NzUxMV9hdWRpby5jIHwgIDMxMCArKysrKysrKysrKwo+ICBkcml2ZXJzL2dwdS9kcm0v
aTJjL2Fkdjc1MTFfY29yZS5jICB8IDEwMDUgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKwpQbGVhc2Uga2VlcCB0aGUgZmlsZSByZW5hbWUgc2VwYXJhdGUgKGFuZCB1c2UgLU0gZmxh
ZyB3aGVuIGdlbmVyYXRpbmcKdGhlIHBhdGNoKSBmcm9tIHRoZSBpbnRyb2R1Y3Rpb24gb2YgYXVk
aW8gc3VwcG9ydC4gSGF2aW5nIHRvIGNoZWNrIDFrCkxPQyBtb3ZlbWVudCBhbG9uZ3NpZGUgdGhl
IGludHJvZHVjdGlvbiBvZiBuZXcgb25lIGlzIGEgYml0Li4uCnN1Ym9wdGltYWwuCgpSZWdhcmRz
LApFbWlsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRy
aS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
