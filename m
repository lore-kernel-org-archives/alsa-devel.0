From: =?UTF-8?B?UmFmYcWCIENpZcWbbGFr?= <rafalcieslak256@gmail.com>
Subject: Re: Why does snd_seq_drain_output() need lots of time
	to execute?
Date: Fri, 27 Jan 2012 14:28:42 +0100
Message-ID: <CABscqj4qkkwPjBPv40MtL2VrY=sAnyhFoNRY8v0ymFb95tDJFA@mail.gmail.com>
References: <CABscqj76Lb9fgD-FY1otzETWwjJO9vwCG=Rt83jU8ti0bE6KpA@mail.gmail.com>
	<4F21CDFA.3070608@ladisch.de>
	<CABscqj6i0JAVbrhFN=BQEjkQFFDdng2jc+mf8ATqMNfGEMq4Lw@mail.gmail.com>
	<20120127120313.GC29445@linuxaudio.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 68A272440C
	for <alsa-devel@alsa-project.org>; Fri, 27 Jan 2012 14:29:03 +0100 (CET)
Received: by iaby26 with SMTP id y26so2205635iab.38
	for <alsa-devel@alsa-project.org>; Fri, 27 Jan 2012 05:29:02 -0800 (PST)
In-Reply-To: <20120127120313.GC29445@linuxaudio.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fons Adriaensen <fons@linuxaudio.org>, Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

PiBJZiB5b3UgbWFuYWdlIHRvIGZpbGwgYSA1MDAtZXZlbnQgYnVmZmVyLCBjb3VsZCB0aGF0IG1l
YW4gdGhhdAo+IHlvdSBhcmUgc2VuZGluZyBldmVudHMgYSBsb25nIHRpbWUgYWhlYWQgb2YgdGhl
aXIgZHVlIHRpbWUgPwoKTm8sIEknbSBub3QgYnVmZmVyaW5nIGEgd2hvbGUgc29uZywgZXZlbnRz
IGFyZSBzZW5kIGF0IG1vc3QgYSBzZWNvbmQKb3IgdHdvIGFoZWFkIChmb3IgZWFjaCBiYXIpLiBU
aGUgcmVhc29uIHdoeSB0aGVyZSBtYXkgYmUgc28gbWFueSBvZgp0aGVtLCBpcyB0aGF0IEkgZW11
bGF0ZSBzbW9vdGggbW92ZW1lbnQgb2YgY29udHJvbCBwYXJhbWV0ZXJzIChqdXN0IGFzCmlmIG9u
ZSB3YXMgc2xvd2x5IG1vdmluZyBhIHNsaWRlci9rbm9iIG9uIGFuIGV4dGVybmFsIE1JREkKY29u
dHJvbGxlciksIHdoaWNoIHJlcXVpcmVzIGxvdHMgb2YgZXZlbnRzLCBhbmQgdGhlIHByb2JsZW0g
c3RhcnRzCndoZW4gSSB0cnkgdG8gZG8gdGhlIHNhbWUgZm9yIG1hbnkgZGlmZmVyZW50IGNvbnRy
b2xsZXJzL2NoYW5uZWxzCmluZGVwZW5kZW50bHkuCgpBbHNvLCBpdCB0dXJuZWQgb3V0IHRoYXQg
YWN0dWFsbHkgc25kX3NlcV9zZXRfY2xpZW50X3Bvb2xfb3V0cHV0KCkKZG9lcyB3b3JrLCB1bmxl
c3MgSSB0cnkgdG8gc2V0IGl0IHRvIGFueXRoaW5nIGdyZWF0ZXIgdGhlbiAyMDAwLiBJcwp0aGlz
IGEgaGFyZC1jb2RlZCBsaW1pdCwgb3IgY2FuIEkgc29tZWhvdyBpbmNyZWFzZSBpdCBldmVuIG1v
cmU/CgpSZWdhcmRzLApSYWZhxYIgQ2llxZtsYWsKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBh
bHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbHNhLWRldmVsCg==
