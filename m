From: jassi brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 5/7] S3C AUDIO: Add header to pass platform
	data to device drivers.
Date: Sat, 7 Nov 2009 12:31:43 +0900
Message-ID: <1b68c6790911061931h59ef299ftb7422421225fd4d0@mail.gmail.com>
References: <1257384900-18308-1-git-send-email-jassi.brar@samsung.com>
	<20091106165214.GF4938@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f185.google.com (mail-px0-f185.google.com
	[209.85.216.185])
	by alsa0.perex.cz (Postfix) with ESMTP id 5F97D245F0
	for <alsa-devel@alsa-project.org>; Sat,  7 Nov 2009 04:31:44 +0100 (CET)
Received: by pxi15 with SMTP id 15so1117791pxi.23
	for <alsa-devel@alsa-project.org>; Fri, 06 Nov 2009 19:31:43 -0800 (PST)
In-Reply-To: <20091106165214.GF4938@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, ben-linux@fluff.org, Jassi Brar <jassi.brar@samsung.com>
List-Id: alsa-devel@alsa-project.org

T24gU2F0LCBOb3YgNywgMjAwOSBhdCAxOjUyIEFNLCBNYXJrIEJyb3duCjxicm9vbmllQG9wZW5z
b3VyY2Uud29sZnNvbm1pY3JvLmNvbT4gd3JvdGU6Cj4gT24gVGh1LCBOb3YgMDUsIDIwMDkgYXQg
MTA6MzU6MDBBTSArMDkwMCwgSmFzc2kgQnJhciB3cm90ZToKPgo+PiArLyoqCj4+ICsgKiBzdHJ1
Y3QgczNjX2F1ZGlvX3BkYXRhIC0gY29tbW9uIHBsYXRmb3JtIGRhdGEgZm9yIGF1ZGlvIGRldmlj
ZSBkcml2ZXJzCj4+ICsgKiBAcGRhdGE6IFBvaW50ZXIgdG8gcHJvdG9jb2woSTJTLCBQQ00gb3Ig
QUM5Nykgc3BlY2lmaWMgcGxhdGZvcm0gZGF0YQo+PiArICogQGNmZ19ncGlvOiBDYWxsYmFjayBm
dW5jdGlvbiB0byBzZXR1cCBtdXgnZWQgcGlucyBpbiBJMlMvUENNL0FDOTcgbW9kZQo+PiArICov
Cj4+ICtzdHJ1Y3QgczNjX2F1ZGlvX3BkYXRhIHsKPj4gKyDCoCDCoCB2b2lkICpwZGF0YTsKPj4g
Kwo+PiArIMKgIMKgIGludCAoKmNmZ19ncGlvKShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICopOwo+
PiArfTsKPgo+IEkgZG9uJ3Qgc2VlIG11Y2ggYmVuZWZpdCBpbiB0aGlzIHN0cnVjdHVyZSB3aXRo
IHRoZSBwZGF0YSBlbWJlZGRlZCBpbiBpdAo+IC0geW91IGp1c3QgZW5kIHVwIHdpdGggYW4gYWRk
aXRpb25hbCBsYXllciBvZiBpbmRpcmVjdGlvbiBpbiB5b3VyCj4gcGxhdGZvcm0gZGF0YSBpZiB5
b3UgbmVlZCB0byBhZGQgZGV2aWNlIHNwZWNpZmljIHN0dWZmIHdoaWNoIGlzIGFubm95aW5nCj4g
dG8gc3BlY2lmeSBpbiBtYWNoaW5lIGRyaXZlcnMuCldlbGwsIHNpbmNlIHRoZSBhYnN0cmFjdGlv
bihkZXYtYXVkaW8pIGlzIHN1cHBvc2VkIHRvIGJlIGNvbW1vbiBmb3IKSTJTLCBQQ00gYW5kIEFD
OTcgcHJvdG9jb2wsIHdlIG5lZWQgdG8gaGF2ZSBhbm90aGVyIGxheWVyIHdoaWNoCmNvbW11bmlj
YXRlIHByb3RvY29sIHNwZWNpZmljIHBsYXRmb3JtIGRhdGEuClRoaXMgcGRhdGEgaXMgbWVhbnQg
dG8gc2VydmUgdGhhdCBwdXJwb3NlIGluIGZ1dHVyZS4KCj4gSSdkIGp1c3QgZW1iZWQgdGhlIEdQ
SU8gY29uZmlndXJhdGlvbiBjYWxsYmFjayBpbiBhIGRyaXZlci1zcGVjaWZpYwo+IHBsYXRmb3Jt
IGRhdGEuCklmIG5vdCBmb3IgcGRhdGEsIHRoZSBjZmdfZ3BpbyB3dWRuJ3QgYmUgZW5vdWdoIGZv
ciBmdXR1cmUgU29DcyB3aGljaApub3Qgb25seSBjb25maWd1cmUgdGhlIE1VWCdlZCBwaW5zIGJ1
dCBhbHNvIHNldCB0aGUgZHJpdmUgc3RyZW5ndGguIFNvbWUKbWlnaHQgYWxzbyBuZWVkIGNvbmZp
Z3VyaW5nIHRoZSBTb0Mgd2hpY2ggbWF5IG5vdCBmYWxsIGludG8gZWl0aGVyIENsb2NrCm9yIFBv
d2VyIGRvbWFpbi4KU28sIGlmIEkgYW0gdG8gcmVtb3ZlIHBkYXRhLCBtYXliZSBjZmdfZ3BpbyBj
YW4gYmUgcmVuYW1lZCBjb25maWdfY29udHJvbGxlcj8KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZl
bEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbHNhLWRldmVsCg==
