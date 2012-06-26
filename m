From: Roberto Nibali <rnibali@gmail.com>
Subject: Re: [PATCH] ASoC: tlv320aic3x: add missing registers
	and bits
Date: Tue, 26 Jun 2012 16:56:27 +0200
Message-ID: <CAONxwYPutt+Tqtt6dKgS1x-c17_czu0_r+hBwQR262sYgzxgdg@mail.gmail.com>
References: <4FE9AD5F.7080302@aksignal.cz>
	<20120626132117.GV30406@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gg0-f179.google.com (mail-gg0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 0A2AF1042D3
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Jun 2012 16:56:50 +0200 (CEST)
Received: by ggnk3 with SMTP id k3so3832250ggn.38
	for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2012 07:56:48 -0700 (PDT)
In-Reply-To: <20120626132117.GV30406@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: vbarinov@embeddedalley.com, alsa-devel@alsa-project.org, sudhakar.raj@ti.com, =?ISO-8859-2?Q?Prchal_Ji=F8=ED?= <jiri.prchal@aksignal.cz>, nsekhar@ti.com, peter.ujfalusi@ti.com, mr.swami.reddy@ti.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

SGkKCk15IHR3byBjZW50cyBvbiB0aGlzOgoKT24gVHVlLCBKdW4gMjYsIDIwMTIgYXQgMzoyMSBQ
TSwgTWFyayBCcm93bgo8YnJvb25pZUBvcGVuc291cmNlLndvbGZzb25taWNyby5jb20+IHdyb3Rl
Ogo+IE9uIFR1ZSwgSnVuIDI2LCAyMDEyIGF0IDAyOjM4OjU1UE0gKzAyMDAsIFByY2hhbCBKacWZ
w60gd3JvdGU6Cj4+IFRoaXMgcGF0Y2ggYWRkcyBtaXNzaW5nIHJlZ2lzdGVycyBhbmQgYml0cyBm
b3IgVExWMzIwQUlDMzEwNi4KPgo+PiDCoHN0YXRpYyBjb25zdCB1OCBhaWMzeF9yZWdbQUlDM1hf
Q0FDSEVSRUdOVU1dID0gewo+PiAtIMKgIMKgIDB4MDAsIDB4MDAsIDB4MDAsIDB4MTAsIC8qIDAg
Ki8KPgo+PiArIMKgIMKgIDB4MDAsIDB4MDAsIDB4MDAsIDB4MTAsIDB4MDQsIDB4MDAsIDB4MDAs
IDB4MDAsIC8qIDAgKi8KPgo+IFRoaXMgaXMgZXNzZW50aWFsbHkgaW1wb3NzaWJsZSB0byByZXZp
ZXcgYXMgeW91J3ZlIG5vdCBzYWlkIHdoYXQncyBiZWluZwo+IGZpeGVkIGFuZCBoYXZlIGNvbXBs
ZXRlbHkgcmVmb3JtYXR0ZWQgdGhlIHRhYmxlIHNvIHRoZSBkaWZmIGRvZXNuJ3QKPiBoaWdobGln
aHQgdGhlIGNoYW5nZXMgYXQgYWxsLiDCoFdoYXQncyB3cm9uZyBhbmQgd2hhdCBpcyB0aGUgY2hh
bmdlCj4gZml4aW5nPwoKVGhpcyBpcyBtZXJlbHkgYSBtYXRjaCB0byB0aGUgZGF0YSBzaGVldCBv
ZiB2YXJpb3VzIFRMVjMyMEFJQzMxMHgKY29kZWNzLiBJJ3ZlIHBsYW5uZWQgb24gc3VibWl0dGlu
ZyBhbG1vc3QgdGhlIHNhbWUgcGF0Y2ggYSBjb3VwbGUgb2YKbW9udGhzIGFnby4gVGhlIHJlZm9y
bWF0dGluZyB0byBteSBhdmFpbCBhZGRzIHRvIHJlYWRhYmlsaXR5LCBubwp2YWx1ZXMgYXJlIGNo
YW5nZWQuIE9ubHkgYSBjb3VwbGUgb2YgMHgwMCBhcmUgYWRkZWQgZm9yIHRoZSBtaXNzaW5nCmFk
ZGl0aW9uYWwgcmVnaXN0ZXJzIGFuZCBhdCBsZWFzdCB0aGUgVExWMzIwQUlDMzEwMSBhbmQgdGhl
ClRMVjMyMEFJQzMxMDYsIHdoaWNoIGVzc2VudGlhbGx5IHdlcmUgbm90IGluaXRpYWxpemVkIGJl
Zm9yZS4KCk9uIHRoZSBvdGhlciBoYW5kIHRoZXJlIGlzIG5vdGhpbmcgZm9yIHBhZ2UgMSBpbiB0
aGlzIGRyaXZlciwgc2luY2UKbW9zdCBwcm9iYWJseSB0aGVyZSBhcmUgbm8gdXNlcnMgb2YgcmVn
aXN0ZXJzID4gMTAyIG9yIHBhZ2UgMS4KCkNoZWVycwpSb2JlcnRvCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFs
c2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3Jn
L21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
