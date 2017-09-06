From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] sound: soc: fsl: Do not set DAI sysclk
 when it is equal to system freq
Date: Wed, 6 Sep 2017 10:33:50 -0700
Message-ID: <20170906173348.GA28104@Asurada-Nvidia>
References: <1504436701-20700-1-git-send-email-lukma@denx.de>
 <AM5PR0401MB262706674539BFE651706CC6E3900@AM5PR0401MB2627.eurprd04.prod.outlook.com>
 <07e54d28-3bbc-aad2-146b-30867c0bc337@denx.de>
 <20170905052031.GB2774@Asurada-CZ80>
 <819784e1-910b-6833-997a-2097e147bd0c@denx.de>
 <20170905181108.GB23906@Asurada-Nvidia>
 <cfb8f844-87aa-f1f3-bd55-4f2b60f3cf88@denx.de>
 <20170905225225.GA14132@Asurada-Nvidia>
 <ae1d3e2a-d618-05e2-1572-5593caff1ee0@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f169.google.com (mail-pf0-f169.google.com
 [209.85.192.169])
 by alsa0.perex.cz (Postfix) with ESMTP id F105A266A8A
 for <alsa-devel@alsa-project.org>; Wed,  6 Sep 2017 19:33:27 +0200 (CEST)
Received: by mail-pf0-f169.google.com with SMTP id m1so13830273pfk.1
 for <alsa-devel@alsa-project.org>; Wed, 06 Sep 2017 10:33:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <ae1d3e2a-d618-05e2-1572-5593caff1ee0@denx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?utf-8?Q?=C5=81ukasz?= Majewski <lukma@denx.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, "festevam@gmail.com" <festevam@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCBTZXAgMDYsIDIwMTcgYXQgMTE6MjI6NDhBTSArMDIwMCwgxYF1a2FzeiBNYWpld3Nr
aSB3cm90ZToKCj4gPkhlcmUgaXMgdGhlIHJvdXRpbmUgdGhhdCBJIHVuZGVyc3Rvb2QgZnJvbSB0
aGUgY29kZToKPiA+MSkgYXNvY19zaW1wbGVfY2FyZF9wYXJzZV9jbGtfY3B1KGRldiwgY3B1LCBk
YWlfbGluaywgY3B1X2RhaSk7Cj4gPiAgICA9PiBhc29jX3NpbXBsZV9jYXJkX3BhcnNlX2Nsayhk
ZXYsIGNwdSwgICAgICAgIC8vIGNwdSBub2RlIGluIHNvdW5ke30gWzFdCj4gPgkJICAgCQkgZGFp
X2xpbmstPmNwdV9vZl9ub2RlLCAgICAgLy8gbm9kZSBzc2kyIFsyXQo+ID4JCQkJIGNwdV9kYWks
IGRhaV9saW5rLT5jcHVfZGFpX25hbWUpOwo+ID4gICAgPT0+IDEuMSkgZGV2bV9nZXRfY2xrX2Zy
b21fY2hpbGQoZGV2LCBub2RlLCBOVUxMKTsgICAgICAgICAgICAgICAgIC8vIFsxXQo+ID4gICAg
PT0+IDEuMikgb2ZfcHJvcGVydHlfcmVhZF91MzIobm9kZSwgInN5c3RlbS1jbG9jay1mcmVxdWVu
Y3kiLCAmdmFsKS8vIFsxXQo+ID4gICAgPT0+IDEuMykgZGV2bV9nZXRfY2xrX2Zyb21fY2hpbGQo
ZGV2LCBkYWlfb2Zfbm9kZSwgTlVMTCk7ICAgICAgICAgIC8vIFsyXQoKPiA+Rm9yIHRoZSBjcHUg
cm91dGluZSwgaXQgZmlyc3QgY2hlY2tzIGZvciBjbG9jayBwcm9wZXJ0eSB1bmRlciBjcHUKPiA+
bm9kZSBvZiBzaW1wbGUtY2FyZCwgdGhlbiBmb3IgInN5c3RlbS1jbG9jay1mcmVxdWVuY3kiIGlu
IHRoZSBjcHUKPiA+bm9kZSBvZiBzaW1wbGUtY2FyZCwgYW5kIGZpbmFsbHkgbG9va3MgZm9yIGNs
b2NrIHByb3BlcnR5IGluIHNzaTIKPiA+bm9kZS4KCj4gLS0tLS0+IGRldjogc291bmQKPiAtLS0t
LT4gY2xrIG5vZGU6IC9zb2MvYWlwcy1idXNAMDIwMDAwMDAvc3BiYS1idXNAMDIwMDAwMDAvc3Np
QDAyMDJjMDAwCj4gLS0tLS0+IENsayBhc2lnbm1lbnQKPiAKPiBBbmQgdGhpcyBjbG9jayBpcyB0
YWtlbiBmcm9tIHRoaXMgbm9kZS4gSXQgbG9va3MgbGlrZSBpcGcgY2xvY2sgZm9yIHNzaS4uLgoK
VGhpcyBtYWtlcyBzZW5zZSBub3cuIFRoZSBkZXZtX2dldF9jbGtfZnJvbV9jaGlsZCgpIGluIDEu
MykgZmV0Y2hlZAp0aGUgZmlyc3QgY2xvY2sgb2Ygc3NpMiAtLSBpcGcgY2xvY2suCgo+IFRoZSBw
cm9ibGVtIGlzIHdpdGggdGhlICJsYWNrIiBvZiBjbG9jayBub2Rlcy9wcm9wZXJ0aWVzIGF0Cj4g
Cj4gIAkJCWRhaWxpbmtfbWFzdGVyOiBjcHUgewo+ICAJCQkgICAgc291bmQtZGFpID0gPCZzc2ky
PjsKPiAJCQkgICAgY2xvY2sgPSA8JlNTU1M+Owo+IAkJCSAgICBzeXN0ZW0tY2xvY2stZnJlcXVl
bmN5ID0gPFhYWFg+Owo+ICAJCQl9OwoKVGhpcyBpcyB0aGUgcmlnaHQgc29sdXRpb24gYmFzZWQg
b24gY3VycmVudCBzaW1wbGUtY2FyZCBkcml2ZXIuIEZvcgpTU0kgKGhhdmluZyB0d28gY2xvY2tz
KSwgeW91IGhhdmUgdG8gc3BlY2lmeSB0aGUgYmF1ZCBjbG9jayBpbiB0aGUKY3B1IG5vZGUgbGlr
ZSB0aGF0LiBJIGJlbGlldmUgdGhpcyBpcyB3aGF0IHRoZSBzaW1wbGUtY2FyZCBkZXNpZ25lcgpl
eHBlY3RlZCB1c2VycyB0byBkbyBzaW5jZSB0aGUgY3B1IG5vZGUgaXMgdGhlIGZpcnN0IHBsYWNl
IHRoYXQgdGhlCmRyaXZlciB0cmllcyB0byBsb29rIGF0LgoKPiBJIHRoaW5rIHRoYXQgdGhlIHBy
b3BlciBzb2x1dGlvbiB3b3VsZCBiZSB0byBhZGQgY2hlY2sgZm9yOgo+IAo+IGZyZXEgPCBzeXNj
bGsvNSBpbiBmc2xfc3NpX3NldF9kYWlfc3lzY2xrKCkgYW5kIHJldHVybiAtRU5PVFNVUFAgdG8K
PiBtYWtlIHRoZSBzaW1wbGUtYXVkby1jYXJkIGRyaXZlciBoYXBweSAoYW5kIG5vdCBpbnRyb2R1
Y2luZwo+IHJlZ3Jlc3Npb25zKS4KCkFzIEkgc2FpZCBpbiB0aGUgZmlyc3QgcGxhY2UsIGFkZGlu
ZyBhbm90aGVyIGNoZWNrIGluIHNldF9zeXNjbGsoKQppcyBub3QgdGhhdCBlc3NlbnRpYWwgYnV0
IHNlZW1zIHRvIGJlIHBsYXVzaWJsZSB0byBtZS4gU28gSSBhbSBva2F5CmlmIHlvdSByZWFsbHkg
d2FudCB0byBoYXZlIHRoYXQuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0
Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxz
YS1kZXZlbAo=
