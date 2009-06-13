From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 2/5] ASoC codec:
	SSM2602: assign last substream to the master when shutting down
Date: Sat, 13 Jun 2009 07:03:12 -0400
Message-ID: <8bd0f97a0906130403k29956684j6caeae40e16b1e6@mail.gmail.com>
References: <1243916337-29953-1-git-send-email-vapier@gentoo.org>
	<20090603105223.GE11507@sirena.org.uk>
	<8bd0f97a0906030537y1e65aa7atec4b0c5cdf4ae2f@mail.gmail.com>
	<20090603145316.GA7315@rakim.wolfsonmicro.main>
	<8bd0f97a0906031826j647efa0bs1ffb6492cfd0ccd8@mail.gmail.com>
	<20090604085921.GD6983@rakim.wolfsonmicro.main>
	<ea2442770906130237s72ff15b3n1168eb3392231149@mail.gmail.com>
	<20090613104435.GA4795@sirena.org.uk>
	<8bd0f97a0906130347x74973be2nf5c26641a09c5e24@mail.gmail.com>
	<20090613105911.GB4795@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.158])
	by alsa0.perex.cz (Postfix) with ESMTP id F1D842443D
	for <alsa-devel@alsa-project.org>;
	Sat, 13 Jun 2009 13:03:32 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 4so1335517ywq.2
	for <alsa-devel@alsa-project.org>; Sat, 13 Jun 2009 04:03:32 -0700 (PDT)
In-Reply-To: <20090613105911.GB4795@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Karl Beldan <karl.beldan@gmail.com>, uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

T24gU2F0LCBKdW4gMTMsIDIwMDkgYXQgMDY6NTksIE1hcmsgQnJvd24gd3JvdGU6Cj4gT24gU2F0
LCBKdW4gMTMsIDIwMDkgYXQgMDY6NDc6MTdBTSAtMDQwMCwgTWlrZSBGcnlzaW5nZXIgd3JvdGU6
Cj4+IGkgdGhpbmsgQ2xpZmYgdmVyaWZpZWQgdGhhdCB0aGUgb3RoZXIgcGFydCBvZiB0aGUgY2hh
bmdlIHdhcyBubyBsb25nZXIKPj4gbmVlZGVkIGluIGhpcyB0ZXN0aW5nLCBzbyByZXZlcnRpbmcg
dGhlIHdob2xlIHBhdGNoIGlzIGZpbmUuIMKgd2UndmUKPj4gZG9uZSB0aGF0IGluIHRoZSBCbGFj
a2ZpbiB0cmVlLgo+Cj4gU28sIHRoZSBmaXJzdCBwYXJ0IG9mIHRoZSBwYXRjaCB3YXMgYXBwbHlp
bmcgY29uc3RyYWludHMuIMKgWW91IGRlZmluaXRlbHkKPiB3YW50IHRvIGRvIHRoYXQgd2l0aCB5
b3VyIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gLSB0aGUgaHdfcGFyYW1zKCkKPiBmdW5jdGlvbiB3
aWxsIGNvbXBsZXRlbHkgaWdub3JlIHRoZSBwYXJhbWV0ZXJzIHNldCBmb3IgdGhlIHNlY29uZAo+
IHN1YnN0cmVhbSBzbyB1bmxlc3MgeW91IHVzZSBjb25zdHJhaW50cyB0aGUgc2Vjb25kIGFwcGxp
Y2F0aW9uIHdpbGwgZ2V0Cj4gYSBjb25maWd1cmF0aW9uIGl0IGRpZG4ndCBhc2sgZm9yIHdoaWNo
IGlzbid0IGdvaW5nIHRvIHdvcmsgc28gd2VsbC4KCnRoZSBmaXJzdCBwYXJ0IGNvbmRpdGlvbmFs
aXplZCB0aGUgY29uc3RyYWludHMuICBpZ25vcmluZyB3aGl0ZXNwYWNlCmNoYW5nZXMsIHRoaXMg
aXMgdGhlIGRpZmY6CitpZiAobWFzdGVyX3J1bnRpbWUtPnJhdGUgIT0gMCkKICAgIHNuZF9wY21f
aHdfY29uc3RyYWludF9taW5tYXgoc3Vic3RyZWFtLT5ydW50aW1lLAogICAgLi4uLi4uCitpZiAo
bWFzdGVyX3J1bnRpbWUtPnNhbXBsZV9iaXRzICE9IDApCiAgICBzbmRfcGNtX2h3X2NvbnN0cmFp
bnRfbWlubWF4KHN1YnN0cmVhbS0+cnVudGltZSwKICAgIC4uLi4uLgoKb3IgbWF5YmUgdGhhdCBp
cyB3aGF0IHlvdSdyZSBzYXlpbmcgYW5kIGkgZG9udCBrbm93IGFsc2EKLW1pa2UKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5n
IGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJv
amVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
