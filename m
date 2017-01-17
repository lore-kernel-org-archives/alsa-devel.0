From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@free-electrons.com>
Subject: [PATCH v2 01/10] ASoC: sun4i-i2s: Increase DMA max burst to 8
Date: Tue, 17 Jan 2017 15:02:21 +0100
Message-ID: <20170117140230.23142-2-mylene.josserand@free-electrons.com>
References: <20170117140230.23142-1-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170117140230.23142-1-mylene.josserand@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, maxime.ripard@free-electrons.com, wens@csie.org, mturquette@baylibre.com, sboyd@codeaurora.org, mark.rutland@arm.com, robh+dt@kernel.org
Cc: thomas.petazzoni@free-electrons.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, alexandre.belloni@free-electrons.com, mylene.josserand@free-electrons.com, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

QXMgZG9uZSBwcmV2aW91c2x5IGZvciBzdW40aS1jb2RlYywgdGhlIERNQSBtYXhidXJzdCBvZiA0
CmlzIG5vdCBzdXBwb3J0ZWQgYnkgZXZlcnkgU29DcyBzbyB0aGUgRE1BIGNvbnRyb2xsZXIgZW5n
aW5lCnJldHVybnMgInVuc3VwcG9ydGVkIHZhbHVlIi4KCkFzIGEgbWF4YnVyc3Qgb2YgOCBpcyBz
dXBwb3J0ZWQgYnkgYWxsIHZhcmlhbnRzLCB0aGlzIHBhdGNoCmluY3JlYXNlcyBpdCB0byA4LgoK
Rm9yIG1vcmUgZGV0YWlscywgc2VlIGNvbW1pdCBmcm9tIENoZW4tWXUgVHNhaToKY29tbWl0IDcz
MGUyZGQwY2JjNyAoIkFTb0M6IHN1bjRpLWNvZGVjOiBJbmNyZWFzZSBETUEgbWF4IGJ1cnN0IHRv
IDgiKQoKU2lnbmVkLW9mZi1ieTogTXlsw6huZSBKb3NzZXJhbmQgPG15bGVuZS5qb3NzZXJhbmRA
ZnJlZS1lbGVjdHJvbnMuY29tPgotLS0KIHNvdW5kL3NvYy9zdW54aS9zdW40aS1pMnMuYyB8IDQg
KystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9zb3VuZC9zb2Mvc3VueGkvc3VuNGktaTJzLmMgYi9zb3VuZC9zb2Mvc3VueGkv
c3VuNGktaTJzLmMKaW5kZXggZjI0ZDE5NTI2NjAzLi40MjM3MzIzZWY1OTQgMTAwNjQ0Ci0tLSBh
L3NvdW5kL3NvYy9zdW54aS9zdW40aS1pMnMuYworKysgYi9zb3VuZC9zb2Mvc3VueGkvc3VuNGkt
aTJzLmMKQEAgLTY5NCwxMCArNjk0LDEwIEBAIHN0YXRpYyBpbnQgc3VuNGlfaTJzX3Byb2JlKHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiAJfQogCQogCWkycy0+cGxheWJhY2tfZG1hX2Rh
dGEuYWRkciA9IHJlcy0+c3RhcnQgKyBTVU40SV9JMlNfRklGT19UWF9SRUc7Ci0JaTJzLT5wbGF5
YmFja19kbWFfZGF0YS5tYXhidXJzdCA9IDQ7CisJaTJzLT5wbGF5YmFja19kbWFfZGF0YS5tYXhi
dXJzdCA9IDg7CiAKIAlpMnMtPmNhcHR1cmVfZG1hX2RhdGEuYWRkciA9IHJlcy0+c3RhcnQgKyBT
VU40SV9JMlNfRklGT19SWF9SRUc7Ci0JaTJzLT5jYXB0dXJlX2RtYV9kYXRhLm1heGJ1cnN0ID0g
NDsKKwlpMnMtPmNhcHR1cmVfZG1hX2RhdGEubWF4YnVyc3QgPSA4OwogCiAJcG1fcnVudGltZV9l
bmFibGUoJnBkZXYtPmRldik7CiAJaWYgKCFwbV9ydW50aW1lX2VuYWJsZWQoJnBkZXYtPmRldikp
IHsKLS0gCjIuMTEuMAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LWFybS1rZXJuZWwK
