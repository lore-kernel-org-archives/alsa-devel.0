From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [pulseaudio-discuss] [PATCH v0 07/20] Consider
 unknown availability in module-switch-on-port-available
Date: Wed, 22 Aug 2012 14:08:21 +0200
Message-ID: <5034CBB5.7090300@canonical.com>
References: <1345622913-16470-1-git-send-email-mikel.astiz.oss@gmail.com>
 <1345622913-16470-8-git-send-email-mikel.astiz.oss@gmail.com>
 <5034A2B6.5080905@canonical.com>
 <CAN8cciYOFdiFD5oHAo=5DnGOTWfGbmgUhMB71Xy+UidnV7FOng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id A25F22663D8
 for <alsa-devel@alsa-project.org>; Wed, 22 Aug 2012 14:08:20 +0200 (CEST)
In-Reply-To: <CAN8cciYOFdiFD5oHAo=5DnGOTWfGbmgUhMB71Xy+UidnV7FOng@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>
Cc: Raymond Yau <superquad.vortex2@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

T24gMDgvMjIvMjAxMiAwMjowMCBQTSwgUmF5bW9uZCBZYXUgd3JvdGU6Cj4KPiAyMDEyLTgtMjIg
5LiL5Y2INToxMyDmlrwgIkRhdmlkIEhlbm5pbmdzc29uIgo+IDxkYXZpZC5oZW5uaW5nc3NvbkBj
YW5vbmljYWwuY29tCj4gPG1haWx0bzpkYXZpZC5oZW5uaW5nc3NvbkBjYW5vbmljYWwuY29tPj4g
5a+r6YGT77yaCj4gID4gQXNzdW1lIHdlIHBsdWcgaW4gSERNSS4gV2l0aCB0aGlzIHBhdGNoIHdl
IHdpbGwgZ2V0IGluY29uc2lzdGVudAo+IGJlaGF2aW91cjogaWYgaGVhZHBob25lcyBhcmUgcGx1
Z2dlZCBpbiAoYXZhaWxhYmxlID0geWVzKSwgd2Ugd29uJ3QKPiBzd2l0Y2ggdG8gSERNSSwgYnV0
IGlmIG5vdCAoc3BlYWtlcnMgYXJlIGF2YWlsYWJsZSA9IHVua25vd24pLCB3ZSB3aWxsCj4gc3dp
dGNoIHRvIEhETUkuCj4gID4KPiAgPgo+Cj4gaWYgeW91IGxvb2sgYXQgdGhvc2UgYnVnIHJlcG9y
dHMgb2Ygbm8gc291bmQgZm9yIHRob3NlIG9uLWJvYXJkIGFjOTcKPiBjb2RlY3Mgd2l0aCB1YnVu
dHUgMTIuMDQKPgo+IGh0dHBzOi8vYnVncy5sYXVuY2hwYWQubmV0L3VidW50dS8rc291cmNlL2Fs
c2EtZHJpdmVyLytidWcvMTAzMzk5Ngo+Cj4gaG93IGRvZXMgcHVsc2VhdWRpbyBkZXRlcm1pbmUg
d2hpY2ggY29udHJvbHMgYXJlIGVmZmVjdGl2ZSBpbiB0aGUKPiBoZWFkcGhvbmUgcGF0aCBhbmQg
c3BlYWtlciBwYXRoIG9mIHRob3NlIGFjOTcgIGNvZGVjcyA/CgpQbGVhc2UgZG8gbm90IGhpamFj
ayB0aHJlYWRzIHRvIGRpc2N1c3Mgc29tZXRoaW5nIGRpZmZlcmVudC4gSWYgeW91IGhhdmUgCmFu
IHVucmVsYXRlZCBxdWVzdGlvbiBzdWNoIGFzIHRoaXMsIHN0YXJ0IGEgbmV3IHRocmVhZCBpbnN0
ZWFkLgoKVGhhbmtzLgoKCi0tIApEYXZpZCBIZW5uaW5nc3NvbiwgQ2Fub25pY2FsIEx0ZC4KaHR0
cHM6Ly9sYXVuY2hwYWQubmV0L35kaXdpYwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2Et
cHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2Fsc2EtZGV2ZWwK
