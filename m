From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: Re: [PATCH] Revert "ASoC: core: replace aux_comp_list
 to component_dev_list"
Date: Thu, 29 Dec 2016 19:20:11 +0300
Message-ID: <dcb60f8c-533a-63a8-22c8-f5ecb7cf2e9c@cogentembedded.com>
References: <CGME20161229152622epcas4p19054a78722d5eae88c983230f457e794@epcas4p1.samsung.com>
 <1483022987-28843-1-git-send-email-nikita.yoush@cogentembedded.com>
 <061fafe6-dc46-375d-9e57-cc59115a04aa@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f49.google.com (mail-lf0-f49.google.com
 [209.85.215.49])
 by alsa0.perex.cz (Postfix) with ESMTP id DE294266F84
 for <alsa-devel@alsa-project.org>; Thu, 29 Dec 2016 17:20:14 +0100 (CET)
Received: by mail-lf0-f49.google.com with SMTP id b14so223626403lfg.2
 for <alsa-devel@alsa-project.org>; Thu, 29 Dec 2016 08:20:14 -0800 (PST)
In-Reply-To: <061fafe6-dc46-375d-9e57-cc59115a04aa@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Chris Healy <cphealy@gmail.com>
List-Id: alsa-devel@alsa-project.org

CgoyOS4xMi4yMDE2IDE5OjE4LCBTeWx3ZXN0ZXIgTmF3cm9ja2kg0L/QuNGI0LXRgjoKPiBPbiAx
Mi8yOS8yMDE2IDAzOjQ5IFBNLCBOaWtpdGEgWXVzaGNoZW5rbyB3cm90ZToKPj4gVGhpcyByZXZl
cnRzIGNvbW1pdCAxYTY1M2FhNDQ3MjU2Njg1OTBiMzZiYmUyZDdmZTQ3MzZhNjlmMDU1ICgiQVNv
QzoKPj4gY29yZTogcmVwbGFjZSBhdXhfY29tcF9saXN0IHRvIGNvbXBvbmVudF9kZXZfbGlzdCIp
Lgo+Pgo+PiBUaGF0IGNvbW1pdCB0cmllcyB0byByZW1vdmUgY2FyZC0+YXV4X2NvbXBfbGlzdCwg
dXNpbmcgZmxhZ2dlZCBlbnRyaWVzCj4+IGluIGNhcmQtPmNvbXBvbmVudF9kZXZfbGlzdCBpbnN0
ZWFkLgo+Pgo+PiBIb3dldmVyLCBjb21wb25lbnRzIGFyZSBhZGRlZCB0byBjYXJkLT5jb21wb25l
bnRfZGV2X2xpc3QgaW4KPj4gc29jX3Byb2JlX2NvbXBvbmVudCgpLCB3aGljaCBpcyBjYWxsZWQg
Zm9yIGF1eCBkZXZpY2VzIGJ5Cj4+IHNvY19wcm9iZV9hdXhfZGV2aWNlcygpLiBCZWZvcmUgdGhh
dCBjb21taXQsIGl0IHRyYXZlcnNlZAo+PiBjYXJkLT5hdXhfY29tcF9saXN0IGFuZCBmb3VuZCBh
dXggZGV2aWNlcyBhZGRlZCBieSBzb2NfYmluZF9hdXhfZGV2KCkuCj4+IEFmdGVyIHRoYXQgY29t
bWl0LCBpdCB0cmF2ZXJzZXMgY2FyZC0+Y29tcG9uZW50X2Rldl9saXN0IGFuZCBmaW5kcyBubwo+
PiBhdXggZGV2aWNlcywgYmVjYXVzZSBzb2NfcHJvYmVfY29tcG9uZW50KCkgd2FzIG5vdCB5ZXQg
Y2FsbGVkIGZvciB0aGVtLgo+Pgo+PiBUaHVzIGFsbCBhdXggZGV2aWNlcyBhcmUgbG9zdCBhbmQg
YW55IHNldHVwIHRoYXQgbmVlZHMgdGhlbSBubyBsb25nZXIKPj4gd29ya3MuCj4gCj4gSSB0aGlu
ayB3ZSBjYW4ndCBzaW1wbHkgcmV2ZXJ0IHRoYXQgY29tbWl0IG5vdywgYWZ0ZXIgY29tbWl0Cj4g
Cj4gOTE3OGZlYiBBU29DOiBhZGQgQ29tcG9uZW50IGxldmVsIHN1c3BlbmQvcmVzdW1lCj4gY29t
cG9uZW50X2Rldl9saXN0IGlzIGFsc28gdXNlZCBmb3IgdGhlIGNvbXBvbmVudCBsZXZlbCBzdXNw
ZW5kL3Jlc3VtZSwKPiBpZiBhdXhpbGlhcnkgZGV2aWNlcyB3b3VsZCBoYXZlIGJlZW4gb24gYSBz
ZXBhcmF0ZSBsaXN0IHRoZXkgd291bGQgYmUKPiBtaXNzZWQgaW4gdGhlIHN1c3BlbmQvcmVzdW1l
IHNlcXVlbmNlcy4KCkkgYmVsaWV2ZSBhdXggZGV2aWNlcyBhcmUgb24gYm90aCBsaXN0cy4KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBt
YWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFs
c2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
