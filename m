From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Bug report: [alsa-sink-USB Audio] alsa-sink.c:
 Most likely this is a bug in the ALSA driver '(null)'. Please report this
 issue to the ALSA
Date: Fri, 30 May 2014 20:17:33 +0800
Message-ID: <CAN8cciai28P9Q7iYpt3EDhnUpRJeXtAtPNSD2FnsHR=jdzf0Cw@mail.gmail.com>
References: <001401cf7818$4be327c0$e3a97740$@lucidpixels.com>
 <CAN8cciZwbNVu7LO_muaynfbudxTB8qRS0aPyxwnd28yupCxSEA@mail.gmail.com>
 <001201cf7be2$dfbb1980$9f314c80$@lucidpixels.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f51.google.com (mail-qg0-f51.google.com
 [209.85.192.51])
 by alsa0.perex.cz (Postfix) with ESMTP id B21182619FB
 for <alsa-devel@alsa-project.org>; Fri, 30 May 2014 14:17:34 +0200 (CEST)
Received: by mail-qg0-f51.google.com with SMTP id q107so5055715qgd.10
 for <alsa-devel@alsa-project.org>; Fri, 30 May 2014 05:17:33 -0700 (PDT)
In-Reply-To: <001201cf7be2$dfbb1980$9f314c80$@lucidpixels.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Pgo+Cj4KPiBBcyByZXF1ZXN0ZWTigJQKPgo+Cj4KPiBodHRwOi8vaG9tZS5jb21jYXN0Lm5ldC9+
anBpc3pjei8yMDE0MDUzMC9sc3VzYi12dnZ2LnR4dAo+Cj4gaHR0cDovL2hvbWUuY29tY2FzdC5u
ZXQvfmpwaXN6Y3ovMjAxNDA1MzAvZnVsbC1wdWxzZS1hdWRpby1sb2cudHh0CgpZb3VyIGxvZyBp
cyB1c2VsZXNzCgpZb3UgaGF2ZSB0byBjaGFuZ2UgbG9nLWluZm89ZGVidWcgaW4gZGFlbW9uLmNv
bmYgYW5kIHJlc3RhcnQgcHVsc2VhdWRpbwoKaHR0cHM6Ly9idWd6aWxsYS5yZWRoYXQuY29tL3No
b3dfYnVnLmNnaT9pZD0xMDY1MDk3Cgo+Cj4gaHR0cDovL2hvbWUuY29tY2FzdC5uZXQvfmpwaXN6
Y3ovMjAxNDA1MzAvYWxzYS1pbmZvLnR4dAoKVVNCIE1peGVyOiB1c2JfaWQ9MHgwZDhjMDAwOCwg
Y3RybGlmPTAsIGN0bGVycj0wCkNhcmQ6IEMtTWVkaWEgVVNCIEF1ZGlvIERldmljZSBhdCB1c2It
MDAwMDowMDoxZC4wLTEuMS4xLCBmdWxsIHNwZWVkCiAgVW5pdDogOQogICAgQ29udHJvbDogbmFt
ZT0iU3BlYWtlciBQbGF5YmFjayBWb2x1bWUiLCBpbmRleD0wCiAgICBJbmZvOiBpZD05LCBjb250
cm9sPTIsIGNtYXNrPTB4MywgY2hhbm5lbHM9MiwgdHlwZT0iUzE2IgogICAgVm9sdW1lOiBtaW49
LTcyNjQsIG1heD0tMTYsIGRCbWluPS0yODM3LCBkQm1heD0tNgoKeW91ciBVU0IgYXVkaW8gZGV2
aWNlIGFyZSB1bmxpa2VseSB0byBwcm92aWRlIDI4LjMxLzcyNDggZEIgcGVyIHN0ZXAKCmh0dHA6
Ly93d3cuZnJlZWRlc2t0b3Aub3JnL3dpa2kvU29mdHdhcmUvUHVsc2VBdWRpby9CYWNrZW5kcy9B
TFNBL0RlY2liZWwvCgpJZiBoYXJkd2FyZSB2b2x1bWUgY29udHJvbCBhbHdheXMgbGVzcyB0aGFu
ICAwZEIKUHVsc2VhdWRpbyBuZWVkIHRvIHVzZSBzb2Z0d2FyZSB2b2x1bWUgKEdBSU4pIGZvciAg
UEFfVk9MVU1FX05PUk0gd2hlbgp2b2x1bWUgc2xpZGVyIGlzIGF0IG1heGltdW0sIHNvZnR3YXJl
IHZvbHVtZSBuZWVkIHJld2luZCBvZiBhdWRpbyBkYXRhIGluCnNvdW5kIGNhcmQgYnVmZmVyIGZv
ciByZWNhbHVsYXRpb24gd2hlbiB5b3UgY2hhbmdlIHZvbHVtZSBzbGlkZXIKCj4KPiDDmCAgc3Rl
cCB0byByZXByb2R1Y2UgeW91ciBwcm9ibGVtIHdoZW4geW91IHJlcG9ydCB0aGUgYnVnCj4KPgo+
Cj4gSSBvZnRlbiBTU0ggdG8gbXkgbWFjaGluZSBvciB1c2UgWCByZW1vdGVseSBhbmQgbm90IGxv
Y2FsbHnigJQgdGhpcyBpcyB0aGUKZmlyc3QgdGltZSBJIGhhdmUgc2VlbiB0aGlzIGluIGxvZ3Mg
dGhhdCBJIGNhbiByZW1lbWJlciBhbmQgSeKAmXZlIG5vdApjaGFuZ2VkIGFueXRoaW5nIGxvY2Fs
bHkuCj4KPgoKCmh0dHBzOi8vYnVncy5mcmVlZGVza3RvcC5vcmcvc2hvd19idWcuY2dpP2lkPTQ2
MjM2CgpUaGUgd29ya2Fyb3VuZCBzZWVtIHRvIHVzZSBpZ25vcmVfZEI9MQpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlz
dApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
