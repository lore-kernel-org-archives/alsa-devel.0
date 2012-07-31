From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/6] ASoC: dapm: If one widget fails,
 do not force all subsequent widgets to fail too
Date: Tue, 31 Jul 2012 15:38:02 +0100
Message-ID: <5017EDCA.4020601@linaro.org>
References: <1343741493-17671-1-git-send-email-lee.jones@linaro.org>
 <1343741493-17671-3-git-send-email-lee.jones@linaro.org>
 <20120731134214.GK4468@opensource.wolfsonmicro.com>
 <5017EAC3.3080504@linaro.org>
 <20120731142820.GW4468@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 97FF7265DE6
 for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2012 16:38:02 +0200 (CEST)
Received: by eeke50 with SMTP id e50so1340222eek.38
 for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2012 07:38:04 -0700 (PDT)
In-Reply-To: <20120731142820.GW4468@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, linus.walleij@stericsson.com, arnd@arndb.de, olalilja@yahoo.se, linux-kernel@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

T24gMzEvMDcvMTIgMTU6MjgsIE1hcmsgQnJvd24gd3JvdGU6Cj4gT24gVHVlLCBKdWwgMzEsIDIw
MTIgYXQgMDM6MjU6MDdQTSArMDEwMCwgTGVlIEpvbmVzIHdyb3RlOgo+PiBPbiAzMS8wNy8xMiAx
NDo0MiwgTWFyayBCcm93biB3cm90ZToKPgo+Pj4gWW91J3JlIHBvc3RpbmcgdGhpcyAqYWdhaW4q
IHdpdGhvdXQgYm90aGVyaW5nIHRvIHJlc3BvbmQgdG8gbXkgcmV2aWV3Cj4+PiBjb21tZW50cy4K
Pgo+PiBJIGRpZG4ndCBzZWUgYW55IGNvbW1lbnRzIG9uIHRoaXMuCj4KPiBSZWFkIHlvdXIgZW1h
aWwuICA8MjAxMjA3MjYxMTU0NTAuR0UzMDk5QG9wZW5zb3VyY2Uud29sZnNvbm1pY3JvLmNvbT4K
PiBhbmQgPDIwMTIwNzI5MjAyNTEwLkdCNDM4NEBvcGVuc291cmNlLndvbGZzb25taWNyby5jb20+
LCB0aGUgc2Vjb25kIG9uZQo+IGV2ZW4gaW5jbHVkZXMgYSBjb21wbGFpbnQgYWJvdXQgeW91IGln
bm9yaW5nIHRoZSBmaXJzdCBtYWlsLgoKTmVpdGhlciBvZiB0aG9zZSBhcmUgaW4gbXkgSW5ib3gu
IEJsYW1lIE1vemlsbGEuIDopCgpJdCdzIGJldHRlciBiZWNhdXNlIHRoZSB3aG9sZSBhdWRpbyBz
eXN0ZW0gZG9lc24ndCBmYWlsIGluIHRoZSBjYXNlIG9mIAptaW5vciBmYWlsdXJlLiBJdCdkIGJl
IGxpa2UgY2FsbGluZyBvZmYgYSBmb290YmFsbCBnYW1lIChvciB3aGF0ZXZlciAKeW91J3JlIGlu
dG8pIGJlY2F1c2Ugb25lIG9mIHRoZSBzdWJzdGl0dXRlcyBydXB0dXJlZCBhbiBleWVsYXNoLgoK
RHVyaW5nIHN0YXJ0LXVwIHRoZSB1eDUwMCBoYXMgYSBjb3VwbGUgb2YgdmVyeSB1bmltcG9ydGFu
dCB3aWRnZXRzIGZhaWwuIApJdCdzIHRoZSB3cm9uZyBiZWhhdmlvciB0byBmb3JjZSBmYWlsdXJl
IG9uIHRoZSBldmVyeXRoaW5nIGF1ZGlvIGp1c3QgCmJlY2F1c2Ugb2YgdGhhdC4KCi0tIApMZWUg
Sm9uZXMKTGluYXJvIFNULUVyaWNzc29uIExhbmRpbmcgVGVhbSBMZWFkCkxpbmFyby5vcmcg4pSC
IE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBBUk0gU29DcwpGb2xsb3cgTGluYXJvOiBGYWNlYm9v
ayB8IFR3aXR0ZXIgfCBCbG9nCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0
Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxz
YS1kZXZlbAo=
