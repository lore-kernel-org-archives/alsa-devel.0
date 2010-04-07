From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: User-space control elements in ext PCM plugin
Date: Wed, 07 Apr 2010 12:32:59 +0100
Message-ID: <hphqhb$839$1@dough.gmane.org>
References: <20100407100104.41190@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 39DB01038B6
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Apr 2010 13:33:14 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1NzTVO-0006Qw-NT
	for alsa-devel@alsa-project.org; Wed, 07 Apr 2010 13:33:10 +0200
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 07 Apr 2010 13:33:10 +0200
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 07 Apr 2010 13:33:10 +0200
In-Reply-To: <20100407100104.41190@gmx.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

J1R3YXMgYnJpbGxpZywgYW5kIE1hcmN1cyBXZWlnZWx0IGF0IDA3LzA0LzEwIDExOjAxIGRpZCBn
eXJlIGFuZCBnaW1ibGU6Cj4gSGksCj4gCj4gScK0bSBoYXZpbmcgYW4gZXh0ZXJuYWwgUENNIHBs
dWdpbiB0aGF0IHNob3VsZCBkbyBzb21lIHByb2Nlc3Npbmcgb24KPiB0aGUgYXVkaW8uIFRoYXQg
cGFydCB3b3JrcyBmaW5lLiBOb3cgScK0ZCBsaWtlIHRvIGhhdmUgc29tZSB3YXkgdG8KPiBtb2Rp
ZnkgdGhlIHdheSB0byBnaXZlIHNvbWUgcGFyYW1ldGVycyB0byB0aGUgcGx1Z2luIHRvIHRlbGwg
aXQgaG93Cj4gdGhlIHByb2Nlc3NpbmcgaXMgZG9uZSAoZWcuIHNldCBkZWxheSB0aW1lLCBwYW4s
IGF0dGFjayB0aW1lLCAuLi4pLiAKPiBJwrR2ZSBzZWFyY2hlZCB0aGUgd2ViIGZvciBkYXlzIGFu
ZCBob3VycywgYnV0IGNvdWxkIG5vdCByZWFsbHkgZmluZAo+IHNvbWV0aGluZy4gT24gdGhlIGFs
c2EgbWFpbGluZyBsaXN0IHRoZXJlIHdhcyBhIHNpbWlsaWFyIHF1ZXN0aW9uCj4gdGhyZWUgeWVh
cnMgYWdvLCBhbmQgdGhlIGFuc3dlciB3YXMsIHRoYXQgb25lIGNvdWxkIGNyZWF0ZSB1c2VyLXNw
YWNlCj4gY29udHJvbCBlbGVtZW50cyBpbiB0aGUgcGx1Z2luLiBIb3cgaXMgdGhhdCBkb25lPyBJ
IGNvdWxkIG5vdCBmaW5kCj4gZXhhbXBsZXMgb3IgZ29vZCBkb2N1bWVudGF0aW9uIGFib3V0IGl0
LiBEaWQgSSBtaXNzIHNvbWV0aGluZyBvdXQ/Cj4gQ2FuIGFueW9uZSBnaXZlIG1lIGEgaGludCwg
bWF5YmUgYSBsaW5rIHRvIHNvbWUgZG9jcyBhYm91dCBpdCBvcgo+IHNvdXJjZSBvZiBhIFBDTSBw
bHVnaW4gY3JlYXRpbmcvdXNpbmcgdXNlciBzcGFjZSBjb250cm9sIGVsZW1lbnRzPwo+IFRoYW5r
cyBhIGxvdC4KClRyeSBsb29raW5nIGF0IHRoZSBQdWxzZUF1ZGlvIHBsdWdpbi4gSXQgcHJlc2Vu
dHMgdXNlcnNwYWNlIHNsaWRlcnMgdG8KY29udHJvbCB0aGUgdm9sdW1lLiBJZiBJJ3ZlIG5vdCBt
aXN1bmRlcnN0b29kIHlvdXIgcmVxdWVzdCB0aGlzIHNob3VsZApkbyB3aGF0IHlvdSBuZWVkLgoK
Q29sCgotLSAKCkNvbGluIEd1dGhyaWUKZ21hbmUoYXQpY29saW4uZ3V0aHIuaWUKaHR0cDovL2Nv
bGluLmd1dGhyLmllLwoKRGF5IEpvYjoKICBUcmliYWxvZ2ljIExpbWl0ZWQgW2h0dHA6Ly93d3cu
dHJpYmFsb2dpYy5uZXQvXQpPcGVuIFNvdXJjZToKICBNYW5kcml2YSBMaW51eCBDb250cmlidXRv
ciBbaHR0cDovL3d3dy5tYW5kcml2YS5jb20vXQogIFB1bHNlQXVkaW8gSGFja2VyIFtodHRwOi8v
d3d3LnB1bHNlYXVkaW8ub3JnL10KICBUcmFjIEhhY2tlciBbaHR0cDovL3RyYWMuZWRnZXdhbGwu
b3JnL10KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFs
c2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8v
bWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
