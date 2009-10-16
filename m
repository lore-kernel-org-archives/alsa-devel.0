From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH] Fix codec_dai->ops NULL pointer bug for
	AC97 codec dai in soc-core
Date: Fri, 16 Oct 2009 17:35:12 +0800
Message-ID: <3c17e3570910160235n28f396b1m665e9e4540a75123@mail.gmail.com>
References: <1255658960-20693-1-git-send-email-21cnbao@gmail.com>
	<20091016090840.GI884@sirena.org.uk>
	<3c17e3570910160214q18e99bd0y932b800a0c4f9fca@mail.gmail.com>
	<20091016093244.GK884@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f184.google.com (mail-pz0-f184.google.com
	[209.85.222.184])
	by alsa0.perex.cz (Postfix) with ESMTP id E8D6E24533
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Oct 2009 11:35:34 +0200 (CEST)
Received: by pzk14 with SMTP id 14so1512435pzk.23
	for <alsa-devel@alsa-project.org>; Fri, 16 Oct 2009 02:35:32 -0700 (PDT)
In-Reply-To: <20091016093244.GK884@sirena.org.uk>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

T24gRnJpLCBPY3QgMTYsIDIwMDkgYXQgNTozMiBQTSwgTWFyayBCcm93bgo8YnJvb25pZUBvcGVu
c291cmNlLndvbGZzb25taWNyby5jb20+IHdyb3RlOgo+IE9uIEZyaSwgT2N0IDE2LCAyMDA5IGF0
IDA1OjE0OjMxUE0gKzA4MDAsIEJhcnJ5IFNvbmcgd3JvdGU6Cj4+IE9uIEZyaSwgT2N0IDE2LCAy
MDA5IGF0IDU6MDggUE0sIE1hcmsgQnJvd24KPgo+PiA+IFRoaXMgaXMgdGhlIHdyb25nIGZpeCAt
IG51bGwgREFJIG9wcyBhcmUgc3VwcG9zZWQgdG8gYmUgc3VwcG9ydGVkIGZvcgo+PiA+IGFsbCBk
ZXZpY2VzIHNpbmNlIG5vdCBhbGwgREFJcyB3aWxsIGJlIGNvbmZpZ3VyYWJsZS4KPgo+PiBCdXQg
dGhlIHByb2JsZW0gaXMgYWM5NyBEQUlzIHdpbGwgaGF2ZSBubyBwYXRoIHRvIGdldCB0aGUgbnVs
bCBvcHMuCj4+IFRoZW4gbWFueSBmdW5jdGlvbnMgd2lsbCBwYW5pYy4gSXQncyB2ZXJ5IGVhc3kg
dG8gcmVwZWF0IHRoZSBwcm9ibGVtCj4+IGluIHlvdXIgc2l0ZSwgb25seSBieSBkZWxldGluZyBv
cHMgZmllbGQgaW4gYW55IEFDOTcgY29kZWMgREFJLgo+Cj4gU3VyZSwgSSBzZWUgdGhlIHByb2Js
ZW0uIMKgVGhlIGlzc3VlIGlzIHRoYXQgdGhpcyBjb3VsZCBhZmZlY3QgYW55IENPREVDLAo+IG5v
dCBqdXN0IEFDOTcgb25lcywgc28gYW4gQUM5Ny1zcGVjaWZpYyBmaXggaXNuJ3Qgd2hhdCdzIG5l
ZWRlZC4gwqBHaXZlbgo+IHRoZSBpZGlvbSBvZiB0aGUgcmVzdCBvZiB0aGUgY29kZSB0aGUgYmVz
dCB0aGluZyB3b3VsZCBiZSB0byBtYWtlIGFsbAo+IHRoZSByZW1haW5pbmcgY2FsbGVycyBjaGVj
ayBmb3Igb3BzIGJlZm9yZSBkZXJlZmVyZW5jaW5nIGl0LgpBdCB0aGUgYmVnaW5uaW5nLCBJIHdh
bnRlZCB0byBkbyBsaWtlIHRoaXMuIEJ1dCBJIHNhdyBhbGwgb3RoZXIgY29kZWMKREFJcyByZWdp
c3RlciB0aGVtc2VsdmVzLCB0aGVuIGdvdCBhIG51bGwgb3BzLiBKdXN0IGFjOTcgaXMgZm9yZ290
LgpUaGVuIEkgcGF0Y2hlZCBBQzk3IGNvZGVjIERBSXMuClRoZW4geW91IHByZWZlciB0byBwYXRj
aCBhbGwgb3BzIGFjY2Vzcz8KCj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2pl
Y3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bHNhLWRldmVsCg==
