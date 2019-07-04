From: Keyon Jie <yang.jie@linux.intel.com>
Subject: Re: [PATCH v2 1/2] ASoC: SOF: add flag for position
 update ipc
Date: Thu, 4 Jul 2019 18:29:20 +0800
Message-ID: <3788800e-7050-d68a-bec6-5b443fd0d563@linux.intel.com>
References: <20190703151023.30313-1-yang.jie@linux.intel.com>
 <alpine.DEB.2.21.1907041254100.4409@eliteleevi>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7D3EFF800E7
 for <alsa-devel@alsa-project.org>; Thu,  4 Jul 2019 12:24:00 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.21.1907041254100.4409@eliteleevi>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc: alsa-devel@alsa-project.org, ranjani.sridharan@linux.intel.com, Marcin Rajwa <marcin.rajwa@linux.intel.com>, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

CgpPbiAyMDE5LzcvNCDkuIvljYg2OjAzLCBLYWkgVmVobWFuZW4gd3JvdGU6Cj4gSGksCj4gCj4g
cGF0Y2ggbG9va3MgZ29vZCwgYnV0IGNvbW1pdCBtZXNzYWdlIGNvdWxkIGJlIGltcHJvdmVkLgo+
IAo+IE9uIFdlZCwgMyBKdWwgMjAxOSwgS2V5b24gSmllIHdyb3RlOgo+IAo+PiBJbiBzb21lIGNh
c2VzLCBGVyBtaWdodCBuZWVkIHVzZSB0aGUgaG9zdF9wZXJpb2RfYnl0ZXMgZXZlbiBubyBwb3Np
dGlvbgo+PiB1cGRhdGUgaXBjIHJlcWl1cmVkIGZyb20gZHJpdmVyLCBoZXJlIGFkZCBhbm90aGVy
IGZsYWcgZm9yIHBvc2l0aW9uIHVwZGF0ZSwKPj4gYW5kIHByZXNlcnZlIGhvc3RfcGVyaW9kX2J5
dGVzIGZvciBGVyB0byB1c2UuCj4gCj4gU3BlY3VsYXRpb24gb24gd2hhdCBGVyBtaWdodCBkbyBp
cyBub3QgcmVhbGx5IG5lZWRlZC4gVGhlCj4gaG9zdF9wZXJpb2RfYnl0ZXMgZmllbGQgaGFzIGJl
ZW4gb3ZlcmxvYWRlZCB3aXRoIG11bHRpcGxlCj4gc2VtYW50aWNzIGFuZCB0aGlzIHBhdGNoIGNs
ZWFycyB0aGF0LCByaWdodC4gSG93IGFib3V0OgoKV2VsbCwgdG8gbWUgaXQgaXMgZmxhdm9yIGNo
b2ljZSwgUmFuamFuaSBzdWdnZXN0ZWQgdG8gaWxsdXN0cmF0ZSB0aGUgdXNlIApjYXNlIHdoZXJl
IHRoZSBGVyB3aWxsIHVzZSB0aGlzIGhvc3RfcGVyaW9kX2J5dGVzLCBhbmQgSSBhZ3JlZWQgdGhp
cyAKd2lsbCBoZWxwIHBlb3BsZSB0byB1bmRlcnN0YW5kIHdoeSB3ZSBuZWVkIHRoaXMgY2hhbmdl
LgoKPiAKPiAiIgo+IFJlbW92ZSB0aGUgc3BlY2lhbCBjYXNlIHNlbWFudGljcyBvZiAnaG9zdF9w
ZXJpb2RfYnl0ZXM9PTAnLgo+IEFkZCBhIG5ldyBmaWVsZCAnbm9fcGVyaW9kX2lycScgdG8gc2ln
bmFsIHdoZXRoZXIgcGVyaW9kIGVsYXBzZWQKPiBJUEMgc2hvdWxkIGJlIHNlbnQgYW5kIHVzZSAn
aG9zdF9wZXJpb2RfYnl0ZXMnIG9ubHkgZm9yCj4gcGVyaW9kIHNpemUuCj4gIiIKPiAKPj4gVGhp
cyBtaWdodCByZXF1aXJlIGNvcnJlc3BvbmRpbmcgRlcgY2hhbmdlIGFuZCBBQkkgYWxpZ25tZW50
Lgo+IAo+IFRoaXMgaXMgbm90IGhlbHBmdWwgLS0gd2Uga25vdyB0aGlzIF9pc18gYSBtaW5vciBB
QkkgY2hhbmdlCj4gYW5kIG5lZWRzIHRvIGJlIGFsaWduZWQgd2l0aCBGVy4KCkl0IGlzIG1pbm9y
IGNoYW5nZSwgYnV0IHRoZSBGVyBjaGFuZ2UgaXMgc3RpbGwgcmVxdWlyZWQsIG90aGVyd2lzZSwg
d2UgCndpbGwgZ2V0IGV4dHJhIHBvc2l0aW9uIHVwZGF0ZSBJUENzIHdoaWNoIG1heSBjb25mdXNl
IHRoZSBkcml2ZXIsIHBsZWFzZSAKcmVmZXIgdG8gaGVyZToKaHR0cHM6Ly9naXRodWIuY29tL3Ro
ZXNvZnByb2plY3Qvc29mL3B1bGwvMTU5MgoKVGhhbmtzLAp+S2V5b24KCj4gCj4gQnIsIEthaQo+
IAo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gQWxz
YS1kZXZlbCBtYWlsaW5nIGxpc3QKPiBBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKPiBodHRw
czovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
PiAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1k
ZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHBzOi8vbWFp
bG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
