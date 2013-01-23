From: Manolo =?UTF-8?B?RMOtYXo=?= <diaz.manolo@gmail.com>
Subject: Re: HD-audio generic parser merged to linux-next
Date: Wed, 23 Jan 2013 16:12:54 +0100
Message-ID: <20130123161254.7e06635c@gmail.com>
References: <s5hbocg1etr.wl%tiwai@suse.de> <20130123144932.743ae35e@gmail.com>
 <s5hd2wwf1hv.wl%tiwai@suse.de> <20130123150143.6fe19b53@gmail.com>
 <s5ha9s0f0bj.wl%tiwai@suse.de> <s5h622oeyoa.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
 [209.85.212.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 2ECB42652E5
 for <alsa-devel@alsa-project.org>; Wed, 23 Jan 2013 16:12:57 +0100 (CET)
Received: by mail-wi0-f179.google.com with SMTP id o1so812594wic.12
 for <alsa-devel@alsa-project.org>; Wed, 23 Jan 2013 07:12:56 -0800 (PST)
In-Reply-To: <s5h622oeyoa.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

RWwgbWnDqSwgMjMgZW5lIDIwMTMgYSBsYXMgMTU6NTUgaG9yYXMKVGFrYXNoaSBJd2FpIGVzY3Jp
YmnDszoKCj5JIHRoaW5rIEkgZm91bmQgdGhlIGN1bHByaXQuICBDb3VsZCB5b3UgdXBkYXRlIHRv
IHRoZSBsYXRlc3QgdHJlZSBhbmQKPmFwcGx5IHRoZSBwYXRjaCBiZWxvdz8KPgo+Cj5UYWthc2hp
Cj4KPi0tLQo+ZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEvaGRhX2NvZGVjLmMgYi9zb3VuZC9w
Y2kvaGRhL2hkYV9jb2RlYy5jCj5pbmRleCA3N2RkZDM0Li5hMjJhMThiIDEwMDY0NAo+LS0tIGEv
c291bmQvcGNpL2hkYS9oZGFfY29kZWMuYwo+KysrIGIvc291bmQvcGNpL2hkYS9oZGFfY29kZWMu
Ywo+QEAgLTM4MjQsNiArMzgyNCw3IEBAIHN0YXRpYyB2b2lkIGhkYV9jYWxsX2NvZGVjX3Jlc3Vt
ZShzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYykKPiAJICovCj4gCWhkYV9rZWVwX3Bvd2VyX29uKGNv
ZGVjKTsKPiAJaGRhX3NldF9wb3dlcl9zdGF0ZShjb2RlYywgQUNfUFdSU1RfRDApOwo+KwlzbmRf
aGRhX2phY2tfc2V0X2RpcnR5X2FsbChjb2RlYyk7Cj4gCXJlc3RvcmVfc2h1dHVwX3BpbnMoY29k
ZWMpOwo+IAloZGFfZXhlY19pbml0X3ZlcmJzKGNvZGVjKTsKPiAJaWYgKGNvZGVjLT5wYXRjaF9v
cHMucmVzdW1lKQo+QEAgLTM4MzcsMTAgKzM4MzgsOCBAQCBzdGF0aWMgdm9pZCBoZGFfY2FsbF9j
b2RlY19yZXN1bWUoc3RydWN0IGhkYV9jb2RlYyAqY29kZWMpCj4gCj4gCWlmIChjb2RlYy0+amFj
a3BvbGxfaW50ZXJ2YWwpCj4gCQloZGFfamFja3BvbGxfd29yaygmY29kZWMtPmphY2twb2xsX3dv
cmsud29yayk7Cj4tCWVsc2Ugewo+LQkJc25kX2hkYV9qYWNrX3NldF9kaXJ0eV9hbGwoY29kZWMp
Owo+KwllbHNlCj4gCQlzbmRfaGRhX2phY2tfcmVwb3J0X3N5bmMoY29kZWMpOwo+LQl9Cj4gCj4g
CWNvZGVjLT5pbl9wbSA9IDA7Cj4gCXNuZF9oZGFfcG93ZXJfZG93bihjb2RlYyk7IC8qIGZsYWcg
ZG93biBiZWZvcmUgcmV0dXJuaW5nICovCgpIaSwgaWYgdGhpcyBwYXRjaCBpcyBpbmNsdWRlZCBp
biB0aGUKMjhlYmZhMDhlMjk0NWIzOGUwOGM1MzdmYWY3Zjc0OTEyNTc4MGNiZSBjb21taXQsIGl0
J3MgYWxyZWFkeSB0ZXN0ZWQgYW5kIGZvdW5kIHRvIHdvcmsgZmluZS4KClJlZ2FyZHMsCi0tIApN
YW5vbG8gRMOtYXoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0
dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVs
Cg==
