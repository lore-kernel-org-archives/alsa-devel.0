From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 07/10] ASoC: ux500: Store DMA data in the
 DAI differently in the pdata and DT case
Date: Mon, 2 Dec 2013 14:03:24 +0000
Message-ID: <20131202140324.GH31626@lee--X1>
References: <1384859269-19801-1-git-send-email-lee.jones@linaro.org>
 <1384859269-19801-8-git-send-email-lee.jones@linaro.org>
 <CAOesGMiu16f_L=cMWFCNZMjNB9tBK-2LXn02k-R7FhkkgR5-+g@mail.gmail.com>
 <20131202101256.GA29373@lee--X1>
 <20131202135452.GI27568@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f174.google.com (mail-ie0-f174.google.com
 [209.85.223.174])
 by alsa0.perex.cz (Postfix) with ESMTP id F1FAC264F2C
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2013 15:03:34 +0100 (CET)
Received: by mail-ie0-f174.google.com with SMTP id at1so20752692iec.33
 for <alsa-devel@alsa-project.org>; Mon, 02 Dec 2013 06:03:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131202135452.GI27568@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Olof Johansson <olof@lixom.net>, LinusW <linus.walleij@linaro.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

T24gTW9uLCAwMiBEZWMgMjAxMywgTWFyayBCcm93biB3cm90ZToKCj4gT24gTW9uLCBEZWMgMDIs
IDIwMTMgYXQgMTA6MTI6NTZBTSArMDAwMCwgTGVlIEpvbmVzIHdyb3RlOgo+IAo+ID4gSXQncyBh
Y3R1YWxseSBteSBmYXVsdC4gSSBoYWQgdHdvIHBhdGNoZXMgcm91bmQgdGhlIHdyb25nIHdheSBp
biB0aGUKPiA+IHNlcmllcy4gVGhlIGltZWRpYXRlbHkgc3Vic2VxdWVudCBwYXRjaCBpbiB0aGUg
c2V0IGZpeGVzIHRoaXMgaXNzdWU6Cj4gCj4gT0ssIHNvIHdoYXQgZG8gd2UgZG8gYWJvdXQgdGhp
cz8gIElzIHRoZXJlIGdvaW5nIHRvIGJlIGEgcmV2aXNpb24gb2YKPiB0aGF0IHBhdGNoIGFkZGlu
ZyB0aGUgbm90ZSBhYm91dCBub3QgdXNpbmcgdGhlIGF1dG9jb25maWd1cmF0aW9uIHN0dWZmCj4g
YW5kIHdoYXQgKGlmIGFueSkgYXJlIHRoZSBkZXBlbmRlbmNpZXMgb24gdGhlIGFyY2gvYXJtIGNo
YW5nZXM/CgpJIGNhbiBzaG9vdCBvdXQgYSByZXZpc2lvbiBubyBwcm9ibGVtLgoKSSdtIG5vdCBh
d2FyZSBvZiBhbnkgZGVwZW5kZW5jaWVzIG9uIHRoZSBBUk0gY2hhbmdlcy4gSSBoYXZlbid0IHRl
c3RlZAp0aGUgYXJjaC9hcm0gYW5kIHNvdW5kL3NvYyBhZGFwdGlvbnMgb3J0aG9nb25hbGx5LCBi
dXQgSSBfdGhpbmtfIHRoZQpyaWdodCBkZWNpc2lvbnMgc2hvdWxkIGJlIG1hZGUgZGVwZW5kaW5n
IG9uIHRoZSBpbmZvcm1hdGlvbiBwYXNzZWQKZnJvbSBwbGF0Zm9ybS9kdCBjb2RlLgoKLS0gCkxl
ZSBKb25lcwpMaW5hcm8gU1RNaWNyb2VsZWN0cm9uaWNzIExhbmRpbmcgVGVhbSBMZWFkCkxpbmFy
by5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBBUk0gU29DcwpGb2xsb3cgTGluYXJv
OiBGYWNlYm9vayB8IFR3aXR0ZXIgfCBCbG9nCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxz
YS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlz
dGluZm8vYWxzYS1kZXZlbAo=
