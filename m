From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [Device-drivers-devel] [PATCH 2/3] ASoC: Blackfin:
 Add bf5xx-adau1701 machine driver
Date: Fri, 10 Jun 2011 14:20:36 -0400
Message-ID: <BANLkTi=Hh7etBGCpfvhHc-76tgsyu3WSmQ@mail.gmail.com>
References: <1307726331-28618-1-git-send-email-lars@metafoo.de>
	<1307726331-28618-2-git-send-email-lars@metafoo.de>
	<20110610173004.GJ26441@sirena.org.uk>
	<4DF25959.9060603@metafoo.de>
	<20110610180256.GQ26436@opensource.wolfsonmicro.com>
	<4DF25EAF.7050203@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 825C0103D4F
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Jun 2011 20:20:59 +0200 (CEST)
Received: by fxm5 with SMTP id 5so1943175fxm.38
	for <alsa-devel@alsa-project.org>; Fri, 10 Jun 2011 11:20:56 -0700 (PDT)
In-Reply-To: <4DF25EAF.7050203@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, uclinux-dist-devel@blackfin.uclinux.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

T24gRnJpLCBKdW4gMTAsIDIwMTEgYXQgMTQ6MTMsIExhcnMtUGV0ZXIgQ2xhdXNlbiB3cm90ZToK
PiBPbiAwNi8xMC8yMDExIDA4OjAyIFBNLCBNYXJrIEJyb3duIHdyb3RlOgo+PiBPbiBGcmksIEp1
biAxMCwgMjAxMSBhdCAwNzo1MDoxN1BNICswMjAwLCBMYXJzLVBldGVyIENsYXVzZW4gd3JvdGU6
Cj4+PiBPbiAwNi8xMC8yMDExIDA3OjMwIFBNLCBNYXJrIEJyb3duIHdyb3RlOgo+Pj4+IFNvLCBJ
IGtlZXAgb24gY29tcGxhaW5pbmcgYWJvdXQgdGhlIHdheSB0aGVzZSBkcml2ZXJzIGFyZSBqdXN0
IGdlbmVyaWMKPj4+PiB0byBhbnkgcmFuZG9tIEJsYWNrZmluIHBsdXMgQ09ERUMgY29tYmluYXRp
b24gcmF0aGVyIHRoYW4gYmVpbmcgYm9hcmQKPj4+PiBzcGVjaWZpYy4gwqBJdCdkIGJlIGdvb2Qg
aWYgd2UgY291bGQgaW1wcm92ZSB0aGlzLCBldmVuIGFkZGluZyBzb21ldGhpbmcKPj4+PiBpbnRv
IHRoZSBkcml2ZXIgbmFtZSB0byBtYWtlIGl0IGNsZWFyIHRoZXNlIGFyZSBmb3IgdGhlIEVWQiB3
b3VsZCBoZWxwLgo+Pgo+Pj4gSSB0aGluayB0aGlzIGlzIGR1ZSwgdGhhdCB0aGUgY29kZWNzIHRo
ZW0tc2VsZiBzaXQgb24gYW4gYWRkLW9uIGJvYXJkIHRvIHRoZQo+Pj4gYmY1eHggZXZhbCBib2Fy
ZHMuCj4+PiBTbyB5b3UgaGF2ZSB0d28gYm9hcmRzLCB0aGUgYmY1eHggZXZhbCBib2FyZCB3aXRo
IGhhcyB0aGUgY29kZWMgZXZhbCBib2FyZAo+Pj4gY29ubmVjdGVkIHRvIGl0LiBUaGF0J3Mgd2h5
IGl0IGl0IGlzIGtlcHQgc28gZ2VuZXJpYy4gWW91IGNvdWxkIGNvbm5lY3QgdGhlCj4+PiBjb2Rl
YyBldmFsIGJvYXJkIHRvIGFueSBvZiB0aGUgYmY1eHggYm9hcmRzLgo+Pgo+PiBJJ2QgYmUgbW9y
ZSBoYXBweSB3aXRoIHRoYXQgaWYgdGhlcmUgd2VyZSBzb21lIGluZGljYXRpb24gaW4gdGhlIGNv
ZGUKPj4gdGhhdCB0aGlzIHdhcyBmb3IgdGhlIHN0YW5kYXJkIEJsYWNrZmluIEVWQnMgcmF0aGVy
IHRoYW4gYWxsIHN5c3RlbXMKPj4gYmFzZWQgb24gQmxhY2tmaW4uCj4KPiBJIGNvdWxkIHJlbmFt
ZSB0aGUgbWFjaGluZSBkcml2ZXIgdG8gYmY1eHgtYWRhdTE3MDEtZXZiIGZvciB2Mi4KCmknZCBs
aWtlIHRvIGdldCBhd2F5IGZyb20gImJmNXh4IiBhY3R1YWxseSBhbmQgc3RhcnQgdXNpbmcgImJm
aW4iLgppdmUgc3RhcnRlZCBkb2luZyB0aGlzIGluIHNvbWUgb2YgdGhlIGZpbGVzLCBzbyBsZXQn
cyBub3QgYWRkIG1vcmUuCgphbHNvLCBpZiB3ZSBkbyBkZWNpZGUgdG8gYWRkIG1vcmUgdG8gdGhl
IG5hbWUsIGl0IHNob3VsZCBiZSBjbG9zZXIgdG8Kd2hhdCBBREkgY2FsbHMgdGhlIGFjdHVhbCBw
cm9kdWN0LCBzbyBwcm9iYWJseSAiYmZpbi1ldmFsLWFkYXUxNzAxIi4KYWx0aG91Z2gsIG9uY2Ug
d2UgcHVzaCB0aGUgU1BPUlQgIyBhbmQgSTJDIGFkZHJlc3MgdG8gcGxhdGZvcm0KcmVzb3VyY2Vz
LCB0aGlzIHNob3VsZCB3b3JrIGZvciBtb3JlIHRoYW4ganVzdCB0aGUgZXZhbC4gIGl0J2QgZmFs
bAppbnRvIG91ciAiYmFzaWMgYmxhY2tmaW4iIGNhdGVnb3J5LCBzbyB3ZSdkIG9ubHkgdHdlYWsg
dGhlIEtjb25maWcKZGVzYy9oZWxwIHRleHQuCi1taWtlCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2
ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxt
YW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
