From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/3] ASoC: AMD: Make the driver name consistent across
 files
Date: Wed, 8 Nov 2017 18:12:34 +0000
Message-ID: <BN6PR12MB165251734231887E8A1E213BF7560@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <20171108172404.19118-1-alexander.deucher@amd.com>
 <20171108172404.19118-2-alexander.deucher@amd.com>
 <20171108180835.7nl7uzxzclcxrfga@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20171108180835.7nl7uzxzclcxrfga@sirena.co.uk>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: 'Mark Brown' <broonie@kernel.org>, Alex Deucher <alexdeucher@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Agrawal,
 Akshu" <Akshu.Agrawal@amd.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Mukunda,
 Vijendar" <Vijendar.Mukunda@amd.com>
List-Id: alsa-devel@alsa-project.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+IEZyb206IE1hcmsgQnJvd24gW21haWx0bzpi
cm9vbmllQGtlcm5lbC5vcmddCj4gU2VudDogV2VkbmVzZGF5LCBOb3ZlbWJlciAwOCwgMjAxNyAx
OjA5IFBNCj4gVG86IEFsZXggRGV1Y2hlcgo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZzsgYWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnOyBkcmktCj4gZGV2ZWxAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnOyBNdWt1bmRhLCBWaWplbmRhcjsgbGdpcmR3b29kQGdtYWlsLmNvbTsKPiB0
aXdhaUBzdXNlLmRlOyBBZ3Jhd2FsLCBBa3NodTsgRGV1Y2hlciwgQWxleGFuZGVyCj4gU3ViamVj
dDogUmU6IFtQQVRDSCAxLzNdIEFTb0M6IEFNRDogTWFrZSB0aGUgZHJpdmVyIG5hbWUgY29uc2lz
dGVudAo+IGFjcm9zcyBmaWxlcwo+IAo+IE9uIFdlZCwgTm92IDA4LCAyMDE3IGF0IDEyOjI0OjAy
UE0gLTA1MDAsIEFsZXggRGV1Y2hlciB3cm90ZToKPiA+IEZyb206IEFrc2h1IEFncmF3YWwgPGFr
c2h1LmFncmF3YWxAYW1kLmNvbT4KPiA+Cj4gPiBUaGlzIGZpeGVzIHRoZSBpc3N1ZSBvZiBkcml2
ZXIgbm90IGdldHRpbmcgYXV0byBsb2FkZWQgd2l0aAo+ID4gTU9EVUxFX0FMSUFTLgo+IAo+IFBs
ZWFzZSBkb24ndCByZXN1Ym1pdCBwYXRjaGVzIHRoYXQgaGF2ZSBhbHJlYWR5IGJlZW4gYXBwbGll
ZCwgeW91IHNob3VsZAo+IHN1Ym1pdCBwYXRjaGVzIGFnYWluc3QgY3VycmVudCBjb2RlIGluIHRo
ZSB0cmVlIHlvdSdyZSBleHBlY3RpbmcgdGhpbmdzCj4gdG8gYmUgYXBwbGllZCB0by4gIElmIGFu
eSB1cGRhdGVzIGFyZSBuZWVkZWQgdG8gYSBwYXRjaCB0aGF0J3MgYWxyZWFkeQo+IGJlZW4gYXBw
bGllZCB5b3Ugc2hvdWxkIHN1Ym1pdCBpbmNyZW1lbnRhbCBwYXRjaGVzIHdoaWNoIG1ha2UgdGhv
c2UKPiB1cGRhdGVzLiAgVGhpcyBhdm9pZHMgaGF2aW5nIHRvIGNoYW5nZSBwdWJsaXNoZWQgZ2l0
IGNvbW1pdHMgd2hpY2ggY291bGQKPiBjYXVzZSBwcm9ibGVtcyBmb3IgcGVvcGxlIHdvcmtpbmcg
YWdhaW5zdCBnaXQuCgpUaGlzIGRpZG4ndCBub3QgYXBwZWFyIHRvIGJlIGluIHlvdXIgdHJlZSB5
ZXQgYW5kIEkgbmV2ZXIgZ290IGFueSBjb25maXJtYXRpb24gaXQgYmVpbmcKYXBwbGllZC4gIEFw
b2xvZ2llcy4KCkFsZXgKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1k
ZXZlbAo=
