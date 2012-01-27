From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Why does snd_seq_drain_output() need lots of time
 to execute?
Date: Fri, 27 Jan 2012 19:04:59 +0100
Message-ID: <4F22E74B.1070009@ladisch.de>
References: <CABscqj76Lb9fgD-FY1otzETWwjJO9vwCG=Rt83jU8ti0bE6KpA@mail.gmail.com>
	<4F21CDFA.3070608@ladisch.de>
	<CABscqj6i0JAVbrhFN=BQEjkQFFDdng2jc+mf8ATqMNfGEMq4Lw@mail.gmail.com>
	<20120127120313.GC29445@linuxaudio.org>
	<CABscqj4qkkwPjBPv40MtL2VrY=sAnyhFoNRY8v0ymFb95tDJFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 98A7A24375
	for <alsa-devel@alsa-project.org>; Fri, 27 Jan 2012 19:05:37 +0100 (CET)
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id A77B120B17
	for <alsa-devel@alsa-project.org>; Fri, 27 Jan 2012 13:05:34 -0500 (EST)
In-Reply-To: <CABscqj4qkkwPjBPv40MtL2VrY=sAnyhFoNRY8v0ymFb95tDJFA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?B?UmFmYcWCIENpZcWbbGFr?= <rafalcieslak256@gmail.com>
Cc: alsa-devel@alsa-project.org, Fons Adriaensen <fons@linuxaudio.org>
List-Id: alsa-devel@alsa-project.org

UmFmYcWCIENpZcWbbGFrIHdyb3RlOgo+IEFsc28sIGl0IHR1cm5lZCBvdXQgdGhhdCBhY3R1YWxs
eSBzbmRfc2VxX3NldF9jbGllbnRfcG9vbF9vdXRwdXQoKQo+IGRvZXMgd29yaywgdW5sZXNzIEkg
dHJ5IHRvIHNldCBpdCB0byBhbnl0aGluZyBncmVhdGVyIHRoZW4gMjAwMC4gSXMKPiB0aGlzIGEg
aGFyZC1jb2RlZCBsaW1pdCwKClllcy4KCj4gb3IgY2FuIEkgc29tZWhvdyBpbmNyZWFzZSBpdCBl
dmVuIG1vcmU/CgpDaGFuZ2UgU05EUlZfU0VRX01BWF9FVkVOVFMgaW4gaW5jbHVkZS9zb3VuZC9z
ZXFfa2VybmVsLmggYW5kIHJlY29tcGlsZQp0aGUga2VybmVsIC4uLgoKClJlZ2FyZHMsCkNsZW1l
bnMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1k
ZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWls
bWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
