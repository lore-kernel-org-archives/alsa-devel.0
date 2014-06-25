From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: alsa-tools 1.0.28 regression with sblive/emu10k1:
 init_live shell script broken.
Date: Wed, 25 Jun 2014 18:57:46 +0200
Message-ID: <53AAFF8A.5060809@ladisch.de>
References: <CAPq5wtZVZpYvBJ2TK-oG5kEbfc95bz4_nVKxzcWXwGXWnWHQgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 0ECE72619F7
 for <alsa-devel@alsa-project.org>; Wed, 25 Jun 2014 18:58:28 +0200 (CEST)
In-Reply-To: <CAPq5wtZVZpYvBJ2TK-oG5kEbfc95bz4_nVKxzcWXwGXWnWHQgw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?B?Um9jIFZhbGzDqHM=?= <vallesroc@gmail.com>, Elimar Riesebieter <riesebie@lxtec.de>, Jordi Mallach <jordi@debian.org>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Um9jIFZhbGzDqHMgd3JvdGU6Cj4gSSd2ZSByZWNlbnRseSB1cGdyYWRlZCB0byBhbHNhLXRvb2xz
IDEuMC4yOC4gVGhlcmUncyBhcHBhcmVudGx5IGEKPiByZWdyZXNzaW9uOiBsaXZlX2luaXQsIHRo
ZSBzY3JpcHQgdGhhdCBpcyBidW5kbGVkIGZvciBzb3VuZCBibGFzdGVyCj4gbGl2ZSBzb3VuZGNh
cmQgaW5pdGlhbGl6YXRpb24sIGhhcyBiZWVuIGJyb2tlbi4KPgo+ICMgL3Vzci9iaW4vaW5pdF9s
aXZlCj4gL3Vzci9iaW4vaW5pdF9saXZlOiBsaW5lIDQ5OiBsb2c6IGNvbW1hbmQgbm90IGZvdW5k
Cj4gL3Vzci9iaW4vaW5pdF9saXZlOiBsaW5lIDUxOiBsb2NhbDogY2FuIG9ubHkgYmUgdXNlZCBp
biBhIGZ1bmN0aW9uCj4gLi4uCgpCcm9rZW4gYnkgdGhlIHBhdGNoIGJlbG93LiAgV2hlcmUgYXJl
IHRoZSBwYXJlbnRoZXNlcz8KCgogICAgY29tbWl0IGExNzI4MjUwM2Y0Y2ViNjJmNjZlYjVhMjg3
MjZmZDA5NmFmMGE3MGIKICAgIEF1dGhvcjogRWxpbWFyIFJpZXNlYmlldGVyIDxyaWVzZWJpZUBs
eHRlYy5kZT4KICAgIERhdGU6ICAgV2VkIE1heSAxNSAxOToxOTowNyAyMDEzICswMjAwCgogICAg
Rml4IGJhc2hpc21zLgoKICAgIFRoZSAiwoDCnGZ1bmN0aW9uIsKAwp0gYnVpbHRpbiBpcyBhIGJh
c2hpc20gdGhhdCBjYW4gYmUgc2ltcGx5IG9taXR0ZWQgd2l0aAogICAgbm8gYmVoYXZpb3VyIGNo
YW5nZSwgaWYgcGFyZW50aGVzZXMgYXJlIHN1cHBsaWVkLgoKICAgIFNpZ25lZC1vZmYtYnk6IEpv
cmRpIE1hbGxhY2ggPGpvcmRpQGRlYmlhbi5vcmc+CiAgICBTaWduZWQtb2ZmLWJ5OiBUYWthc2hp
IEl3YWkgPHRpd2FpQHN1c2UuZGU+CgogICAgZGlmZiAtLWdpdCBhL2xkMTBrMS9zZXR1cC9pbml0
X2xpdmUuaW4gYi9sZDEwazEvc2V0dXAvaW5pdF9saXZlLmluCiAgICBpbmRleCA3MGQzMGM4Li41
ZTY1ODBmIDEwMDY0NAogICAgLS0tIGEvbGQxMGsxL3NldHVwL2luaXRfbGl2ZS5pbgogICAgKysr
IGIvbGQxMGsxL3NldHVwL2luaXRfbGl2ZS5pbgogICAgQEAgLTQ2LDcgKzQ2LDcgQEAgc3RkX3Bs
YXliYWNrPXBsYXliYWNrCiAgICAgc3RkX2NhcHR1cmU9Y2FwdHVyZQogICAgICNzdGRfY2FwdHVy
ZT1jYXB0dXJlX25vc3dpdGNoCgogICAgLWZ1bmN0aW9uIGxvZwogICAgK2xvZwogICAgIHsKICAg
ICAgICAgbG9jYWwgbGV2ZWw9JDEKICAgIC4uLgoKClJlZ2FyZHMsCkNsZW1lbnMKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5n
IGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJv
amVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
