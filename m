From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] ALSA: hda - Remove ignore_misc_bit
Date: Tue, 25 Sep 2012 23:38:22 +0800
Message-ID: <CAN8cciZZM6OExsJuAVbXVZUxS+fSUF3YSPVkDo5f8=BRdYTMwg@mail.gmail.com>
References: <1346995544-6754-1-git-send-email-david.henningsson@canonical.com>
 <CAN8cciYZBU+LaaQFXrn9kPoFc=MdYahw0ucKNmAhrG=CT0+C5g@mail.gmail.com>
 <s5h392rhbyu.wl%tiwai@suse.de> <5056D395.4090603@canonical.com>
 <CAN8cciZVWqzzN+vXvGqheUHxQmY_RrwF-ekV+O1Vd4FYn=1QeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
 [209.85.216.179])
 by alsa0.perex.cz (Postfix) with ESMTP id E549C261739
 for <alsa-devel@alsa-project.org>; Tue, 25 Sep 2012 17:38:23 +0200 (CEST)
Received: by qcsb14 with SMTP id b14so3366466qcs.38
 for <alsa-devel@alsa-project.org>; Tue, 25 Sep 2012 08:38:22 -0700 (PDT)
In-Reply-To: <CAN8cciZVWqzzN+vXvGqheUHxQmY_RrwF-ekV+O1Vd4FYn=1QeA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, 939161@bugs.launchpad.net
List-Id: alsa-devel@alsa-project.org

MjAxMi05LTE5IOS4iuWNiDg6MzUg5pa8ICJSYXltb25kIFlhdSIgPHN1cGVycXVhZC52b3J0ZXgy
QGdtYWlsLmNvbT4g5a+r6YGT77yaCj4KPiA+Pj4gZG8geW91IG1lYW4gdGhlIGNvbW1pdCBkb2Vz
IG5vdCBmaXggdGhlIGJ1Zz8KPiA+Pj4KPiA+Pj4gQUxTQTogaGRhIC0gYWRkIHN1cHBvcnQgZm9y
IFVuaXdpbGwgRUNTIE0zMUVJIG5vdGVib29rCj4gPj4+Cj4gPj4+IFRoaXMgaGFyZHdhcmUgcmVx
dWlyZXMgc2FtZSBmaXh1cCBmb3IgdGhlIG5vZGUgMHgwZiBsaWtlIEFzdXMgQTZScC4KPiA+Pj4g
TW9yZSBpbmZvcm1hdGlvbjogaHR0cHM6Ly9idWd6aWxsYS5yZWRoYXQuY29tL3Nob3dfYnVnLmNn
aT9pZD03ODU0MTcKPiA+Pj4KPiA+Pj4KaHR0cDovL2dpdC5rZXJuZWwub3JnLz9wPWxpbnV4L2tl
cm5lbC9naXQvdGl3YWkvc291bmQuZ2l0O2E9Y29tbWl0O2g9NDE2ODQ2ZDJiMzFmYzc0MGVkOWQ1
YTVlYzExNjk2NGZiNDNjNG8zNTgKPgo+ID4KPiA+Cj4gPiBUaGUgUENJIFNTSURzIGFyZSBkaWZm
ZXJlbnQsIHNvIEkgZG9uJ3QgdGhpbmsgdGhhdCBjb21taXQgd2lsbCBhZmZlY3QKdGhlIGJ1ZyBJ
IHdhcyB0cnlpbmcgdG8gZml4LgoKaHR0cHM6Ly9sYXVuY2hwYWRsaWJyYXJpYW4ubmV0LzkzODEw
MDY4L1BjaU11bHRpbWVkaWEudHh0CgowMDoxYi4wIEF1ZGlvIGRldmljZSBbMDQwM106IEludGVs
IENvcnBvcmF0aW9uIE4xMC9JQ0ggNyBGYW1pbHkgSGlnaApEZWZpbml0aW9uIEF1ZGlvIENvbnRy
b2xsZXIgWzgwODY6MjdkOF0gKHJldiAwMikKU3Vic3lzdGVtOiBVbml3aWxsIENvbXB1dGVyIENv
cnAgRGV2aWNlIFsxNTg0OjkwNzJdCgpodHRwczovL2xhdW5jaHBhZGxpYnJhcmlhbi5uZXQvOTM4
MTAwNjQvQ2FyZDAuQ29kZWNzLmNvZGVjLjAudHh0CgpDb2RlYzogUmVhbHRlayBBTEM4NjEKQWRk
cmVzczogMApBRkcgRnVuY3Rpb24gSWQ6IDB4MSAodW5zb2wgMCkKVmVuZG9yIElkOiAweDEwZWMw
ODYxClN1YnN5c3RlbSBJZDogMHgxNTg0MDAwMApSZXZpc2lvbiBJZDogMHgxMDAzMDAKCmh0dHBz
Oi8vYnVnemlsbGEucmVkaGF0LmNvbS9hdHRhY2htZW50LmNnaT9pZD01NTk1ODIKCkFkdmFuY2Vk
IGluZm9ybWF0aW9uIC0gUENJIFZlbmRvci9EZXZpY2UvU3Vic3lzdGVtIElEJ3MKISEtLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQoKMDA6MWIu
MCAwNDAzOiA4MDg2OjI3ZDggKHJldiAwMikKU3Vic3lzdGVtOiAxNTg0OjkwNzIKCkNvZGVjOiBS
ZWFsdGVrIEFMQzg2MQpBZGRyZXNzOiAwCkFGRyBGdW5jdGlvbiBJZDogMHgxICh1bnNvbCAwKQpW
ZW5kb3IgSWQ6IDB4MTBlYzA4NjEKU3Vic3lzdGVtIElkOiAweDE1ODQwMDAwClJldmlzaW9uIElk
OiAweDEwMDMwMApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0
cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
