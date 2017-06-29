From: Delio Brignoli <dbrignoli@audioscience.com>
Subject: Re: Make snd_card_free() a no-op again for NULL ptr
 argument
Date: Thu, 29 Jun 2017 13:31:28 +0200
Message-ID: <15C6BEB0-2C5C-4CEF-8A2B-80F28397D739@audioscience.com>
References: <4ED8A548-C7E7-42A8-B3C7-0D32BFC49367@audioscience.com>
 <s5hfuejgjb5.wl-tiwai@suse.de>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from GWA7.webcontrolcenter.com (gwa7.webcontrolcenter.com
 [63.134.207.34])
 by alsa0.perex.cz (Postfix) with ESMTP id 451D0266991
 for <alsa-devel@alsa-project.org>; Thu, 29 Jun 2017 13:32:18 +0200 (CEST)
In-Reply-To: <s5hfuejgjb5.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Cj4gT24gMjkgSnVuIDIwMTcsIGF0IDEyOjQ5LCBUYWthc2hpIEl3YWkgPHRpd2FpQHN1c2UuZGU+
IHdyb3RlOgo+IAo+IE9uIFRodSwgMjkgSnVuIDIwMTcgMTI6NDY6MzMgKzAyMDAsCj4gRGVsaW8g
QnJpZ25vbGkgd3JvdGU6Cj4+IAo+PiBIZWxsbyBUYWthc2hpLAo+PiAKPj4gQ29tbWl0IOKAnEFM
U0E6IFVzZSBzdGFuZGFyZCBkZXZpY2UgcmVmY291bnQgZm9yIGNhcmQgYWNjb3VudGluZ+KAnSA8
aHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMv
bGludXguZ2l0L2NvbW1pdC9zb3VuZC9jb3JlL2luaXQuYz9oPXY0LjEyLXJjNiZpZD1mMjQ2NDA2
NDgxODZiNTliZDM5ZjhjZDY0MGQ2MzFiZGI2MWEzMTk3PiBjaGFuZ2VkIHRoZSBiZWhhdmlvdXIg
b2Ygc25kX2NhcmRfZnJlZSgpIGluIGNhc2Ugb2YgYSBOVUxMIHB0ciBhcmd1bWVudC4gQmVmb3Jl
IGYyNDY0MDY0ODE4NmI1OWJkMzlmOGNkNjQwZDYzMWJkYjYxYTMxOTcgc25kX2NhcmRfZnJlZSgp
IHdhcyBhIG5vLW9wIGluIGNhc2Ugb2YgYSBOVUxMIHB0ciBhcmd1bWVudCBhcyBJIHdvdWxkIGV4
cGVjdCBmb3IgYSAqX2ZyZWUoKSBmdW5jdGlvbi4gQ3VycmVudGx5IHBhc3NpbmcgYSBOVUxMIHB0
ciByZXN1bHRzIGluIGEgTlVMTCBwdHIgZGVyZWZlcmVuY2UuCj4+IAo+PiBJIGJlbGlldmUgdGhl
IHByZXZpb3VzIGJlaGF2aW91ciBpcyB3b3J0aCByZXN0b3JpbmcuIElmIHlvdSBhZ3JlZSBJ4oCZ
bGwgZm9sbG93IHVwIHdpdGggYSBwYXRjaC4KPiAKPiBJbiB3aGljaCBzaXR1YXRpb24gZG8geW91
IG5lZWQgdG8gcGFzcyBOVUxMIHRvIHNuZF9jYXJkX2ZyZWUoKT8KClVuY29uZGl0aW9uYWwgY2Fs
bHMgdG8gc25kX2NhcmRfZnJlZSgpLCBzaW1pbGFybHkgdG8gdW5jb25kaXRpb25hbCBjYWxscyB0
byBmcmVlKCkuCgpzdHJ1Y3Qgc25kX2NhcmQgKmNhcmQgPSBOVUxMOwrigKYKLyogc2V0dXAgY29k
ZSAqLwppZiAoc29tZXRoaW5nX2dvZXNfd3JvbmcpCiAgZ290byBjbGVhbnVwOwrigKYKcmV0dmFs
ID0gc25kX2NhcmRfbmV3KOKApiwgJmNhcmQpOwrigKYKY2xlYW51cDoKICBzbmRfY2FyZF9mcmVl
KGNhcmQpOwouLi4KClN1cmUsIGNvZGUgY2FuIGJlIHJlLW9yZ2FuaXplZCB0byBhdm9pZCBpdCBi
dXQgKl9mcmVlKCkgZnVuY3Rpb24gYmVpbmcgYSBuby1vcCBpbiBjYXNlIG9mIE5VTEwgcHRyIGFy
Z3VtZW50IGlzIHRoZSBub3JtIEFGQUlLLiBJZiBzbyB0aGVuIHdoeSBzbmRfY2FyZF9mcmVlKCkg
c2hvdWxkIGJlIGRpZmZlcmVudCBlc3BlY2lhbGx5IGlmIGl0IHdhcyBkb2luZyB0aGUgInJpZ2h0
IiB0aGluZyBiZWZvcmUuCgpUaGFuayB5b3UKLS0KRGVsaW8KCgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxz
YS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
