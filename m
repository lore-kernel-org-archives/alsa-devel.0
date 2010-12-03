From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 3/3] ASoC: SAMSUNG: Match spdif source
 clock id and asoc platform device
Date: Fri, 3 Dec 2010 19:33:32 +0900
Message-ID: <AANLkTikuPbPE+cOjbdgzh6K3dSq7wAYPkF18rJK9fiw-@mail.gmail.com>
References: <1291368453-30905-1-git-send-email-sw.youn@samsung.com>
	<1291369067-31429-1-git-send-email-sw.youn@samsung.com>
	<AANLkTi=V_S=ivPv8f1uRC+8ArmX_dhHWGpbqaSqEzJ_g@mail.gmail.com>
	<AANLkTimqqS70vow58nOqSK7DhWD_NBNpU9ujX08es8SM@mail.gmail.com>
	<AANLkTikrmOWOS=K4XaBigw1X7hSJZixV2JjctB1=mtOL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 935B324431
	for <alsa-devel@alsa-project.org>; Fri,  3 Dec 2010 11:33:33 +0100 (CET)
Received: by bwz8 with SMTP id 8so8465289bwz.38
	for <alsa-devel@alsa-project.org>; Fri, 03 Dec 2010 02:33:33 -0800 (PST)
In-Reply-To: <AANLkTikrmOWOS=K4XaBigw1X7hSJZixV2JjctB1=mtOL@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Seungwhan Youn <claude.youn@gmail.com>
Cc: alsa-devel@alsa-project.org, Kukjin Kim <kgene.kim@samsung.com>, jassi.brar@samsung.com, broonie@opensource.wolfsonmicro.com, Seungwhan Youn <sw.youn@samsung.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

T24gRnJpLCBEZWMgMywgMjAxMCBhdCA3OjIzIFBNLCBKYXNzaSBCcmFyIDxqYXNzaXNpbmdoYnJh
ckBnbWFpbC5jb20+IHdyb3RlOgo+IE9uIEZyaSwgRGVjIDMsIDIwMTAgYXQgNzoxNyBQTSwgU2V1
bmd3aGFuIFlvdW4gPGNsYXVkZS55b3VuQGdtYWlsLmNvbT4gd3JvdGU6Cj4+Pj4gLSDCoCDCoCDC
oCBzbWRrX3NuZF9zcGRpZl9kZXZpY2UgPSBwbGF0Zm9ybV9kZXZpY2VfYWxsb2MoInNvYy1hdWRp
byIsIC0xKTsKPj4+PiArIMKgIMKgIMKgIHNtZGtfc25kX3NwZGlmX2RldmljZSA9IHBsYXRmb3Jt
X2RldmljZV9hbGxvYygic29jLWF1ZGlvIiwgMCk7Cj4+Pgo+Pj4gSSB0aGluayB0aGlzIGlzIG5v
dCBhcHByb3ByaWF0ZS4KPj4+Cj4+PiBNYXliZSB5b3Ugc2hvdWxkIGRvIDotCj4+PiDCoHNjbGtf
YXVkaW8wID0gY2xrX2dldChOVUxMLCAic2Nsa19hdWRpbyIpOwo+Pgo+PiBZZXMsIEkgdGhpbmsg
c28sIGJ1dCB3aXRob3V0IGlkLCB0aGVyZSBpcyBubyB3YXkgdG8gZmluZCBzY2xrX2F1ZGlvMAo+
PiBpbiBjdXJyZW50IHNhbXN1bmcgczVwLiBCZWNhdXNlLCBjdXJyZW50IHNjbGtfYXVkaW8wLDEs
MiBpcyBvbmx5IHRvCj4+IGRpc3Rpbmd1aXNoZWQgYnkgaWQgbm90IGJ5IG5hbWUsIGFuZCBhbHNv
IGFsbCBzY2xrX2F1ZGlvMCdzIGlkIGZvciBzNXAKPj4gaXMgJzAnIGZvciBub3cuIFNvLCBJIHRo
aW5rIHRoYXQgdGhpcyBtb2RpZmljYXRpb24gaXMgbW9yZSBiYXR0ZXIgdG8KPj4gbW9kaWZ5IGFs
bCBzNXAncyBzY2xrX2F1ZGlvIGNsb2NrIGlkIHRvICctMScuCj4KPiB0aGUgcGxhdGZvcm1fZGV2
aWNlIHNvYy1hdWRpbyBoYXMgbm90aGluZyB0byBkbyB3aXRoIGEgcGFydGljdWxhcgo+IGF1ZGlv
IGNvbnRyb2xsZXIsIHNvIEkgZG9uJ3QgZmF2b3IgYXNzb2NpYXRpbmcgd2l0aCBhIGNvbnRyb2xs
ZXIuCj4gR29vZCBmb3IgdXMsIFNQRElGIG5lZWRzIHNjbGtfYXVkaW8wIHdoaWNoIGlzIHRoZSBm
aXJzdCBpbnN0YW5jZQo+IHRoYXQgY2xrX2dldCB3aWxsIGNvbWUgYWNyb3NzIGFuZCBoZW5jZSB3
ZSBjYW4gc3RpbGwgZ2V0IHRoZSBjbG9jay4KCk9rLCBJIHNlZSBpdCB3b3VsZG4ndCB3b3JrIGFz
IHN1Y2guCgpUaGVvcmV0aWNhbGx5IHdlIGhhdmUgdHdvIHBhcmFsbGVsIGNsb2NrcyBmcm9tIHNh
bWUgc291cmNlIC0gb25lIGdvZXMKdG8gSTJTXzAgYW5kIHRoZSBvdGhlciB0byBTUERJRi4KU28s
IElNTywgd2UgbmVlZCB0byBjbG9uZSB0aGUgc2Nsa19hdWRpbzAgY2xvY2sgd2l0aCBTUERJRiBz
cGVjaWZpYyBuYW1lCmFuZCB0aGF0IGhhcyBpZCBhcyAtMQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRl
dmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWls
bWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
