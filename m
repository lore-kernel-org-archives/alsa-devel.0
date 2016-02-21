From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH] Revert "ASoC: fsl_ssi: remove explicit
	register defaults"
Date: Sun, 21 Feb 2016 20:13:26 +0100
Message-ID: <56CA0C56.8060109@maciej.szmigiero.name>
References: <1456065300-23752-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps-vb.mhejs.net (vi37-28-154-113.vibiznes.pl [37.28.154.113])
 by alsa0.perex.cz (Postfix) with ESMTP id 601B326067D
 for <alsa-devel@alsa-project.org>; Sun, 21 Feb 2016 20:13:38 +0100 (CET)
In-Reply-To: <1456065300-23752-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>, broonie@kernel.org
Cc: nicoleotsuka@gmail.com, Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org, mika.penttila@nextfour.com
List-Id: alsa-devel@alsa-project.org

T24gMjEuMDIuMjAxNiAxNTozNSwgRmFiaW8gRXN0ZXZhbSB3cm90ZToKPiBGcm9tOiBGYWJpbyBF
c3RldmFtIDxmYWJpby5lc3RldmFtQG54cC5jb20+Cj4gCj4gQ29tbWl0IDVjNDA4ZmVlMjU0NiAo
IkFTb0M6IGZzbF9zc2k6IHJlbW92ZSBleHBsaWNpdCByZWdpc3RlciBkZWZhdWx0cyIpCj4gY2F1
c2VzIHRoZSBkcml2ZXIgdG8gZmFpbCB0byBwcm9iZToKPiAKPiBmc2wtc3NpLWRhaSAyMDI4MDAw
LnNzaTogTm8gY2FjaGUgZGVmYXVsdHMsIHJlYWRpbmcgYmFjayBmcm9tIEhXCj4gZnNsLXNzaS1k
YWkgMjAyODAwMC5zc2k6IEZhaWxlZCB0byBpbml0IHJlZ2lzdGVyIG1hcAo+IGZzbC1zc2ktZGFp
OiBwcm9iZSBvZiAyMDI4MDAwLnNzaSBmYWlsZWQgd2l0aCBlcnJvciAtMjIKPiAKPiAsIHNvIHJl
dmVydCB0aGlzIGNvbW1pdC4KPiAKPiBDYzogTWFjaWVqIFMuIFN6bWlnaWVybyA8bWFpbEBtYWNp
ZWouc3ptaWdpZXJvLm5hbWU+Cj4gUmVwb3J0ZWQtYnk6IE1pa2EgUGVudHRpbMOkIDxtaWthLnBl
bnR0aWxhQG5leHRmb3VyLmNvbT4gCj4gU2lnbmVkLW9mZi1ieTogRmFiaW8gRXN0ZXZhbSA8ZmFi
aW8uZXN0ZXZhbUBueHAuY29tPgo+IC0tLQo+IE1hY2llaiwKPiAKPiBBcyB0aGlzIGN1cnJlbnRs
eSBicmVha3MgU1NJIG9uIDQuNS1yYyB3ZSBzaG91bGQgYmV0dGVyIHJldmVydCBpdCBmb3IKPiB0
aGlzIGN5Y2xlLgo+IAo+IFdlIGNhbiB0aGVuIGFkZCBpdCBiYWNrIHRvIDQuNyB3aGVuIE1hcmsn
cyBwYXRjaCAzMjQ1ZDQ2MGExZWI1NSAKPiAoInJlZ21hcDogY2FjaGU6IEZhbGwgYmFjayB0byBy
ZWdpc3RlciBieSByZWdpc3RlciByZWFkIGZvciBjYWNoZSBkZWZhdWx0cyIpCj4gd2lsbCBiZSBh
dmFpbGFibGUgYW5kIHRoZW4gdGhlIGRyaXZlciB3aWxsIHdvcmsgZmluZSB3aXRoIHlvdXIgcGF0
Y2guCgpXaGlsZSBJIHNlZSBubyBwcm9ibGVtIHdpdGggZGVsYXlpbmcgdGhpcyBwYXRjaCB0byBu
ZXh0IGtlcm5lbCB3b3VsZG4ndAppdCBiZSBlYXNpZXIgdG8gc2ltcGx5IG1lcmdlIHRoZSByZWdt
YXAgY2hhbmdlIGFzIGEgZml4IGFzIHlvdQpoYWQgc3VnZ2VzdGVkIHByZXZpb3VzbHk/CgpNYWNp
ZWoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2Et
ZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFp
bG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
