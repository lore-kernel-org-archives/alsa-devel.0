From: John Spencer <maillist-alsa@barfooze.de>
Subject: [PATCH 2/2] alsa-utils: pcmjob.c: use portable way to
 initialize recursive mutex
Date: Fri, 08 Nov 2013 14:03:52 +0100
Message-ID: <527CE138.9060805@barfooze.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040201070802030204070305"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from furnace.wzff.de (furnace.wzff.de [176.9.216.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 02A192656CB
 for <alsa-devel@alsa-project.org>; Fri,  8 Nov 2013 14:03:54 +0100 (CET)
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
--------------040201070802030204070305
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

attaching the patch, as i currently have problems with git-send-email.

thanks,
--JS

--------------040201070802030204070305
Content-Type: text/plain;
 name*0="0001-pcmjob.c-use-portable-way-to-initialize-recursive-mu.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename*0="0001-pcmjob.c-use-portable-way-to-initialize-recursive-mu.pa";
 filename*1="tch"

RnJvbSBmYWVkMDZmZDRhM2I5N2VlN2Y0YjQ2YzYwZTNhODI4ZTQ3ODQ1ZDBlIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIFNwZW5jZXIgPG1haWxsaXN0LWFsc2FAYmFy
Zm9vemUuZGU+CkRhdGU6IEZyaSwgOCBOb3YgMjAxMyAxMzo1OTo0MSArMDEwMApTdWJqZWN0
OiBbUEFUQ0hdIHBjbWpvYi5jOiB1c2UgcG9ydGFibGUgd2F5IHRvIGluaXRpYWxpemUgcmVj
dXJzaXZlIG11dGV4CgpQVEhSRUFEX1JFQ1VSU0lWRV9NVVRFWF9JTklUSUFMSVpFUl9OUCBp
cyBub3QgaW4gUE9TSVgsIGFzIF9OUAoobm9uLXBvcnRhYmxlKSBzdWdnZXN0cy4KCmV4cG9z
aW5nIHN1Y2ggYSBzeW1ib2wgaW4gbXVzbCBsaWJjIHdvdWxkIGxvY2sgaW4gdGhlIEFCSSBm
b3IgYWxsCnRpbWVzIGFuZCBtYWtlcyBpdCBpbXBvc3NpYmxlIHRvIGRvIGZ1dHVyZSBjaGFu
Z2VzIHRvIHRoZSB1bmRlci0KbHlpbmcgc3RydWN0IHdpdGhvdXQgaGlkZW91cyBzeW1ib2wg
dmVyc2lvbmluZyBoYWNrcy4KCnVzZSB0aGUgcG9ydGFibGUgd2F5IGluc3RlYWQ6IHB0aHJl
YWRfb25jZSB3YXMgZGVzaWduZWQgZm9yIHN1Y2gKY2FzZXMuCgpTaWduZWQtb2ZmLWJ5OiBK
b2huIFNwZW5jZXIgPG1haWxsaXN0LWFsc2FAYmFyZm9vemUuZGU+ClRlc3RlZC1ieTogSm9o
biBTcGVuY2VyIDxtYWlsbGlzdC1hbHNhQGJhcmZvb3plLmRlPgotLS0KIGFsc2Fsb29wL3Bj
bWpvYi5jIHwgMTUgKysrKysrKysrKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hbHNhbG9vcC9wY21qb2Iu
YyBiL2Fsc2Fsb29wL3BjbWpvYi5jCmluZGV4IDEzOWI2ZmQuLmYzMjE4MGMgMTAwNjQ0Ci0t
LSBhL2Fsc2Fsb29wL3BjbWpvYi5jCisrKyBiL2Fsc2Fsb29wL3BjbWpvYi5jCkBAIC02Miwx
MSArNjIsMjIgQEAgc3RhdGljIGNvbnN0IGNoYXIgKnNyY190eXBlc1tdID0gewogfTsKICNl
bmRpZgogCi1zdGF0aWMgcHRocmVhZF9tdXRleF90IHBjbV9vcGVuX211dGV4ID0KLSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgUFRIUkVBRF9SRUNVUlNJVkVfTVVURVhfSU5J
VElBTElaRVJfTlA7CitzdGF0aWMgcHRocmVhZF9vbmNlX3QgcGNtX29wZW5fbXV0ZXhfb25j
ZSA9IFBUSFJFQURfT05DRV9JTklUOworc3RhdGljIHB0aHJlYWRfbXV0ZXhfdCBwY21fb3Bl
bl9tdXRleDsKKworc3RhdGljIHZvaWQgcGNtX29wZW5faW5pdF9tdXRleCh2b2lkKQorewor
CXB0aHJlYWRfbXV0ZXhhdHRyX3QgYXR0cjsKKworCXB0aHJlYWRfbXV0ZXhhdHRyX2luaXQo
JmF0dHIpOworCXB0aHJlYWRfbXV0ZXhhdHRyX3NldHR5cGUoJmF0dHIsIFBUSFJFQURfTVVU
RVhfUkVDVVJTSVZFKTsKKwlwdGhyZWFkX211dGV4X2luaXQoJnBjbV9vcGVuX211dGV4LCAm
YXR0cik7CisJcHRocmVhZF9tdXRleGF0dHJfZGVzdHJveSgmYXR0cik7Cit9CiAKIHN0YXRp
YyBpbmxpbmUgdm9pZCBwY21fb3Blbl9sb2NrKHZvaWQpCiB7CisJcHRocmVhZF9vbmNlKCZw
Y21fb3Blbl9tdXRleF9vbmNlLCBwY21fb3Blbl9pbml0X211dGV4KTsKIAlpZiAod29ya2Fy
b3VuZHMgJiBXT1JLQVJPVU5EX1NFUklBTE9QRU4pCiAJICAgICAgICBwdGhyZWFkX211dGV4
X2xvY2soJnBjbV9vcGVuX211dGV4KTsKIH0KLS0gCjEuOC40Cgo=
--------------040201070802030204070305
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------040201070802030204070305--
