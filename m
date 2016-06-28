From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH 2/2] ASoC: fsl_ssi: Fix number of words per
 frame for I2S-slave mode
Date: Tue, 28 Jun 2016 15:06:42 -0700
Message-ID: <20160628220641.GB378@Asurada-Nvidia>
References: <1466830762-31646-1-git-send-email-shc_work@mail.ru>
 <20160628182053.GA21603@Asurada-Nvidia>
 <1467143972.433375523@f318.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f175.google.com (mail-pf0-f175.google.com
 [209.85.192.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 227D6265A8C
 for <alsa-devel@alsa-project.org>; Wed, 29 Jun 2016 00:06:45 +0200 (CEST)
Received: by mail-pf0-f175.google.com with SMTP id i123so10721810pfg.0
 for <alsa-devel@alsa-project.org>; Tue, 28 Jun 2016 15:06:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1467143972.433375523@f318.i.mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Timur Tabi <timur@tabi.org>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: alsa-devel@alsa-project.org

T24gVHVlLCBKdW4gMjgsIDIwMTYgYXQgMTA6NTk6MzJQTSArMDMwMCwgQWxleGFuZGVyIFNoaXlh
biB3cm90ZToKPiA+0JLRgtC+0YDQvdC40LosIDI4INC40Y7QvdGPIDIwMTYsIDIxOjIwICswMzow
MCDQvtGCIE5pY29saW4gQ2hlbiA8bmljb2xlb3RzdWthQGdtYWlsLmNvbT46Cj4gPgo+ID5PbiBT
YXQsIEp1biAyNSwgMjAxNiBhdCAwNzo1OToyMkFNICswMzAwLCBBbGV4YW5kZXIgU2hpeWFuIHdy
b3RlOgo+ID4+IFRoZSBpLk1YNTEgZGF0YXNoZWV0IHNheXM6Cj4gPj4gQ2hhcHRlciA1Ni4xLjIu
NCBJMlMgTW9kZQo+ID4+IC4uLgo+ID4+IFdoZW4gSTJTIG1vZGVzIGFyZSBlbnRlcmVkIChJMlMg
bWFzdGVyICgwMSkgb3IgSTJTIHNsYXZlICgxMCkpLAo+ID4+IHRoZSBmb2xsb3dpbmcgc2V0dGlu
Z3MgYXJlIHJlY29tbWVuZGVkOgo+ID4+IC4uLgo+ID4+IC0gVFggRnJhbWUgUmF0ZSBzaG91bGQg
YmUgMiBpLmUuIChTVENDUlsxMjo4XSA9IDEpCj4gPj4gLSBSWCBGcmFtZSBSYXRlIHNob3VsZCBi
ZSAyIGkuZS4gKFNSQ0NSWzEyOjhdID0gMSkKPiA+PiAKPiA+PiBDaGFwdGVyIDU2LjMuMy4xMiBT
U0kgVHJhbnNtaXQgYW5kIFJlY2VpdmUgQ2xvY2sgQ29udHJvbCBSZWdpc3RlcnMgKFNUQ0NSICYg
U1JDQ1IpCj4gPj4gLi4uCj4gPj4gQml0cyAxMi04IERDNC1EQzAKPiA+PiBGcmFtZSBSYXRlIERp
dmlkZXIgQ29udHJvbC4gVGhlc2UgYml0cyBhcmUgdXNlZCB0byBjb250cm9sIHRoZSBkaXZpZGUg
cmF0aW8KPiA+PiBmb3IgdGhlIHByb2dyYW1tYWJsZSBmcmFtZSByYXRlIGRpdmlkZXJzLiBUaGUg
ZGl2aWRlIHJhdGlvIHdvcmtzIG9uIHRoZSB3b3JkCj4gPj4gY2xvY2suIEluIE5vcm1hbCBtb2Rl
LCB0aGlzIHJhdGlvIGRldGVybWluZXMgdGhlIHdvcmQgdHJhbnNmZXIgcmF0ZS4KPiA+PiBJbiBO
ZXR3b3JrIG1vZGUsIHRoaXMgcmF0aW8gc2V0cyB0aGUgbnVtYmVyIG9mIHdvcmRzIHBlciBmcmFt
ZS4gVGhlIGRpdmlkZQo+ID4+IHJhdGlvIHJhbmdlcyBmcm9tIDEgdG8gMzIgaW4gTm9ybWFsIG1v
ZGUgYW5kIGZyb20gMiB0byAzMiBpbiBOZXR3b3JrIG1vZGUuCj4gPj4gSW4gTm9ybWFsIG1vZGUs
IGEgZGl2aWRlIHJhdGlvIG9mIDEgKERDPTAwMDAwKSBwcm92aWRlcyBjb250aW51b3VzIHBlcmlv
ZGljCj4gPj4gZGF0YSB3b3JkIHRyYW5zZmVyLiBBIGJpdC1sZW5ndGggZnJhbWUgc3luYyBtdXN0
IGJlIHVzZWQgaW4gdGhpcyBjYXNlLgo+ID4+IAo+ID4+IEZ1bmN0aW9uIGZzbF9zc2lfaHdfcGFy
YW1zKCkgc2V0dXAgTm9ybWFsIG1vZGUgZm9yIE1PTk8gb3V0cHV0LAo+ID4+IHNvIHdpdGggREM9
MCwgU1NJIGVudGVycyB0byBjb250aW51b3VzIHBlcmlvZGljIGRhdGEgd29yZCB0cmFuc2Zlci4K
PiA+PiBUbyBmaXggdGhpcywgc2V0dXAgREMgZm9yIGFueSBJMlMgbW9kZS4KPiA+Cj4gPlRoZSBj
aGFuZ2UgbG9va3MgZmluZSBhbmQgZGlkbid0IHNob3cgYW55IHByb2JsZW0gd2hlbiBJIHRlc3Rl
ZCBpdC4KPiA+QnV0IEkgYW0gd29uZGVyaW5nIHdoYXQncyB0aGUgZmFpbGVkIHVzZXIgY2FzZSBo
ZXJlIHNvIHdlIG5lZWQgdGhpcwo+ID5wYXRjaCB0byBmaXg/IChUaGUgbW9ubyBwbGF5YmFjayB3
b3JrcyB3aXRob3V0IHRoaXMgcGF0Y2ggYXMgd2VsbC4pCj4gCj4gUHJvYmFibHkgdGhpcyB3b3Jr
cyBmaW5lIHdpdGhvdXQgcGF0Y2ggaWYgRlNjbGsgPT0gQklUY2xrICogc2l6ZS4KCkkgYWNrZWQg
dGhpcyBwYXRjaCBzaW5jZSBpdCdzIG1vcmUgbGlrZWx5IGEgY29ycmVjdCBjb25maWd1cmF0aW9u
CmFjY29yZGluZyB0byB0aGUgcmVmZXJlbmNlIG1hbnVhbCB3aGlsZSBzdGlsbCB3YW50IHRvIGtu
b3cgd2hhdCdzCnlvdXIgZmFpbGVkIGNhc2UuIENvdWxkIHlvdSBwbGVhc2UgdGVsbCBtZSB3aGF0
IHdlcmUgdGhlIEZTY2xrLApCSVRjbGsgYW5kIHNpemUgb2YgeW91ciBjYXNlPwoKVGhhbmtzCk5p
Y29saW4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxz
YS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9t
YWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
