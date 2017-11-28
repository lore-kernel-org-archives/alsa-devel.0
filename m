From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: ALSA: nm256: Fine-tuning for three function
	implementations
Date: Tue, 28 Nov 2017 13:33:48 +0100
Message-ID: <c2b7543c-cd2c-f7f6-98f3-23e2ca6f8b90@users.sourceforge.net>
References: <d98a2685-ddf9-1cba-839a-d12c5ff8d3ba@users.sourceforge.net>
 <s5hefoy16xg.wl-tiwai@suse.de>
 <dfa99045-f213-3dad-b1f4-2e90eb38ddbd@users.sourceforge.net>
 <s5h7euq9hqt.wl-tiwai@suse.de>
 <24f8c777-1eb4-e7e7-9371-79f32700c9dc@users.sourceforge.net>
 <s5hbmjmluba.wl-tiwai@suse.de>
 <2cbef557-5f89-c630-e108-14ef2ce6b41a@users.sourceforge.net>
 <s5h4lpelqfm.wl-tiwai@suse.de>
 <1547a4c2-5b70-e3a3-b482-d28c538e615c@users.sourceforge.net>
 <s5hy3mqr5v9.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by alsa0.perex.cz (Postfix) with ESMTP id 917AB266B0F
 for <alsa-devel@alsa-project.org>; Tue, 28 Nov 2017 13:33:53 +0100 (CET)
In-Reply-To: <s5hy3mqr5v9.wl-tiwai@suse.de>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Pj4gSXQgc2VlbXMgdGhlbiB0aGF0IHlvdSBjYW4gbm90IGdldCB0aGUga2luZCBvZiBpbmZvcm1h
dGlvbiB5b3UgbWlnaHQgYmUgbG9va2luZyBmb3IKPj4gYXQgdGhlIG1vbWVudCBmcm9tIG1lIChh
bG9uZSkuCj4gCj4gTm8sIHRoZSBwYXRjaCBpdHNlbGYgc3BlYWtzLgoKQXJlIHdlIHN0aWxsIHRy
eWluZyB0byBjbGFyaWZ5IChvbmx5KSB0d28gcG9zc2libGUgdXBkYXRlIHN0ZXBzCmZvciB0aGlz
IHNvZnR3YXJlIG1vZHVsZT8KCgo+IElmIHlvdSBnZXQgbW9yZSByZXZpZXdlZC1ieSBmcm9tIG90
aGVycywgaXQgbWVhbnMgYWxyZWFkeSBpdCdzIHNhZmVyCj4gdG8gYXBwbHkuICBUaGVuIEkgY2Fu
IHRha2UgaXQuCgpIb3cgYXJlIHRoZSBzdGF0aXN0aWNzIGZvciBzdWNoIHRhZ3MgaW4gdGhlIHNv
dW5kIHN1YnN5c3RlbT8KCgo+IEJ1dCB3aXRob3V0IHRoYXQsIGl0J3Mgb2J2aW91c2x5IG5vIG1h
dGVyaWFsIHRvIHRha2UuCgpUaGFua3MgZm9yIHN1Y2ggYW4gZXhwbGFuYXRpb24gb2YgeW91ciBj
dXJyZW50IHZpZXcuCgoKPj4gSSBob3BlIHRoYXQgbWFpbGluZyBsaXN0IHJlYWRlcnMgY291bGQg
b2ZmZXIgc29tZXRoaW5nLgo+IAo+IExldCdzIGhvcGUuCgpBcmUgYW55IGFkZGl0aW9uYWwgY29t
bXVuaWNhdGlvbiBpbnRlcmZhY2VzIGhlbHBmdWw/CgoKPj4gRGlkIHRoaXMgc29mdHdhcmUgbW9k
dWxlIGJlY29tZSDigJx0b28gb2xk4oCdPwo+IAo+IE1vc3RseSB0aGUgaGFyZHdhcmUgaXMgdG9v
IG9sZCwKCldoaWNoIHRpbWUgZnJhbWVzIGhhdmUgeW91IGdvdCBpbiBtaW5kIGZvciBhY2NlcHRh
YmxlIHNvZnR3YXJlIG1haW50ZW5hbmNlPwoKCj4gb3IgdGhlIGNoYW5nZSBpdHNlbGYgaXNuJ3Qg
aW50ZXJlc3RpbmcgZW5vdWdoLgoKVGhpcyBpcyBhbm90aGVyIGdlbmVyYWwgcG9zc2liaWxpdHku
CgoKPj4gQ2FuIGhpZ2hlciBsZXZlbCB0cmFuc2Zvcm1hdGlvbiBwYXR0ZXJucyBiZWNvbWUgZWFz
aWVyIHRvIGFjY2VwdAo+PiBieSBhbnkgb3RoZXIgbWVhbnM/Cj4gCj4gT25seSBpZiBpdCdzIGFz
c3VyZWQgdG8gd29yayBhbmQgbm90IHRvIGJyZWFrIGFueXRoaW5nIGVsc2UuCgpIYXZlIHlvdSBn
b3QgYW55IHN0ZXBzIGluIG1pbmQgZm9yIGFuIGltcHJvdmVkIOKAnGZlZWxpbmfigJ0gb3Ig4oCc
YXNzdXJhbmNl4oCdPwoKCj4+IEhvdyBtdWNoIGRvZXMgdGhlIG9taXNzaW9uIG9mIHN1Y2ggYW4g
dXNlZnVsIGRldmVsb3BtZW50IHRvb2wKPj4gaW5mbHVlbmNlIHlvdXIgY29uY2VybnM/Cj4gCj4g
Q2FuJ3QganVkZ2UgdW5sZXNzIEkgcmVhbGx5IHNlZSAvIHVzZSBpdC4KCkkgZmluZCB0aGF0IHRo
ZXJlIGFyZSBzb21lIG9wdGlvbnMgdG8gY29uc2lkZXIuCgoKPj4gV291bGQgeW91IGxpa2UgdG8g
aW1wcm92ZSB0aGUgc29mdHdhcmUgc2l0dWF0aW9uIGluIGFueSB3YXlzIHRoZXJlPwo+IAo+IEkg
KmhvcGUqLCBidXQgb25seSB3aGVuIGl0J3Mgbm90IHRvbyBhbm5veWluZy4KClVuZGVyIHdoaWNo
IGNpcmN1bXN0YW5jZXMgYXJlIHlvdSBnb2luZyB0byBzdGFydCB3b3JraW5nIHdpdGggYSBjb250
aW51b3VzCmludGVncmF0aW9uIHN5c3RlbT8KClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlz
dApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
