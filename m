From: =?UTF-8?Q?=c5=81ukasz_Majewski?= <lukma@denx.de>
Subject: Re: [PATCH] sound: soc: fsl: Do not set DAI sysclk
 when it is equal to system freq
Date: Fri, 8 Sep 2017 01:10:12 +0200
Message-ID: <76aeecd9-bff8-7b25-ca10-73d0743f724e@denx.de>
References: <AM5PR0401MB262706674539BFE651706CC6E3900@AM5PR0401MB2627.eurprd04.prod.outlook.com>
 <07e54d28-3bbc-aad2-146b-30867c0bc337@denx.de>
 <20170905052031.GB2774@Asurada-CZ80>
 <819784e1-910b-6833-997a-2097e147bd0c@denx.de>
 <20170905181108.GB23906@Asurada-Nvidia>
 <cfb8f844-87aa-f1f3-bd55-4f2b60f3cf88@denx.de>
 <20170905225225.GA14132@Asurada-Nvidia>
 <ae1d3e2a-d618-05e2-1572-5593caff1ee0@denx.de>
 <20170906173348.GA28104@Asurada-Nvidia>
 <69352458-2e90-a847-2c2f-bba259a32162@denx.de>
 <20170906194748.GA31334@Asurada-Nvidia>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 88B9F266943
 for <alsa-devel@alsa-project.org>; Fri,  8 Sep 2017 01:10:17 +0200 (CEST)
In-Reply-To: <20170906194748.GA31334@Asurada-Nvidia>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, "festevam@gmail.com" <festevam@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

SGkgTmljb2xpbiwKCj4gT24gV2VkLCBTZXAgMDYsIDIwMTcgYXQgMDg6MzU6NTBQTSArMDIwMCwg
xYF1a2FzeiBNYWpld3NraSB3cm90ZToKPiAgIAo+PiAJY2xvY2tzID0gPCZjbGtzIElNWDZRRExf
Q0xLX1NTSTJfSVBHPiwKPj4gCQkgPCZjbGtzIElNWDZRRExfQ0xLX1NTSTI+Owo+PiAJY2xvY2st
bmFtZXMgPSAiaXBnIiwgImJhdWQiOwo+IAo+Pj4+ICAgCQkJZGFpbGlua19tYXN0ZXI6IGNwdSB7
Cj4+Pj4gICAJCQkgICAgc291bmQtZGFpID0gPCZzc2kyPjsKPj4+PiAJCQkgICAgY2xvY2sgPSA8
JlNTU1M+Owo+Pgo+PiAJSWYgcG9zc2libGUgSSBkbyBwcmVmZXIgYSBzb2x1dGlvbiwgd2hpY2gg
dXNlcyBvbmx5IERUUy4KPj4gU2lkZSBxdWVzdGlvbiAtIGhvdyB0byByZWZlciB0byBiYXVkIGNs
b2NrIGZyb20gWzFdPwo+IAo+IEp1c3QgYWRkIGEgcHJvcGVydHkgdG8gdGhpcyBjcHUgbm9kZSBs
aWtlOgo+IAljbG9jayA9IDwmY2xrcyBJTVg2UURMX0NMS19TU0kyPjsKClRoaXMgZG9lc24ndCBz
b2x2ZSB0aGUgaXNzdWU6Cgpyb290QGRpc3BsYXk1On4jIHNwZWFrZXItdGVzdAoKc3BlYWtlci10
ZXN0IDEuMS4zCgpQbGF5YmFjayBkZXZpY2UgaXMgZGVmYXVsdApTdHJlYW0gcGFyYW1ldGVycyBh
cmUgNDgwMDBIeiwgUzE2X0xFLCAxIGNoYW5uZWxzClVzaW5nIDE2IG9jdGF2ZXMgb2YgcGluayBu
b2lzZQpSYXRlIHNldCB0byA0ODAwMEh6IChyZXF1ZXN0ZWQgNDhmc2wtc3NpLWRhaSAyMDJjMDAw
LnNzaTogYml0Y2xrID4gaXBnY2xrLzUKMDAwSHopCkJ1ZmZlciBzaXplIHJhbmdlIGZyb20gNjRm
c2wtc3NpLWRhaSAyMDJjMDAwLnNzaTogQVNvQzogY2FuJ3Qgc2V0IAoyMDJjMDAwLnNzaSBodyBw
YXJhbXM6IC0yMgogIHRvIDY1NTM2ClBlcmlvZCBzaXplIHJhbmdlIGZyb20gMzIgdG8gODE5MQpV
c2luZyBtYXggYnVmZmVyIHNpemUgNjU1MzYKUGVyaW9kcyA9IDQKVW5hYmxlIHRvIHNldCBodyBw
YXJhbXMgZm9yIHBsYXliYWNrOiBJbnZhbGlkIGFyZ3VtZW50ClNldHRpbmcgb2YgaHdwYXJhbXMg
ZmFpbGVkOiBJbnZhbGlkIGFyZ3VtZW50CgoKPiAKPj4+PiAJCQkgICAgc3lzdGVtLWNsb2NrLWZy
ZXF1ZW5jeSA9IDxYWFhYPjsKPiAKPiBUaGlzIHdvdWxkIG5vdCBiZSBuZWNlc3NhcnkgdW5sZXNz
IHlvdSB3YW50IHRvIHNwZWNpZnkgYSBjbG9jayByYXRlCj4gc28gYXMgdG8gb3ZlcnJpZGUgdGhl
IGNsb2NrIHJhdGUgY29uZmlndXJhdGlvbiBpbiBod19wYXJhbXMoKS4KPiAKPj4+IFRoaXMgaXMg
dGhlIHJpZ2h0IHNvbHV0aW9uIGJhc2VkIG9uIGN1cnJlbnQgc2ltcGxlLWNhcmQgZHJpdmVyLiBG
b3IKPj4+IFNTSSAoaGF2aW5nIHR3byBjbG9ja3MpLCB5b3UgaGF2ZSB0byBzcGVjaWZ5IHRoZSBi
YXVkIGNsb2NrIGluIHRoZQo+Pj4gY3B1IG5vZGUgbGlrZSB0aGF0LiBJIGJlbGlldmUgdGhpcyBp
cyB3aGF0IHRoZSBzaW1wbGUtY2FyZCBkZXNpZ25lcgo+Pj4gZXhwZWN0ZWQgdXNlcnMgdG8gZG8g
c2luY2UgdGhlIGNwdSBub2RlIGlzIHRoZSBmaXJzdCBwbGFjZSB0aGF0IHRoZQo+Pj4gZHJpdmVy
IHRyaWVzIHRvIGxvb2sgYXQuCj4+Cj4+IEkgd2lsbCBnaXZlIGEgc2hvb3QgdGhlIG9wdGlvbiB3
aXRoIGFkZGluZyB0aGUgaXBnIGNsb2NrLgo+IAo+IE5vLCBub3QgaXBnIGNsb2NrLiBZb3Ugc2hv
dWxkIHVzZSB0aGUgc2Vjb25kIGNsb2NrIC0tIGJhdWQgY2xvY2suCj4gCgoKLS0gCkJlc3QgcmVn
YXJkcywKCkx1a2FzeiBNYWpld3NraQoKLS0KCkRFTlggU29mdHdhcmUgRW5naW5lZXJpbmcgR21i
SCwgICAgICBNYW5hZ2luZyBEaXJlY3RvcjogV29sZmdhbmcgRGVuawpIUkIgMTY1MjM1IE11bmlj
aCwgT2ZmaWNlOiBLaXJjaGVuc3RyLjUsIEQtODIxOTQgR3JvZWJlbnplbGwsIEdlcm1hbnkKUGhv
bmU6ICgrNDkpLTgxNDItNjY5ODktMTAgRmF4OiAoKzQ5KS04MTQyLTY2OTg5LTgwIEVtYWlsOiB3
ZEBkZW54LmRlCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRw
Oi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
