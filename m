From: joy ping <joy@pingfm.org>
Subject: spdiff with ct5880 (ens1371)
Date: Tue, 26 Mar 2002 14:10:54 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.43.0203261339540.3081-200000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-587041893-1017148254=:3081"
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-587041893-1017148254=:3081
Content-Type: TEXT/PLAIN; charset=US-ASCII

i added rev 3 of ct5880 as to have an spdiff_out in ens1370.c, cause i
know this works with my soundcard. i did 'ensoniq->rev == CT5880REV_C
T5880_D' cause i dont know how it works with later releases.
maybe it could be aplied in the driver.

for details see patch.

i also tried to enable line-in as a second line-out for pcm0, as it could
made with ens1370, but this does not work with ens1370 settings. its not
documented in the ens1371 specs but i know that it works with the
windows-drivers, the current setting i aplied doesnt cause an error but
should removed cause its probably wrong for ens1371.
maybe someone nows the right bit which has to be set, for enabling line-in
as second line-out, or has the current specs for the CT5880 REV 3. would
be a nice feature for this driver.

regards

joy

--8323328-587041893-1017148254=:3081
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="ens1370.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.43.0203261410541.3081@localhost.localdomain>
Content-Description: 
Content-Disposition: attachment; filename="ens1370.patch"

LS0tIGVuczEzNzBfb3JpZy5jCVR1ZSBNYXIgMjYgMTM6MzY6NTYgMjAwMg0K
KysrIGVuczEzNzAuYwlUdWUgTWFyIDI2IDEzOjM2OjQyIDIwMDINCkBAIC0x
MzAzLDcgKzEzMDMsNyBAQA0KIAlhYzk3LnByaXZhdGVfZnJlZSA9IHNuZF9l
bnNvbmlxX21peGVyX2ZyZWVfYWM5NzsNCiAJaWYgKChlcnIgPSBzbmRfYWM5
N19taXhlcihjYXJkLCAmYWM5NywgJmVuc29uaXEtPnUuZXMxMzcxLmFjOTcp
KSA8IDApDQogCQlyZXR1cm4gZXJyOw0KLQlpZiAoZW5zb25pcS0+cmV2ID49
IEVTMTM3MVJFVl9FUzEzNzNfQSkNCisJaWYgKChlbnNvbmlxLT5yZXYgPj0g
RVMxMzcxUkVWX0VTMTM3M19BKSB8fCAoZW5zb25pcS0+cmV2ID09IENUNTg4
MFJFVl9DVDU4ODBfRCkpDQogCQlzbmRfY3RsX2FkZChjYXJkLCBzbmRfY3Rs
X25ldzEoJnNuZF9lczEzNzFfbWl4ZXJfc3BkaWYsIGVuc29uaXEpKTsNCiAJ
cmV0dXJuIDA7DQogfQ0KQEAgLTEzOTgsMTEgKzEzOTgsMTcgQEANCiAgKiAg
R2VuZXJhbCBTd2l0Y2hlcy4uLg0KICAqLw0KIA0KLXN0YXRpYyBzbmRfa2Nv
bnRyb2xfbmV3X3Qgc25kX2Vuc29uaXFfY29udHJvbF9qb3lzdGljayBfX2Rl
dmluaXRkYXRhID0NCitzdGF0aWMgc25kX2tjb250cm9sX25ld190IHNuZF9l
bnNvbmlxX2NvbnRyb2xfam95c3RpY2sgX19kZXZpbml0ZGF0YSA9IA0KIEVO
U09OSVFfQ09OVFJPTCgiSm95c3RpY2sgRW5hYmxlIiwgRVNfSllTVEtfRU4p
Ow0KIA0KICNpZmRlZiBDSElQMTM3MQ0KIA0KKy8qIGhhY2sgZm9yIGVuYWJs
aW5nIGxpbmVpbiBhcyBzZWNvbmQgbGluZW91dCAqLw0KK3N0YXRpYyBzbmRf
a2NvbnRyb2xfbmV3X3Qgc25kX2Vuc29uaXFfY29udHJvbF9saW5laW4gX19k
ZXZpbml0ZGF0YSA9IA0KK0VOU09OSVFfQ09OVFJPTCgiRW5hYmxlIExpbmVp
biBhcyBzZWNvbmQgT3V0IiwgRVNfMTM3MF9YQ1RMMCk7DQorDQorLyogc25k
X2N0bF9hZGQoY2FyZCwgc25kX2N0bF9uZXcxKCZzbmRfZW5zb25pcV9jb250
cm9sX2xpbmVpbiwgZW5zb25pcSkpOyAqLw0KKw0KICNkZWZpbmUgRVMxMzcx
X0pPWVNUSUNLX0FERFIoeG5hbWUpIFwNCiB7IGlmYWNlOiBTTkRSVl9DVExf
RUxFTV9JRkFDRV9DQVJELCBuYW1lOiB4bmFtZSwgaW5mbzogc25kX2VzMTM3
MV9qb3lzdGlja19hZGRyX2luZm8sIFwNCiAgIGdldDogc25kX2VzMTM3MV9q
b3lzdGlja19hZGRyX2dldCwgcHV0OiBzbmRfZXMxMzcxX2pveXN0aWNrX2Fk
ZHJfcHV0IH0NCkBAIC0xNDcxLDYgKzE0NzcsNyBAQA0KIAlzbmRfaXByaW50
ZihidWZmZXIsICJMaW5lIEluIHRvIEFPVVQgIDogJXNcbiIsIGVuc29uaXEt
PmN0cmwgJiBFU18xMzcwX1hDVEwwID8gIm9uIiA6ICJvZmYiKTsNCiAjZWxz
ZQ0KIAlzbmRfaXByaW50ZihidWZmZXIsICJKb3lzdGljayBwb3J0ICAgIDog
MHgleFxuIiwgKEVTXzEzNzFfSk9ZX0FTRUxJKGVuc29uaXEtPmN0cmwpICog
OCkgKyAweDIwMCk7DQorCXNuZF9pcHJpbnRmKGJ1ZmZlciwgIkxpbmUgSW4g
dG8gQU9VVCAgOiAlc1xuIiwgZW5zb25pcS0+Y3RybCAmIEVTXzEzNzBfWENU
TDAgPyAib24iIDogIm9mZiIpOw0KICNlbmRpZg0KIH0NCiANCkBAIC0xNzAz
LDYgKzE3MTAsNyBAQA0KIAlzbmRfY3RsX2FkZChjYXJkLCBzbmRfY3RsX25l
dzEoJnNuZF9lbnNvbmlxX2NvbnRyb2xfam95c3RpY2ssIGVuc29uaXEpKTsN
CiAjaWZkZWYgQ0hJUDEzNzENCiAJc25kX2N0bF9hZGQoY2FyZCwgc25kX2N0
bF9uZXcxKCZzbmRfZXMxMzcxX2pveXN0aWNrX2FkZHIsIGVuc29uaXEpKTsN
CisJc25kX2N0bF9hZGQoY2FyZCwgc25kX2N0bF9uZXcxKCZzbmRfZW5zb25p
cV9jb250cm9sX2xpbmVpbiwgZW5zb25pcSkpOw0KICNlbmRpZg0KIAlzeW5j
aHJvbml6ZV9pcnEoKTsNCiANCg==
--8323328-587041893-1017148254=:3081--
