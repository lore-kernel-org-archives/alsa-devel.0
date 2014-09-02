From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [PATCH][RFC] ASoC: simple-card: fixup cpu_dai_name
	clear case
Date: Tue, 2 Sep 2014 20:00:45 +0200
Message-ID: <20140902200045.7d8f5252@armhf>
References: <20140902090005.4a2c80b2@armhf>
 <878um2jncd.wl%kuninori.morimoto.gx@gmail.com>
 <877g1mjn9i.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
 by alsa0.perex.cz (Postfix) with ESMTP id 27CBC265499
 for <alsa-devel@alsa-project.org>; Tue,  2 Sep 2014 19:59:16 +0200 (CEST)
In-Reply-To: <877g1mjn9i.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

T24gVHVlLCAwMiBTZXAgMjAxNCAwNDowNTozMCAtMDcwMCAoUERUKQpLdW5pbm9yaSBNb3JpbW90
byA8a3VuaW5vcmkubW9yaW1vdG8uZ3hAZ21haWwuY29tPiB3cm90ZToKCj4gRnJvbTogS3VuaW5v
cmkgTW9yaW1vdG8gPGt1bmlub3JpLm1vcmltb3RvLmd4QHJlbmVzYXMuY29tPgo+IAo+IGY2ODdk
OTAwZDMwYTYxZGRhMzhkYjJhOTkyMzlmNTI4NGE4NmEzMDkKPiAoQVNvQzogc2ltcGxlLWNhcmQ6
IGNwdV9kYWlfbmFtZSBjcmVhdGVzIGNvbmZ1c2lvbiB3aGVuIERUIGNhc2UpCj4gY2xlYXJlZCBj
cHVfZGFpX25hbWUgZm9yIGNhcmluZyBmbXRfc2luZ2xlX25hbWUgY2FzZSwKPiBhbmQKPiAxNzk5
NDliYzA0YzcxNTdhNGIyMjc5ZjYyYTg0MjYzOGI2MWY3OGY5Cj4gKEFTb0M6IHNpbXBsZS1jYXJk
OiByZW1vdmUgZGFpX2xpbmstPmNwdV9kYWlfbmFtZSB3aGVuIERUKQo+IGNhcmVkIG11bHRpIGRh
aS1saW5rIGNhc2UuCj4gYnV0LCBjcHVfZGFpX25hbWUgbWF0Y2hpbmcgaXMgcmVxdWlyZWQgd2hl
biBmbXRfbXVsdGlwbGVfbmFtZSB3YXMgdXNlZAo+IAo+IFNpZ25lZC1vZmYtYnk6IEt1bmlub3Jp
IE1vcmltb3RvIDxrdW5pbm9yaS5tb3JpbW90by5neEByZW5lc2FzLmNvbT4KPiAtLS0KPiA+PiBK
ZWFuICAKPiAKPiBDYW4geW91IHBsZWFzZSB0ZXN0IHRoaXMgcGF0Y2ggPwo+IElzIHlvdXIgaXNz
dWUgc29sdmVkID8KPiAKPiAgc291bmQvc29jL2dlbmVyaWMvc2ltcGxlLWNhcmQuYyB8ICAgMjkg
KysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDE5IGluc2Vy
dGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQoKRXZlcnl0aGluZyB3b3JrcyBmaW5lLiBUaGFua3Mu
CgpUZXN0ZWQtYnk6IEplYW4tRnJhbmNvaXMgTW9pbmUgPG1vaW5lamZAZnJlZS5mcj4KCi0tIApL
ZW4gYXIgYydoZW50YcOxCXwJICAgICAgKiogQnJlaXpoIGhhIExpbnV4IGF0YXYhICoqCkplZgkJ
fAkJaHR0cDovL21vaW5lamYuZnJlZS5mci8KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNh
LXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbHNhLWRldmVsCg==
