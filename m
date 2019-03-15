From: Chih-Wei Huang <cwhuang@android-x86.org>
Subject: Re: [PATCH 4/5] Android: avoid link_warning
Date: Sat, 16 Mar 2019 00:19:05 +0800
Message-ID: <CAKc24n2a25TqvUfxb4t00824orC6Z+Eb4mx0YscFYJV_wmENew@mail.gmail.com>
References: <20190315091706.26772-1-cwhuang@linux.org.tw>
 <20190315091706.26772-5-cwhuang@linux.org.tw>
 <77c916c1-4265-5929-9c8b-4ace67ff4490@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B3F83F89673
 for <alsa-devel@alsa-project.org>; Fri, 15 Mar 2019 17:19:18 +0100 (CET)
Received: by mail-qt1-x841.google.com with SMTP id z17so10707121qtn.4
 for <alsa-devel@alsa-project.org>; Fri, 15 Mar 2019 09:19:18 -0700 (PDT)
In-Reply-To: <77c916c1-4265-5929-9c8b-4ace67ff4490@perex.cz>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

SmFyb3NsYXYgS3lzZWxhIDxwZXJleEBwZXJleC5jej4g5pa8IDIwMTnlubQz5pyIMTXml6Ug6YCx
5LqUIOS4i+WNiDg6MTjlr6vpgZPvvJoKPgo+IERuZSAxNS4gMDMuIDE5IHYgMTA6MTcgQ2hpaC1X
ZWkgSHVhbmcgbmFwc2FsKGEpOgo+ID4gSXQgd2lsbCBiZSB0cmVhdGVkIGFzIGFuIGVycm9yLgo+
ID4KPiA+IFNpZ25lZC1vZmYtYnk6IENoaWgtV2VpIEh1YW5nIDxjd2h1YW5nQGxpbnV4Lm9yZy50
dz4KPiA+IC0tLQo+ID4gIHNyYy9wY20vcGNtLmMgfCAyICstCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4gPgo+ID4gZGlmZiAtLWdpdCBhL3NyYy9w
Y20vcGNtLmMgYi9zcmMvcGNtL3BjbS5jCj4gPiBpbmRleCAxMWFlYzgwNS4uNGJiNWZlNWYgMTAw
NjQ0Cj4gPiAtLS0gYS9zcmMvcGNtL3BjbS5jCj4gPiArKysgYi9zcmMvcGNtL3BjbS5jCj4gPiBA
QCAtMTA1Myw3ICsxMDUzLDcgQEAgaW50IHNuZF9wY21faHdzeW5jKHNuZF9wY21fdCAqcGNtKQo+
ID4gICAgICAgc25kX3BjbV91bmxvY2socGNtKTsKPiA+ICAgICAgIHJldHVybiBlcnI7Cj4gPiAg
fQo+ID4gLSNpZm5kZWYgRE9DX0hJRERFTgo+ID4gKyNpZiAhZGVmaW5lZChET0NfSElEREVOKSAm
JiAhZGVmaW5lZChBTkRST0lEKQo+ID4gIGxpbmtfd2FybmluZyhzbmRfcGNtX2h3c3luYywgIldh
cm5pbmc6IHNuZF9wY21faHdzeW5jKCkgaXMgZGVwcmVjYXRlZCwgY29uc2lkZXIgdG8gdXNlIHNu
ZF9wY21fYXZhaWwoKSIpOwo+ID4gICNlbmRpZgo+Cj4gQ3JlYXRlIGEgbmV3IG9wdGlvbiBpbiB0
aGUgY29uZmlndXJlIHNjcmlwdCAoLS1kaXNhYmxlLWh3c3luYy13YXJuaW5nIG9yCj4gc28pLiBJ
IGRvbid0IHRoaW5rIHRoYXQgdGhpcyBzaG91bGQgYmUgQW5kcm9pZCBvbmx5IHNwZWNpZmljIGNh
c2UuCgpJJ20gc29ycnkgYnV0IEFuZHJvaWQgZG9lc24ndCB1c2UgdGhlIGNvbmZpZ3VyZSBzY3Jp
cHQuClRoZSBBbmRyb2lkIGJ1aWxkIHN5c3RlbSBpbmNsdWRlIHRoZSBBbmRyb2lkLm1rIGluCnRo
ZSBzdWJmb2xkZXJzIGFuZCBidWlsZCB0aGUgdGFyZ2V0cyBkZWZpbmVkIGluIGl0IGRpcmVjdGx5
LgoKSSd2ZSB0cmllZCB0byBhZGQgY2ZsYWcgLURET0NfSElEREVOIHRvIEFuZHJvaWQubWsgYnV0
Cml0IGdlbmVyYXRlcyBtb3JlIGVycm9ycy4KCklmIGNoYW5nZSBpdCB0bwoKI2lmICFkZWZpbmVk
KERPQ19ISURERU4pICYmICFkZWZpbmVkKE5PX0hXU1lOQ19XQVJOSU5HKQoKYW5kIHRoZW4gZGVm
aW5lIE5PX0hXU1lOQ19XQVJOSU5HIGluIEFuZHJvaWQubWssCmlzIGl0IGFjY2VwdGFibGU/Cgot
LSAKQ2hpaC1XZWkKQW5kcm9pZC14ODYgcHJvamVjdApodHRwOi8vd3d3LmFuZHJvaWQteDg2Lm9y
ZwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRl
dmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cHM6Ly9tYWls
bWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
