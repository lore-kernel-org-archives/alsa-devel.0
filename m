From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 1/3] ASoC: sgtl5000: prevent playback to be
 muted when terminating concurrent capture
Date: Thu, 1 Aug 2013 10:06:40 -0300
Message-ID: <CAOMZO5DMdHrbk8vd0Zb3SRfdW9zhERzN=cfWiJxhbezD3umKag@mail.gmail.com>
References: <1375281871-28128-1-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f48.google.com (mail-vb0-f48.google.com
 [209.85.212.48])
 by alsa0.perex.cz (Postfix) with ESMTP id A107526030E
 for <alsa-devel@alsa-project.org>; Thu,  1 Aug 2013 15:06:42 +0200 (CEST)
Received: by mail-vb0-f48.google.com with SMTP id w16so2021682vbf.7
 for <alsa-devel@alsa-project.org>; Thu, 01 Aug 2013 06:06:40 -0700 (PDT)
In-Reply-To: <1375281871-28128-1-git-send-email-LW@KARO-electronics.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <LW@karo-electronics.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCBKdWwgMzEsIDIwMTMgYXQgMTE6NDQgQU0sIExvdGhhciBXYcOfbWFubiA8TFdAa2Fy
by1lbGVjdHJvbmljcy5kZT4gd3JvdGU6Cj4gV2hlbiBhIHNvdW5kIGNhcHR1cmUvcGxheWJhY2sg
aXMgdGVybWluYXRlZCB3aGlsZSBhIHBsYXliYWNrL2NhcHR1cmUKPiBpcyBydW5uaW5nLCBwb3dl
cl92YWdfZXZlbnQoKSB3aWxsIGNsZWFyIFNHVEw1MDAwX0NISVBfQU5BX1BPV0VSIGluCj4gdGhl
IFNORF9TT0NfREFQTV9QUkVfUE1EIGV2ZW50LCB0aHVzIG11dGluZyB0aGUgcmVzcGVjdGl2ZSBv
dGhlcgo+IGNoYW5uZWwuCj4KPiBEb24ndCBjbGVhciBTR1RMNTAwMF9DSElQX0FOQV9QT1dFUiB3
aGVuIGJvdGggREFDIGFuZCBBREMgYXJlIGFjdGl2ZQo+IHRvIHByZXZlbnQgdGhpcy4KPgo+IFNp
Z25lZC1vZmYtYnk6IExvdGhhciBXYcOfbWFubiA8TFdAS0FSTy1lbGVjdHJvbmljcy5kZT4KClJl
dmlld2VkLWJ5OiBGYWJpbyBFc3RldmFtIDxmYWJpby5lc3RldmFtQGZyZWVzY2FsZS5jb20+Cl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwg
bWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5h
bHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
