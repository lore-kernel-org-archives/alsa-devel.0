From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: PulseAudio and SNDRV_PCM_INFO_BATCH
Date: Mon, 22 Jun 2015 15:49:16 +0800
Message-ID: <CAN8cciZT2R=+qsokZR2XRUcAbh4XiexvP2kxzU7S_3uacH7sSw@mail.gmail.com>
References: <CACuU-+jBWck1e3tf--=G+X3xNAQm++JCxRzQFkDUJ4f5zwhgoQ@mail.gmail.com>
 <557E86DD.8020709@metafoo.de>
 <CAN8cciYApKja0e0U7Uy2YG2ySemfhvKfLGUueGyFx5ajjyqKBA@mail.gmail.com>
 <557EBEAA.70004@metafoo.de>
 <CAN8cciZ4B2X+o4AXdCGEEAFCcX+iWqyf+FvMkEkrSu3Vt8Vx8Q@mail.gmail.com>
 <557EDE22.7080808@metafoo.de>
 <CAN8ccibPTkiayx_9ETOwjw1dSF+UPsxjgcqWJR+mm149c69WBg@mail.gmail.com>
 <5587AE77.1020709@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f48.google.com (mail-oi0-f48.google.com
 [209.85.218.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 01EF1261615
 for <alsa-devel@alsa-project.org>; Mon, 22 Jun 2015 09:49:18 +0200 (CEST)
Received: by oiyy130 with SMTP id y130so98953245oiy.0
 for <alsa-devel@alsa-project.org>; Mon, 22 Jun 2015 00:49:16 -0700 (PDT)
In-Reply-To: <5587AE77.1020709@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, clemens@ladisch.de, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Arun Raghavan <arun@accosted.net>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

MjAxNS02LTIyIOS4i+WNiDI6NDMg5pa8ICJMYXJzLVBldGVyIENsYXVzZW4iIDxsYXJzQG1ldGFm
b28uZGU+IOWvq+mBk++8mgo+Cj4gT24gMDYvMjIvMjAxNSAwNDozNSBBTSwgUmF5bW9uZCBZYXUg
d3JvdGU6Cj4+Cj4+Cj4+ICA+Cj4+ICA+IERNQV9SRVNJRFVFX0dSQU5VTEFSSVRZX0JVUlNUIG1l
YW5zIGl0IGNhbiByZXBvcnQgdGhlIHBvc2l0aW9uIHdpdGggYQo+PiBncmFudWxhcml0eSBvZiBh
IGZldyBzYW1wbGVzLiBUeXBpY2FsbHkgaGFsZiB0aGUgYXVkaW8gRklGTyBzaXplLgo+PiAgPgo+
PiAgPgo+Pgo+PiBIb3cgbWFueSBzb2MgZHJpdmVyL3BsYXRmb3JtIGRtYSBlbmdpbmUgc3VwcG9y
dApETUFfUkVTSURVRV9HUkFOVUxBUklUWV9CVVJTVCA/Cj4KPgo+IE5vdCBzdXJlLCBtYXliZSBo
YWxmIG9mIHRoZW0uIEJ1dCBtb3N0IG9mIHRoZSB0aW1lIGl0IGlzIGEgc29mdHdhcmUKcmVzdHJp
Y3Rpb24gcmF0aGVyIHRoYW4gYSBoYXJkd2FyZSByZXN0cmljdGlvbiBhbmQgbW9yZSBhbmQgbW9y
ZSBkcml2ZXJzCmFyZSBzdXBwb3J0aW5nIGl0LgoKaHR0cHM6Ly9idWdzLmZyZWVkZXNrdG9wLm9y
Zy9hdHRhY2htZW50LmNnaT9pZD0xMDc2NTAKCnNuZF9ycGlfaGlmaWJlcnJ5X2FtcAoKZ3JhbnVs
YXJpdHkgc2VlbSA0IGZyYW1lcyBtb3N0IG9mIHRoZSB0aW1lIGJ1dCBzb21ldGltZSB0aGVyZSBp
cyBhIGxhcmdlCmRlbGF5IGJldHdlZW4gMzU4NCBhbmQgMzk4OCAsc2VlbSBjYW5ub3QgcmVhY2gg
NDA5NgoKQXZhaWxhYmxlOiAzNTgwLCBsb29wIGl0ZXJhdGlvbjogNDIwCkF2YWlsYWJsZTogMzU4
NCwgbG9vcCBpdGVyYXRpb246IDQyMQpBdmFpbGFibGU6IDM5ODgsIGxvb3AgaXRlcmF0aW9uOiA0
MjIKQXZhaWxhYmxlOiAzOTk2LCBsb29wIGl0ZXJhdGlvbjogNDIzCkF2YWlsYWJsZTogNDAwNCwg
bG9vcCBpdGVyYXRpb246IDQyNApBdmFpbGFibGU6IDQwMTIsIGxvb3AgaXRlcmF0aW9uOiA0MjUK
CkFyZSB0aGUgcG9pbnRlciBjYWxsYmFjayByZWFsbHkgdXNlIHZhbHVlIHJlYWQgZnJvbSBoYXJk
d2FyZSByZWdpc3RlciBvcgp2YWx1ZSBjYWxjdWxhdGVkIGZyb20gY2xvY2sgPwpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcg
bGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9q
ZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
