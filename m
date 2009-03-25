From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH 1/2] ASoC: dapm - Add DAPM for
 always	active DAC or ADC
Date: Wed, 25 Mar 2009 17:34:57 +0900
Message-ID: <49C9ECB1.9030005@samsung.com>
References: <49C8D8B0.8030807@samsung.com>
	<20090324161510.GD5990@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 845E4103810
	for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2009 09:35:10 +0100 (CET)
Received: from epmmp2 (mailout1.samsung.com [203.254.224.24])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KH100GT1ZU98A@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Wed, 25 Mar 2009 17:34:57 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0KH100ETDZU9E7@mmp2.samsung.com> for
	alsa-devel@alsa-project.org; Wed, 25 Mar 2009 17:34:57 +0900 (KST)
In-reply-to: <20090324161510.GD5990@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, '?????????' <kyungmin.park@samsung.com>, ????????? <bhmin@samsung.com>
List-Id: alsa-devel@alsa-project.org

TWFyayBCcm93biDsk7Qg6riAOgo+IE9uIFR1ZSwgTWFyIDI0LCAyMDA5IGF0IDA5OjU3OjIwUE0g
KzA5MDAsIEpvb255b3VuZyBTaGltIHdyb3RlOgo+PiBUaGlzIHBhdGNoIHN1cHBvcnRzIERBUE0g
d2lkZ2V0IGZvciBhbHdheXMgYWN0aXZlIERBQyBvciBBREMgcmVnYXJkbGVzcwo+PiBvZiBzdHJl
YW0uIFRoaXMgd2lkZ2V0cyB3aWxsIGJlIHVzZWQgZm9yIHZvaWNlIGNhbGwgYXQgVFdMNDAzMCBj
b2RlYy4KPiAKPj4gVFdMNDAzMCBjb2RlYyB1c2UgdGhlIGRpZ2l0YWwgc2lnbmFsIGZvciB2b2lj
ZSBjYWxsLCBzbyBpdCBuZWVkcyBEQUMgYW5kCj4+IEFEQyB0byBjaGFuZ2Ugc2lnbmFsIHRvIGRp
Z2l0YWwgb3IgYW5hbG9nLCBob3dldmVyIGN1cnJlbnRseSBEQUMgYW5kIEFEQwo+PiB3aWRnZXRz
IGNhbm5vdCBzdXBwb3J0IHZvaWNlIGNhbGwgYmVjYXVzZSB0aGV5IGFyZSBhY3RpdmF0ZWQgb25s
eSB3aGVuCj4+IHBsYXliYWNrIG9yIGNhcHR1cmUgaXMgZXhlY3V0ZWQuCj4gCj4gV2hhdCdzIGFj
dHVhbGx5IG5lZWRlZCBoZXJlIGlzIHByb3BlciBwYXRoIG1hbmFnZW1lbnQgaW4gdGhlIGRpZ2l0
YWwKPiBkb21haW4uICBQb3dlcmluZyBjb21wb25lbnRzIG9uIGFsbCB0aGUgdGltZSBpcyBjbGVh
cmx5IHN1Ym9wdGltYWwgc2luY2UKPiBpdCBjb25zdW1lcyBwb3dlciB3aGVuIHRoZSBieXBhc3Mg
cGF0aHMgYXJlbid0IGluIHVzZSwgcG90ZW50aWFsbHkKPiBpbmNsdWRpbmcgcG93ZXIgZnJvbSBv
dGhlciBjb21wb25lbnRzIAoKQWN0aXZhdGluZyBhbHdheXMgREFDIG9yIEFEQyB3aWRnZXQgZG9l
c24ndCBtZWFuIHBvd2VyaW5nIGl0IG9uIGFsbCB0aGUKdGltZS4gVG8gcG93ZXIgb24gREFDIG9y
IEFEQyBhY3RpdmF0ZWQsIHdlIG5lZWQgb25lIG9yIG1vcmUgY29tcGxldGUgcGF0aApjb25uZWN0
aW5nIHdpdGggREFDIG9yIEFEQyBiZWNhdXNlIHRoZSBwb3dlciBvZiB3aWRnZXRzIGlzIGNvbnRy
b2xsZWQgYnkKREFQTSBhdXRvbWF0aWNhbGx5LiBJZiBjb21wbGV0ZSBwYXRoIGlzIG5vLCBEQUMg
b3IgQURDIHdpbGwgYmUgcG93ZXJlZCBvZmYKLCBzbyB3ZSBjYW4gY29udHJvbCB0aGUgcG93ZXIg
b2YgREFDIG9yIEFEQyB1c2luZyBjb250cm9scyBhdCB1c2VyIHNwYWNlLgoKPiAKPiBUaGlzIGlz
IHNvbWV0aGluZyB0aGF0J3MgcGxhbm5lZCBpbiBmb3IgdGhlIGNvcmUgKHRoZXJlIGFyZSBkZXZp
Y2VzIG91dAo+IHRoZXJlIHdpdGggbW9yZSBjb21wbGV4IGRpZ2l0YWwgcm91dGluZyBuZWVkcyB0
aGFuIGNhbiBiZSBzb2x2ZWQgd2l0aAo+IHRoaXMgc29ydCBvZiBjb25maWd1cmF0aW9uKSBidXQg
SSBjYW4ndCBnaXZlIHlvdSBhIHNwZWNpZmljIHNjaGVkdWxlIGZvcgo+IGl0Lgo+IAo+IFdoYXQg
SSdkIHN1Z2dlc3QgZG9pbmcgZm9yIG5vdyBpcyBwcm92aWRpbmcgYSBkaXJlY3QgYW5hbG9nIGxp
bmsgZnJvbQo+IHRoZSBBREMgaW5wdXQgdG8gdGhlIERBQyBvdXRwdXQgZm9yIERBUE0gYW5kIHRo
ZW4gaG9va2luZyBpbiB1c2luZwo+IGV2ZW50cyBvbiB0aGUgd2lkZ2V0cyB0byBtYW5hZ2UgdGhl
IHBvd2VyIG9mIHRoZSBEQUMgYW5kIEFEQyBtYW51YWxseS4KClRoYW5rcywgYnV0IGkgdGhpbmsg
aG9va2luZyBpbiB1c2luZyBldmVudHMgb24gdGhlIHdpZGdldHMgaXMgaW1wb3NzaWJsZQpiZWNh
dXNlIHZvaWNlIGNhbGwgaXMgZGlmZmVyZW50IG9wZXJhdGlvbiB3aXRoIHJlY29yZCBvciBwbGF5
YmFjay4KCj4gV2hlbiB0aGUgY29yZSBnYWlucyBzdXBwb3J0IGZvciBkaWdpdGFsIHJvdXRpbmcg
dGhpcyBjYW4gYmUgcmVwbGFjZWQuCj4gQWx0ZXJuYXRpdmVseSwgaWYgdGhlcmUgaXMgbm8gaW50
ZWdyYXRpb24gd2l0aCByZWNvcmQgb3IgcGxheWJhY2sKPiByZXF1aXJlZCB0aGVuIHRoZXJlJ3Mg
bm8gcmVhc29uIHRvIHJlcHJlc2VudCB0aGVtIGFzIERBQ3MgYW5kIEFEQ3MsIHRoZXkKPiBjb3Vs
ZCBiZSBkb25lIGFzIHNvbWUgb3RoZXIgcGF0aCBlbGVtZW50IHRoYXQgREFQTSBkb2VzIGtub3cg
YWJvdXQuCgpIbW0sIEkgdGhpbmsgYWRkaXRpb25hbCBzdXBwb3J0IG5lZWRzIGZvciB2b2ljZSBj
YWxsIG9wZXJhdGlvbiBhdCBBU29DLCBzbwppIHN1Z2dlc3RlZCBhIHdheSBvZiB0aGlzIHBhdGNo
LgoKPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFs
c2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8v
bWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
