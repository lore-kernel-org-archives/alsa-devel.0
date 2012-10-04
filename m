From: "Rafal Powierski" <powierski@mediascore.de>
Subject: Re: snd_hwdep_open() as non-root user
Date: Thu, 4 Oct 2012 18:06:48 +0200
Message-ID: <A60A5874942842A88CDCF66A5EB018C6@mediascore.mediascore.de>
References: <44F73A434CA44E548BE58635A97F56C9@mediascore.mediascore.de>
 <506D8602.3050007@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
 [212.227.126.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 291202615C3
 for <alsa-devel@alsa-project.org>; Thu,  4 Oct 2012 18:06:49 +0200 (CEST)
In-Reply-To: <506D8602.3050007@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

ClRoYW5rIHlvdSBDbGVtZW5zLApzdWRvIHNldGNhcCBjYXBfc3lzX3Jhd2lvLi4uIHNvbHZlcyB0
aGUgcHJvYmxlbSA6KQpJIG9ubHkgbmVlZCB0byBhZCBpdCB0byB0aGUgcXQgYnVpbGQgb3IgdG8g
dGhlIGFwcCBpdHNlbGYuCkJlc3QgUmVnYXJkcywKUmFmYWwKCgotLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLSAKRnJvbTogQ2xlbWVucyBMYWRpc2NoClNlbnQ6IFRodXJzZGF5LCBPY3RvYmVyIDA0
LCAyMDEyIDI6NTAgUE0KVG86IFJhZmFsIFBvd2llcnNraQpDYzogYWxzYS1kZXZlbEBhbHNhLXBy
b2plY3Qub3JnClN1YmplY3Q6IFJlOiBbYWxzYS1kZXZlbF0gc25kX2h3ZGVwX29wZW4oKSBhcyBu
b24tcm9vdCB1c2VyCgpSYWZhbCBQb3dpZXJza2kgd3JvdGU6Cj4gSSB3b3VsZCBsaWtlIHRvIGFj
Y2VzcyBwaW4gdmVyYiBoZGEgaW50ZXJmYWNlIHVzaW5nIHNuZF9od2RlcF9vcGVuKCkgCj4gZnVu
Y3Rpb24uCj4gSXQgd29ya3MgZmluZSBpZiBJIHJ1biBhcyByb290Lgo+IEkgaG9wZSB0aGVyZSBp
cyBhIHdheSB0byBjb25maWd1cmUgbXkga3VidW50dSBzbyBJIGNhbiBkbyBpdCBhcyBub24tcm9v
dCAKPiB1c2VyIChlLmcuIGRlYnVnZ2luZykKPiBzbyBmYXIsIEkgaGF2ZSBiZWVuIHRyeWluZyBj
aGFuZ2luZyBhY2Nlc3MgZmxhZ3MgZm9yIGRldmljZXMgaW4gL2Rldi9zbmQvIAo+IGRpcmVjdG9y
eSB0byBjcnd4cnd4cnd4IG5vIHBsdXMgY2hhcmFjdGVyLgo+IEl0IGRpZCBub3QgY2hhbmdlIG15
IHByaXZpbGVnZXMgZm9yIHNuZF9od2RlcF9vcGVuKCkgLSAgc3RpbGwgcmV0dXJucyDigJMxMy4K
CnNvdW5kL3BjaS9oZGEvaGRhX2h3ZGVwLmMgc2F5czoKCnN0YXRpYyBpbnQgaGRhX2h3ZGVwX29w
ZW4oc3RydWN0IHNuZF9od2RlcCAqaHcsIHN0cnVjdCBmaWxlICpmaWxlKQp7CiNpZm5kZWYgQ09O
RklHX1NORF9ERUJVR19WRVJCT1NFCmlmICghY2FwYWJsZShDQVBfU1lTX1JBV0lPKSkKcmV0dXJu
IC1FQUNDRVM7CiNlbmRpZgpyZXR1cm4gMDsKfQoKClJlZ2FyZHMsCkNsZW1lbnMKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5n
IGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJv
amVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsIAoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxz
YS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
