From: John Spencer <maillist-alsa@barfooze.de>
Subject: [PATCH 1/2] alsa-lib: conf.c: use portable way to
 initialize recursive mutex
Date: Fri, 08 Nov 2013 14:03:50 +0100
Message-ID: <527CE136.3090500@barfooze.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020801010407010803030007"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from furnace.wzff.de (furnace.wzff.de [176.9.216.40])
 by alsa0.perex.cz (Postfix) with ESMTP id A34762656F2
 for <alsa-devel@alsa-project.org>; Fri,  8 Nov 2013 14:03:51 +0100 (CET)
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
Cc: =?UTF-8?B?VGltbyBUZXLDpHM=?= <timo.teras@iki.fi>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------020801010407010803030007
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

attaching the patch, as i currently have problems with git-send-email,
and it would force me to use the wrong author name.

got the OK from Timo on IRC to send his patch.

thanks,
--JS


--------------020801010407010803030007
Content-Type: text/plain;
 name*0="0001-conf.c-use-portable-way-to-initialize-recursive-mute.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename*0="0001-conf.c-use-portable-way-to-initialize-recursive-mute.pa";
 filename*1="tch"

RnJvbSBkYzI4YjExODNhZjczZTIwNWQ4MzU0MTRjYWNjOWQ5ZGZkZjhhZjAyIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBUaW1vIFRlcsOkcyA8dGltby50ZXJhc0Bpa2kuZmk+
CkRhdGU6IEZyaSwgOCBOb3YgMjAxMyAxMzoxNzo1OCArMDEwMApTdWJqZWN0OiBbUEFUQ0hd
IGNvbmYuYzogdXNlIHBvcnRhYmxlIHdheSB0byBpbml0aWFsaXplIHJlY3Vyc2l2ZSBtdXRl
eApNSU1FLVZlcnNpb246IDEuMApDb250ZW50LVR5cGU6IHRleHQvcGxhaW47IGNoYXJzZXQ9
VVRGLTgKQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzogOGJpdAoKUFRIUkVBRF9SRUNVUlNJ
VkVfTVVURVhfSU5JVElBTElaRVJfTlAgaXMgbm90IGluIFBPU0lYLCBhcyBfTlAKKG5vbi1w
b3J0YWJsZSkgc3VnZ2VzdHMuCgpleHBvc2luZyBzdWNoIGEgc3ltYm9sIGluIG11c2wgbGli
YyB3b3VsZCBsb2NrIGluIHRoZSBBQkkgZm9yIGFsbAp0aW1lcyBhbmQgbWFrZXMgaXQgaW1w
b3NzaWJsZSB0byBkbyBmdXR1cmUgY2hhbmdlcyB0byB0aGUgdW5kZXItCmx5aW5nIHN0cnVj
dCB3aXRob3V0IGhpZGVvdXMgc3ltYm9sIHZlcnNpb25pbmcgaGFja3MuCgp1c2UgdGhlIHBv
cnRhYmxlIHdheSBpbnN0ZWFkOiBwdGhyZWFkX29uY2Ugd2FzIGRlc2lnbmVkIGZvciBzdWNo
CmNhc2VzLgoKU2lnbmVkLW9mZi1ieTogVGltbyBUZXLDpHMgPHRpbW8udGVyYXNAaWtpLmZp
PgpUZXN0ZWQtYnk6IEpvaG4gU3BlbmNlciA8bWFpbGxpc3QtYWxzYUBiYXJmb296ZS5kZT4K
LS0tCiBzcmMvY29uZi5jIHwgMTUgKysrKysrKysrKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwg
MTMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zcmMvY29u
Zi5jIGIvc3JjL2NvbmYuYwppbmRleCBiZmVkMWM0Li41Y2NjOGUxIDEwMDY0NAotLS0gYS9z
cmMvY29uZi5jCisrKyBiL3NyYy9jb25mLmMKQEAgLTQyNyw4ICs0MjcsOCBAQCBiZWdpbm5p
bmc6PC9QPgogI2lmbmRlZiBET0NfSElEREVOCiAKICNpZmRlZiBIQVZFX0xJQlBUSFJFQUQK
LXN0YXRpYyBwdGhyZWFkX211dGV4X3Qgc25kX2NvbmZpZ191cGRhdGVfbXV0ZXggPQotCQkJ
CVBUSFJFQURfUkVDVVJTSVZFX01VVEVYX0lOSVRJQUxJWkVSX05QOworc3RhdGljIHB0aHJl
YWRfbXV0ZXhfdCBzbmRfY29uZmlnX3VwZGF0ZV9tdXRleDsKK3N0YXRpYyBwdGhyZWFkX29u
Y2VfdCBzbmRfY29uZmlnX3VwZGF0ZV9tdXRleF9vbmNlID0gUFRIUkVBRF9PTkNFX0lOSVQ7
CiAjZW5kaWYKIAogc3RydWN0IF9zbmRfY29uZmlnIHsKQEAgLTQ3Miw4ICs0NzIsMTkgQEAg
dHlwZWRlZiBzdHJ1Y3QgewogCiAjaWZkZWYgSEFWRV9MSUJQVEhSRUFECiAKK3N0YXRpYyB2
b2lkIHNuZF9jb25maWdfaW5pdF9tdXRleCh2b2lkKQoreworCXB0aHJlYWRfbXV0ZXhhdHRy
X3QgYXR0cjsKKworCXB0aHJlYWRfbXV0ZXhhdHRyX2luaXQoJmF0dHIpOworCXB0aHJlYWRf
bXV0ZXhhdHRyX3NldHR5cGUoJmF0dHIsIFBUSFJFQURfTVVURVhfUkVDVVJTSVZFKTsKKwlw
dGhyZWFkX211dGV4X2luaXQoJnNuZF9jb25maWdfdXBkYXRlX211dGV4LCAmYXR0cik7CisJ
cHRocmVhZF9tdXRleGF0dHJfZGVzdHJveSgmYXR0cik7Cit9CisKIHN0YXRpYyBpbmxpbmUg
dm9pZCBzbmRfY29uZmlnX2xvY2sodm9pZCkKIHsKKwlwdGhyZWFkX29uY2UoJnNuZF9jb25m
aWdfdXBkYXRlX211dGV4X29uY2UsIHNuZF9jb25maWdfaW5pdF9tdXRleCk7CiAJcHRocmVh
ZF9tdXRleF9sb2NrKCZzbmRfY29uZmlnX3VwZGF0ZV9tdXRleCk7CiB9CiAKLS0gCjEuOC40
Cgo=
--------------020801010407010803030007
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------020801010407010803030007--
