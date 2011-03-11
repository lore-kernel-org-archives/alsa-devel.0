From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: PROBLEM: Asoc driver in 2.6.37.3 for AT91SAM9260 /
 TLV320AIC3X is broken
Date: Fri, 11 Mar 2011 17:05:16 +0200
Message-ID: <20110311170516.f2e923fb.jhnikula@gmail.com>
References: <4D79E428.2060408@aksignal.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 9118B24500
	for <alsa-devel@alsa-project.org>; Fri, 11 Mar 2011 16:03:56 +0100 (CET)
Received: by fxm6 with SMTP id 6so1049486fxm.38
	for <alsa-devel@alsa-project.org>; Fri, 11 Mar 2011 07:03:55 -0800 (PST)
In-Reply-To: <4D79E428.2060408@aksignal.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Prchal =?UTF-8?B?SmnFmcOt?= <jiri.prchal@aksignal.cz>
Cc: sedji.gaouaou@atmel.com, slapin@ossfans.org, broonie@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

T24gRnJpLCAxMSBNYXIgMjAxMSAwOTo1ODoxNiArMDEwMApQcmNoYWwgSmnFmcOtIDxqaXJpLnBy
Y2hhbEBha3NpZ25hbC5jej4gd3JvdGU6Cgo+IFNvIEkgY2hhbmdlIGZpbGUgc25kLXNvYy1hZmVi
OTI2MC5jLCBkaWZmIGlzIGF0dGFjaGVkLCBhbmQgS2NvbmZpZyBhbmQgTWFrZWZpbGUgdG9vLgo+
IEluIHZlcnNpb24gMi42LjM1LjExIGl0IHdvcmtzIGdvb2QsIGJ1dCBNTUMvU0QgY2FyZCBkb2Vz
bid0IHdvcmsuIChTb21ldGhpbmcgaXMgYnJva2VuIGl0IHRoYXQgZHJpdmVyIGp1c3QgaW4gdGhp
cwo+IHZlcnNpb24pLiBJIG5lZWQgdG8gd29yayBzb3VuZCBhbmQgU0QgY2FyZC4KPiBJIHRoaW5n
IHRoZSBwcm9ibGVtIGlzIHNvbWV3aGVyZSBiZXR3ZWVuICJ0bHYzMjBhaWMzeC1jb2RlYyAwLTAw
MWE6IHByb2JlIiBhbmQgImkyYy1jb3JlOiBkcml2ZXIgW3RsdjMyMGFpYzN4LWNvZGVjXQo+IHJl
Z2lzdGVyZWQiLiBJbiB2ZXJzaW9uIDIuNi4zNS4xMSB0aGVyZSBpcyBJMkMgY29tbXVuaWNhdGlv
biwgaW4gMi42LjM3IGFuZCBoaWdoZXIgbm90aGluZyBvbiBJMkMuCj4gSSBhbHNvIHRyeSB0byBw
dXQgbmV3ZXIgYWxzYSAxLjAuMjQgdG8ga2VybmVsIDIuNi4zNy4zIHdpdGhvdXQgYW55IGltcHJv
dmVtZW50LgoKSnVzdCB0byBtYWtlIHN1cmUsIGhhdmUgeW91IGFkZGVkIEkyQ19CT0FSRF9JTkZP
KCJ0bHYzMjBhaWMzeCIsIDB4MWEpCnRvIGFmZWI5MjYwX2kyY19kZXZpY2VzW10gaW4gYXJjaC9h
cm0vbWFjaC1hdDkxL2JvYXJkLWFmZWItOTI2MHYxLmM/Cgo+IFRyeWluZyB0byBwdXQgb2xkZXIg
YWxzYSAoYnV0IHNhbWUgdmVyc2lvbj8pIGZyb20ga2VybmVsIDIuNi4zNS4xMSB0byAyLjYuMzcu
MyBwcm9kdWNlIHNvdW5kY2FyZCwgYnV0IHdoZW4gdHJ5IHRvIHBsYXkKPiBrZXJuZWwgb29wcywg
ImNhbm5vdCBkZXJlZmVyZW5jZSBudWxsIHBvaW50ZXIiIGFuZCBmcmVlemVzLgo+IAo+IEkgdHJ5
IG1hbnkgdmVyc2lvbnMgb2YKPiAvKiBEaWdpdGFsIGF1ZGlvIGludGVyZmFjZSBnbHVlIC0gY29u
bmVjdHMgY29kZWMgPC0tPiBDUFUgKi8KPiBzdGF0aWMgc3RydWN0IHNuZF9zb2NfZGFpX2xpbmsg
YWZlYjkyNjBfZGFpID0gewo+IAkubmFtZSA9ICJUTFYzMjBBSUMzWCIsIC8vQUlDM1gKPiAJLnN0
cmVhbV9uYW1lID0gIkFJQzNYIiwKPiAJLmNwdV9kYWlfbmFtZSA9ICJhdG1lbC1zc2MtZGFpLjAi
LCAvL2F0bWVsLXNzYy1kYWkKPiAJLmNvZGVjX2RhaV9uYW1lID0gInRsdjMyMGFpYzN4LWhpZmki
LCAvL2FpYzN4LCBhaWMzeC1oaWZpLCB0bHYzMjBhaWMzeAo+IAkucGxhdGZvcm1fbmFtZSA9ICJh
dG1lbC1wY20tYXVkaW8iLCAvL2F0bWVsX3BjbS1hdWRpbwo+IAkuY29kZWNfbmFtZSA9ICJ0bHYz
MjBhaWMzeC1jb2RlYy4wLTAwMWEiLCAvL3RsdjMyMGFpYzN4LWNvZGVjLjAtMHgxYQo+IAkuaW5p
dCA9IGFmZWI5MjYwX2FpYzN4X2luaXQsCj4gCS5vcHMgPSAmYWZlYjkyNjBfb3BzLAo+IH07Cgpj
b2RlY19uYW1lIGFuZCBjb2RlY19kYWlfbmFtZSBsb29rIG9rIGhlcmUuCgotLSAKSmFya2tvCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwg
bWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5h
bHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
