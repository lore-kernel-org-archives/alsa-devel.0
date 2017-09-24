From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: ALSA: bebob: Use common error handling code in
 snd_bebob_stream_start_duplex()
Date: Sun, 24 Sep 2017 09:06:12 +0200
Message-ID: <3afecbef-b7ac-a4e8-f439-a351916f05e5@users.sourceforge.net>
References: <85f95150-9cec-7a53-7692-837ba543e1ec@users.sourceforge.net>
 <541f0f9f-fc87-f65b-bbd8-fec5d45d5d2e@users.sourceforge.net>
 <a1dee732-f5c4-5b35-9f82-553fc8ce430d@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by alsa0.perex.cz (Postfix) with ESMTP id DF681266B67
 for <alsa-devel@alsa-project.org>; Sun, 24 Sep 2017 09:06:34 +0200 (CEST)
In-Reply-To: <a1dee732-f5c4-5b35-9f82-553fc8ce430d@sakamocchi.jp>
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

PiA2NjjCoMKgwqDCoCBpZiAoIWFtZHRwX3N0cmVhbV93YWl0X2NhbGxiYWNrKCZiZWJvYi0+dHhf
c3RyZWFtLAo+IDY2OcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBDQUxMQkFDS19USU1FT1VUKSkgewo+IDY3MMKg
wqDCoMKgwqDCoMKgwqAgYW1kdHBfc3RyZWFtX3N0b3AoJmJlYm9iLT50eF9zdHJlYW0pOwo+IDY3
McKgwqDCoMKgwqDCoMKgwqAgYW1kdHBfc3RyZWFtX3N0b3AoJmJlYm9iLT5yeF9zdHJlYW0pOwo+
IDY3MsKgwqDCoMKgwqDCoMKgwqAgYnJlYWtfYm90aF9jb25uZWN0aW9ucyhiZWJvYik7Cj4gNjcz
wqDCoMKgwqDCoMKgwqDCoCBlcnIgPSAtRVRJTUVET1VUOwo+IDY3NMKgwqDCoMKgIH0KPiA2NzUg
fQo+IAo+IEkgdGhpbmsgaXQgYmV0dGVyIHRvIGFwcGx5IHlvdXIgc29sdXRpb24gdG9vIGluIHRo
ZSBhYm92ZSB0byBrZWVwIGNvZGUgY29uc2lzdGVuY3kuCgpIb3cgZG8geW91IHRoaW5rIGFib3V0
IHRvIGFkanVzdCB0aGlzIGZ1bmN0aW9uIGltcGxlbWVudGF0aW9uIGFmdGVyIHRoZSBvdGhlciB0
d28KdXBkYXRlIHN0ZXBzIGZyb20gdGhlIHBhdGNoIHNlcmllcyB3b3VsZCBiZSBpbnRlZ3JhdGVk
PwoKCj4gRm9yIHRoZSBvdGhlciBwYXRjaGVzLCBJIGNhbiBmaW5kIG5vIG1lcml0IHRvIGFwcGx5
IGV4Y2VwdCBmb3IgcmVkdWN0aW9uCj4gb2YgdGhlIG51bWJlciBvZiBjaGFyYWN0ZXJzIGluY2x1
ZGVkIGluIHRoZSBmaWxlLgoKV291bGQgeW91IGxpa2UgdG8gcmVmZXIgdG8gYW55IHNwZWNpZmlj
IHVwZGF0ZSBzdWdnZXN0aW9ucyBmb3IgZnVydGhlciBjbGFyaWZpY2F0aW9uPwoKUmVnYXJkcywK
TWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFs
c2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8v
bWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
