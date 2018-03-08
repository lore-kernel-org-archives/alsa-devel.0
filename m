From: Nicolai Stange <nstange@suse.de>
Subject: Re: [PATCH 2/2] ALSA: seq: More protection for
	concurrent write and ioctl races
Date: Thu, 08 Mar 2018 11:38:30 +0100
Message-ID: <87371akg2h.fsf@suse.de>
References: <20180308071856.12149-1-tiwai@suse.de>
 <20180308071856.12149-3-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A0FD2673D6
 for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2018 11:38:32 +0100 (CET)
In-Reply-To: <20180308071856.12149-3-tiwai@suse.de> (Takashi Iwai's message of
 "Thu, 8 Mar 2018 08:18:56 +0100")
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
Cc: alsa-devel@alsa-project.org, Miroslav Benes <mbenes@suse.cz>, =?utf-8?B?6IyD6b6Z6aOe?= <long7573@126.com>, Nicolai Stange <nstange@suse.de>
List-Id: alsa-devel@alsa-project.org

VGFrYXNoaSBJd2FpIDx0aXdhaUBzdXNlLmRlPiB3cml0ZXM6Cgo+IFRoaXMgcGF0Y2ggaXMgYW4g
YXR0ZW1wdCBmb3IgZnVydGhlciBoYXJkZW5pbmcgYWdhaW5zdCByYWNlcyBiZXR3ZWVuCj4gdGhl
IGNvbmN1cnJlbnQgd3JpdGUgYW5kIGlvY3Rscy4gIFRoZSBwcmV2aW91cyBmaXggZDE1ZDY2MmU4
OWZjCj4gKCJBTFNBOiBzZXE6IEZpeCByYWN5IHBvb2wgaW5pdGlhbGl6YXRpb25zIikgY292ZXJl
ZCB0aGUgcmFjZSBvZiB0aGUKPiBwb29sIGluaXRpYWxpemF0aW9uIGF0IHdyaXRlciBhbmQgdGhl
IHBvb2wgcmVzaXplIGlvY3RsIGJ5IHRoZQo+IGNsaWVudC0+aW9jdGxfbXV0ZXggKENWRS0yMDE4
LTEwMDAwMDQpLiAgSG93ZXZlciwgYmFzaWNhbGx5IHRoaXMgbXV0ZXgKPiBzaG91bGQgYmUgYXBw
bGllZCBtb3JlIHdpZGVseSB0byB0aGUgd2hvbGUgd3JpdGUgb3BlcmF0aW9uIGZvcgo+IGF2b2lk
aW5nIHRoZSB1bmV4cGVjdGVkIHBvb2wgb3BlcmF0aW9ucyBieSBhbm90aGVyIHRocmVhZC4KPgo+
IFRoZSBvbmx5IGNoYW5nZSBvdXRzaWRlIHNuZF9zZXFfd3JpdGUoKSBpcyB0aGUgYWRkaXRpb25h
bCBtdXRleAo+IGFyZ3VtZW50IHRvIGhlbHBlciBmdW5jdGlvbnMsIHNvIHRoYXQgd2UgY2FuIHVu
bG9jayAvIHJlbG9jayB0aGUgZ2l2ZW4KPiBtdXRleCB0ZW1wb3JhcmlseSBkdXJpbmcgc2NoZWR1
bGUoKSBjYWxsIGZvciBibG9ja2luZyB3cml0ZS4KPgo+IEZpeGVzOiBkMTVkNjYyZTg5ZmMgKCJB
TFNBOiBzZXE6IEZpeCByYWN5IHBvb2wgaW5pdGlhbGl6YXRpb25zIikKPiBSZXBvcnRlZC1ieTog
6IyD6b6Z6aOeIDxsb25nNzU3M0AxMjYuY29tPgo+IFJlcG9ydGVkLWJ5OiBOaWNvbGFpIFN0YW5n
ZSA8bnN0YW5nZUBzdXNlLmRlPgo+IENjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4KPiBTaWdu
ZWQtb2ZmLWJ5OiBUYWthc2hpIEl3YWkgPHRpd2FpQHN1c2UuZGU+Cj4gLS0tCgpSZXZpZXdlZC1h
bmQtdGVzdGVkLWJ5OiBOaWNvbGFpIFN0YW5nZSA8bnN0YW5nZUBzdXNlLmRlPgoKCi0tIApTVVNF
IExpbnV4IEdtYkgsIEdGOiBGZWxpeCBJbWVuZMO2cmZmZXIsIEphbmUgU21pdGhhcmQsIEdyYWhh
bSBOb3J0b24sCkhSQiAyMTI4NCAoQUcgTsO8cm5iZXJnKQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRl
dmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWls
bWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
