From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH] ALSA: snd-usb: Fix uninitialized variable usage
Date: Sat,  6 Aug 2011 00:23:18 +0200
Message-ID: <1312582998-25390-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
	by alsa0.perex.cz (Postfix) with ESMTP id 05FFF1039DD
	for <alsa-devel@alsa-project.org>;
	Sat,  6 Aug 2011 00:23:37 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

UHVyZWx5IGNvc21ldGljLCBidXQgZml4ZXMgdGhlIGZvbGxvd2luZyBidWlsZCB3YXJuaW5nLgoK
ICBDQyBbTV0gIHNvdW5kL3VzYi9xdWlya3Mubwpzb3VuZC91c2IvcXVpcmtzLmM6IEluIGZ1bmN0
aW9uIOKAmHNuZF91c2JfYXBwbHlfYm9vdF9xdWlya+KAmToKc291bmQvdXNiL3F1aXJrcy5jOjQy
OTo2OiB3YXJuaW5nOiDigJhlcnLigJkgbWF5IGJlIHVzZWQgdW5pbml0aWFsaXplZCBpbiB0aGlz
IGZ1bmN0aW9uIFstV3VuaW5pdGlhbGl6ZWRdCgpTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgTWFjayA8
em9ucXVlQGdtYWlsLmNvbT4KQ2M6IFRha2FzaGkgSXdhaSA8dGl3YWlAc3VzZS5kZT4KLS0tCiBz
b3VuZC91c2IvcXVpcmtzLmMgfCAgICAyICstCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zb3VuZC91c2IvcXVpcmtzLmMgYi9z
b3VuZC91c2IvcXVpcmtzLmMKaW5kZXggNzc3NjJjOS4uODFlMDdkOCAxMDA2NDQKLS0tIGEvc291
bmQvdXNiL3F1aXJrcy5jCisrKyBiL3NvdW5kL3VzYi9xdWlya3MuYwpAQCAtNDI2LDcgKzQyNiw3
IEBAIHN0YXRpYyBpbnQgc25kX3VzYl9jbTEwNl9ib290X3F1aXJrKHN0cnVjdCB1c2JfZGV2aWNl
ICpkZXYpCiAgKi8KIHN0YXRpYyBpbnQgc25kX3VzYl9jbTYyMDZfYm9vdF9xdWlyayhzdHJ1Y3Qg
dXNiX2RldmljZSAqZGV2KQogewotCWludCBlcnIsIHJlZzsKKwlpbnQgZXJyICA9IDAsIHJlZzsK
IAlpbnQgdmFsW10gPSB7MHgyMDA0LCAweDMwMDAsIDB4ZjgwMCwgMHgxNDNmLCAweDAwMDAsIDB4
MzAwMH07CiAKIAlmb3IgKHJlZyA9IDA7IHJlZyA8IEFSUkFZX1NJWkUodmFsKTsgcmVnKyspIHsK
LS0gCjEuNy42CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0
cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
