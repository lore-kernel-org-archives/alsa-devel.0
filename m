From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: Re: [PATCH] ASoC: tpa6130a2: unmerge power enable
 error path from power disable path
Date: Mon, 26 Sep 2016 19:11:10 +0300
Message-ID: <af03a3b5-3598-844e-1de8-10e7d8ab344e@cogentembedded.com>
References: <20160924183110.s4lxuigycpxegamq@sirena.org.uk>
 <1474886150-16207-1-git-send-email-nikita.yoush@cogentembedded.com>
 <20160926160831.e5gd4t4fqhkxgzii@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f49.google.com (mail-lf0-f49.google.com
 [209.85.215.49])
 by alsa0.perex.cz (Postfix) with ESMTP id BB4062606F7
 for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2016 18:11:22 +0200 (CEST)
Received: by mail-lf0-f49.google.com with SMTP id g62so147350154lfe.3
 for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2016 09:11:22 -0700 (PDT)
In-Reply-To: <20160926160831.e5gd4t4fqhkxgzii@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Takashi Iwai <tiwai@suse.com>, Helen Koike <helen.koike@collabora.co.uk>, Chris Healy <cphealy@gmail.com>
List-Id: alsa-devel@alsa-project.org

CgoyNi4wOS4yMDE2IDE5OjA4LCBNYXJrIEJyb3duINC/0LjRiNC10YI6Cj4gT24gTW9uLCBTZXAg
MjYsIDIwMTYgYXQgMDE6MzU6NTBQTSArMDMwMCwgTmlraXRhIFl1c2hjaGVua28gd3JvdGU6Cj4g
Cj4+IEkgZG91YnQgdGhhdCBjb3B5aW5nIDcgbGluZXMgaW50byBlcnJvciBwYXRoIGlzIGJldHRl
ciB0aGFuIGhhdmluZyBhIHRpbnkKPj4gbG9naWMgd2l0aCByZXR1cm4gdmFsdWVzLCBidXQgc3Rp
bGwgaGVyZSBpdCBpcy4KPiAKPiBDb25zaWRlciB3aGF0IGhhcHBlbnMgaWYgc29tZW9uZSB3YW50
cyB0byBjaGFuZ2UgdGhlIGNvZGUuLi4gCgpJIGJlbGlldmUgdGhhdCAidW5kbyBwb3dlcm9uIiBh
bmQgInBvd2Vyb2ZmIiBzZXF1ZW5jZXMgc3RpbGwgd2lsbCBoYXZlCnRvIHJlbWFpbiB0aGUgc2Ft
ZS4gVGhpcyBoYXZpbmcgdHdvIGNvcGllcyBvZiBjb2RlIGlzIG1vcmUgZXJyb3ItcHJvbmUKdGhh
biBoYXZpbmcgb25lLgoKTmlraXRhCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9q
ZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8v
YWxzYS1kZXZlbAo=
