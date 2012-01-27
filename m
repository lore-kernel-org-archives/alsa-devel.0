From: Fons Adriaensen <fons@linuxaudio.org>
Subject: Re: Why does snd_seq_drain_output() need lots of
	time	to execute?
Date: Fri, 27 Jan 2012 12:03:13 +0000
Message-ID: <20120127120313.GC29445@linuxaudio.org>
References: <CABscqj76Lb9fgD-FY1otzETWwjJO9vwCG=Rt83jU8ti0bE6KpA@mail.gmail.com>
	<4F21CDFA.3070608@ladisch.de>
	<CABscqj6i0JAVbrhFN=BQEjkQFFDdng2jc+mf8ATqMNfGEMq4Lw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lists.linuxaudio.org (bukvic.music.vt.edu [198.82.152.114])
	by alsa0.perex.cz (Postfix) with ESMTP id EB95124381
	for <alsa-devel@alsa-project.org>; Fri, 27 Jan 2012 13:03:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CABscqj6i0JAVbrhFN=BQEjkQFFDdng2jc+mf8ATqMNfGEMq4Lw@mail.gmail.com>
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

T24gRnJpLCBKYW4gMjcsIDIwMTIgYXQgMDE6MjA6MTdBTSArMDEwMCwgUmFmYcWCIENpZcWbbGFr
IHdyb3RlOgogCj4gSG93ZXZlciwgaXQgc2VlbXMgdGhhdCBzb21laG93IEkgY2Fubm90IGNoYW5n
ZSBpdC4gSWYgSSB0cnkgdXNpbmcKPiBzbmRfc2VxX3NldF9jbGllbnRfcG9vbF9vdXRwdXQoKSwg
dGhpcyBnaXZlcyBhYnNvbHV0ZWx5IG5vIGVmZmVjdCwgYW5kCj4gZG9lcyBub3Qgc2VlbSB0byBt
YWtlIGFueSBlZmZlY3QsIHRoZSBwb29sIHNpemUgc3RheXMgYXQgNTAwIChldmVuCj4gdGhvdWdo
IHRoZSBmdW5jdGlvbiByZXR1cm5zIDApICAodG8gY2hlY2sgdGhlIHBvb2wgc2l6ZSBJIGxvb2sg
YXQKPiAvcHJvYy9hc291bmQvc2VxL2NsaWVudHMsIGFuZCBpdCBpcyBhbHdheXMgNTAwKS4KCklm
IHlvdSBtYW5hZ2UgdG8gZmlsbCBhIDUwMC1ldmVudCBidWZmZXIsIGNvdWxkIHRoYXQgbWVhbiB0
aGF0CnlvdSBhcmUgc2VuZGluZyBldmVudHMgYSBsb25nIHRpbWUgYWhlYWQgb2YgdGhlaXIgZHVl
IHRpbWUgPwoKSW4gdGhhdCBjYXNlIHRoZSBzb2x1dGlvbiBpcyB0byBrZWVwIGV2ZW50cyBpbiBh
cHBsaWNhdGlvbiBidWZmZXJzCnVudGlsIHNheSBoYWxmIGEgc2Vjb25kIGJlZm9yZSB0aGV5IGFy
ZSByZWFsbHkgbmVlZGVkLiBJbiBvdGhlcgp3b3JkcyBsZXQgdGhlIGFwcCBkbyB0aGUgcm91Z2gg
dGltaW5nLCBhbmQgQUxTQSB0aGUgZmluZSBvbmUuCgpJdCByZXF1aXJlcyBhIGJpdCBtb3JlIGxv
Z2ljLCBidXQgaXQncyBwcm9iYWJseSBuZWVkZWQgYW55d2F5IC0KeW91IGNhbid0IGV4cGVjdCBr
ZXJuZWwgc2lkZSBBTFNBIHRvIGJ1ZmZlciBlLmcuIGEgY29tcGxldGUgc29uZy4KCkxpbWl0aW5n
IHRoZSBzZW5kLWFoZWFkIHRpbWUgd2lsbCBhbHNvIG1ha2UgdGhlIGFwcCBtb3JlCnJlc3BvbnNp
dmUgaW4gY2FzZSB5b3UgaGF2ZSB0byBzdG9wIGFuZC9vciByZXBvc2l0aW9uIHRoZQpzdHJlYW0u
CgpDaWFvLAoKLS0gCkZBCgpWb3IgdW5zIGxpZWd0IGVpbiB3ZWl0ZXMgVGFsLCBkaWUgU29ubmUg
c2NoZWludCAtIGVpbiBHbGl0emVyc3RyYWhsLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBh
bHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbHNhLWRldmVsCg==
