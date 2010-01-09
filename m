From: Daniel Chen <seven.steps@gmail.com>
Subject: [PATCH] ALSA: ac97: Add Dell Dimension 2400 to
	Headphone/Line Jack Sense blacklist
Date: Sat, 9 Jan 2010 01:27:45 -0500
Message-ID: <604760771001082227s6e3f6bbah97c1cbcc4c163f7f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016368e23e0f8ce04047cb56684
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f53.google.com (mail-pw0-f53.google.com
	[209.85.160.53]) by alsa0.perex.cz (Postfix) with ESMTP id 8A34424507
	for <alsa-devel@alsa-project.org>; Sat,  9 Jan 2010 07:27:46 +0100 (CET)
Received: by pwi18 with SMTP id 18so1514032pwi.32
	for <alsa-devel@alsa-project.org>; Fri, 08 Jan 2010 22:27:45 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--0016368e23e0f8ce04047cb56684
Content-Type: text/plain; charset=UTF-8

Hi,

Attached is a patch against current sound-2.6 master HEAD fixing
inaudible playback by default.

Thanks,
-Dan

--0016368e23e0f8ce04047cb56684
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-ALSA-ac97-Add-Dell-Dimension-2400-to-Headphone-Line-.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-ac97-Add-Dell-Dimension-2400-to-Headphone-Line-.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g480jfm50

RnJvbSAyOWU2YTI5OTE1YjIxMmVjMGFiZTFhNGQ1ZDFkYTZiOTI4MDk2NjVhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IFNhdCwgOSBKYW4gMjAxMCAwMToyMjoyOSAtMDUwMApTdWJqZWN0OiBbUEFUQ0hdIEFMU0E6
IGFjOTc6IEFkZCBEZWxsIERpbWVuc2lvbiAyNDAwIHRvIEhlYWRwaG9uZS9MaW5lIEphY2sgU2Vu
c2UgYmxhY2tsaXN0CgpUaGlzIG1vZGVsIG5lZWRzIGJvdGggJ0hlYWRwaG9uZSBKYWNrIFNlbnNl
JyBhbmQgJ0xpbmUgSmFjayBTZW5zZScgbXV0ZWQKZm9yIGF1ZGlibGUgcGxheWJhY2ssIHNvIGp1
c3QgYWRkIGl0IHRvIHRoZSBhZDE5ODEgamFjayBzZW5zZSBibGFja2xpc3QuCgpDYzogc3RhYmxl
QGtlcm5lbC5vcmcKVGVzdGVkLWJ5OiBQZXRlIDx4NDEyMTUyMDFAZ21haWwuY29tPgpTaWduZWQt
b2ZmLWJ5OiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+Ci0tLQogc291bmQvcGNp
L2FjOTcvYWM5N19wYXRjaC5jIHwgICAgMSArCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
cygrKSwgMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zb3VuZC9wY2kvYWM5Ny9hYzk3X3Bh
dGNoLmMgYi9zb3VuZC9wY2kvYWM5Ny9hYzk3X3BhdGNoLmMKaW5kZXggMTM5Y2YzYi4uZDkyNjZi
YSAxMDA2NDQKLS0tIGEvc291bmQvcGNpL2FjOTcvYWM5N19wYXRjaC5jCisrKyBiL3NvdW5kL3Bj
aS9hYzk3L2FjOTdfcGF0Y2guYwpAQCAtMTg3MCw2ICsxODcwLDcgQEAgc3RhdGljIHVuc2lnbmVk
IGludCBhZDE5ODFfamFja3NfYmxhY2tsaXN0W10gPSB7CiAJMHgxMDE0MDU1NCwgLyogVGhpbmtw
YWQgVDQycC9SNTBwICovCiAJMHgxMDE0MDU2NywgLyogVGhpbmtwYWQgVDQzcCAyNjY4LUc3VSAq
LwogCTB4MTAxNDA1ODEsIC8qIFRoaW5rcGFkIFg0MS0yNTI3ICovCisJMHgxMDI4MDE2MCwgLyog
RGVsbCBEaW1lbnNpb24gMjQwMCAqLwogCTB4MTA0MzgwYjAsIC8qIEFzdXMgQTdWOFgtTVggKi8K
IAkweDExNzkwMjQxLCAvKiBUb3NoaWJhIFNhdGVsbGl0ZSBBLTE1IFMxMjcgKi8KIAkweDE0NGRj
MDFhLCAvKiBTYW1zdW5nIE5QLVgyMEMwMDQvU0VHICovCi0tIAoxLjYuNQoK
--0016368e23e0f8ce04047cb56684
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0016368e23e0f8ce04047cb56684--
