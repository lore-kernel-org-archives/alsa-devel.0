From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [RFC] ymfpci - re-enable legacy audio after
	suspend resume
Date: Sun, 11 Mar 2012 07:37:30 +0800
Message-ID: <CAN8ccib6ki86e9At-umn6nPCLa-ub4E8Gv0p2gHp=ApeEy=Lvg@mail.gmail.com>
References: <CAN8ccibfK6Cpho5F5vk8jq_gbZQKp4_C3bMcZ6Ef4c+TU2=EBQ@mail.gmail.com>
	<s5h399jpohv.wl%tiwai@suse.de>
	<CAN8ccia-mdoS4w5FHN_0tPnuCzfi2HaDb4nhZ3TdvV-8OezBvA@mail.gmail.com>
	<s5hboo6nvq9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 49DCD24152
	for <alsa-devel@alsa-project.org>; Sun, 11 Mar 2012 00:37:32 +0100 (CET)
Received: by wibhn6 with SMTP id hn6so1705581wib.2
	for <alsa-devel@alsa-project.org>; Sat, 10 Mar 2012 15:37:30 -0800 (PST)
In-Reply-To: <s5hboo6nvq9.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

MjAxMi8zLzkgVGFrYXNoaSBJd2FpIDx0aXdhaUBzdXNlLmRlPjoKPiBBdCBGcmksIDkgTWFyIDIw
MTIgMDc6Mjg6MjYgKzA4MDAsCj4gUmF5bW9uZCBZYXUgd3JvdGU6Cj4+Cj4+IDIwMTIvMy84LCBU
YWthc2hpIEl3YWkgPHRpd2FpQHN1c2UuZGU+Ogo+PiA+IEF0IFRodSwgOCBNYXIgMjAxMiAxMjox
MjozMyArMDgwMCwKPj4gPiBSYXltb25kIFlhdSB3cm90ZToKPj4gPj4KPj4gPj4gU2luY2UgdGhl
IExlZ2FjeSBBdWRpbyBDb250cm9sIHJlZ2lzdGVyIGlzIHJlc2V0IHRvIGRlZmF1bHQgYWZ0ZXIK
Pj4gPj4gc3VzcGVuZCByZXN1bWUgY3ljbGUKPj4gPj4KPj4gPj4gbmVlZCB0byBlbmFibGUgdGhl
IExlZ2FjeSBBdWRpbyBDb250cm9sIEJpdCBpbiBvcmRlciB0byB1c2UgT1BMMyBGTSBTeW50aAo+
PiA+Pgo+PiA+PiBob3dldmVyIGl0IGlzIHN0aWxsIG5lZWQgdG8gdXNlIHNiaWxvYWQgwqBpbnN0
cnVtZW50IGxvYWRlciB0byByZWxvYWQKPj4gPj4gdGhlIGluc3RydW1lbnRzCj4+ID4KPj4gPiBJ
c24ndCBpdCBiZXR0ZXIgdG8gc2F2ZSBhbmQgcmVzdG9yZSB0aGVzZSBQQ0kgcmVnaXN0ZXJzIGxp
a2UgYmVsb3c/Cj4+ID4gSXQgc3RpbGwgZG9lc24ndCBzb2x2ZSB0aGUgbG9zdCBpbnN0cnVtZW50
IHByb2JsZW0sIHRob3VnaC4KPj4gPgo+Pgo+PiBJIG9ubHkgdXNlIHN0ZC5vMyBhbmQgZHJ1bXMu
bzMKPj4KPj4gSXQgc2VlbSB0aGF0IHRoZSBwbGF5YmFjayBvZiBtaWRpIHVzaW5nIGFwbGF5bWlk
aSBjYW4gcmVzdW1lIHBsYXliYWNrCj4+IGFmdGVyIHN1c3BlbmQgd2l0aCBteSB5bWY3MjRmCj4+
Cj4+IHNvIGl0IHNlZW0gdGhhdCB0aGVyZSBpcyBubyBuZWVkIHRvIHJlbG9hZCB0aGUgaW5zdHJ1
bWVudCB3aXRoIHlvdXIgcGF0Y2gKPj4KPj4gPgo+PiA+IC0tLQo+PiA+IGRpZmYgLS1naXQgYS9p
bmNsdWRlL3NvdW5kL3ltZnBjaS5oIGIvaW5jbHVkZS9zb3VuZC95bWZwY2kuaAo+PiA+IGluZGV4
IDQ0NGNkNmIuLjFlMzViMTYgMTAwNjQ0Cj4+ID4gLS0tIGEvaW5jbHVkZS9zb3VuZC95bWZwY2ku
aAo+PiA+ICsrKyBiL2luY2x1ZGUvc291bmQveW1mcGNpLmgKPj4gPiBAQCAtMzY2LDYgKzM2Niw4
IEBAIHN0cnVjdCBzbmRfeW1mcGNpIHsKPj4gPiDCoCNpZmRlZiBDT05GSUdfUE0KPj4gPiDCoCDC
oCB1MzIgKnNhdmVkX3JlZ3M7Cj4+ID4gwqAgwqAgdTMyIHNhdmVkX3lkc3hncl9tb2RlOwo+PiA+
ICsgwqAgdTE2IHNhdmVkX3NhdmVkX2RzeGdfbGVnYWN5Owo+PiA+ICsgwqAgdTE2IHNhdmVkX3Nh
dmVkX2RzeGdfZWxlZ2FjeTsKPj4KPj4KPj4gU2hvdWxkIGJlIHNhdmVkX2RzeGdfbGVnYWN5IGFu
ZCBzYXZlX2RzeGdfZWxlZ2FjeS4KPgo+IEVyciwgb2YgY291cnNlLgo+Cj4+IEhvdyBjYW4gdGhp
cyBjaGFuZ2UgYmFjayBwb3J0IHRvIDIuNiBrZXJuZWwgPwo+Cj4gSSBndWVzcyB0aGUgcGF0Y2gg
Y2FuIGJlIGFwcGxpZWQgYXMgaXMuIMKgVGhlcmUgaGF2ZSBiZWVuIG5vIGJpZyBjaGFuZ2VzCj4g
aW4gdGhhdCBkcml2ZXIgc2luY2UgYWdlcy4KPgo+CgpUaGlzIHBhdGNoIG1heSBiZSB1c2VsZXNz
IHdoZW4gb3NzIGlzIGRpc2FibGVkIGluIGtlcm5lbCAzLngKCmFwbGF5bWlkaSAtbApvcGVuIC9k
ZXYvc25kL3NlcSBmYWlsZWQ6IE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkKCml0IG9ubHkgaGFw
cGVuIHdpdGggc25kLXltZnBjaSAgd2hlbiB0aGVyZSBvc3MgaXMgZGlzYWJsZWQKCgogSSBjYW4g
c3RpbGwgdXNlIHdhdmV0YWJsZSBzeW50aCBvZiBzbmQtZW11MTBrMSBhZnRlciBJIHJlcGxhY2Vk
CnltZjcyNGYgd2l0aCBjdDQ3NjBwCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9q
ZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8v
YWxzYS1kZXZlbAo=
