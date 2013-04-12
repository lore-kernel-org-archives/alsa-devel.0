From: Stas Sergeev <stsp@list.ru>
Subject: Re: [PATCH] ASoC: define playback and capture streams
	in dummy codec
Date: Fri, 12 Apr 2013 19:20:19 +0400
Message-ID: <51682633.70008@list.ru>
References: <5167E7C4.7080501@list.ru>
 <20130412105943.GU9243@opensource.wolfsonmicro.com>
 <20130412181943.0338083b@stas> <516824B4.20802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2.mail.ru (smtp2.mail.ru [94.100.176.130])
 by alsa0.perex.cz (Postfix) with ESMTP id AA2622616DB
 for <alsa-devel@alsa-project.org>; Fri, 12 Apr 2013 17:20:24 +0200 (CEST)
In-Reply-To: <516824B4.20802@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, stsp@users.sourceforge.net
List-Id: alsa-devel@alsa-project.org

MTIuMDQuMjAxMyAxOToxMywgR2FicmllbCBNLiBCZWRkaW5nZmllbGQg0L/QuNGI0LXRgjoKPiBP
biAwNC8xMi8yMDEzIDA3OjE5IEFNLCBTdGFzIFNlcmdlZXYgd3JvdGU6Cj4+IE9uIEZyaSwgMTIg
QXByIDIwMTMgMTE6NTk6NDQgKzAxMDAKPj4gTWFyayBCcm93biA8YnJvb25pZUBvcGVuc291cmNl
LndvbGZzb25taWNyby5jb20+IHdyb3RlOgo+Pj4+IFRoaXMgcGF0Y2ggYWRkcyBhIHBsYXliYWNr
IGFuZCBjYXB0dXJlIHN0cmVhbXMgdG8gdGhlIGR1bW15IGNvZGVjIERBSQo+Pj4+IGNvbmZpZ3Vy
YXRpb24uIE1vc3QgcGVybWlzc2l2ZSBzZXQgb2Ygc2FtcGxpbmcgcmF0ZXMgYW5kIGZvcm1hdHMg
aXMKPj4+PiB1c2VkLgo+Pj4gVGhlIGNoYW5nZWxvZyBvdWdodCB0byBleHBsYWluIHdoeSB0aGlz
IGlzIHJlcXVpcmVkLi4uCj4+IEkgY2FuIG9ubHkgdGVsbCB0aGF0IHdpdGhvdXQgdGhpcyBwYXRj
aCBJIGFtIG5vdCBnZXR0aW5nIGFueQo+PiBzb3VuZCBhdCBhbGwuLi4gd2hpY2ggaXMgcHJvYmFi
bHkgYSByYXRoZXIgcG9vciBzdGF0ZW1lbnQgZm9yCj4+IHRoZSBjaGFuZ2Vsb2cuIENvdWxkIHlv
dSBwbGVhc2UgY29ycmVjdCB0aGUgY2hhbmdlbG9nIHdpdGggdGhlCj4+IGJldHRlciBrbm93bGVk
Z2Ugb2YgdGhlIGRldGFpbHM/Cj4KPiBIZSBtZWFucyB0aGF0IHRoZSBjb21taXQgbWVzc2FnZS4g
WW91ciBjb21taXQgbWVzc2FnZSBzYXlzIHdoYXQgdGhlCj4gcGF0Y2ggZG9lcy4gSXQgZG9lcyBu
b3Qgc2F5IHdoeSB0aGUgcGF0Y2ggaXMgbmVlZGVkLgpZZXMuCkJ1dCB3aGF0IHNob3VsZCBJIGFk
ZCB0byB0aGUgY29tbWl0IG1lc3NhZ2UsIGlmIHRoZQpvbmx5IHRoaW5nIEkga25vdyBhYm91dCB0
aGlzIHBhdGNoLCBpcyB0aGF0IEkgYW0gbm90IGdldHRpbmcKYW55IHNvdW5kIHdpdGhvdXQgaXQ/
IDopIFRoZSByZWFzb24gc2hvdWxkIGJlIG9idmlvdXMgZm9yCndob2V2ZXIgaXMgZmFtaWxpYXIg
d2l0aCB0aGF0IHN1YnN5c3RlbSwgYnV0IGl0cyBub3QgbWUuCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2Et
ZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21h
aWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
