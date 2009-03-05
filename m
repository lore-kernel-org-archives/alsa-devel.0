From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH] ASoC: make ops a pointer in 'struct
	snd_soc_dai'
Date: Thu, 5 Mar 2009 10:03:18 +0800
Message-ID: <f17812d70903041803s4c95dfebjf38079cce34b10ca@mail.gmail.com>
References: <f17812d70903011925w2a201e27m39fa001d4c700d45@mail.gmail.com>
	<ed82fe3e0903020439u497389ccp7ec35c7de37ad936@mail.gmail.com>
	<f17812d70903020646q15d43dcch8ad90df2cb486499@mail.gmail.com>
	<49AC225D.6090002@freescale.com>
	<f17812d70903021740w5c0c5dfck5a92869650bf5bd7@mail.gmail.com>
	<49AEF38A.6050802@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.244])
	by alsa0.perex.cz (Postfix) with ESMTP id 3D77D1037EB
	for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2009 03:03:19 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id c5so3226273rvf.32
	for <alsa-devel@alsa-project.org>; Wed, 04 Mar 2009 18:03:19 -0800 (PST)
In-Reply-To: <49AEF38A.6050802@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>, Liam Girdwood <lrg@kernel.org>
List-Id: alsa-devel@alsa-project.org

T24gVGh1LCBNYXIgNSwgMjAwOSBhdCA1OjMyIEFNLCBUaW11ciBUYWJpIDx0aW11ckBmcmVlc2Nh
bGUuY29tPiB3cm90ZToKPiBFcmljIE1pYW8gd3JvdGU6Cj4KPj4gVXBkYXRlZCBhcyBiZWxvdywg
KGd6aXAgdmVyc2lvbiBhdHRhY2hlZCBkdWUgdG8gbWFpbGluZyBsaXN0Cj4+IG1haWwgc2l6ZSBs
aW1pdGF0aW9uKS4KPj4KPj4gRnJvbSA3NGEyYjZkZmZmMjk0OGQ5ZDA0YjMzZDBhMDJmNjQ1Zjhj
MTJjYWY3IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQo+PiBGcm9tOiBFcmljIE1pYW8gPGVyaWMu
bWlhb0BtYXJ2ZWxsLmNvbT4KPj4gRGF0ZTogTW9uLCAyIE1hciAyMDA5IDIyOjM4OjMxICswODAw
Cj4+IFN1YmplY3Q6IFtQQVRDSF0gQVNvQzogbWFrZSBvcHMgYSBwb2ludGVyIG9mICdzdHJ1Y3Qg
c25kX3NvY19kYWknCj4+Cj4+IENvbnNpZGVyaW5nIHRoZSBmYWN0IHRoYXQgbW9zdCBjcHVfZGFp
IG9yIGNvZGVjX2RhaSBhcmUgdXNpbmcgYSBzYW1lCj4+ICdzbmRfc29jX2RhaV9vcHMnIGZvciBz
ZXZlcmFsIHNpbWlsYXIgaW50ZXJmYWNlcywgJ29wcycgd291bGQgYmUgYmV0dGVyCj4+IG1hZGUg
YSBwb2ludGVyIGluc3RlYWQsIHRvIG1ha2Ugc2hhcmluZyBlYXNpZXIgYW5kIGNvZGUgYSBiaXQg
Y2xlYW5lci4KPj4KPj4gVGhlIHBhdGNoIGJlbG93IGlzIHJhdGhlciBwcmVsaW1pbmFyeSBzaW5j
ZSB0aGUgYXNvYyB0cmVlIGlzIGJlaW5nCj4+IGFjdGl2ZWx5IGRldmVsb3BlZCwgYW5kIHRoaXMg
dG91Y2hlcyBhbG1vc3QgZXZlcnkgcGllY2Ugb2YgY29kZSwKPj4gKGFuZCBwb3NzaWJseSBtYW55
IG90aGVycyBpbiBkZXZlbG9wbWVudCBuZWVkIHRvIGJlIGNoYW5nZWQgYXMKPj4gd2VsbCkuIEJ1
aWxkaW5nIG9mIGFsbCBjb2RlY3MgYXJlIE9LLCB5ZXQgdG8gZXZlcnkgU29DLCBJIGRpZG4ndCB0
ZXN0Cj4+IHRoYXQuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEVyaWMgTWlhbyA8ZXJpYy5taWFvQG1h
cnZlbGwuY29tPgo+Cj4gVGVzdGVkIG9uIGFuIE1QQzg2MTAgSFBDRCwgYW5kIGl0IHdvcmtzLiDC
oFRoYXQncyBhbGwgSSBjYW4gdm91Y2ggZm9yLAo+IHRob3VnaC4KPgo+IEFja2VkLWJ5OiBUaW11
ciBUYWJpIDx0aW11ckBmcmVlc2NhbGUuY29tPgo+CgpUaGFua3MuCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFs
c2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3Jn
L21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
