From: =?UTF-8?B?UGhpbGlwcGUgUsOpdG9ybmF6?= <philippe.retornaz@epfl.ch>
Subject: Re: [alsa-devel] [PATCH 1/2] ASoC: fsl: imx-ssi: fix probe on imx31
Date: Mon, 07 Oct 2013 11:07:24 +0200
Message-ID: <525279CC.8080309@epfl.ch>
References: <1380630971-11431-1-git-send-email-philippe.retornaz@epfl.ch>
 <1380630971-11431-2-git-send-email-philippe.retornaz@epfl.ch>
 <20131003155954.GV27287@sirena.org.uk> <524D963F.5080507@epfl.ch>
 <CAOMZO5C_kjTJ8iVGc67pcLLaO43arTiyMRQ1822VkBLDm7hzPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAOMZO5C_kjTJ8iVGc67pcLLaO43arTiyMRQ1822VkBLDm7hzPw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

SGVsbG8KCkxlIDA0LzEwLzIwMTMgMjA6MTAsIEZhYmlvIEVzdGV2YW0gYSDDqWNyaXQgOgo+IE9u
IFRodSwgT2N0IDMsIDIwMTMgYXQgMTowNyBQTSwgUGhpbGlwcGUgUsOpdG9ybmF6IHdyb3RlCj4+
IEl0IHdhcyB3b3JraW5nIGJ1dCBpdCBpcyBicm9rZW4gc2luY2UgYSBmZXcgcmVsZWFzZS4gVGhl
cmUgaXMgbm8KPj4gbmVlZCB0byBydXNoIGZvciBhIGZpeCwgYm90aCBwYXRjaGVzIGNhbiBmb2xs
b3cgdGhlIHN0YW5kYXJkCj4+IHByb2Nlc3MuCj4KPiBXZSBoYXZlIGJlZW4gdXNpbmcgIHNvdW5k
L3NvYy9mc2wvZnNsX3NzaS5jIGZvciB0aGUgZHQgaW14IGFuZAo+IHBvd2VycGMgcGFydHMsIGFu
ZCB0aGF0J3MgcHJvYmFibHkgdGhlIHJlYXNvbiB3ZSBoYXZlbid0IG5vdGljZWQgdGhpcwo+IGJ1
Zy4KCldlbGwsIEkgZG9uJ3QgdGhpbmsgaXQncyBmYWlyIHRvIGJyZWFrIGJvYXJkcyBqdXN0IGJl
Y2F1c2UgdGhleSBhcmUgbm90Cih5ZXQpIGNvbnZlcnRlZCB0byBEVCAuLi4gdGhpcyBib2FyZCB3
YXMgbWVyZ2VkIGJlZm9yZSB0aGUgRFQgZXJhIG9uIEFSTS4KCkFueXdheSBldmVuIG9uIERUIGl0
J3MgYnJva2VuOiBiZWZvcmUgdGhlIHN3aXRjaCB0byB0aGUgY29tbW9uIGFzb2MgcGNtCmNvZGUs
IHRoZSBkbWEgQVBJIHdhcyBtaXN1c2VkIHRvIGxldCBpdCB0aGluayB0aGF0IHRoZSBhdWRpbyBw
YXJ0IG9mIHRoZQpTb0Mgd2FzIGRvaW5nIHRoZSBidXMgbWFzdGVyaW5nLCB3aGlsZSBpbiBmYWN0
IHRoZSBzZG1hIHdhcyBkb2luZyBpdC4KClJlZ2FyZHMsCgpQaGlsaXBwZQoKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFp
bGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
