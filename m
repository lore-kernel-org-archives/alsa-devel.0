From: Dan Chen <crimsunkg@yahoo.com>
Subject: [PATCH] ALSA: intel8x0: Mute External Amplifier by
	default for another Sony model
Date: Wed, 4 Nov 2009 18:10:26 -0800 (PST)
Message-ID: <461767.29010.qm@web112609.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1797899396-1257387026=:29010"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web112609.mail.gq1.yahoo.com (web112609.mail.gq1.yahoo.com
	[98.137.27.189]) by alsa0.perex.cz (Postfix) with SMTP id E48E1103850
	for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2009 03:10:27 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: crimsun@ubuntu.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--0-1797899396-1257387026=:29010
Content-Type: text/plain; charset=us-ascii

Hi,

Attached is a patch against current sound-2.6 HEAD adding the SSID of
another Sony model that requires the inv_eapd quirk.

Thanks,
Dan



      
--0-1797899396-1257387026=:29010
Content-Type: application/octet-stream; name="0001-ALSA-intel8x0-Mute-External-Amplifier-by-default-for.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0001-ALSA-intel8x0-Mute-External-Amplifier-by-default-for.patch"

RnJvbSA3YTc1YjFkNjA2ZWNkMjNkZmNiMTY2NmIyODMzZjc3ZmM5OWJlNzI0
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVu
IDxjcmltc3VuQHVidW50dS5jb20+CkRhdGU6IFdlZCwgNCBOb3YgMjAwOSAy
MTowMzo0NiAtMDUwMApTdWJqZWN0OiBbUEFUQ0hdIEFMU0E6IGludGVsOHgw
OiBNdXRlIEV4dGVybmFsIEFtcGxpZmllciBieSBkZWZhdWx0IGZvciBhbm90
aGVyIFNvbnkgbW9kZWwKCkJ1Z0xpbms6IGh0dHBzOi8vYnVncy5sYXVuY2hw
YWQubmV0L2J1Z3MvNDc0OTcyCgpUaGlzIFNvbnkgbW9kZWwgbmVlZHMgRXh0
ZXJuYWwgQW1wbGlmaWVyIG11dGVkIGZvciBhdWRpYmxlIHBsYXliYWNrLCBz
bwptYWtlIHN1cmUgd2Ugc2V0IHRoZSBpbnZfZWFwZCBxdWlyay4KClNpZ25l
ZC1vZmYtYnk6IERhbmllbCBUIENoZW4gPGNyaW1zdW5AdWJ1bnR1LmNvbT4K
LS0tCiBzb3VuZC9wY2kvaW50ZWw4eDAuYyB8ICAgIDYgKysrKysrCiAxIGZp
bGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9zb3VuZC9wY2kvaW50ZWw4eDAuYyBiL3NvdW5kL3Bj
aS9pbnRlbDh4MC5jCmluZGV4IDc1NDg2N2UuLmFhYzIwZmIgMTAwNjQ0Ci0t
LSBhL3NvdW5kL3BjaS9pbnRlbDh4MC5jCisrKyBiL3NvdW5kL3BjaS9pbnRl
bDh4MC5jCkBAIC0xOTUwLDYgKzE5NTAsMTIgQEAgc3RhdGljIHN0cnVjdCBh
Yzk3X3F1aXJrIGFjOTdfcXVpcmtzW10gX19kZXZpbml0ZGF0YSA9IHsKIAl9
LAogCXsKIAkJLnN1YnZlbmRvciA9IDB4MTA0ZCwKKwkJLnN1YmRldmljZSA9
IDB4ODE0NCwKKwkJLm5hbWUgPSAiU29ueSIsCisJCS50eXBlID0gQUM5N19U
VU5FX0lOVl9FQVBECisJfSwKKwl7CisJCS5zdWJ2ZW5kb3IgPSAweDEwNGQs
CiAJCS5zdWJkZXZpY2UgPSAweDgxOTcsCiAJCS5uYW1lID0gIlNvbnkgUzFY
UCIsCiAJCS50eXBlID0gQUM5N19UVU5FX0lOVl9FQVBECi0tIAoxLjYuMy4z
Cgo=

--0-1797899396-1257387026=:29010
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0-1797899396-1257387026=:29010--
