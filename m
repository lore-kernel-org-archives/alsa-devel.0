From: "=?UTF-8?Q?Vedran_Mileti=C4=87?=" <rivanvx@gmail.com>
Subject: Re: [PATCH] ALSA: emu10k1: fix device names for
	Live!/Audigy1/2/4/E-mu and coding style
Date: Thu, 23 Oct 2008 12:14:09 +0200
Message-ID: <fd3eb9bf0810230314x205100bepe8afa8aaf6bc14e7@mail.gmail.com>
References: <1224678686.4001.22.camel@localhost>
	<fd3eb9bf0810220822k4318ff3eha70447f0a15e7e28@mail.gmail.com>
	<48FF96AE.6030407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.168])
	by alsa0.perex.cz (Postfix) with ESMTP id E357910384A
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Oct 2008 12:14:27 +0200 (CEST)
Received: by wf-out-1314.google.com with SMTP id 24so278941wfg.23
	for <alsa-devel@alsa-project.org>; Thu, 23 Oct 2008 03:14:09 -0700 (PDT)
In-Reply-To: <48FF96AE.6030407@gmail.com>
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
To: adezeo@gmail.com, alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

RG8geW91IGhhdmUgdGhlIG5vbi13b3JraW5nIG9sZCByZXZpc2lvbiBvciB3b3JraW5nIG5ldyBy
ZXZpc2lvbj8KQmVjYXVzZSwgaWYgaXQgYWxyZWFkeSB3b3JrcywgaXQgd2lsbCBjb250aW51ZSB0
byB3b3JrLiBIb3dldmVyLCBpZiBpdApkb2VzbiwgdGhlbiBpdCB3b24ndCBjaGFuZ2UgOi0oIEl0
J3MgYSBrbm93biBoYXJkd2FyZSBpc3N1ZSB3aXRoIG9sZApFLW11IDA0MDQgKEVNODg1MCBpZiBJ
J20gbm90IG1pc3Rha2VuKS4KCk15IGNvZGUgY2hhbmdlcyBhcmUgbW9zdGx5IGNsZWFudXBzIHRv
IGFkaGVyZSB0byBzdGFuZGFyZHMgYW5kIGNoYW5nZXMKdG8gbWFrZSBkZXZpY2UgbmFtZXMgbW9y
ZSB1c2VyIGZyaWVuZGx5IGFuZCBjb25zaXN0ZW50LCBubyBiaWcgY2hhbmdlcwpzaW5jZSBJJ20g
bm90IGEgcmVhbCBwcm9ncmFtbWVyICh5ZXQhIDotKSB3aG8ga25vd3MuLi4pLgoKMjAwOC8xMC8y
MiBhZHJpYW4gZGV6ZW8gPGFkZXplb0BnbWFpbC5jb20+Ogo+IEhpIFZlZHJhbjoKPgo+ICAgTXkg
bmFtZSBpcyBBZHJpYW4gRGV6ZW8gYW5kIEknbSBmcm9tIEFyZ2VudGluYS4KPiAgIEkgaGF2ZSBh
IGVtdSAwNDA0IGFuZCBnbGFkbHkgd2lsbCB0ZXN0IGFueSBjb2RlIGZyb20gdGhlIGVtdTEwazEg
YWxzYQo+IGRyaXZlciBpZiB5b3UgbmVlZCB0by4KPiAgIFRoYW5rcyBpbiBhZHZhbmNlLgo+ICAg
YmVzdCByZWdhcmRzLgo+Cj4gQWRyaWFuLgo+Cj4KPiBWZWRyYW4gTWlsZXRpxIcgd3JvdGU6Cj4+
Cj4+IEhtbS4uLiBJIGFjdHVhbGx5IGZvbGxvd2VkIEphbWVzIGhlcmUsIGhlIHNldCBzdGFuZGFy
ZCBvZiBuYW1pbmcgd2l0aAo+PiBDYXJkQnVzIDE2MTYncyBuYW1lLiBCdXQsIG9oIHdlbGwuIEkg
Y2FuIGZpeCBpdCBpbiBteSBuZXh0IHJ1biwgYW5kIEkKPj4gd2lsbCBsaWtlbHkgZG8gaXQgd2hl
biBJIHBsYXkgYXJvdW5kIHdpdGggcG9ydGluZyBvdmVyIGNvbXBsZXRlCj4+IGt4LmluZidzIGRl
dmljZSBsaXN0Lgo+Pgo+PiAyMDA4LzEwLzIyIFRvbnkgVnJvb24gPHRvbnlAdnJvb24ub3JnPjoK
Pj4KPj4+Cj4+PiBPbiBhIHJlbGF0ZWQgbm90ZSwgaXQgbG9va3MgdG8gbWUgYXMgaWYgdGhlIGxl
YWRpbmcgdHdvIGNoYXJhY3RlcnMgKHRoZQo+Pj4gbWFudWZhY3R1cmluZyBsb2NhdGlvbikgaGF2
ZSBiZWVuIGVycm9uZW91c2x5IGluY2x1ZGVkIGZvciBFLU1VCj4+PiBwcm9kdWN0cy4KPj4+IFlv
dSdsbCBzZWUgdGhpcyBNQSBjb2RlIG9uIHNvbWUgc291bmQgY2FyZHMgYXMgd2VsbCAoTUFTQnh4
eHgpCj4+Pgo+Pj4gUmVnYXJkcywKPj4+IFRvbnkgVi4KPj4+Cj4+Pgo+Pgo+Pgo+Pgo+Pgo+Cj4K
CgoKLS0gClZlZHJhbiBNaWxldGnEhwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJv
amVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2Fsc2EtZGV2ZWwK
