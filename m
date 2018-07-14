From: jimqu <jimqu@amd.com>
Subject: =?UTF-8?B?UmU6IOetlOWkjTog562U5aSNOiBbYWxzYS1kZXZlbF0g562U5aSNOiBb?=
 =?UTF-8?Q?PATCH]_vgaswitchroo:_set_audio_client_id_according_to_bound_gpu_c?=
 =?UTF-8?Q?lient_id?=
Date: Sat, 14 Jul 2018 20:03:26 +0800
Message-ID: <cad8a61b-064a-5f20-acb3-06cee3a19e04@amd.com>
References: <20180629080634.GA7357@wunner.de>
 <DM3PR12MB0873FEC702770190057B49F799440@DM3PR12MB0873.namprd12.prod.outlook.com>
 <20180709092759.GA3649@wunner.de>
 <DM3PR12MB087309CBC2CD3A934327EBCE99440@DM3PR12MB0873.namprd12.prod.outlook.com>
 <CADnq5_OpZz=AgNomX7+5BzeN77CRZT7mXDT7kn620TE-OjqS0w@mail.gmail.com>
 <s5hr2kco3gp.wl-tiwai@suse.de> <20180709155643.GE3008@phenom.ffwll.local>
 <s5hpnzwcsf7.wl-tiwai@suse.de>
 <DM3PR12MB0873E9DD8B7448CB8A6829DA99440@DM3PR12MB0873.namprd12.prod.outlook.com>
 <s5hr2kbr03k.wl-tiwai@suse.de> <a37f08e7-734e-977c-597f-46d5c3ec34bc@amd.com>
 <s5hin5nctby.wl-tiwai@suse.de> <733011b9-1880-76a8-d00f-076591e93c53@amd.com>
 <s5hbmbfcp5v.wl-tiwai@suse.de> <s5hfu0qp7cv.wl-tiwai@suse.de>
 <1936c752-f858-2caf-35e7-98bea431fb7c@amd.com> <s5h1scap2h2.wl-tiwai@suse.de>
 <46d4d516-8373-2b22-da2e-f9f386c66973@amd.com> <s5h601mayk0.wl-tiwai@suse.de>
 <112c3801-8138-2e05-557a-08be69f3810b@amd.com> <s5hwou29gce.wl-tiwai@suse.de>
 <s5hzhyv6uol.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <s5hzhyv6uol.wl-tiwai@suse.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Qu,
 Jim" <Jim.Qu@amd.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
List-Id: alsa-devel@alsa-project.org

CgrlnKggMjAxOC83LzEzIDIzOjA3LCBUYWthc2hpIEl3YWkg5YaZ6YGTOgo+IE9uIFdlZCwgMTEg
SnVsIDIwMTggMTM6MTI6MDEgKzAyMDAsCj4gVGFrYXNoaSBJd2FpIHdyb3RlOgo+PiBBbmQgdGhl
IGZvcmNlZCBydW50aW1lIFBNIGlzIHN0aWxsIGFuIGlzc3VlLCBhbmQgdGhpcyB3b3VsZCBuZWVk
IHRoZQo+PiBvdGhlciBub3RpZmljYXRpb24gbWVjaGFuaXNtIHRoYW4gdGhlIEhELWF1ZGlvIHVu
c29saWNpdGVkIGV2ZW50IGFzCj4+IEFNRCBIRE1JIGNvbnRyb2xsZXIgZG9lc24ndCBob25vciB0
aGUgSEQtYXVkaW8gV0FLRUVOIGJpdC4KPiBTaW5jZSB3ZSBoYWQgYSBuaWNlICJoYWNrIHdlZWsi
IGluIHRoaXMgd2VlayBhdCBTVVNFLCBJIHNwZW50IHNvbWUKPiB0aW1lIHRvIHdyaXRlIHNvbWUg
cGF0Y2hlcyBmb3IgdGhlIHN1cHBvcnQgb2YgdGhlIGRpcmVjdCBob3RwbHVnCj4gbm90aWZpY2F0
aW9uIC8gRUxEIHF1ZXJ5IGJldHdlZW4gSEQtYXVkaW8gYW5kIHJhZGVvbi9hbWRncHUuICBJdAo+
IHJlLXV0aWxpemVzIHRoZSBhdWRpbyBjb21wb25lbnQgZnJhbWV3b3JrIGZvciBpOTE1IGJ1dCBp
biBhIHNsaWdodGx5Cj4gbW9yZSBmbGV4aWJsZSB3YXkuCj4KPiBUaGUgcGF0Y2hlcyBhcmUgZm91
bmQgaW4gdG9waWMvaGRhLWFjb21wIGJyYW5jaCBvZiBteSBzb3VuZC5naXQgdHJlZToKPiAgICBn
aXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdGl3YWkvc291bmQu
Z2l0Cj4KPiBUaGUgZm9sbG93aW5nIGNvbW1pdHMgYXJlIHJlbGV2YW50Ogo+ICAgIGRybS9pOTE1
OiBTcGxpdCBhdWRpbyBjb21wb25lbnQgdG8gYSBnZW5lcmljIHR5cGUKPiAgICBBTFNBOiBoZGEv
aTkxNTogQWxsb3cgZGVsYXllZCBpOTE1IGF1ZGlvIGNvbXBvbmVudCBiaW5kaW5nCj4gICAgQUxT
QTogaGRhL2k5MTU6IEFzc29jaWF0ZSBhdWRpbyBjb21wb25lbnQgd2l0aCBkZXZyZXMKPiAgICBB
TFNBOiBoZGE6IE1ha2UgYXVkaW8gY29tcG9uZW50IHN1cHBvcnQgbW9yZSBnZW5lcmljCj4gICAg
QUxTQTogaGRhL2hkbWk6IEFsbG93IGF1ZGlvIGNvbXBvbmVudCBmb3IgQU1EL0FUSSBIRE1JCj4g
ICAgQUxTQTogaGRhL2hkbWk6IFVzZSBzaW5nbGUgbXV0ZXggdW5sb2NrIGluIGVycm9yIHBhdGhz
Cj4gICAgZHJtL3JhZGVvbjogQWRkIGF1ZGlvIGNvbXBvbmVudCBzdXBwb3J0Cj4gICAgZHJtL2Ft
ZGdwdTogQWRkIGF1ZGlvIGNvbXBvbmVudCBzdXBwb3J0Cj4KPiBUaGUgYnJhbmNoIHNob3VsZCBi
ZSBjbGVhbmx5IHB1bGxhYmxlIG9udG8gdGhlIGxhdGVzdCA0LjE4LXJjLgo+Cj4gSSBjb3VsZG4n
dCB0ZXN0IGFtZGdwdSBidXQgdGhlIHRlc3Qgd2l0aCBhIHJhZGVvbiBkcml2ZXIgb24gYW4gb2xk
Cj4gbGFwdG9wIHNlZW1lZCB3b3JraW5nIHRocm91Z2ggYSB2ZXJ5IHF1aWNrIHRlc3QuCj4KPiBQ
bGVhc2UgZ2l2ZSBpdCBhIHRyeS4KClRoYXQgaXMgcmVhbGx5IHdvbmRlcmZ1bCB3b3JrLiBJIHdp
bGwgY2hlY2sgaXQgb24gb3VyIEFNRCBwbGF0Zm9ybS4gQlRXLCAKRm9yIGRpc3BsYXksIEFNRCBo
YXMgbW92ZWQgdG8gdXNlIERDIHRvIHN1cHBvcnQgbmV3IGFzaWNzLiBzbyB0aGVyZSBhbHNvIApu
ZWVkIGEgcGF0Y2ggZm9yIGFtZGdwdSBpbiBEQyBjb2RlLgoKVGhhbmtzCkppbVF1Cj4KPiB0aGFu
a3MsCj4KPiBUYWthc2hpCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmkt
ZGV2ZWwK
