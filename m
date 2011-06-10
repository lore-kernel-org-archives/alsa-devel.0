From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [Device-drivers-devel] [PATCH 1/3] ASoC: Add
	ADAU1701 codec driver
Date: Fri, 10 Jun 2011 14:08:10 -0400
Message-ID: <BANLkTikSqdHDzQUZdh87YX3y+=GtKDe27g@mail.gmail.com>
References: <1307726331-28618-1-git-send-email-lars@metafoo.de>
	<BANLkTimLAfEj+tgNMWjTsanccgfEt9UW1g@mail.gmail.com>
	<4DF25AF5.6070909@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 816EF103D27
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Jun 2011 20:08:30 +0200 (CEST)
Received: by fxm5 with SMTP id 5so1937123fxm.38
	for <alsa-devel@alsa-project.org>; Fri, 10 Jun 2011 11:08:30 -0700 (PDT)
In-Reply-To: <4DF25AF5.6070909@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, uclinux-dist-devel@blackfin.uclinux.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

T24gRnJpLCBKdW4gMTAsIDIwMTEgYXQgMTM6NTcsIExhcnMtUGV0ZXIgQ2xhdXNlbiB3cm90ZToK
PiBPbiAwNi8xMC8yMDExIDA3OjQzIFBNLCBNaWtlIEZyeXNpbmdlciB3cm90ZToKPj4gT24gRnJp
LCBKdW4gMTAsIDIwMTEgYXQgMTM6MTgsIExhcnMtUGV0ZXIgQ2xhdXNlbiB3cm90ZToKPj4+ICtN
T0RVTEVfQVVUSE9SKCJMYXJzLVBldGVyIENsYXVzZW4gPGxhcnNAbWV0YWZvby5kZT4iKTsKPj4K
Pj4gZGlkIHlvdSBhY3R1YWxseSByZXdyaXRlIHRoaXMgdGhpbmcgZnJvbSBzY3JhdGNoID8gwqBz
ZWVtcyBsaWtlIHlvdQo+PiBzaG91bGQga2VlcCBDbGlmZiBhcyB0aGUgYXV0aG9yIGluIGdpdC9N
T0RVTEVfQVVUSE9SLCBhbmQgdGhlbiBhZGQKPj4geW91ciBuYW1lIHRvIHRoZSBzLW8tYiBsaXN0
IGFuZCB0aGlzIG1hY3JvLgo+Cj4gTm90IGZyb20gc2NyYXRjaCwgYnV0IEkgZ3Vlc3MgZXhjZXB0
IGZvciB0aGUgcmVnaXN0ZXIgZGVmaW5pdGlvbnMgYW5kIHRoZQo+IGNvcHlyaWdodCBoZWFkZXIg
bm90IG11Y2ggb2YgdGhlIG9yaWdpbmFsIGRyaXZlciBpcyBsZWZ0Ogo+IHNvdW5kL3NvYy9jb2Rl
Y3MvYWRhdTE3MDEuYyB8IMKgNjYyICsrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0t
LS0tLS0tLS0KPiDCoDEgZmlsZXMgY2hhbmdlZCwgMzcxIGluc2VydGlvbnMoKyksIDI5MSBkZWxl
dGlvbnMoLSkKCmJhc2VkIHB1cmVseSBvbiBMb0MsIENsaWZmIHdyb3RlIDQ2Nywgc28geW91IHRv
b2sgdGhhdCBhbmQgcHVudGVkIDI5MQooNjIlKSBhbmQgdGhlbiBhZGRlZCAzNzEuICB0aGF0IGxl
YXZlcyB0aGUgZmluYWwgZmlsZSB3aXRoIDMyJSBDbGlmZgphbmQgNjglIHlvdS4KCmhvd2V2ZXIs
IHNvbWUgb2YgdGhhdCB3YXMgcmVnaXN0ZXIgcmVuYW1pbmcgYW5kIHNodWZmbGluZyBiZXR3ZWVu
IHRoZQphZGF1MTcwMS5jIGFuZCBhZGF1MTcwMS5oLCBhbmQgaXQncyBlYXNpZXIgdG8gc3RhcnQg
d2l0aCBhIGJhc2UgYW5kCmNsZWFuIHVwIHRoYW4gZnJvbSBzY3JhdGNoLgoKc28gaSdtIGRlZmlu
aXRlbHkgbm90IGNvbWZvcnRhYmxlIGRyb3BwaW5nIENsaWZmJ3MgY29tcGxldGVseSBmcm9tIHRo
ZQpmaWxlIGFuZCB0aGUgbG9nICh3aGljaCBtZWFucyBoZSBuZWVkcyB0byBiZSByZWFkZGVkIGFu
ZCBtYWRlIHN1cmUgdG8KYmUgcmV0YWluZWQgaW4gYWxsIHRoZSBvdGhlciBBREFVIGRyaXZlcnMg
Z29pbmcgZm9yd2FyZCksIGFuZCBpJ20gbm90CmVudGlyZWx5IHNvbGQgYWJvdXQgY2hhbmdpbmcg
b2YgdGhlIEF1dGhvciBmaWVsZCBpbiB0aGUgZ2l0IGNvbW1pdC4KCmRvbid0IGdldCBtZSB3cm9u
ZyAuLi4gaSdtIG5vdCBhIGZhbmJvaSBvZiBDbGlmZiBvciBzb21ldGhpbmcsIGkganVzdAp0aGlu
ayBjcmVkaXQgaXMgZHVlIHRvIGhpbSBmb3IgaGlzIHdvcmsuCi1taWtlCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0
CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qu
b3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
