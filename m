From: Smilen Dimitrov <sd@imi.aau.dk>
Subject: Re: Questions about virtual ALSA driver (dummy),
 PortAudio and full-duplex drops (playback)
Date: Fri, 16 Aug 2013 07:20:08 +0200
Message-ID: <520DB688.3050205@imi.aau.dk>
References: <51EF41C8.2040701@imi.aau.dk>
 <201307241403.28873.gineera@aspect135.co.uk> <51F07150.1060004@imi.aau.dk>
 <51F0E3C5.4020400@ladisch.de> <520B9487.7070709@imi.aau.dk>
 <CAN8cciZd5s-XQRehE4LDQ=mY5X1HrAiy+c=QG7VYUx9ykjQoqQ@mail.gmail.com>
Reply-To: alsa-devel@alsa-project.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from asmtp.www1.dk (asmtp.www1.dk [91.144.243.214])
 by alsa0.perex.cz (Postfix) with ESMTP id D8003261AF9
 for <alsa-devel@alsa-project.org>; Fri, 16 Aug 2013 07:20:09 +0200 (CEST)
Received: from [31.193.237.139] (helo=cp6.danhost.dk)
 by asmtp.www1.dk with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.80 (FreeBSD)) (envelope-from <sd@imi.aau.dk>)
 id 1VACSH-0008Om-9N
 for alsa-devel@alsa-project.org; Fri, 16 Aug 2013 07:20:09 +0200
Received: from [62.199.57.204] (port=49324 helo=[192.168.1.12])
 by cp6.danhost.dk with esmtpa (Exim 4.80.1)
 (envelope-from <sd@imi.aau.dk>) id 1VACSG-0008Eh-RE
 for alsa-devel@alsa-project.org; Fri, 16 Aug 2013 07:20:08 +0200
In-Reply-To: <CAN8cciZd5s-XQRehE4LDQ=mY5X1HrAiy+c=QG7VYUx9ykjQoqQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

SGkgUmF5bW9uZCwKCk1hbnkgdGhhbmtzIGZvciB5b3VyIHJlc3BvbnNlIQoKCj4+Cj4+IFdoaWxl
IEkgaGF2ZSBsZWFybmVkIHRoYXQgbW9kZXJuIGNhcmRzIGRvIG5vdCBoYXZlIG9uLWJvYXJkIGJ1
ZmZlcnMsCj4KPiBUYWtlIGEgbG9vayBhdCBJbnRlbMKuIEhpZ2ggRGVmaW5pdGlvbiBBdWRpbyBT
cGVjaWZpY2F0aW9uIERvY3VtZW50IENoYW5nZQo+IE5vdGlmaWNhdGlvbgo+IDQuNiBFbmVyZ3kg
RWZmaWNpZW50IEhEIEF1ZGlvIChFRUF1ZGlvKSBNZWNoYW5pc20KPgo+IFRoZXJlIGlzIGNvbnRy
b2xsZXIgKEhXKSBidWZmZXIgPGxvY2FsIGZpZm8+IGluIHRoZSBGaWd1cmUgMTQgSEQgQXVkaW8g
RE1BCj4gYW5kIGJ1ZmZlcmluZwoKVGhhbmtzIGZvciBzcG90dGluZyB0aGF0IC0gd2Fzbid0IGF3
YXJlIG9mIHRoaXMgZG9jdW1lbnQuIEkgaGFkIGEgYml0IG9mIHRyb3VibGUgdHJhY2tpbmcgaXQg
ZG93biB1c2luZyB0aG9zZSB0ZXJtcyAtIGVuZGVkIHVwIGZpbmRpbmcgaXQgb24gYSBwYWdlIGVu
dGl0bGVkICJJbnRlbMKuIEhpZ2ggRGVmaW5pdGlvbiBBdWRpbyBFbmVyZ3kgRWZmaWNpZW50IEJ1
ZmZlcmluZzogU3BlYyIuCgpOb3csIHRoYXQgY29tbWVudCBvZiBtaW5lLCBzdGVtcyBmcm9tIHRo
aXM6Cgo+Pj4gSSdtIGFzc3VtaW5nIHRoYXQgdGhlIGNhcmQgaGFzIGl0J3Mgb3duIGludGVybiBj
YXB0dXJlIGJ1ZmZlciBtZW1vcnkKPj4+IG9uIGJvYXJkOwo+Pgo+PiBObyBtb2Rlcm4gY2FyZCBo
YXMgdGhpcy4gIEFsbCBkYXRhIGlzIGltbWVkaWF0ZWx5IHJlYWQgZnJvbS93cml0dGVuIHRvCj4+
IG1haW4gbWVtb3J5Lgo+Pgo+Cj4gVGhhbmtzIGZvciBub3RpbmcgdGhpcyAtIEkgd2lzaCBJIGtu
ZXcgYmV0dGVyIDopIFsuLi5dCgouLi4gYW5kIGNvbWUgdG8gdGhpbmsgb2YgaXQsIEkgZGlkIHN0
YXJ0IHRoZSBkaXNjdXNzaW9uIHJlZmVycmluZyB0byAiY2FwdHVyZSIgdGhlcmUuIFJlYWRpbmcg
dGhlIEludGVsIHNwZWMgRENOLCAiY2FwdHVyZSIgaXMgbmV2ZXIgbWVudGlvbmVkLCB3aGlsZSAi
cGxheWVkIiBpcyBtZW50aW9uZWQgb25jZS4gRG9lcyB0aGlzIG1lYW4gdGhhdCB0aGUgcmVmZXJy
ZWQgRklGTyBmb3IgaGRhLWludGVsIGlzIGp1c3QgZm9yIHBsYXliYWNrLCB3aGlsZSB0aGVyZSBp
cyBubyBzdWNoIGNvdW50ZXJwYXJ0IGZvciBjYXB0dXJlPyBPciBpcyBpdCB0aGF0IGZvciBoZGEt
aW50ZWwgb24tYm9hcmQgY2FyZHMsIHRoZXkgaGF2ZSBGSUZPJ3MgaW4gYm90aCBkaXJlY3Rpb24s
IGJ1dCBvdGhlciBtb2Rlcm4gY2FyZHMgZG9uJ3QgbmVjZXNzYXJpbHk/IE9yIG1heWJlIEkgaW50
cm9kdWNlZCB0aGUgcHJvYmxlbSwgYnkgY2FyZWxlc3NseSByZWZlcnJpbmcgdG8gImJ1ZmZlciBt
ZW1vcnkiLCB3aGljaCBtaWdodCBtZWFuIHRydWUgcmFuZG9tIGFjY2VzcyBtZW1vcnkgLSB3aGls
ZSBtb2Rlcm4gY2FyZHMgbWF5IGhhdmUgRklGTydzICh3aGljaCBJJ2QgZ3Vlc3MgYXJlIGVsZWN0
cmljYWxseSBzaW1wbGVyKT8KCgpUaGFua3MgZm9yIGFueSBjbGFyaWZpY2F0aW9ucywKQ2hlZXJz
IQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1k
ZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWls
bWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
