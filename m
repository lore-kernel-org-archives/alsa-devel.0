From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 1/1] mx27_3ds: Add sound support
Date: Mon, 6 Aug 2012 10:36:32 -0300
Message-ID: <CAOMZO5B9ZmTHrYjVc5a7j=uUgUEyfDva54cKxBP3UeCYZsUWRw@mail.gmail.com>
References: <1344258447-6162-1-git-send-email-gcembed@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CCC326538A
 for <alsa-devel@alsa-project.org>; Mon,  6 Aug 2012 15:06:46 +0200 (CEST)
Received: by obbeh20 with SMTP id eh20so5352693obb.38
 for <alsa-devel@alsa-project.org>; Mon, 06 Aug 2012 06:36:32 -0700 (PDT)
In-Reply-To: <1344258447-6162-1-git-send-email-gcembed@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?Q?Ga=C3=ABtan_Carlier?= <gcembed@gmail.com>
Cc: alsa-devel@alsa-project.org, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

SGkgR2HDq3RhbiwKCk9uIE1vbiwgQXVnIDYsIDIwMTIgYXQgMTA6MDcgQU0sIEdhw6t0YW4gQ2Fy
bGllciA8Z2NlbWJlZEBnbWFpbC5jb20+IHdyb3RlOgo+IEhpLAo+IEkgaGF2ZSBwb3J0ZWQgY29k
ZSAiRW5hYmxlIHNvdW5kIG9uIG14MzFfM2RzIiBmcm9tIFBoaWxpcHBlIFLDqXRvcm5heiB0bwo+
IE1YMjcgM0RTIHBsYXRmb3JtIG9uIG1hc3RlciBicmFuY2ggb2YgbGludXgtbmV4dCAodGFnIG5l
eHQtMjAxMjA4MDYpLgo+IEkgYWxzbyBhcHBsaWVkIHBhdGNoICJkbWE6IGlteC1kbWE6IEZpeCBr
ZXJuZWwgY3Jhc2ggZHVlIHRvIG1pc3NpbmcgY2xvY2sKPiBjb252ZXJzaW9uIiBvZiBGYWJpbyBF
c3RldmFtIHdoaWNoIGlzIG5vdCB5ZXQgbWVyZ2VkIGluIGxpbnV4LW5leHQuCj4gVGhhbmtzIHRv
IHRoZW0sIGV2ZXJ5dGhpbmcgaXMgd29ya2luZyBnb29kIG9uIE1YMjcgM0RTIHBsYXRmb3JtIGV4
Y2VwdCB0aGF0Cj4gc291bmQgaXMgcGxheWVkIHRvbyBmYXN0Lgo+IFdoaWNoIHBhcmFtZXRlciBt
dXN0IGJlIGFkanVzdGVkIHRvIGhhdmUgc291bmQgcGxheWluZyBhdCBub3JtYWwgc3BlZWQgPwo+
IEluIG1jMTM3ODMgY29kZWMgZHJpdmVyLCBpbXhfYWRkX2lteF9zc2koKSwgY2xvY2sgY29uZmln
dXJhdGlvbiBpbgo+IG1hY2gtbXgyN18zZHMgZmlsZSA/Cj4KPiBUaGFua3MgZm9yIHlvdXIgaGVs
cC4KPgo+IFNpZ25lZC1vZmYtYnk6IEdhw6t0YW4gQ2FybGllciA8Z2NlbWJlZEBnbWFpbC5jb20+
CgpJIGhhdmUgYWRkZWQgYXVkaW8gc3VwcG9ydCBmb3IgbXgyN3BkazoKaHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wYXRjaC8xMTUyOTUxLwoKLGFuZCBpbiBteSB0ZXN0cyB0aGUgYXVkaW8g
d2FzIHBsYXllZCBhdCB0aGUgY29ycmVjdCByYXRlLgoKQ2FuIHlvdSBwbGVhc2UgaGF2ZSBhIHRy
eT8KCldoYXQgaXMgdGhlIHNhbXBsaW5nIHJhdGUgb2YgeW91ciBmaWxlPwoKUmVnYXJkcywKCkZh
YmlvIEVzdGV2YW0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0
dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVs
Cg==
