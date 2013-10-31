From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: Re: [PATCH] drm/radeon/audio: fix missing multichannel PCM SAD in
	some cases
Date: Fri, 1 Nov 2013 00:46:48 +0100
Message-ID: <CACna6ryN99oVSpAuV3DDzF+U6R8XP80q2JY61d45yf4PMFXYmw@mail.gmail.com>
References: <526EE844.4030608@iki.fi>
	<1383002356-2479-1-git-send-email-anssi.hannula@iki.fi>
	<CACna6rzvZd-6s5gBLJnqFUfBCQuSKgCmJ7mNPhaEGuPscfxqqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <CACna6rzvZd-6s5gBLJnqFUfBCQuSKgCmJ7mNPhaEGuPscfxqqA@mail.gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
Errors-To: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
To: Anssi Hannula <anssi.hannula@iki.fi>
Cc: Alex Deucher <alexander.deucher@amd.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, dri-devel <dri-devel@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

MjAxMy8xMS8xIFJhZmHFgiBNacWCZWNraSA8emFqZWM1QGdtYWlsLmNvbT46Cj4gMjAxMy8xMC8y
OSBBbnNzaSBIYW5udWxhIDxhbnNzaS5oYW5udWxhQGlraS5maT46Cj4+IEZpeCB0aGUgY29kZSB0
byBwaWNrIHRoZSBQQ00gU0FEIHdpdGggdGhlIGhpZ2hlc3QgbnVtYmVyIG9mIGNoYW5uZWxzLAo+
PiB3aGlsZSBtZXJnaW5nIHRoZSByYXRlIG1hc2tzIG9mIFBDTSBTQURzIHdpdGggbG93ZXIgYW1v
dW50IG9mIGNoYW5uZWxzCj4+IGludG8gdGhlIGFkZGl0aW9uYWwgc3RlcmVvIHJhdGUgbWFzayBi
eXRlLgo+Cj4gRG9lcyBpdCBtZWFuIHRoYXQgbm93IGluc3RlYWQgb2YgMiByZWFsIFNBRHM6Cj4g
MSkgMTkya0h6IHN1cHBvcnQgZm9yIDIgY2hhbm5lbHMKPiAyKSA5NmtIeiBzdXBwb3J0IGZvciA4
IGNoYW5uZWxzCj4geW91IHdpbGwgb25seSBnZXQ6Cj4gMSkgMTkya0h6IHN1cHBvcnQgZm9yIDgg
Y2hhbm5lbHMKPiA/Cj4gRG9lcyBpdCBtZWFuIGFsc2EgbWF5IHRyeSB0byBwbGF5IDhjaGFubmVs
cyBhdWRpbyBhdCAxOTJrSHogYW5kIGZhaWwgYXQgdGhpcz8KPiBUaGF0IGRvZXNuJ3Qgc291bmQg
Z29vZCwgYnV0IG9uIHRoZSBvdGhlciBoYW5kIEkgY2FuJ3QgcHJvcG9zZQo+IGFueXRoaW5nIGJl
dHRlciA6fAoKQWhoLCB3YWl0LiBJIGp1c3Qgbm90aWNlZCB5b3UncmUgdXNpbmcgU1VQUE9SVEVE
X0ZSRVFVRU5DSUVTIGFuZAooZGlmZmVyZW50IG9uZSkgU1VQUE9SVEVEX0ZSRVFVRU5DSUVTX1NU
RVJFTyB0aGVyZS4gU29ycnkgSSBtaXNzZWQKdGhhdCBlYXJsaWVyLgoKWWVhaCwganVzdCBjb2Rl
IG1ha2VzIG11Y2ggbW9yZSBzZW5zZSwgSSBqdXN0IHRoaW5rIHRoZSBsb2dpYyBpbgpzZXR0aW5n
IHRoYXQgZnJlcXVlbmN5IG1heSBiZSBhIGJpdCBiYWQuLi4gTGV0IG1lIHRoaW5rIGFib3V0IHRo
aXMKY2xlYXJseSB0b21vcnJvdyBhbmQgSSdsbCBsZXQgeW91IGtub3cgOikKCi0tIApSYWZhxYIK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
