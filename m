From: Peter Zubaj <pzad@pobox.sk>
Subject: Audigy + AC97 Master Volume
Date: Tue, 17 Aug 2004 09:47:01 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200408170747.i7H7kwv9006626@www6.pobox.sk>
Reply-To: Peter Zubaj <pzad@pobox.sk>
Mime-Version: 1.0
Content-Type: MULTIPART/mixed; charset=iso-8859-2; BOUNDARY="97784024-1804289383-1092728821=:6625"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from www6.pobox.sk (www6.pobox.sk [212.5.216.16])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 0491328B
	for <alsa-devel@alsa-project.org>; Tue, 17 Aug 2004 09:05:00 +0200 (MEST)
Received: from www6.pobox.sk (www6.pobox.sk [212.5.216.16])
	by www6.pobox.sk (8.12.9-20030917/8.12.9) with SMTP id i7H7kwv9006626
	for <alsa-devel@alsa-project.org>; Tue, 17 Aug 2004 09:47:01 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--97784024-1804289383-1092728821=:6625
Content-Type: TEXT/plain; CHARSET=US-ASCII
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

This patch sets AC97 Master  volume to 0 (0 dB). Previous value was
0x0202 (-3 dB) (this was my misstake).

Peter Zubaj


=0A____________________________________=0Ahttp://www.pobox.sk/ - spolahliva=
 a bezpecna prevadzka=0A=0A=0A
--97784024-1804289383-1092728821=:6625
Content-Type: APPLICATION/octet-stream; name="ac97_master_volume.diff"
Content-Transfer-Encoding: BASE64

LS0tIGVtdW1peGVyLmMub2xkCTIwMDQtMDctMDUgMTc6MDc6MjMuMDAwMDAw
MDAwICswMjAwCisrKyBlbXVtaXhlci5jCTIwMDQtMDgtMTYgMjA6MzE6MzEu
MDAwMDAwMDAwICswMjAwCkBAIC01MjcsNyArNTI3LDcgQEAKIAkJCXJldHVy
biBlcnI7CiAJCWlmIChlbXUtPmF1ZGlneSkgewogCQkJLyogc2V0IG1hc3Rl
ciB2b2x1bWUgdG8gMCBkQiAqLwotCQkJc25kX2FjOTdfd3JpdGUoZW11LT5h
Yzk3LCBBQzk3X01BU1RFUiwgMHgwMjAyKTsKKwkJCXNuZF9hYzk3X3dyaXRl
KGVtdS0+YWM5NywgQUM5N19NQVNURVIsIDB4MDAwMCk7CiAJCQkvKiBzZXQg
Y2FwdHVyZSBzb3VyY2UgdG8gbWljICovCiAJCQlzbmRfYWM5N193cml0ZShl
bXUtPmFjOTcsIEFDOTdfUkVDX1NFTCwgMHgwMDAwKTsKIAkJCWMgPSBhdWRp
Z3lfcmVtb3ZlX2N0bHM7Cg==

--97784024-1804289383-1092728821=:6625--


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
