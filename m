From: Denys Vlasenko <vda.linux@googlemail.com>
Subject: Re: [PATCH -mm] sb16: Shut up uninitialized var build
	warning
Date: Thu, 20 Sep 2007 18:52:11 +0100
Message-ID: <200709201852.11497.vda.linux@googlemail.com>
References: <alpine.LFD.0.999.0709022344550.27844@enigma.security.iitk.ac.i n>
	<alpine.LFD.0.999.0709030143550.29617@enigma.security.iitk.ac.in>
	<46DB33D0.40204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.188])
	by alsa0.perex.cz (Postfix) with ESMTP id 4C44124392
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Sep 2007 19:52:20 +0200 (CEST)
Received: by fk-out-0910.google.com with SMTP id f40so562078fka
	for <alsa-devel@alsa-project.org>; Thu, 20 Sep 2007 10:52:19 -0700 (PDT)
In-Reply-To: <46DB33D0.40204@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jaroslav Kysela <perex@suse.cz>, Satyam Sharma <satyam@infradead.org>
List-Id: alsa-devel@alsa-project.org

T24gU3VuZGF5IDAyIFNlcHRlbWJlciAyMDA3IDIzOjA2LCBSZW5lIEhlcm1hbiB3cm90ZToKPiBP
biAwOS8wMi8yMDA3IDEwOjE1IFBNLCBTYXR5YW0gU2hhcm1hIHdyb3RlOgo+IAo+ID4gc291bmQv
aXNhL3NiMTYvc2IxNi5jOiBJbiBmdW5jdGlvbiDigJhzbmRfc2IxNl9pc2FfcHJvYmXigJk6Cj4g
Cj4gQmxhaC4gWW91ciBtZXNzYWdlIGhhczoKPiAKPiAJQ29udGVudC1UeXBlOiBURVhUL1BMQUlO
OyBjaGFyc2V0PWlzby0yMDIyLWpwCj4gCj4gVGhpcyBhcHBhcmVudGx5IGlzIGNhdXNlZCBieSBh
IGNvbWJpbmF0aW9uIG9mIEdDQyB1c2luZyBncm9vdnkgVVRGIHRpY2ttYXJrcyAKPiBpbiBpdHMg
ZXJyb3IgbWVzc2FnZXMgd2hlbiBpbiBhIFVURiBsb2NhbGUgYW5kIGFscGluZSBiZWxpZXZpbmcg
aXQgdG8gYmUgYSAKPiBncmVhdCBpZGVhIHRvIGF1dG9tYXRpY2FsbHkgdHJ5IGZvciB0aGUgInNp
bXBsZXN0IiBjaGFyYWN0ZXIgc2V0IGl0IGNhbiAKPiBlbmNvZGUgdGhlIGNvbnRlbnQgaW4uIE5v
IGlkZWEgd2h5IHRoYXQgbWVhbnMgdGhhdCBpc28tMjAyMi1qcCBpcyBwaWNrZWQsIAo+IGJ1dCBp
dCBpcy4KPiAKPiBXaGlsZSBJIGNvdWxkIGFjdHVhbGx5IHJlYWQgdGhlIG1lc3NhZ2UgdGhpcyB0
aW1lIHlvdSBzaG91bGQgc2VlIHdoYXQgCj4gaXNvLTIwMjItanAgZG9lcyB0byBteSBmb250LiBJ
dCdzIHNjYXJ5LiBCZXN0IHNvbHV0aW9uIGFzIGZhciBhcyBJJ20gCj4gY29uY2VybmVkIGlzIHNs
YXAgYSBmZXcgR0NDIGRldmVsb3BlcnMgKG5vdCB0aGF0IGl0IHdpbCBoZWxwLCBidXQgaXQnbGwg
Cj4gY2VydGFpbmx5IGZlZWwgZ29vZCkgYW5kIHRoZW4gdGVhY2ggYWxwaW5lIHRvIGdvIGZvciBV
VEYtOCBkaXJlY3RseSBpZiAKPiBVUy1BU0NJSSB3b24ndCBkby4KCnJvdGZsLgoKS2luZGx5IGdp
dmUgbWUgcGVybWlzc2lvbiB0byBjb252ZXJ0IHlvdXIgZW1haWwgaW50byBnY2MgYnVncmVwb3J0
CmFuZC9vciB0byBmb3J3YXJkIGl0IHRvIGdjYyBtYWlsaW5nIGxpc3QuCi0tCnZkYQpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxp
bmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1w
cm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
