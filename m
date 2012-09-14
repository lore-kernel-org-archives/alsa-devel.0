From: Lee Jones <lee.jones@linaro.org>
Subject: Re: FW: [PATCH 07/22] ASoC: Ux500: Initialise PCM from
 MSP probe rather than as a device
Date: Fri, 14 Sep 2012 14:09:06 +0100
Message-ID: <20120914130904.GB12893@gmail.com>
References: <014401cd8165$99960c40$ccc224c0$@se>
 <50377C0D.2060905@stericsson.com>
 <20120827163337.GC4339@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 3824C262639
 for <alsa-devel@alsa-project.org>; Fri, 14 Sep 2012 15:09:11 +0200 (CEST)
Received: by eeke50 with SMTP id e50so2140343eek.38
 for <alsa-devel@alsa-project.org>; Fri, 14 Sep 2012 06:09:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120827163337.GC4339@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: roger.xr.nilsson@stericsson.com, Ola Lilja <ola.o.lilja@stericsson.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

T24gTW9uLCBBdWcgMjcsIDIwMTIgYXQgMDk6MzM6MzhBTSAtMDcwMCwgTWFyayBCcm93biB3cm90
ZToKPiBPbiBGcmksIEF1ZyAyNCwgMjAxMiBhdCAwMzowNToxN1BNICswMjAwLCBPbGEgTGlsamEg
d3JvdGU6Cj4gCj4gPiBJIGhhdmVuJ3QgZm9sbG93ZWQgZXZlcnl0aGluZyBpbiB0aGlzIGRpc2N1
c3Npb24sIGJ1dCB3aGF0IEkgbWVhbnQgaW4gYW4gZWFybGllcgo+ID4gbWFpbCB3YXMgdGhhdCB1
c2luZyB0aGUgZGV2aWNlIGZvciBwbGF0Zm9ybS1EQUkgKE1TUF9JMlMpIGFsc28KPiA+IGFzIHBs
YXRmb3JtIGludCB0aGUgREFJLWxpbmsgc3RydWN0IGlzIG5vdCBhbnl0aGluZyBJIGNhbiBzZWUg
Zml0IChhcyBpbiB0aGUKPiA+IHBhdGNoIExlZSBmaXJzdCBzdWJtaXR0ZWQpLgo+IAo+IEknbSBu
b3Qgc3VyZSBJIGZ1bGx5IHVuZGVyc3RhbmQgdGhlIGFib3ZlIC0gSSBkaWRuJ3Qgbm90aWNlIGFu
eXRoaW5nCj4gd2l0aCB0aGUgZGFpIGxpbmtzIGJ1dCBJIGhhdmUgdG8gc2F5IHRoYXQgSSBjb3Vs
ZCd2ZSBsb29rZWQgbW9yZSBjbG9zZWx5Cj4gYXMgSSB3YXMgd2FpdGluZyBmb3IgQVJNIHNpZGUg
cmV2aWV3cy4KPiAKPiA+IEkgY2FuIHNlZSBhIGZldyBhY2NlcHRhYmxlIHNvbHV0aW9uczoKPiA+
IDEpIFVzZSBpdCBhcyBpdCBpcyEgKEEgdmlydHVhbCBkZXZpY2UgZm9yIFBDTSBpcyBjcmVhdGVk
IGluIGFyY2gvYXJtIGFuZCB0aGUKPiA+IHByb2JlIGlzIGludm9rZWQgZnJvbSB0aGUgbWFjaGlu
ZS1kcml2ZXIpLgo+ID4gMikgU2luY2UgdGhlIGFjdHVhbCBwbGF0Zm9ybSBpcyB0aGUgRE1BLWJs
b2NrLCBtYXliZSB0aGVyZSBpcyBzb21lIHdheSBvZiBtYWtpbmcKPiA+IHRoZSBkZXZpY2UgIm5v
bi12aXJ0dWFsIiBieSBoYXZpbmcgc29tZSBzdWItZGV2aWNlIGluIHRoZSBETUEtZHJpdmVyIHRo
YXQgaXMKPiA+IGluc3RlYWQgdHJpZ2dlcmVkIGluIHRoZSBzYW1lIHdheSBhcyBpbiAxKS4KPiAK
PiBUaGUgb3B0aW9uIHdlJ3JlIHVzaW5nIGlzIGVzc2VudGlhbGx5IHlvdXIgb3B0aW9uIDIgYnV0
IGRvaW5nIGl0IGZyb20KPiB0aGUgREFJIGRyaXZlciByYXRoZXIgdGhhbiBmcm9tIHRoZSBETUEg
ZHJpdmVyIChrZWVwaW5nIHRoaW5ncyBpbiB0aGUKPiBhdWRpbyBzdWJzeXN0ZW0gc2luY2UgaXQn
cyBhbiBhdWRpbyBzcGVjaWZpYyBpc3N1ZSkuCgpPbGEgY291bGQgeW91IHBsZWFzZSByZXBseSB0
byB0aGlzLiBXaXRob3V0IHlvdXIgQWNrIHRoaXMgaXMgb3VyIGJpZ2dlc3QKYmxvY2tlci4gVGhl
cmUgYXJlIG90aGVyIGF1ZGlvIGRyaXZlcnMgd2hpY2ggZG8gaXQgdGhpcyB3YXkgYWxyZWFkeS4g
V2UKYXJlIGFscmVhZHkgZG9pbmcgc29tZXRoaW5nIHlvdSBzdWdnZXN0ZWQsIGp1c3QgaW4gYSBz
bGlnaHRseSBkaWZmZXJlbnQKKG1vcmUgY29udGFpbmVkKSB3YXkuCgpQbGVhc2UgcmVzcG9uZC4K
CktpbmQgcmVnYXJkcywKTGVlCgotLSAKTGVlIEpvbmVzCkxpbmFybyBTVC1Fcmljc3NvbiBMYW5k
aW5nIFRlYW0gTGVhZApMaW5hcm8ub3JnIOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQVJN
IFNvQ3MKRm9sbG93IExpbmFybzogRmFjZWJvb2sgfCBUd2l0dGVyIHwgQmxvZwpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcg
bGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9q
ZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
