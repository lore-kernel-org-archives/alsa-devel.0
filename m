From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 0/5] ASoC: davinci: Use edma-pcm and remove
 davinci-pcm
Date: Thu, 5 Mar 2015 12:48:48 +0200
Message-ID: <54F83490.9010208@ti.com>
References: <1425393921-14219-1-git-send-email-peter.ujfalusi@ti.com>
 <54F6A3E5.1090201@topic.nl> <54F6C737.309@ti.com> <54F6FA66.8000803@topic.nl>
 <54F71249.2090703@ti.com> <54F82553.7050508@topic.nl>
 <54F833B1.1070204@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 4805E260448
 for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2015 11:48:52 +0100 (CET)
In-Reply-To: <54F833B1.1070204@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mike Looijmans <mike.looijmans@topic.nl>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

T24gMDMvMDUvMjAxNSAxMjo0NSBQTSwgUGV0ZXIgVWpmYWx1c2kgd3JvdGU6Cj4gT0ssIHRoaXMg
aXMgYWxzbyBzdXBwb3J0ZWQgYnkgdGhlIGVkbWEtcGNtLCB5b3UgbmVlZCB0byBlbmFibGUgdGhl
IEZJRk8gYW5kCj4gc3BlY2lmeSB0aGUgdGhyZXNob2xkLgoKVmlhIGVkbWEtcGNtIHlvdSBjYW4g
ZGlzYWJsZSB0aGUgcGVyaW9kIGludGVycnVwdHMgc28gZm9yIGV4YW1wbGUgUEEgY2FuIHdvcmsK
aW4gdGhpcyBtb2RlLiBZb3UgaGF2ZSBiaWcgZW5vdWdoIGJ1ZmZlciBhbmQgeW91IGRvIG5vdCBn
ZXQgYW55IGludGVycnVwdHMKZHVyaW5nIGF1ZGlvLCBqdXN0IHVzZXIgc3BhY2UgdGltZXIgdG8g
Y2hlY2sgdGhlIGF1ZGlvIHN0YXR1cyBldmVyeSBub3cgYW5kIHRoZW4uClRoaXMgd2FzIG5vdCBw
b3NzaWJsZSB3aXRoIHRoZSBkYXZpbmNpLXBjbS4KCj4+IEkgdXNlIGEgNE1CIGJ1ZmZlciBmb3Ig
dGhhdCAxNi1jaGFubmVscy1vZi0zMi1iaXRzIHN5c3RlbSwgdXN1YWxseSB3aXRoIDgKPj4gcGVy
aW9kcyBvZiA1MTJrQiBlYWNoLgo+IAo+IEdsYWQgdG8gaGVhciwgaWYgeW91IGV2ZXIgbmVlZCB0
byB1cGRhdGUgdGhlIGtlcm5lbCwgdGhlIGVkbWEtcGNtIGNvbnZlcnNpb24KPiB3aWxsIG5vdCBn
b2luZyB0byBjYXVzZSB5b3UgcmVncmVzc2lvbiA7KQo+IAo+PiBNZXQgdnJpZW5kZWxpamtlIGdy
b2V0IC8ga2luZCByZWdhcmRzLAo+Pgo+PiBNaWtlIExvb2lqbWFucwo+PiBTeXN0ZW0gRXhwZXJ0
Cj4+Cj4+Cj4+IFRPUElDIEVtYmVkZGVkIFN5c3RlbXMKPj4gRWluZGhvdmVuc2V3ZWcgMzItQywg
TkwtNTY4MyBLSCBCZXN0Cj4+IFBvc3RidXMgNDQwLCBOTC01NjgwIEFLIEJlc3QKPj4gVGVsZWZv
b246ICgrMzEpICgwKSA0OTkgMzMgNjkgNzkKPj4gVGVsZWZheDogICgrMzEpICgwKSA0OTkgMzMg
NjkgNzAKPj4gRS1tYWlsOiBtaWtlLmxvb2lqbWFuc0B0b3BpYy5ubAo+PiBXZWJzaXRlOiB3d3cu
dG9waWMubmwKPj4KPj4gUGxlYXNlIGNvbnNpZGVyIHRoZSBlbnZpcm9ubWVudCBiZWZvcmUgcHJp
bnRpbmcgdGhpcyBlLW1haWwKPj4KPj4gVG9waWMgem9la3QgZ2VkcmV2ZW4gKGVtYmVkZGVkKSBz
b2Z0d2FyZSBzcGVjaWFsaXN0ZW4hCj4+IGh0dHA6Ly90b3BpYy5ubC92YWNhdHVyZXMvdG9waWMt
em9la3Qtc29mdHdhcmUtZW5naW5lZXJzLwo+Pgo+IAo+IAoKCi0tIApQw6l0ZXIKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5n
IGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJv
amVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
