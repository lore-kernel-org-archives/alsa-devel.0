From: =?UTF-8?Q?=c5=81ukasz_Majewski?= <lukma@denx.de>
Subject: Re: [PATCH] sound: soc: fsl: Do not set DAI sysclk
 when it is equal to system freq
Date: Tue, 5 Sep 2017 10:19:05 +0200
Message-ID: <deb40031-9db0-d667-7314-352cf548c295@denx.de>
References: <1504436701-20700-1-git-send-email-lukma@denx.de>
 <20170905050602.GA2774@Asurada-CZ80>
 <bbcb123b-8700-501f-e6d9-cab9e212de40@denx.de>
 <20170905075247.GA6112@Asurada>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 7814C266E25
 for <alsa-devel@alsa-project.org>; Tue,  5 Sep 2017 10:19:10 +0200 (CEST)
In-Reply-To: <20170905075247.GA6112@Asurada>
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
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

T24gMDkvMDUvMjAxNyAwOTo1MiBBTSwgTmljb2xpbiBDaGVuIHdyb3RlOgo+IE9uIFR1ZSwgU2Vw
IDA1LCAyMDE3IGF0IDA5OjM3OjQzQU0gKzAyMDAsIMWBdWthc3ogTWFqZXdza2kgd3JvdGU6Cj4g
Cj4+Pj4gVGhlIGxhc3QgY2FsbCBpcyBjaGFuZ2luZyB0aGUgYml0IGNsb2NrIChCQ0xLKSBmcmVx
dWVuY3kgdG8gU1NJJ3MgSVAKPj4+PiBibG9jayBjbG9jayAoaXBnID0gNjYgTUh6KSBbMV0uCj4+
Pgo+Pj4gSSB0aGluayBhIGJpZ2dlciBxdWVzdGlvbiBoZXJlIGlzIHdoeSB0aGUgcm91dGluZSBz
ZXRzIEJDTEsgdG8gNjZNSHouCj4+Cj4+IFllcywgZXhhY3RseS4KPj4KPj4gSW4gbXkgY2FzZSB0
aGUgYmNsayBpcyBzZXQgdG8gaXBnIGNsb2NrLCB3aGljaCBpcyB0aGUgU1NJIElQIGJsb2NrIGNs
b2NrCj4+IChpcGcpLgo+IAo+IENhbiB5b3UgZWxhYm9yYXRlIHdoeSB5b3Ugc2V0IGlwZyBjbG9j
ayBhcyBiY2xrPyBJIGRvbid0IHJlbWVtYmVyIFNTSSBjb3VsZAo+IGRlcml2ZSBiaXRjbG9jayBm
cm9tIGlwZyBjbG9jay4KCkp1c3QgdG8gYmUgY2xlYXI6CgpXaGF0IGNsb2NrIHNoYWxsIGJlIHNl
dCB3aXRoOgoKc3RydWN0IHNuZF9zb2NfZGFpX29wcyB7CgoJaW50ICgqc2V0X3N5c2Nsaykoc3Ry
dWN0IHNuZF9zb2NfZGFpICpkYWksCgkJaW50IGNsa19pZCwgdW5zaWduZWQgaW50IGZyZXEsIGlu
dCBkaXIpOwp9CgpjYWxsYmFjaz8KClRoZSBTU0kgSVAgYmxvY2sgb3IgQkNMSyA/CgoKPiAKPj4+
PiBUaGlzIGlzIHdyb25nLCBzaW5jZSBJTVggU1NJIGJsb2NrIHJlcXVpcmVzIHRoZSBJMlMgQkNM
SyB0byBiZSBsZXNzCj4+Pj4gdGhhbiAxLzUgb2YgWzFdLgo+Pj4+Cj4+Pj4gQXMgYSByZXN1bHQg
dGhlIGRyaXZlciBpbml0aWFsaXphdGlvbiBwYXNzZXMgd2l0aG91dCBhbnkgZXJyb3JzLCBidXQg
dGhlCj4+Pj4gc3BlYWtlci10ZXN0IHRlc3QgY2FzZSBicmVha3MuCj4+Pj4KPj4+PiBUaGlzIGNv
bW1pdCBjaGVja3MgaWYgdGhlIGZzbF9zc2lfc2V0X2RhaV9zeXNjbGsoKSBmcmVxdWVuY3kgcGFz
c2VkIGlzCj4+Pj4gbm90IGVxdWFsIHRvIFsxXS4KPj4+Cj4+PiBJIGRvbid0IGZlZWwgaXQncyBx
dWl0ZSBjb21wcmVoZW5zaXZlLi4ud2hhdCBpZiBpdCdzIGJlaW5nIHNldCB0byA2N01Iei4KPj4K
Pj4gSSB0aGluayB0aGF0IHRoaXMgY2xvY2sgaXMgbm90IGNoYW5naW5nIGZvciB0aGUgU29DLiBJ
dCBzaG91bGQgYmUgNjYgTUh6Cj4+IGZpeGVkLgo+IAo+IFdoYXQgSSBtZWFuIGlzIHRoYXQgd2Ug
Y2Fubm90IGp1c3QgbG9vayBhdCB0aGlzIFNvQy4gVG9kYXkgaXMgNjZNSHogZm9yIHRoaXMKPiBT
b0MuIFRvbW9ycm93IGNvdWxkIGJlIDEzM01IeiBmb3IgYW5vdGhlciBvbmUuIFdlIHNob3VsZCBw
dXQgYSBjaGVjayB0aGF0IG5vbmUKPiBvZiB0aGVzZSBzaGFsbCBwYXNzIC0tIHRoZSAxLzUgbGlt
aXQuCj4gCgpPay4gR29vZCBwb2ludC4KCgotLSAKQmVzdCByZWdhcmRzLAoKTHVrYXN6IE1hamV3
c2tpCgotLQoKREVOWCBTb2Z0d2FyZSBFbmdpbmVlcmluZyBHbWJILCAgICAgIE1hbmFnaW5nIERp
cmVjdG9yOiBXb2xmZ2FuZyBEZW5rCkhSQiAxNjUyMzUgTXVuaWNoLCBPZmZpY2U6IEtpcmNoZW5z
dHIuNSwgRC04MjE5NCBHcm9lYmVuemVsbCwgR2VybWFueQpQaG9uZTogKCs0OSktODE0Mi02Njk4
OS0xMCBGYXg6ICgrNDkpLTgxNDItNjY5ODktODAgRW1haWw6IHdkQGRlbnguZGUKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5n
IGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJv
amVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
