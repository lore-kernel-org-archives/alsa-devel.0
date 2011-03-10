From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [Device-drivers-devel] [PATCH] Add driver for
 Analog Devices ADAU1701 SigmaDSP
Date: Wed, 9 Mar 2011 19:35:48 -0500
Message-ID: <AANLkTinhm3t5TRRXnArzA=H23JOsAMCDwPUPp6aYi1gW@mail.gmail.com>
References: <1299460302-15392-1-git-send-email-cliff.cai@analog.com>
	<20110307114142.GB13471@opensource.wolfsonmicro.com>
	<AANLkTikynw7vCsqqyNZW-LFuGUKKQEtG3s4YCZjpOvko@mail.gmail.com>
	<20110307121502.GG13471@opensource.wolfsonmicro.com>
	<AANLkTinKpvgBokSHpsVf1KVX+m6sD0Xp_dFe8Y+HzY-7@mail.gmail.com>
	<AANLkTik=wEyCEY5xsrdGJw6t_VHH9ByKt4mX348P8uD7@mail.gmail.com>
	<20110309100055.GB6923@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id D83281039A5
	for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2011 01:36:09 +0100 (CET)
Received: by iwc10 with SMTP id 10so1091586iwc.38
	for <alsa-devel@alsa-project.org>; Wed, 09 Mar 2011 16:36:08 -0800 (PST)
In-Reply-To: <20110309100055.GB6923@opensource.wolfsonmicro.com>
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
Cc: cliff.cai@analog.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, akpm@linux-foundation.org, Cliff Cai <cliffcai.sh@gmail.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCBNYXIgOSwgMjAxMSBhdCAwNTowMCwgTWFyayBCcm93biB3cm90ZToKPiBPbiBXZWQs
IE1hciAwOSwgMjAxMSBhdCAwMzoyNTowNVBNICswODAwLCBDbGlmZiBDYWkgd3JvdGU6Cj4+IE9u
IE1vbiwgTWFyIDcsIDIwMTEgYXQgODoyOSBQTSwgTWlrZSBGcnlzaW5nZXIgd3JvdGU6Cj4+ID4g
aSBkb250IHNlZSB0aGUgaXNzdWUgaGVyZS4gwqB0aGUgZmlybXdhcmUgaXMgKm9wdGlvbmFsKiBh
bmQgZG9lcyBub3QKPj4gPiBpbXBhaXIgYmFzaWMgYXVkaW8gb3V0cHV0LiDCoGZ1cnRoZXIsIHRo
ZSBmaXJtd2FyZSBpcyBmdWxseQo+PiA+IHdyaXR0ZW4vY29tcGlsZWQvbWFpbnRhaW5lZCBieSB0
aGUgZW5kIGN1c3RvbWVyLCBqdXN0IGxpa2UgdGhlCj4+ID4gYXBwbGljYXRpb24uIMKgd2hpY2gg
bWVhbnMgdGhlcmUgaXMgbm8gIm1hZ2ljIiBoZXJlIC0tIHRoZSBlbmQgY3VzdG9tZXIKPj4gPiBp
cyB0aGUgd2l6YXJkLgo+Pgo+PiBpdCdzIGEgRFNQLHNvIGZpcm13YXJlIGlzIG5vdCBvcHRpb25h
bCxhY3R1YWxseSB0aGVyZSBpcyBkZWZhdWx0Cj4+IGludGVybmFsIHByb2dyYW0gY2FuIGJlIHVz
ZWQKPj4gaWYgbm8gZXh0ZXJuYWwgZmlybXdhcmUgaXMgZG93bmxvYWRlZCxvZiBjYXVzZSwgdGhl
IGludGVybmFsIHByb2dyYW0KPj4gaXMgb25seSB1c2VkIHRvIHRlc3QgYW5hbG9nIGF1ZGlvIHBh
c3MtdGhyb3VnaC4KPgo+IElmIHRoZXJlIGlzIGRlZmF1bHQgZmlybXdhcmUgdGhlbiBldmVuIGlm
IGl0J3Mgbm90IHBhcnRpY3VsYXJseSB1c2VmdWwKPiB0aGUga2VybmVsIHNob3VsZCBwcm9iYWJs
eSBub3QgKnJlcXVpcmUqIHRoYXQgYWRkaXRpb25hbCBmaXJtd2FyZSBpcwo+IHByb3ZpZGVkIGR1
cmluZyBkcml2ZXIgc3RhcnR1cCAtIHRoZSBzeXN0ZW0gbWF5IHdpc2ggdG8gd2FpdCB1bnRpbCBs
YXRlcgo+IGluIHRoZSBib290IHRvIHByb3ZpZGUgaXQsIGZvciBleGFtcGxlIGJlY2F1c2UgaXQg
bmVlZHMgdG8gbW91bnQgbWVkaWEKPiB0byBnZXQgdG8gdGhlIGZpcm13YXJlIG9yIGJlY2F1c2Ug
aXQgbmVlZHMgdG8gZG8gYWRkaXRpb25hbCB3b3JrIHRvCj4gZGVjaWRlIHdoYXQgZmlybXdhcmUg
aXMgcmVxdWlyZWQgZm9yIHRoZSBjdXJyZW50IHN5c3RlbSBzZXR1cC4KCnNvcnJ5LCBpIHdhcyB0
aGlua2luZyB0aGlzIHBhcnQgd2FzIGxpa2UgdGhlIG90aGVyIEFESSBvbmVzIHdoZXJlIHRoZQpE
U1AgaXMgdGhlcmUgYXMgYW4gZW5oYW5jZW1lbnQuICBzbyBtYW55IG9mIG15IGNvbW1lbnRzIHdl
cmUgdGFpbG9yZWQKdG93YXJkcyB0aGF0LgoKdGhlcmUgc2hvdWxkbnQgYmUgYW55IHByb2JsZW0g
d2l0aCB1cyBwcm92aWRpbmcgYSBzdHViIGZpcm13YXJlIHdpdGgKdGhlIGtlcm5lbCAoaW4gZmly
bXdhcmUvKSB0aGF0IHNpbXBseSBkb2VzIGEgInBhc3MgdGhyb3VnaCIgb3IKd2hhdGV2ZXIuCi1t
aWtlCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2Et
ZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFp
bG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
