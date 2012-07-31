From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/5] ASoC: dapm: If one widget fails,
 do not force all subsequent widgets to fail too
Date: Tue, 31 Jul 2012 16:09:08 +0100
Message-ID: <5017F514.4030106@linaro.org>
References: <1343745944-18418-1-git-send-email-lee.jones@linaro.org>
 <1343745944-18418-2-git-send-email-lee.jones@linaro.org>
 <20120731145614.GZ4468@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
 [209.85.215.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 993D8265D29
 for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2012 17:09:08 +0200 (CEST)
Received: by eaaa13 with SMTP id a13so1137030eaa.38
 for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2012 08:09:10 -0700 (PDT)
In-Reply-To: <20120731145614.GZ4468@opensource.wolfsonmicro.com>
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
Cc: ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, linus.walleij@stericsson.com, arnd@arndb.de, olalilja@yahoo.se, linux-kernel@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

T24gMzEvMDcvMTIgMTU6NTYsIE1hcmsgQnJvd24gd3JvdGU6Cj4gT24gVHVlLCBKdWwgMzEsIDIw
MTIgYXQgMDM6NDU6NDBQTSArMDEwMCwgTGVlIEpvbmVzIHdyb3RlOgo+PiBJZiBhIGxpc3Qgb2Yg
d2lkZ2V0cyBpcyBwcm92aWRlZCBhbmQgb25lIG9mIHRoZW0gZmFpbHMgdG8gYmUgYWRkZWQgYXMK
Pj4gYSBjb250cm9sLCB0aGUgcHJlc2VudCBzZW1hbnRpY3MgZmFpbCBhbGwgc3Vic2VxdWVudCB3
aWRnZXRzLiBBIGJldHRlcgo+PiBzb2x1dGlvbiB3b3VsZCBiZSB0byBvbmx5IGZhaWwgdGhhdCB3
aWRnZXQsIGJ1dCBwdXJzdWUgaW4gYXR0ZW1wdGluZwo+PiB0byBhZGQgdGhlIHJlc3Qgb2YgdGhl
IGxpc3QuCj4KPiBUbyByZWl0ZXJhdGUsIHRoaXMgaXMgaW4gKm5vKiB3YXkgdXJnZW50IG9yIGV2
ZW4gYSBidWcgZml4LgoKSXQgZml4ZXMgc291bmQgaW4gb3VyIGRyaXZlci4KCldpdGhvdXQgdGhp
cyB0aGUgY2FyZCBmYWlsZXMgdG8gaW5zdGFudGlhdGUuCgo+PiAgIAkJCWRldl9lcnIoZGFwbS0+
ZGV2LAo+PiAgIAkJCQkiQVNvQzogRmFpbGVkIHRvIGNyZWF0ZSBEQVBNIGNvbnRyb2wgJXNcbiIs
Cj4+ICAgCQkJCXdpZGdldC0+bmFtZSk7Cj4+IC0JCQlyZXQgPSAtRU5PTUVNOwo+PiAtCQkJYnJl
YWs7Cj4KPiBJbmRlZWQsIHJlbW92aW5nIHRoZSBlcnJvciByZXR1cm4gaXMgYSByZWdyZXNzaW9u
LgoKSXNuJ3QgdGhlIHJldHVybiBjb2RlIGluY29ycmVjdD8gVGhlcmUgYXJlIGEgbXVsdGl0dWRl
IG9mIHJlYXNvbnMgd2h5IApzbmRfc29jX2RhcG1fbmV3X2NvbnRyb2woKSB3b3VsZCBmYWlsLiBO
by1tZW1vcnkgaXMganVzdCBvbmUgb2YgdGhlbSwgc28gCndoeSBkbyB3ZSBmb3JjZSB0aGlzIHBy
b2JhYmxlIGxpZT8KCi0tIApMZWUgSm9uZXMKTGluYXJvIFNULUVyaWNzc29uIExhbmRpbmcgVGVh
bSBMZWFkCkxpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBBUk0gU29DcwpG
b2xsb3cgTGluYXJvOiBGYWNlYm9vayB8IFR3aXR0ZXIgfCBCbG9nCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFs
c2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3Jn
L21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
