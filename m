From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: ALSA: bebob: Use common error handling code in
 snd_bebob_stream_start_duplex()
Date: Wed, 27 Sep 2017 08:38:48 +0200
Message-ID: <06a8e3ee-c3c3-b4c7-0cf9-69a2efdaf0ba@users.sourceforge.net>
References: <85f95150-9cec-7a53-7692-837ba543e1ec@users.sourceforge.net>
 <541f0f9f-fc87-f65b-bbd8-fec5d45d5d2e@users.sourceforge.net>
 <a1dee732-f5c4-5b35-9f82-553fc8ce430d@sakamocchi.jp>
 <3afecbef-b7ac-a4e8-f439-a351916f05e5@users.sourceforge.net>
 <09bb0e83-01fe-cd12-a084-31db3f12d663@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by alsa0.perex.cz (Postfix) with ESMTP id 1270F2671E3
 for <alsa-devel@alsa-project.org>; Wed, 27 Sep 2017 08:39:11 +0200 (CEST)
In-Reply-To: <09bb0e83-01fe-cd12-a084-31db3f12d663@sakamocchi.jp>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, Clemens Ladisch <clemens@ladisch.de>, Takashi Iwai <tiwai@suse.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

PiBBcyBsb25nIGFzIEkga25vdywgdGhlIGxhc3QgcHJvZHVjdCB3aXRoIHRoaXMgc29sdXRpb24g
d2FzIHNoaXBwZWQKPiBhdCAyMDEwLiBUaHVzIHRoZSBkcml2ZXIgaXMgdW5kZXIgbWFpbnRlbmFu
Y2UuCgpUaGFua3MgZm9yIHlvdXIgaW5mb3JtYXRpb24uCgoKPiBJIGhhdmUgc29tZSB0YXNrcyBm
b3IgdGhpcyBkcml2ZXIgYXMgd2VsbCBhcyBkcml2ZXJzIGluIEFMU0EgZmlyZXdpcmUgc3RhY2ss
Cj4gaG93ZXZlciBiYXNpY2FsbHkgdGhpcyBkcml2ZXIgaXMgdW5kZXIgbWFpbnRlbmFuY2UgYW5k
IG1pZ2h0IG5vdCBnZXQKPiBmdXJ0aGVyIGludGVncmF0aW9uLgoKR29vZCB0byBrbm93IGluIHBy
aW5jaXBsZSDigKYKCgo+IEkgdGhpbmsgdGhhdCBjb2RlIGNsZWFudXAgZm9yIHRoZSBkcml2ZXIg
ZG9uJ3QgaGVscCB0aGUgb3RoZXIgZGV2ZWxvcGVycy4KCkkgdGhvdWdodCBpbiBhbiBvdGhlciBk
aXJlY3Rpb24gaWYgb3RoZXIgY29udHJpYnV0b3JzIHdvdWxkIGxpa2UgdG8gY2FyZQpmb3IgbG9u
Z2VyIHRlcm0gc3VwcG9ydC4KCgo+IEl0J3MgYmV0dGVyIHRvIGFwcGx5IHN1Y2ggY2xlYW51cCB0
byBtb3JlIGxvbmctbGl2ZSBjb2RlcyBzdWNoIGFzCj4gY29yZSBmdW5jdGlvbmFsaXR5IG9mIEFM
U0EuCgpJIGFtIHRyeWluZyBhbm90aGVyIGdlbmVyYWwgdHJhbnNmb3JtYXRpb24gcGF0dGVybiBv
dXQuCgoKPiBJbiB0aGlzIHBvaW50IG9mIHZpZXcsIHdoZXRoZXIgeW91ciBwYXRjaHNldCBpcyB3
b3J0aCB0byBiZSBhcHBsaWVkCj4gb3Igbm90LCBQbGVhc2Uga2VlcCBlbm91Z2ggdGltZSB0byB0
aGluayBhYm91dC4KCkF1dG9tYXRpYyBzb3VyY2UgY29kZSBhbmFseXNpcyBjYW4gZmluZCB2YXJp
b3VzIHVwZGF0ZSBjYW5kaWRhdGVzLgpJIGFtIGp1c3QgdW5zdXJlIGlmIGEgYml0IG1vcmUgc29m
dHdhcmUgZGV2ZWxvcG1lbnQgYXR0ZW50aW9uIGlzIHN0aWxsCmFwcHJvcHJpYXRlIGF0IHNvbWUg
cGxhY2VzLgoKRG8geW91IGZpbmQgYW55IG9mIHRoZSBhZmZlY3RlZCBzb2Z0d2FyZSBtb2R1bGVz
IHNvIG91dGRhdGVkCnNvIHRoYXQgdGhleSBzaG91bGQgbm90IGJlIHRvdWNoZWQgYW55IG1vcmU/
CgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qu
b3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNh
LWRldmVsCg==
