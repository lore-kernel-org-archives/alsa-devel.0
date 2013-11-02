From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [PATCH] drm/radeon/audio: fix missing multichannel PCM SAD in
	some cases
Date: Sat, 02 Nov 2013 03:08:10 +0200
Message-ID: <5274507A.707@iki.fi>
References: <526EE844.4030608@iki.fi>	<1383002356-2479-1-git-send-email-anssi.hannula@iki.fi>
	<CACna6ryJjHJwu7_=rHfff8f8=f3BFEDrDcKgx-kTEofoJDn3Fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CACna6ryJjHJwu7_=rHfff8f8=f3BFEDrDcKgx-kTEofoJDn3Fg@mail.gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces@lists.freedesktop.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, dri-devel <dri-devel@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

MDIuMTEuMjAxMyAwMzowMSwgUmFmYcWCIE1pxYJlY2tpIGtpcmpvaXR0aToKPiAyMDEzLzEwLzI5
IEFuc3NpIEhhbm51bGEgPGFuc3NpLmhhbm51bGFAaWtpLmZpPjoKPj4gRml4IHRoZSBjb2RlIHRv
IHBpY2sgdGhlIFBDTSBTQUQgd2l0aCB0aGUgaGlnaGVzdCBudW1iZXIgb2YgY2hhbm5lbHMsCj4+
IHdoaWxlIG1lcmdpbmcgdGhlIHJhdGUgbWFza3Mgb2YgUENNIFNBRHMgd2l0aCBsb3dlciBhbW91
bnQgb2YgY2hhbm5lbHMKPj4gaW50byB0aGUgYWRkaXRpb25hbCBzdGVyZW8gcmF0ZSBtYXNrIGJ5
dGUuCj4gCj4gRG9uJ3QgeW91IHRoaW5rIHRoYXQgd2Ugc2hvdWxkIHVzZSBTVVBQT1JURURfRlJF
UVVFTkNJRVNfU1RFUkVPIGZvcgo+IHN0ZXJlbyBmcmVxdWVuY2llcyBvbmx5Pwo+IAo+IAo+PiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChzYWQtPmZvcm1hdCA9PSBIRE1JX0FV
RElPX0NPRElOR19UWVBFX1BDTSkKPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHN0ZXJlb19mcmVxcyB8PSBzYWQtPmZyZXE7Cj4gCj4gSSBtZWFuIG1ha2luZyB0aGF0
ICguLi4gJiYgc2FkLT5jaGFubmVscyA9PSAxKQo+IAoKU0FEIHdpdGggY2hhbm5lbHM9NixmcmVx
cz0zMi4uOTZrSHosYml0cz0xNi4uMjQgaW1wbGllcyB0aGF0IHRob3NlIGZyZXFzCmFuZCBicHMg
YXJlIHN1cHBvcnRlZCBmb3IgYWxsIGNoYW5uZWwgY291bnRzIHVwIHRvIDYgKHNpbmNlIGl0IGlz
ICJNYXgKTnVtYmVyIG9mIGNoYW5uZWxzIikuIFRoZXJlZm9yZSB0aGUgc3BlY2lmaWVkIHJhdGVz
IGFyZSBzdXBwb3J0ZWQgaW4Kc3RlcmVvIG1vZGUgYXMgd2VsbCBhbmQgSSBiZWxpZXZlIHNob3Vs
ZCBiZSBpbmNsdWRlZCBpbiB0aGUgc3RlcmVvIGJpdG1hc2suCgpBcyBwZXIgQU1EIEhEQSBWZXJi
cyBkb2N1bWVudGF0aW9uIHRoZSA0dGggYnl0ZSBpcyAiUmF0ZXMgc3VwcG9ydGVkIGZvcgpzdGVy
ZW8iLiBBbmQgc2luY2UgdGhvc2UgcmF0ZXMgX2FyZV8gc3VwcG9ydGVkIGJ5IHN0ZXJlbywgSU1P
IHRoZXkKc2hvdWxkIGJlIHRoZXJlLgoKLS0gCkFuc3NpIEhhbm51bGEKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApk
cmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
