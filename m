From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH 10/10] sound/soc/blackfin: Fix continuation
	line formats
Date: Mon, 1 Feb 2010 23:13:04 -0500
Message-ID: <8bd0f97a1002012013t5c4a3951ra559a8965d67a672@mail.gmail.com>
References: <cover.1264967493.git.joe@perches.com>
	<aee58f4fc07709fe8a34021899e701824a0a6b53.1264967500.git.joe@perches.com>
	<20100201144745.GC26011@rakim.wolfsonmicro.main>
	<1265044080.25140.266.camel@Joe-Laptop.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 3FA7A2446C
	for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2010 05:13:25 +0100 (CET)
Received: by yxe9 with SMTP id 9so4007362yxe.23
	for <alsa-devel@alsa-project.org>; Mon, 01 Feb 2010 20:13:24 -0800 (PST)
In-Reply-To: <1265044080.25140.266.camel@Joe-Laptop.home>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joe Perches <joe@perches.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

T24gTW9uLCBGZWIgMSwgMjAxMCBhdCAxMjowOCwgSm9lIFBlcmNoZXMgd3JvdGU6Cj4gT24gTW9u
LCAyMDEwLTAyLTAxIGF0IDE0OjQ3ICswMDAwLCBNYXJrIEJyb3duIHdyb3RlOgo+PiBPbiBTdW4s
IEphbiAzMSwgMjAxMCBhdCAxMjowMjoxMlBNIC0wODAwLCBKb2UgUGVyY2hlcyB3cm90ZToKPj4g
PiBTdHJpbmcgY29uc3RhbnRzIHRoYXQgYXJlIGNvbnRpbnVlZCBvbiBzdWJzZXF1ZW50IGxpbmVz
IHdpdGggXAo+PiA+IGFyZSBub3QgZ29vZC4KPj4gPgo+PiA+IFNpZ25lZC1vZmYtYnk6IEpvZSBQ
ZXJjaGVzIDxqb2VAcGVyY2hlcy5jb20+Cj4+Cj4+IEdhaCwgSSB0aG91Z2h0IEknZCBjYXVnaHQg
bW9zdCBvZiB0aGVzZSB3aGVuIHJldmlld2luZy4gwqBJZiB5b3UncmUgdXNpbmcKPj4gYSBzY3Jp
cHQgdG8gcGljayB0aGlzIHN0dWZmIHVwIGl0J2QgYmUgd29ydGggY2hlY2tpbmcgZm9yIGV4dHJh
bmVvdXMKPj4gY29udGludWF0aW9ucyBpbiB0aGUgbWlkZGxlIG9mIGNvZGUgLSBvdXRzaWRlIG9m
IG1hY3JvcyB0aGVyZSdzIGxpdHRsZQo+PiBjYWxsIGZvciBpdC4KPj4KPj4gQXBwbGllZCwgdGhh
bmtzLgo+Cj4gVGhlcmUgYXJlIGEgZmV3IGZhbHNlIHBvc2l0aXZlcyBhbmQgcHJvYmFibHkgYSBm
ZXcgbWlzc2luZyB1c2luZwo+Cj4gwqAgwqAgwqAgwqBncmVwIC1yUCAtLWluY2x1ZGU9Ki5bY2hd
ICciLipcXCQnICogfCBcCj4gwqAgwqAgwqAgwqBhd2sgJ3sgaWYgKChnc3ViKCJcIiIsICJcIiIp
ICUgMikgPT0gMSkgcHJpbnQgJDA7IH0nCj4KPiBNb3N0IG9mIHRoZSB1c2VzIGFyZSBfX2FzbV9f
IF9fdm9sYXRpbGVfXyB3aGljaCBjb3VsZCBiZQo+IGNvbnNpZGVyZWQgdW5zaWdodGx5IGJ1dCBk
b24ndCBpbXBhY3QgbG9nZ2luZyBtZXNzYWdlcy4KPgo+IFRoZSByZXN0IGNvdWxkL3Nob3VsZCBi
ZSBmaXhlZC4KCipjb3VnaCogY2hlY2twYXRjaC5wbCAqY291Z2gqCgp0aGUgQmxhY2tmaW4gYWxz
YSBmaXhlcyBhbGwgbG9vayBnb29kIHRvIG1lLCB0aGFua3MKLW1pa2UKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QK
QWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
