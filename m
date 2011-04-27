From: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: prevent compilers from optimising pll
	calculation into __aeabi__uldivmod
Date: Wed, 27 Apr 2011 23:23:39 +0800
Message-ID: <BANLkTin4y192A0Jdujv2t5tjoccmUBzQMQ@mail.gmail.com>
References: <1303889252-6722-1-git-send-email-bs14@csr.com>
	<s5h8vuwgl7f.wl%tiwai@suse.de>
	<BANLkTi=RuNgN_+26GBrwoHJuz1xSM=YcfQ@mail.gmail.com>
	<s5h1v0ogk6k.wl%tiwai@suse.de>
	<BANLkTimm3wB+EcBZMZzW2SoeJkibisdBWQ@mail.gmail.com>
	<20110427143002.GC31952@opensource.wolfsonmicro.com>
	<BANLkTimOdPO=LJNAM8EqXnMcx3xHPcoOXA@mail.gmail.com>
	<20110427151249.GE31952@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linaro-toolchain-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <20110427151249.GE31952-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-toolchain>,
	<mailto:linaro-toolchain-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-toolchain>
List-Post: <mailto:linaro-toolchain-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-toolchain-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-toolchain>,
	<mailto:linaro-toolchain-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-toolchain-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-toolchain-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, linaro-toolchain-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, Zhiwu Song <zhiwu.song-kQvG35nSl+M@public.gmane.org>, Binghua Duan <binghua.duan-kQvG35nSl+M@public.gmane.org>, lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

MjAxMS80LzI3IE1hcmsgQnJvd24gPGJyb29uaWVAb3BlbnNvdXJjZS53b2xmc29ubWljcm8uY29t
PjoKPiBPbiBXZWQsIEFwciAyNywgMjAxMSBhdCAxMTowMDoxOFBNICswODAwLCBCYXJyeSBTb25n
IHdyb3RlOgo+PiAyMDExLzQvMjcgTWFyayBCcm93biA8YnJvb25pZUBvcGVuc291cmNlLndvbGZz
b25taWNyby5jb20+Cj4KPj4gPiBJZiB3ZSBkbyBoYXZlIHRvIGRvIHNvbWV0aGluZyBpbiB0aGUg
Y2FsbGVycyByYXRoZXIgdGhhbiBpbiBkb19kaXYoKSB0aGUKPj4gPiBhbm5vdGF0aW9uIHNlZW1z
IHN1YnN0YW50aWFsbHkgbW9yZSB0YXNlZnVsIHRoYW4gaW5zZXJ0aW5nIGEgcmFuZG9tIGFzbQo+
PiA+IGludG8gdGhlIGNvZGUuCj4KPj4gSSBhZ3JlZS4gZm9yIHRoaXMgcGF0Y2ggd2hpY2ggd2ls
bCBub3QgYmUgYXBwbGllZCwgcGVvcGxlIGNhbiBqdXN0IGdldAo+PiBpbmZvcm1hdGlvbiBhYm91
dCBob3cgdG8gd29ya2Fyb3VuZCB0aGUgZ2NjIGlzc3VlIHdoaWxlIHRoZXkgaGF2ZSB0aGUKPj4g
c2FtZSBwcm9ibGVtLiBnb29nbGUgY2FuIGZpbmQgdGhlcmUgYXJlIG90aGVyIHBlb3BsZSB3aG8g
ZmFpbGVkIHRvCj4+IGNvbXBpbGUgd204OTc0IG1vZHVsZSB0b28uIGVnLgo+PiBodHRwOi8vaXJj
bG9ncy51YnVudHUuY29tLzIwMTAvMDMvMzAvJTIzdWJ1bnR1LWFybS50eHQKPgo+PiBBbmRyZXcg
U3R1YmJzLCBNaWNoYWVsIEhvcGUgaW4gTGluYXJvJ3MgdG9vbGNoYWluIHRlYW0gYXJlIHdvcmtp
bmcKPj4gaGFyZCBvbiB0aGlzIGdjYyBpc3N1ZS4gdGhlcmUgaGF2ZSBiZWVuIG1hbnkgdXBkYXRl
IHRvZGF5Ogo+PiBodHRwOi8vZ2NjLmdudS5vcmcvYnVnemlsbGEvc2hvd19idWcuY2dpP2lkPTQ4
NzgzCj4KPiBJcyB0aGlzIGp1c3Qgc29tZSBMaW5hcm8gdG9vbGNoYWluIHRoYXQgaGFzIHRoZSBp
c3N1ZSByYXRoZXIgdGhhbiBhCj4gdmFuaWxsYSBHQ0MgcmVsZWFzZT8gwqBJZiBzbyBhbmQgdGhl
eSBmaXggdGhlIGNvbXBpbGVyIGJ1ZyBpdCBkb2Vzbid0Cj4gc2VlbSB0ZXJyaWJseSB1c2VmdWwg
dG8gYm9kZ2UgaXQgaW4gbWFpbmxpbmUuCj4KCmkgYW0gZ3Vlc3NpbmcgaXQgaXMgYSBnZW5lcmlj
IGdjYyBpc3N1ZSBzaW5jZSBNaWNoYWVsIHBvc3RlZCBpdCBhdApodHRwOi8vZ2NjLmdudS5vcmcv
YnVnemlsbGEgbm90IExpbmFybydzIExhdW5jaHBhZC4gbm90IHN1cmUgOi0pCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW5hcm8tdG9vbGNoYWluIG1h
aWxpbmcgbGlzdApsaW5hcm8tdG9vbGNoYWluQGxpc3RzLmxpbmFyby5vcmcKaHR0cDovL2xpc3Rz
LmxpbmFyby5vcmcvbWFpbG1hbi9saXN0aW5mby9saW5hcm8tdG9vbGNoYWluCg==
