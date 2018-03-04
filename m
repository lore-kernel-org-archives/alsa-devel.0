From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 02/22] ASoC: rt5651: Add devicetree-bindings
	for jack-detect
Date: Sun,  4 Mar 2018 15:35:50 +0100
Message-ID: <20180304143610.21125-3-hdegoede@redhat.com>
References: <20180304143610.21125-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id EC452267063
 for <alsa-devel@alsa-project.org>; Sun,  4 Mar 2018 15:36:16 +0100 (CET)
In-Reply-To: <20180304143610.21125-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Carlo Caione <carlo@endlessm.com>, devicetree@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

QWRkIG5ldyBwcm9wZXJ0aWVzIHRvIHRoZSBydDU2NTEgZHQtYmluZGluZ3MgZm9yIGNvbmZpZ3Vy
aW5nIHRoZQpqYWNrLWRldGVjdCBzb3VyY2UgYW5kIG92ZXItY3VycmVudCBkZXRlY3Qgc2V0dGlu
Z3MuCgpDYzogZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcKU2lnbmVkLW9mZi1ieTogSGFucyBk
ZSBHb2VkZSA8aGRlZ29lZGVAcmVkaGF0LmNvbT4KLS0tCiBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3Mvc291bmQvcnQ1NjUxLnR4dCB8IDE3ICsrKysrKysrKysrKysrKysrCiAxIGZp
bGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9ydDU2NTEudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3NvdW5kL3J0NTY1MS50eHQKaW5kZXggMzg3NTIzMzA5NWY1Li43ODkw
YWE5NDc3ZjggMTAwNjQ0Ci0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9z
b3VuZC9ydDU2NTEudHh0CisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9z
b3VuZC9ydDU2NTEudHh0CkBAIC0xNiw2ICsxNiwyMyBAQCBPcHRpb25hbCBwcm9wZXJ0aWVzOgog
LSByZWFsdGVrLGRtaWMtZW4KICAgQm9vbGVhbi4gdHJ1ZSBpZiBkbWljIGlzIHVzZWQuCiAKKy0g
cmVhbHRlayxqYWNrLWRldGVjdC1zb3VyY2UKKyAgdTMyLiBWYWxpZCB2YWx1ZXM6CisgIDE6IFVz
ZSBKRDFfMSBwaW4gZm9yIGphY2stZGVjdGVjdAorICAyOiBVc2UgSkQxXzIgcGluIGZvciBqYWNr
LWRlY3RlY3QKKyAgMzogVXNlIEpEMiBwaW4gZm9yIGphY2stZGVjdGVjdAorCistIHJlYWx0ZWss
b3Zlci1jdXJyZW50LXRocmVzaG9sZC1taWNyb2FtcAorICB1MzIsIG1pY2JpYXMgb3Zlci1jdXJy
ZW50IGRldGVjdGlvbiB0aHJlc2hvbGQgaW4gwrVBLCB2YWxpZCB2YWx1ZXMgYXJlCisgIDYwMCwg
MTUwMCBhbmQgMjAwMMK1QS4KKworLSByZWFsdGVrLG92ZXItY3VycmVudC1zY2FsZS1mYWN0b3IK
KyAgdTMyLCBtaWNiaWFzIG92ZXItY3VycmVudCBkZXRlY3Rpb24gc2NhbGUtZmFjdG9yLCB2YWxp
ZCB2YWx1ZXMgYXJlOgorICAwOiBTY2FsZSBjdXJyZW50IGJ5IDAuNQorICAxOiBTY2FsZSBjdXJy
ZW50IGJ5IDAuNzUKKyAgMjogU2NhbGUgY3VycmVudCBieSAxLjAKKyAgMzogU2NhbGUgY3VycmVu
dCBieSAxLjUKKwogUGlucyBvbiB0aGUgZGV2aWNlIChmb3IgbGlua2luZyBpbnRvIGF1ZGlvIHJv
dXRlcykgZm9yIFJUNTY1MToKIAogICAqIERNSUMgTDEKLS0gCjIuMTQuMwoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxp
c3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVj
dC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
