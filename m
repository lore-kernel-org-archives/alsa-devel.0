From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 0/5] ASoC: atmel: extend SSC support
Date: Mon, 22 Jul 2019 20:27:17 +0200
Message-ID: <cover.1563819483.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 89B2CF800F5
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2019 20:27:21 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Liam Girdwood <lgirdwood@gmail.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Codrin Ciubotariu <codrin.ciubotariu@microchip.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

VGhpcyBzZXJpZXMgaW1wcm92ZXMgc3VwcG9ydCBmb3IgdmFyaW91cyBjb25maWd1cmF0aW9ucyB1
c2luZyBTU0MgbW9kdWxlCmFzIGltcGxlbWVudGVkIGluIEF0bWVsIFNBTUE1RHggU29Dcy4gUGF0
Y2hlcyBhcmU6CgoxLiBlbmFibGUgU1NDIGluIEtjb25maWcgZm9yIGF1ZGlvLWdyYXBoLWNhcmQg
c3VwcG9ydAoyLTMuIGltcGxlbWVudCBsZWZ0LWp1c3RpZmllZCBkYXRhIG1vZGUKNC01LiBmaXgg
c2hhcmVkIEZTWU5DIHNvdXJjZSBmb3Igc2xhdmUgbW9kZQoKUGF0Y2hlcyBhZ2FpbnN0IHRpd2Fp
L3NvdW5kL2Zvci1uZXh0IHRyZWUuIFlvdSBjYW4gYWxzbyBwdWxsIGZyb20KICAgaHR0cHM6Ly9y
ZXJlLnFtcW0ucGwvZ2l0L2xpbnV4CmJyYW5jaDoKICAgYXRtZWwtc3NjCgpNaWNoYcWCIE1pcm9z
xYJhdyAoNSk6CiAgQVNvQzogYXRtZWw6IGVuYWJsZSBTU0NfUENNX0RNQSBpbiBLY29uZmlnCiAg
QVNvQzogYXRtZWxfc3NjX2RhaTogcmV3b3JrIERBSSBmb3JtYXQgY29uZmlndXJhdGlvbgogIEFT
b0M6IGF0bWVsX3NzY19kYWk6IGltcGxlbWVudCBsZWZ0LWp1c3RpZmllZCBkYXRhIG1vZGUKICBB
U29DOiBhdG1lbF9zc2NfZGFpOiBzcGxpdCBUWC9SWCBGUyBjb25zdGFudHMKICBBU29DOiBhdG1l
bF9zc2NfZGFpOiBFbmFibGUgc2hhcmVkIEZTWU5DIHNvdXJjZSBpbiBmcmFtZS1zbGF2ZSBtb2Rl
CgogLi4uL2RldmljZXRyZWUvYmluZGluZ3MvbWlzYy9hdG1lbC1zc2MudHh0ICAgIHwgICA0ICsK
IGRyaXZlcnMvbWlzYy9hdG1lbC1zc2MuYyAgICAgICAgICAgICAgICAgICAgICB8ICAgMiArCiBp
bmNsdWRlL2xpbnV4L2F0bWVsLXNzYy5oICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKwogc291
bmQvc29jL2F0bWVsL0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgIHwgICAyICstCiBzb3Vu
ZC9zb2MvYXRtZWwvYXRtZWxfc3NjX2RhaS5jICAgICAgICAgICAgICAgfCAzMDYgKysrKysrLS0t
LS0tLS0tLS0tCiBzb3VuZC9zb2MvYXRtZWwvYXRtZWxfc3NjX2RhaS5oICAgICAgICAgICAgICAg
fCAgIDkgKy0KIDYgZmlsZXMgY2hhbmdlZCwgMTIwIGluc2VydGlvbnMoKyksIDIwNCBkZWxldGlv
bnMoLSkKCi0tIAoyLjIwLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0
Lm9yZwpodHRwczovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fs
c2EtZGV2ZWwK
