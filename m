From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: Bug in setting channels,
	related to recent ELD/EDID changes?
Date: Tue, 4 Jan 2011 18:46:13 +0000
Message-ID: <AANLkTi=0uVQwsd-cWpZSfRuBVZjh7oRsLXpe_kuLP5Hq@mail.gmail.com>
References: <AANLkTikneYHc9NmrRW41=xRBW_PVgc0jqdcOaTgHcC-t@mail.gmail.com>
	<4D12E292.9050204@iki.fi>
	<AANLkTimxHsUS_zVm0_m-vUcwt4vupUAf-vRhH5VWLwoy@mail.gmail.com>
	<4D20508C.7070609@iki.fi>
	<AANLkTimHu0QS-t=JroWy4j0vts0wjq_R4m4VrGpmu-sb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
	[209.85.216.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 375C22437E
	for <alsa-devel@alsa-project.org>; Tue,  4 Jan 2011 19:46:15 +0100 (CET)
Received: by qyj19 with SMTP id 19so14513671qyj.17
	for <alsa-devel@alsa-project.org>; Tue, 04 Jan 2011 10:46:13 -0800 (PST)
In-Reply-To: <AANLkTimHu0QS-t=JroWy4j0vts0wjq_R4m4VrGpmu-sb@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: VDR User <user.vdr@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Anssi Hannula <anssi.hannula@iki.fi>, "mailing list: alsa-dev" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

T24gNCBKYW51YXJ5IDIwMTEgMTY6NDEsIFZEUiBVc2VyIDx1c2VyLnZkckBnbWFpbC5jb20+IHdy
b3RlOgo+Pgo+PiBBL1YgcmVjZWl2ZXJzIHNob3dpbmcgVFYgaW5mb3JtYXRpb24gaXMgaW5kZWVk
IHNvbWV0aGluZyB0aGF0IHdhc24ndAo+PiB0aG91Z2h0IGFib3V0IDooCj4KPiBUaGlzIGhhcyBj
ZXJ0YWlubHkgY2F1c2VkIHByb2JsZW1zLiDCoEFueW9uZSB0aG91Z2h0IG9mIGEgd2F5IHRvCj4g
cmVzb2x2ZSBpdCwgb3IgYmV0dGVyIHlldCByZXZlcnNlZCB0aGUgcGF0Y2ggdGhhdCBjcmVhdGVk
IHRoZQo+IHNpdHVhdGlvbj8KPgoKSSB0aGluayB0aGlzIGlzIHJlbGF0ZWQgdG8gZ2VuZXJhbCBo
b3QtcGx1ZyBzdXBwb3J0IGluIEFMU0EuCklmIHlvdSBwbHVnIGluIGEgVVNCIHNwZWFrZXJzLCBB
TFNBIHNob3VsZCBkZXRlY3QgbmV3IHNwZWFrZXJzIGFuZApoYXZlIGEgd2F5IG9mIGluZm9ybWlu
ZyBhcHBsaWNhdGlvbnMgYWJvdXQgaXQuCldoZW4geW91IHVucGx1ZyBVU0Igc3BlYWtlcnMsIEFM
U0Egc2hvdWxkIGRldGVjdCB0aGUgbGFjayBvZiBzcGVha2VycwphbmQgaGF2ZSBhIHdheSBvZiBp
bmZvcm1pbmcgYXBwbGljYXRpb24gYWJvdXQgaXQuCkluIHRoZSBzYW1lIHdheSB0aGUgaWYgeW91
IHBvd2VyIG9uIGEgSERNSSBhbXAsIGluc3RlYWQgb2YganVzdCB0d28Kc3BlYWtlcnMgKGluIHRo
ZSBUViksIHdlIG5vdyBoYXZlIDUuMSBzcGVha2Vycy4KQUxTQSBzaG91bGQgaGF2ZSBhIHdheSB0
byBpbmZvcm0gYXBwbGljYXRpb25zIG9mIHRoZSBjaGFuZ2VzLgoKSSBkbyBub3QgdGhpbmsgQUxT
QSBhbG9uZSBjYW4gaGFuZGxlIHRoZXNlIGhvdCBwbHVnL3VucGx1ZyBldmVudHMuIEl0CmhhcyB0
byBiZSBhcHBsaWNhdGlvbnMgdGhhdCBhcmUgbWFkZSB0byB1bmRlcnN0YW5kIHRoZXNlIGV2ZW50
cyBhbmQKYWRqdXN0IGFjY29yZGluZ2x5LgpCZWZvcmUgbm93LCBBTFNBIGhhcyBoYWQgdG8gYmUg
dG9sZCBtYW51YWxseSBob3cgbWFueSBzcGVha2VycyBhIHVzZXIKaGFzIGF0dGFjaGVkLCBFLmcu
IFN0ZXJlbywgNS4xIGV0Yy4KV2l0aCBtb2Rlcm4gc291bmQgZGV2aWNlcywgdGhpcyBpbmZvcm1h
dGlvbiBpcyBhdmFpbGFibGUgYXV0b21hdGljYWxseQpmcm9tIHRoZSBoYXJkd2FyZSBhbmQgY2hh
bmdlcyB3aXRob3V0IG5vdGljZS4KClNvLCBJIHByb3Bvc2UgdGhhdCBhbiBBUEkgc2hvdWxkIGJl
IGFkZGVkIHRvIGFjaGlldmUgdGhpcy4KU28sIGluc3RlYWQgb2YgdGhlIGFwcGxpY2F0aW9uIHNl
dHRpbmcgdGhlIHNwZWFrZXIgYXJyYW5nZW1lbnQsIHRoZQpzcGVha2VyIGFycmFuZ2VtZW50IGlz
IHNldCBpbiBBTFNBLCBhbmQgdGhlIGFwcGxpY2F0aW9uIHJlcXVlc3RzCmluZm9ybWF0aW9uIGFi
b3V0IGl0LgpXaGVuIHRoZSBhcHBsaWNhdGlvbiB3cml0ZXMgc291bmQgc2FtcGxlcyB0byB0aGUg
c291bmQgY2FyZCBhbmQgdGhlCnNwZWFrZXIgYXJyYW5nZW1lbnQgaGFzIGNoYW5nZWQsIEFMU0Eg
c2hvdWxkIHVzZSBhIHNwZWNpZmljIGVycm9yCm51bWJlciByZXBvcnRlZCBiYWNrIHNvIHRoZSBh
cHBsaWNhdGlvbiBrbm93cyB0aGF0IGl0IHNob3VsZCByZS1jaGVjawp0aGUgc3BlYWtlci1hcnJh
bmdlbWVudCBBUEkgYW5kIHJlLW9wZW4gdGhlIHNvdW5kIGNhcmQgd2l0aCB0aGUgbmV3CmRldGFp
bHMuCgpLaW5kIFJlZ2FyZHMKCkphbWVzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1w
cm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGlu
Zm8vYWxzYS1kZXZlbAo=
