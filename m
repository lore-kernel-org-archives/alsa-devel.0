From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 4/9] ALSA: usb-audio: use usb_fill_int_urb()
Date: Wed, 20 Jun 2018 11:23:12 +0300
Message-ID: <ce8ffb2b-35e8-1108-9065-81f4d3cb4d8d@cogentembedded.com>
References: <20180619215521.13688-1-bigeasy@linutronix.de>
 <20180619215521.13688-5-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f66.google.com (mail-lf0-f66.google.com
 [209.85.215.66])
 by alsa0.perex.cz (Postfix) with ESMTP id F33D226720C
 for <alsa-devel@alsa-project.org>; Wed, 20 Jun 2018 10:23:14 +0200 (CEST)
Received: by mail-lf0-f66.google.com with SMTP id n24-v6so3624528lfh.3
 for <alsa-devel@alsa-project.org>; Wed, 20 Jun 2018 01:23:14 -0700 (PDT)
In-Reply-To: <20180619215521.13688-5-bigeasy@linutronix.de>
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
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, alsa-devel@alsa-project.org
Cc: tglx@linutronix.de, linux-usb@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

SGVsbG8hCgpPbiA2LzIwLzIwMTggMTI6NTUgQU0sIFNlYmFzdGlhbiBBbmRyemVqIFNpZXdpb3Ig
d3JvdGU6Cgo+IFVzaW5nIHVzYl9maWxsX2ludF91cmIoKSBoZWxwcyB0byBmaW5kIGNvZGUgd2hp
Y2ggaW5pdGlhbGl6ZXMgYW4KPiBVUkIuIEEgZ3JlcCBmb3IgbWVtYmVycyBvZiB0aGUgc3RydWN0
IChsaWtlIC0+Y29tcGxldGUpIHJldmVhbCBsb3RzCj4gb2Ygb3RoZXIgdGhpbmdzLCB0b28uCj4g
Cj4gZGF0YV9lcF9zZXRfcGFyYW1zKCkgYWRkaXRpb25hbGx5IHNldHMgdXJiLT50cmFuc2Zlcl9i
dWZmZXJfbGVuZ3RoIHdoaWNoCj4gd2FzIG5vdCB0aGUgY2FzZSBlYXJsaWVyLgo+IGRhdGFfZXBf
c2V0X3BhcmFtcygpIGFuZCBkYXRhX2VwX3NldF9wYXJhbXMoKQoKICAgIFRoZXNlIDIgYXJlIHRo
ZSBzYW1lIGZ1bmN0aW9uPwoKPiBlbnN1cmUgdGhhdCBzeW5jaW50ZXJ2YWwgaXMKPiB3aXRoaW4g
dGhlIGFsbG93ZWQgcmFuZ2Ugb24gSFMvU1MuIFRoZSBpbnRlcnZhbCB2YWx1ZSBzZWVtcyB0byBj
b21lIGZyb20KPiBzbmRfdXNiX3BhcnNlX2RhdGFpbnRlcnZhbCgpIHdoaWNoIGlzIGJJbnRlcnZh
bCAtIDEgYW5kIG9ubHkgaW4gdGhlIHJhZ2UgMSDigKYgNC4KPiBTbyBpbiBvcmRlciB0byBrZWVw
IHRoZSBtYWdpYyB3b2tyaW5nIEkgcGFzcyBkYXRhaW50ZXJ2YWwgKyAxLgoKICAgIFdvcmtpbmcu
Cgo+IENjOiBKYXJvc2xhdiBLeXNlbGEgPHBlcmV4QHBlcmV4LmN6Pgo+IENjOiBUYWthc2hpIEl3
YWkgPHRpd2FpQHN1c2UuY29tPgo+IFNpZ25lZC1vZmYtYnk6IFNlYmFzdGlhbiBBbmRyemVqIFNp
ZXdpb3IgPGJpZ2Vhc3lAbGludXRyb25peC5kZT4KWy4uLl0KCk1CUiwgU2VyZ2VpCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGlu
ZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXBy
b2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
