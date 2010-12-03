From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 3/3] ASoC: SAMSUNG: Match spdif source
 clock id and asoc platform device
Date: Fri, 3 Dec 2010 19:06:55 +0900
Message-ID: <AANLkTi=V_S=ivPv8f1uRC+8ArmX_dhHWGpbqaSqEzJ_g@mail.gmail.com>
References: <1291368453-30905-1-git-send-email-sw.youn@samsung.com>
	<1291369067-31429-1-git-send-email-sw.youn@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 41052243FA
	for <alsa-devel@alsa-project.org>; Fri,  3 Dec 2010 11:06:56 +0100 (CET)
Received: by bwz8 with SMTP id 8so8444912bwz.38
	for <alsa-devel@alsa-project.org>; Fri, 03 Dec 2010 02:06:56 -0800 (PST)
In-Reply-To: <1291369067-31429-1-git-send-email-sw.youn@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Seungwhan Youn <sw.youn@samsung.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, jassi.brar@samsung.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

T24gRnJpLCBEZWMgMywgMjAxMCBhdCA2OjM3IFBNLCBTZXVuZ3doYW4gWW91biA8c3cueW91bkBz
YW1zdW5nLmNvbT4gd3JvdGU6Cj4gVGhpcyBwYXRjaCBtb2RpZnkgdG8gbWF0Y2ggaWRzIGJldHdl
ZW4gc291cmNlIGNsb2NrIGlkIGFuZCBhc29jIHBsYXRmb3JtCj4gZGV2aWNlIHRoYXQgc3BkaWYg
ZHJpdmVyIGNhbiBmaW5kIHNjbGtfYXVkaW8wIHdpdGggZGV2aWNlIGlkLgo+Cj4gU2lnbmVkLW9m
Zi1ieTogU2V1bmd3aGFuIFlvdW4gPHN3LnlvdW5Ac2Ftc3VuZy5jb20+Cj4gLS0tCj4gwqBzb3Vu
ZC9zb2MvczNjMjR4eC9zbWRrX3NwZGlmLmMgfCDCoCDCoDIgKy0KPiDCoDEgZmlsZXMgY2hhbmdl
ZCwgMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL3NvdW5k
L3NvYy9zM2MyNHh4L3NtZGtfc3BkaWYuYyBiL3NvdW5kL3NvYy9zM2MyNHh4L3NtZGtfc3BkaWYu
Ywo+IGluZGV4IDBlMWZlNjAuLmI0YWQyMzEgMTAwNjQ0Cj4gLS0tIGEvc291bmQvc29jL3MzYzI0
eHgvc21ka19zcGRpZi5jCj4gKysrIGIvc291bmQvc29jL3MzYzI0eHgvc21ka19zcGRpZi5jCj4g
QEAgLTE4Myw3ICsxODMsNyBAQCBzdGF0aWMgaW50IF9faW5pdCBzbWRrX2luaXQodm9pZCkKPiDC
oCDCoCDCoCDCoGlmIChyZXQpCj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBnb3RvIGVycjI7Cj4K
PiAtIMKgIMKgIMKgIHNtZGtfc25kX3NwZGlmX2RldmljZSA9IHBsYXRmb3JtX2RldmljZV9hbGxv
Yygic29jLWF1ZGlvIiwgLTEpOwo+ICsgwqAgwqAgwqAgc21ka19zbmRfc3BkaWZfZGV2aWNlID0g
cGxhdGZvcm1fZGV2aWNlX2FsbG9jKCJzb2MtYXVkaW8iLCAwKTsKCkkgdGhpbmsgdGhpcyBpcyBu
b3QgYXBwcm9wcmlhdGUuCgpNYXliZSB5b3Ugc2hvdWxkIGRvIDotCiAgc2Nsa19hdWRpbzAgPSBj
bGtfZ2V0KE5VTEwsICJzY2xrX2F1ZGlvIik7Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxz
YS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlz
dGluZm8vYWxzYS1kZXZlbAo=
