From: Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>
Subject: Re: How to select input from muxer in front of SSI on
	i.MX6
Date: Wed, 8 Oct 2014 17:24:49 +0200
Message-ID: <CAL8zT=gPh=pETH0fk7Jfz+n+-sRm_U1hEZv2FQAoSEkywjdVKw@mail.gmail.com>
References: <CAL8zT=iopOiRmo8vT5RNOowucDif-oY2skdrJu=vijiUqpHz-w@mail.gmail.com>
 <20140919175205.GB1736@Asurada> <20140923015134.GE27755@sirena.org.uk>
 <CAL8zT=ggs=fsBhEY=vXyH=6Bvy6iftV4JjxJ+YXuftk+xQ3Zdw@mail.gmail.com>
 <20140924082146.GV4015@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f41.google.com (mail-oi0-f41.google.com
 [209.85.218.41])
 by alsa0.perex.cz (Postfix) with ESMTP id C2C8726046A
 for <alsa-devel@alsa-project.org>; Wed,  8 Oct 2014 17:25:05 +0200 (CEST)
Received: by mail-oi0-f41.google.com with SMTP id u20so8044675oif.0
 for <alsa-devel@alsa-project.org>; Wed, 08 Oct 2014 08:25:04 -0700 (PDT)
In-Reply-To: <20140924082146.GV4015@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Michael Trimarchi <michael@amarulasolutions.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

SGkgTWFyaywKCjIwMTQtMDktMjQgMTA6MjEgR01UKzAyOjAwIE1hcmsgQnJvd24gPGJyb29uaWVA
a2VybmVsLm9yZz46Cj4gT24gVHVlLCBTZXAgMjMsIDIwMTQgYXQgMDg6MTE6MjdBTSArMDIwMCwg
SmVhbi1NaWNoZWwgSGF1dGJvaXMgd3JvdGU6Cj4+IExlIDIzIHNlcHQuIDIwMTQgMDM6NTEsICJN
YXJrIEJyb3duIiA8YnJvb25pZUBrZXJuZWwub3JnPiBhIMOpY3JpdCA6Cj4KPj4gPiBEZXBlbmRp
bmcgb24gd2hhdCB0aGUgc3lzdGVtIGxvb2tzIGxpa2UgaXQncyBub3QgYXQgYWxsIGNsZWFyIHRo
YXQgdGhlcmUKPj4gPiBzaG91bGQgYmUgYW55IHZpc2liaWxpdHkgYXQgYWxsIG9mIERQQ00gaW4g
dGhlIERUIC0gaXQncyBhIGRldGFpbCBvZiBob3cKPj4gPiBMaW51eCBpcyBpbXBsZW1lbnRlZCBh
dCB0aGUgZW5kIG9mIHRoZSBkYXkuCj4KPj4gU28gdGhpcyBzaG91bGQgZGVmaW5pdGVseSBiZSBp
bXBsZW1lbnRlZCBkaXJlY3RseSBpbiBhIHNwZWNpZmljIGRyaXZlciBmb3IKPj4gbXkgRlBHQSB3
aGljaCBpcyBhIERQQ00gcmlnaHQgPwo+Cj4gTm8sIHRoYXQncyByZWFsbHkgbm90IHdoYXQgRFBD
TSBpcyBhbGwgYWJvdXQuLi4gIGlmIHRoaXMgaXMgYSBwaHlzaWNhbGx5Cj4gc2VwYXJhdGUgZGV2
aWNlIHRoYXQncyBub3QgZ290IGRpcmVjdCBtZW1vcnkgYWNjZXNzIGl0J3MgcHJvYmFibHkgbW9y
ZQo+IGFwcHJvcHJpYXRlIHRvIHJlcHJlc2VudCBhcyBhIENPREVDLiAgSSB3YXMgQ0NlZCBpbiBw
YXJ0IHdheSBzbyBkb24ndAo+IGVudGlyZWx5IGtub3cuCgpPSywgc29ycnkgZm9yIG15IGxhdGUg
YW5zd2VyLCBidXQgSSB3YXMgb24gYSBsb3Qgb2YgdGhpbmdzIGF0IHRoZSBzYW1lIHRpbWUgOi8u
CldlbGwsIGhlcmUgaXMgYSB0ZW50YXRpdmUgdG8gZXhwbGFpbiB3aGF0IEkgd2FudCB0byBkbyA6
Cmh0dHA6Ly9wYXN0ZS5rZGUub3JnL3B3aWp6dHkycApUaGUgb2JqZWN0aXZlIGlzIHRvIGRldmVs
b3AgdGhlICJNdXggScKyUyIgcGFydCwgYXMgdGhpcyBpcyBpbiBmYWN0IGEKRlBHQSB3aXRoIEnC
skMgcmVnaXN0ZXJzIHdoaWNoIHRlbGwgd2hpY2ggaW5wdXQgc2hvdWxkIGdvIG9uIHdoaWNoCm91
dHB1dC4KCkkgYW0gcmVhZGluZyBBbHNhIGRvY3MsIGluIG9yZGVyIHRvIGZ1bGx5IHVuZGVyc3Rh
bmQgd2hhdCBzaG91bGQgYmUKZG9uZSwgYnV0IGl0IHNlZW1zIHRoYXQgdGhpcyBpcyBub3RoaW5n
IG1vcmUgdGhhbiBhIHNpbXBsZSBjb2RlYyB3aXRoCm5vIGVmZmVjdCBvbiBhdWRpbyBwYXJhbWV0
ZXJzLi4uIEl0IHNob3VsZCBiZSB2aXNpYmxlIGluIGFsc2EgbWl4ZXIKdGhvdWdoLCBpbiBvcmRl
ciB0byBkcml2ZSB0aGUgaW5wdXRzIGZyb20gdXNlciBzcGFjZSBlYXNpbHkuCgpJIGhvcGUgdGhp
cyBpcyBjbGVhcmVyLi4uClRoYW5rcyAhCkpNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxz
YS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlz
dGluZm8vYWxzYS1kZXZlbAo=
