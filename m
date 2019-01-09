From: Jay Foster <jay@systech.com>
Subject: Re: ALSA 1.1.8 Release - POLLRDNORM undefined
Date: Wed, 9 Jan 2019 08:22:36 -0800
Message-ID: <1e297542-0023-0a92-7407-076ee547b5d9@systech.com>
References: <34543a6f-8123-10e5-ea79-338b82a22818@systech.com>
 <s5htviixf0t.wl-tiwai@suse.de>
Reply-To: jay@systech.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rcloudmail.hostconnection.net (rcloudmail.hostconnection.net
 [38.96.19.98]) by alsa0.perex.cz (Postfix) with ESMTP id 37D6B266875
 for <alsa-devel@alsa-project.org>; Wed,  9 Jan 2019 17:22:44 +0100 (CET)
In-Reply-To: <s5htviixf0t.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

CgpPbiAxLzkvMjAxOSAzOjEwIEFNLCBUYWthc2hpIEl3YWkgd3JvdGU6Cj4gT24gVHVlLCAwOCBK
YW4gMjAxOSAxODowMDoxOCArMDEwMCwKPiBKYXkgRm9zdGVyIHdyb3RlOgo+PiBJIGFtIGF0dGVt
cHRpbmcgdG8gYnVpbGQgdGhlIDEuMS44IHJlbGVhc2Ugb2YgYWxzYS11dGlscyBhbmQgZ2V0dGlu
Zwo+PiBhbiBlcnJvciBhYm91dCBQT0xMUkROT1JNIChhbmQgb3RoZXJzKSB1bmRlZmluZWQuwqAg
VGhpcyBlcnJvciBjb21lcwo+PiBmcm9tIGF4ZmVyL3dhaXRlci1zZWxlY3QuYy7CoCBheGZlci93
YWl0ZXItc2VsZWN0LmMgaW5jbHVkZXMKPj4gIndhaXRlci5oIiwgd2hpY2ggaW5jbHVkZXMgInBv
bGwuaCIuwqAgVGhpcyBidWlsZCBpcyBmb3IgYSBsaW51eAo+PiB0YXJnZXQuCj4+Cj4+IHBvbGwu
aCBpbmNsdWRlcyBzeXMvcG9sbC5oIHdoaWNoIGluY2x1ZGVzIGJpdHMvcG9sbC5oLCB3aGljaCBv
bmx5Cj4+IGRlZmluZXMgUE9MTFJETk9STSAoYW5kIG90aGVycykgd2hlbiBfX1VTRV9YT1BFTiBp
cyBkZWZpbmVkICh3aGljaCBpdAo+PiBpcyBub3QpLgo+Pgo+PiBIb3dldmVyLCBsaW51eC9wb2xs
LmggaW5jbHVkZXMgYXNtL3BvbGwuaCB3aGljaCBpbmNsdWRlcwo+PiBhc20tZ2VuZXJpYy9wb2xs
Lmggd2hpY2ggZG9lcyBkZWZpbmUgUE9MTFJETk9STSAoYW5kIG90aGVycykuCj4+Cj4+IFNob3Vs
ZCBJIGNoYW5nZSBteSBidWlsZCB0byBkZWZpbmVfX1VTRV9YT1BFTiBvciBzaG91bGQgSSBwYXRj
aAo+PiB3YWl0ZXIuaCB0byBpbmNsdWRlIGxpbnV4L3BvbGwuaCBpbnN0ZWFkIG9mIGp1c3QgcG9s
bC5oPwo+IFdoaWNoIGxpYmMgYXJlIHlvdSB1c2luZz8gIFRoZSBQT1NJWCBtYW4gcGFnZSAobWFu
IHBvbGwuaCkgbWVudGlvbnMKPiBQT0xMUkROT1JNIGRlZmluZWQgdGhlcmUsIGF0IGxlYXN0LCBv
biBteSBzeXN0ZW0gd2l0aCBnbGliYyAyLjI3Lgo+Cj4KPiB0aGFua3MsCj4KPiBUYWthc2hpCj4K
PgpUaGlzIGlzIGEgbGVnYWN5IEFSTSBwcm9kdWN0IHVzaW5nIGdsaWJjIDIuOS7CoCBOZWl0aGVy
IG9mIHRoZSBhcHByb2FjaGVzIApJIG1lbnRpb25lZCBhYm92ZSBhY3R1YWxseSB3b3JrZWQuwqAg
PGxpbnV4L3BvbGwuaD4gaXMgdGhlIGtlcm5lbCAKaGVhZGVycywgd2hpY2ggcmVzdWx0cyBpbiBh
IGR1cGxpY2F0ZSBkZWZpbml0aW9uIG9mIHN0cnVjdCBwb2xsZmRzLsKgIFRoZSAKb3RoZXIgYXBw
cm9hY2ggKEkgYWRkZWQgJ0NGTEFHUz0tRF9YT1BFTl9TT1VSQ0U9NTAwJyB0byB0aGUgbWFrZSBj
b21tYW5kIApsaW5lLCBhbmQgb3RoZXIgdmFyaWF0aW9ucykgZmFpbGVkIGVsc2V3aGVyZSBkdWUg
dG8gbWlzc2luZyBvciAKbWlzbWF0Y2hlZCBmdW5jdGlvbiBwcm90b3R5cGVzIChyZWYgPGZlYXR1
cmVzLmg+KS4KCkkgZ290IHRoaXMgdG8gd29yayBieSBwYXRjaGluZyBheGZlci93YWl0ZXIuaCB0
byBhZGQgdGhlIG1pc3NpbmcgCmRlZmludGlvbnMsIGJhc2VkIG9uIHRob3NlIGZvdW5kIGluIDxh
c20tZ2VuZXJpYy9wb2xsLmg+LgoKSmF5CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNh
LXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbHNhLWRldmVsCg==
