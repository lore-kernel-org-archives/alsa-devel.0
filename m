From: John Spencer <maillist-alsa@barfooze.de>
Subject: [PATCH] snd_dlsym: only do versioning checks if built
	--with-versioning
Date: Sat, 15 Nov 2014 13:55:54 +0100
Message-ID: <54674D5A.3010500@barfooze.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070107010405070503040906"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hindenburg.barfooze.de (hindenburg.barfooze.de [195.154.9.123])
 by alsa0.perex.cz (Postfix) with ESMTP id E3E562605B1
 for <alsa-devel@alsa-project.org>; Sat, 15 Nov 2014 13:57:11 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: sabotage@lists.openwall.com
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070107010405070503040906
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

 From 291553a0132936611d48f41e924601dff8941537 Mon Sep 17 00:00:00 2001
From: John Spencer <maillist-alsa@barfooze.de>
Date: Sat, 15 Nov 2014 13:41:00 +0100
Subject: [PATCH] snd_dlsym: only do versioning checks if built 
--with-versioning

a combination of some of the following garbage collecting LD/CFLAGS
-Os -g0 -fdata-sections -ffunction-sections -s -Wl,--gc-sections
-fno-unwind-tables -fno-asynchronous-unwind-tables
causes the symbol versioning marker symbols to be removed from BSS
since they're otherwise unreferenced. this causes dlsym failing to
find them which results in runtime breakage:

$ alsamixer
ALSA lib dlmisc.c:142:(snd_dlsym_verify) unable to verify version for 
symbol snd_config_hook_load
ALSA lib conf.c:3328:(snd_config_hooks_call) symbol snd_config_hook_load 
is not defined inside (null)
ALSA lib conf.c:3788:(snd_config_update_r) hooks failed, removing 
configuration
cannot open mixer: No such device or address

correct DSO:
$ objdump -T libasound.so.2.strip | grep 
_snd_config_hook_load_dlsym_config_hook_001
001196bc g    DO .bss   00000001 _snd_config_hook_load_dlsym_config_hook_001

incorrect DSO:
$ objdump -T libs/libasound.so.2 | grep 
_snd_config_hook_load_dlsym_config_hook_001
00000000 g    DO *ABS*  00000001 _snd_config_hook_load_dlsym_config_hook_001

since alsa was built with --without-versioning, doing those versioning
checks at all is unnecessary and harmful and thus now disabled in this case.

Signed-off-by: John Spencer <maillist-alsa@barfooze.de>

---
  src/dlmisc.c | 2 ++
  1 file changed, 2 insertions(+)


--------------070107010405070503040906
Content-Type: text/plain;
 name*0="0001-snd_dlsym-only-do-versioning-checks-if-built-with-ve.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename*0="0001-snd_dlsym-only-do-versioning-checks-if-built-with-ve.pa";
 filename*1="tch"

RnJvbSAyOTE1NTNhMDEzMjkzNjYxMWQ0OGY0MWU5MjQ2MDFkZmY4OTQxNTM3IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIFNwZW5jZXIgPG1haWxsaXN0LWFsc2FAYmFy
Zm9vemUuZGU+CkRhdGU6IFNhdCwgMTUgTm92IDIwMTQgMTM6NDE6MDAgKzAxMDAKU3ViamVj
dDogW1BBVENIXSBzbmRfZGxzeW06IG9ubHkgZG8gdmVyc2lvbmluZyBjaGVja3MgaWYgYnVp
bHQgLS13aXRoLXZlcnNpb25pbmcKCmEgY29tYmluYXRpb24gb2Ygc29tZSBvZiB0aGUgZm9s
bG93aW5nIGdhcmJhZ2UgY29sbGVjdGluZyBMRC9DRkxBR1MKLU9zIC1nMCAtZmRhdGEtc2Vj
dGlvbnMgLWZmdW5jdGlvbi1zZWN0aW9ucyAtcyAtV2wsLS1nYy1zZWN0aW9ucwotZm5vLXVu
d2luZC10YWJsZXMgLWZuby1hc3luY2hyb25vdXMtdW53aW5kLXRhYmxlcwpjYXVzZXMgdGhl
IHN5bWJvbCB2ZXJzaW9uaW5nIG1hcmtlciBzeW1ib2xzIHRvIGJlIHJlbW92ZWQgZnJvbSBC
U1MKc2luY2UgdGhleSdyZSBvdGhlcndpc2UgdW5yZWZlcmVuY2VkLiB0aGlzIGNhdXNlcyBk
bHN5bSBmYWlsaW5nIHRvCmZpbmQgdGhlbSB3aGljaCByZXN1bHRzIGluIHJ1bnRpbWUgYnJl
YWthZ2U6CgokIGFsc2FtaXhlcgpBTFNBIGxpYiBkbG1pc2MuYzoxNDI6KHNuZF9kbHN5bV92
ZXJpZnkpIHVuYWJsZSB0byB2ZXJpZnkgdmVyc2lvbiBmb3Igc3ltYm9sIHNuZF9jb25maWdf
aG9va19sb2FkCkFMU0EgbGliIGNvbmYuYzozMzI4OihzbmRfY29uZmlnX2hvb2tzX2NhbGwp
IHN5bWJvbCBzbmRfY29uZmlnX2hvb2tfbG9hZCBpcyBub3QgZGVmaW5lZCBpbnNpZGUgKG51
bGwpCkFMU0EgbGliIGNvbmYuYzozNzg4OihzbmRfY29uZmlnX3VwZGF0ZV9yKSBob29rcyBm
YWlsZWQsIHJlbW92aW5nIGNvbmZpZ3VyYXRpb24KY2Fubm90IG9wZW4gbWl4ZXI6IE5vIHN1
Y2ggZGV2aWNlIG9yIGFkZHJlc3MKCmNvcnJlY3QgRFNPOgokIG9iamR1bXAgLVQgbGliYXNv
dW5kLnNvLjIuc3RyaXAgfCBncmVwIF9zbmRfY29uZmlnX2hvb2tfbG9hZF9kbHN5bV9jb25m
aWdfaG9va18wMDEKMDAxMTk2YmMgZyAgICBETyAuYnNzICAgMDAwMDAwMDEgX3NuZF9jb25m
aWdfaG9va19sb2FkX2Rsc3ltX2NvbmZpZ19ob29rXzAwMQoKaW5jb3JyZWN0IERTTzoKJCBv
YmpkdW1wIC1UIGxpYnMvbGliYXNvdW5kLnNvLjIgfCBncmVwIF9zbmRfY29uZmlnX2hvb2tf
bG9hZF9kbHN5bV9jb25maWdfaG9va18wMDEKMDAwMDAwMDAgZyAgICBETyAqQUJTKiAgMDAw
MDAwMDEgX3NuZF9jb25maWdfaG9va19sb2FkX2Rsc3ltX2NvbmZpZ19ob29rXzAwMQoKc2lu
Y2UgYWxzYSB3YXMgYnVpbHQgd2l0aCAtLXdpdGhvdXQtdmVyc2lvbmluZywgZG9pbmcgdGhv
c2UgdmVyc2lvbmluZwpjaGVja3MgYXQgYWxsIGlzIHVubmVjZXNzYXJ5IGFuZCBoYXJtZnVs
IGFuZCB0aHVzIG5vdyBkaXNhYmxlZCBpbiB0aGlzIGNhc2UuCgpTaWduZWQtb2ZmLWJ5OiBK
b2huIFNwZW5jZXIgPG1haWxsaXN0LWFsc2FAYmFyZm9vemUuZGU+CgotLS0KIHNyYy9kbG1p
c2MuYyB8IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1n
aXQgYS9zcmMvZGxtaXNjLmMgYi9zcmMvZGxtaXNjLmMKaW5kZXggNGI4YTAyYy4uNjJmNzA0
NyAxMDA2NDQKLS0tIGEvc3JjL2RsbWlzYy5jCisrKyBiL3NyYy9kbG1pc2MuYwpAQCAtMTc3
LDExICsxNzcsMTMgQEAgdm9pZCAqc25kX2Rsc3ltKHZvaWQgKmhhbmRsZSwgY29uc3QgY2hh
ciAqbmFtZSwgY29uc3QgY2hhciAqdmVyc2lvbikKIAl9CiAjZW5kaWYKICNpZmRlZiBIQVZF
X0xJQkRMCisjaWZkZWYgVkVSU0lPTkVEX1NZTUJPTFMKIAlpZiAodmVyc2lvbikgewogCQll
cnIgPSBzbmRfZGxzeW1fdmVyaWZ5KGhhbmRsZSwgbmFtZSwgdmVyc2lvbik7CiAJCWlmIChl
cnIgPCAwKQogCQkJcmV0dXJuIE5VTEw7CiAJfQorI2VuZGlmCiAJcmV0dXJuIGRsc3ltKGhh
bmRsZSwgbmFtZSk7CiAjZWxzZQogCXJldHVybiBOVUxMOwotLSAKMS44LjQKCg==
--------------070107010405070503040906
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------070107010405070503040906--
