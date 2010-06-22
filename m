From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH v2] codecs/tlv320aic23: fix bias management
 for suspend/resume
Date: Tue, 22 Jun 2010 11:07:04 +0100
Message-ID: <1277201224.4537.1.camel@odin>
References: <20100619105929.GB2409@opensource.wolfsonmicro.com>
	<1276968819-17285-1-git-send-email-eric@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 40EB51038B6
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Jun 2010 12:07:07 +0200 (CEST)
Received: by wyb40 with SMTP id 40so3059591wyb.38
	for <alsa-devel@alsa-project.org>; Tue, 22 Jun 2010 03:07:06 -0700 (PDT)
In-Reply-To: <1276968819-17285-1-git-send-email-eric@eukrea.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric =?ISO-8859-1?Q?B=E9nard?= <eric@eukrea.com>
Cc: anuj.aggarwal@ti.com, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

T24gU2F0LCAyMDEwLTA2LTE5IGF0IDE5OjMzICswMjAwLCBFcmljIELDqW5hcmQgd3JvdGU6Cj4g
aW4gdGx2MzIwYWljMjNfc2V0X2JpYXNfbGV2ZWwsIGZvciB0aGUgY2FzZSBTTkRfU09DX0JJQVNf
T04sIHRoZQo+IGNvbW1lbnQgc2F5cyAidnJlZi9taWQsIG9zYyBvbiwgZGFjIHVubXV0ZSIgYnV0
IHRoZSBjb2RlIGRvZXNuJ3QKPiBjbGVhciB0aGUgY29ycmVzcG9uZGluZyBiaXRzLCB0aHVzIHdo
ZW4gcmVzdW1pbmcsIHNldmVyYWwgYml0cyBhcmUKPiBub3QgY2xlYXJlZCBwcmV2ZW50aW5nIHRo
ZSBjb2RlYyBmcm9tIHdvcmtpbmcuCj4gCj4gaW4gdGx2MzIwYWljMjNfc3VzcGVuZCwgY2xlYXJp
bmcgdGhlIGFjdGl2ZSByZWdpc3RlciBpcyBub3QgbmVlZGVkCj4gYXMgaXQgd2lsbCBiZSBkb25l
IGJ5IHRsdjMyMGFpYzIzX3NldF9iaWFzX2xldmVsLCB3aGVuIHNldHRpbmcKPiBiaWFzIHRvIFNO
RF9TT0NfQklBU19PRkYKPiAKPiBTaWduZWQtb2ZmLWJ5OiBFcmljIELDqW5hcmQgPGVyaWNAZXVr
cmVhLmNvbT4KPiBDYzogYnJvb25pZUBvcGVuc291cmNlLndvbGZzb25taWNyby5jb20KPiBDYzog
YW51ai5hZ2dhcndhbEB0aS5jb20KPiBDYzogbHJnQHNsaW1sb2dpYy5jby51awo+IC0tLQo+IHYy
Ogo+IAlmaXggdGhlIHByb2JsZW0gaW4gdGx2MzIwYWljMjNfc2V0X2JpYXNfbGV2ZWwgaW5zdGVh
ZCBvZiB0aGUKPiAJcHJldmlvdXMgYmFkIHdvcmthcm91bmQgaW4gc3VzcGVuZC4KPiAKPiAgc291
bmQvc29jL2NvZGVjcy90bHYzMjBhaWMyMy5jIHwgICAgNyArKysrLS0tCj4gIDEgZmlsZXMgY2hh
bmdlZCwgNCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+IAoKQWNrZWQtYnk6IExpYW0g
R2lyZHdvb2QgPGxyZ0BzbGltbG9naWMuY28udWs+Ci0tIApGcmVlbGFuY2UgRGV2ZWxvcGVyLCBT
bGltTG9naWMgTHRkCkFTb0MgYW5kIFZvbHRhZ2UgUmVndWxhdG9yIE1haW50YWluZXIuCmh0dHA6
Ly93d3cuc2xpbWxvZ2ljLmNvLnVrCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJv
amVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2Fsc2EtZGV2ZWwK
