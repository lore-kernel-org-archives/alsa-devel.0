From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH v5 4/6] drm: bridge/dw_hdmi-i2s-audio: add audio driver
Date: Mon, 22 Jun 2015 12:06:04 +0200
Message-ID: <1434967564.31094.20.camel@x220>
References: <1434730417-10629-1-git-send-email-ykk@rock-chips.com>
 <1434731295-11060-1-git-send-email-ykk@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1434731295-11060-1-git-send-email-ykk@rock-chips.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Yakir Yang <ykk@rock-chips.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>, Doug Anderson <dianders@chromium.org>, linux-rockchip@lists.infradead.org, Mark Brown <broonie@kernel.org>, Andy Yan <andy.yan@rock-chips.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Jaroslav Kysela <perex@perex.cz>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

U29tZXRoaW5nIEkgZGlkbid0IG5vdGljZSBpbiB2NCwgc29ycnkuCgpPbiBTYXQsIDIwMTUtMDYt
MjAgYXQgMDA6MjggKzA4MDAsIFlha2lyIFlhbmcgd3JvdGU6Cj4gLS0tIC9kZXYvbnVsbAo+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9icmlkZ2UvZHdfaGRtaS1pMnMtYXVkaW8uYwoKPiArI2RlZmlu
ZSBEUklWRVJfTkFNRSAiZHctaGRtaS1pMnMtYXVkaW8iCgo+ICtNT0RVTEVfQUxJQVMoUExBVEZP
Uk1fTU9EVUxFX1BSRUZJWCBEUklWRVJfTkFNRSk7CgowKSBTaWRlIG5vdGU6IHRoaXMgaXMgdGhl
IGZpcnN0IHRpbWUgdGhhdCBQTEFURk9STV9NT0RVTEVfUFJFRklYIGlzIHVzZWQKaW5zaWRlIE1P
RFVMRV9BTElBUygpLiBCdXQgbm9uZSBvZiB0aGUgMTAwMCsgb3RoZXIgInBsYXRmb3JtOiIgYWxp
YXNlcwpkbyB0aGF0LiBBbmQgbmVpdGhlciBkb2VzIDUvNiBvZiB0aGlzIHNlcmllcyEgVGhhdCBz
dWdnZXN0cywgSSB0aGluaywKdGhhdCB0aGlzIHNob3VsZG4ndCBiZSBkb25lLgoKWW91IGNvdWxk
IGNvbnNpZGVyIGFkZGluZyBzb21ldGhpbmcgbGlrZQogICAgI2RlZmluZSBNT0RVTEVfQUxJQVNf
UExBVEZPUk0oTkFNRSkgTU9EVUxFX0FMSUFTKFBMQVRGT1JNX01PRFVMRV9QUkVGSVggTkFNRSkK
CkJ1dCB0aGVuLCBJIHRoaW5rLCBhbGwgdGhlIGN1cnJlbnQgMTAwMCsgcGxhdGZvcm06IGFsaWFz
ZXMgc2hvdWxkIGJlCmNvbnZlcnRlZCB0byB0aGF0IG1hY3JvLiBXb3VsZCB0aGF0IGJlIHdvcnRo
IGl0PwoKMSkgTm93IG9uIHRvIG15IHJlbWFyazogdGhpcyBhbGlhcyBzZWVtcyB0byBiZSBvbmx5
IHVzZWZ1bCBpZiB0aGVyZSBhbHNvCmlzIGEgc3RydWN0IHBsYXRmb3JtX2RldmljZSB3aXRoIGEg
ImR3LWhkbWktaTJzLWF1ZGlvIiBuYW1lLiBCZWNhdXNlCnRoYXQgcGxhdGZvcm1fZGV2aWNlIHdv
dWxkLCBiYWRseSBzdW1tYXJpemVkLCBmaXJlIG9mIGEKIk1PREFMSUFTPXBsYXRmb3JtOmR3LWhk
bWktaTJzLWF1ZGlvIiB1ZXZlbnQgd2hlbiBjcmVhdGVkLiBXaGljaCwgaW4gaXRzCnR1cm4sIHdv
dWxkIHRyaWdnZXIgdXNlcnNwYWNlIHRvIGxvYWQgdGhpcyBtb2R1bGUsIGNvcnJlY3Q/CgpCdXQg
SSB0aGluayB0aGVyZSdzIG5vIHBsYXRmb3JtX2RldmljZSB3aXRoIGEgImR3LWhkbWktaTJzLWF1
ZGlvIiBuYW1lLgpTbyBJIHdvbmRlciB3aGV0aGVyIHRoaXMgTU9EVUxFX0FMSUFTKCkgaXMgYWN0
dWFsbHkgbmVlZGVkLiBXaGF0IGJyZWFrcwppZiB5b3UgbGVhdmUgaXQgb3V0PwoKKExpa2V3aXNl
IGZvciA1LzYsIGJ1dCB0aGVyZSB0aGUgcGxhdGZvcm1fZGV2aWNlIHNob3VsZCBoYXZlIGEKInJv
Y2tjaGlwLWhkbWktYXVkaW8iIG5hbWUuKQoKVGhhbmtzLAoKClBhdWwgQm9sbGUKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5n
IGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
