From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 0/2 v4] ALSA: pcm: anonymous dup
	implementation
Date: Tue, 26 Mar 2019 15:41:11 +0100
Message-ID: <f5b429c6-803c-b624-6d39-5001c76e892f@perex.cz>
References: <20190204093910.23878-1-perex@perex.cz>
 <20190326140928.GC10898@sirena.org.uk> <s5hva0567vs.wl-tiwai@suse.de>
 <CACL=Q7we61BwO81W7tQFvb9ohkBZkk34DSXL2B-Ky2B6zfWk1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EEB80F801D9
 for <alsa-devel@alsa-project.org>; Tue, 26 Mar 2019 15:41:19 +0100 (CET)
In-Reply-To: <CACL=Q7we61BwO81W7tQFvb9ohkBZkk34DSXL2B-Ky2B6zfWk1A@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Phil Burk <philburk@google.com>, Takashi Iwai <tiwai@suse.de>
Cc: Zach Riggle <riggle@google.com>, ALSA development <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Baolin Wang <baolin.wang@linaro.org>, Leo Yan <leo.yan@linaro.org>
List-Id: alsa-devel@alsa-project.org

RG5lIDI2LiAwMy4gMTkgdiAxNToyNyBQaGlsIEJ1cmsgbmFwc2FsKGEpOgo+IEhlbGxvLAo+IAo+
IFRoYW5rcyBmb3Iga2VlcGluZ8KgdGhpcyBtb3ZpbmcgZm9yd2FyZC4KPiAKPiBBbnkgc3VnZ2Vz
dGlvbnMgZm9yIHRlc3RpbmcgdGhpcz8gV2UgY2FuIHRyeSB0byB0ZXN0IGl0IGhlcmUgaW4gQW5k
cm9pZC4gSXQgbWF5IGJlIHRyaWNreSBiZWNhdXNlIHlvdXIgcGF0Y2hlcyBtYXkgY29uZmxpY3Qg
d2l0aCBzb21lIHByb3ByaWV0YXJ5IFF1YWxjb21tIGNoYW5nZXMgaW4gdGhlIGtlcm5lbCB3ZSBh
cmUgY3VycmVudGx5IHVzaW5nLgo+IAo+IENhbiBJIGdldCBhIHN1bW1hcnkgbGlzdCBvZiB0aGUg
cGF0Y2hlcyByZXF1aXJlZCBmb3Iga2VybmVsIGFuZCB0aW55YWxzYT8KClRoZSB2NiBpcyB0aGUg
bGFzdCB2ZXJzaW9uLCB0aGUgZnVsbCBpbmZvcm1hdGlvbiBpcyBpbiB0aGUgY292ZXIgbGV0dGVy
OgoKaHR0cHM6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvcGlwZXJtYWlsL2Fsc2EtZGV2ZWwv
MjAxOS1GZWJydWFyeS8xNDUxMjcuaHRtbApodHRwczovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9y
Zy9waXBlcm1haWwvYWxzYS1kZXZlbC8yMDE5LUZlYnJ1YXJ5LzE0NTEyOC5odG1sCmh0dHBzOi8v
bWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL3BpcGVybWFpbC9hbHNhLWRldmVsLzIwMTktRmVicnVh
cnkvMTQ1MTI5Lmh0bWwKaHR0cHM6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvcGlwZXJtYWls
L2Fsc2EtZGV2ZWwvMjAxOS1GZWJydWFyeS8xNDUxMzAuaHRtbAoKCQkJCQkJSmFyb3NsYXYKCj4g
Cj4gVGhhbmtzLAo+IFBoaWwgQnVyawo+IAo+IAo+IE9uIFR1ZSwgTWFyIDI2LCAyMDE5IGF0IDc6
MTMgQU0gVGFrYXNoaSBJd2FpIDx0aXdhaUBzdXNlLmRlIDxtYWlsdG86dGl3YWlAc3VzZS5kZT4+
IHdyb3RlOgo+IAo+ICAgICBPbiBUdWUsIDI2IE1hciAyMDE5IDE1OjA5OjI4ICswMTAwLAo+ICAg
ICBNYXJrIEJyb3duIHdyb3RlOgo+ICAgICA+Cj4gICAgID4gT24gTW9uLCBGZWIgMDQsIDIwMTkg
YXQgMTA6Mzk6MDhBTSArMDEwMCwgSmFyb3NsYXYgS3lzZWxhIHdyb3RlOgo+ICAgICA+ID4gVGhp
cyBwYXRjaHNldCBjb250YWlucyB0aGUgYW5vbnltb3VzIGR1cCBpbXBsZW1lbnRhdGlvbiB3aXRo
IHBlcm1pc3Npb25zCj4gICAgID4gPiBjaGVja2luZyBmb3IgdGhlIEFMU0EncyBQQ00gaW50ZXJm
YWNlIGluIGtlcm5lbCB0byBlbmFibGUgdGhlIHJlc3RyaWN0ZWQKPiAgICAgPiA+IERNQSBzb3Vu
ZCBidWZmZXIgc2hhcmluZyBmb3IgdGhlIHJlc3RyaWN0ZWQgdGFza3MuCj4gICAgID4KPiAgICAg
PiBJcyB0aGVyZSBhbnkgbmV3cyBvbiBtZXJnaW5nIHRoaXMgZHVyaW5nIHRoZSBjdXJyZW50IGRl
dmVsb3BtZW50IGN5Y2xlLAo+ICAgICA+IG9yIGFueXRoaW5nIGVsc2UgbmVlZGVkIHRvIG1vdmUg
dGhpcyBmb3J3YXJkcz8KPiAKPiAgICAgSSd2ZSBzZWVuIG5vIHJlYWN0aW9uIHdoZXRoZXIgdGhl
IHBhdGNoIHJlYWxseSB0ZXN0ZWQsIHdvcmtlZCBvcgo+ICAgICBoZWxwZWQgaW4gdGhlIHJlYWwg
c2NlbmFyaW8uLi4KPiAKPiAKPiAgICAgVGFrYXNoaQo+IAoKCi0tIApKYXJvc2xhdiBLeXNlbGEg
PHBlcmV4QHBlcmV4LmN6PgpMaW51eCBTb3VuZCBNYWludGFpbmVyOyBBTFNBIFByb2plY3Q7IFJl
ZCBIYXQsIEluYy4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0
dHBzOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZl
bAo=
