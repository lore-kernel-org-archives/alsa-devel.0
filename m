From: Trent Piepho <xyzzy@speakeasy.org>
Subject: [PATCH] snd-bt87x: Power down audio ADC when not in use
Date: Thu, 6 Sep 2007 15:56:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0709061552360.31808@shell4.speakeasy.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="289736052-1740772708-1189119365=:31808"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail6.sea5.speakeasy.net (mail6.sea5.speakeasy.net
	[69.17.117.8]) by alsa0.perex.cz (Postfix) with ESMTP id A9833103859
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Sep 2007 00:56:07 +0200 (CEST)
Received: from shell4.sea5.speakeasy.net ([69.17.116.5])
	(envelope-sender <xyzzy@speakeasy.org>)
	by mail6.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted
	SMTP for <alsa-devel@alsa-project.org>; 6 Sep 2007 22:56:05 -0000
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
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--289736052-1740772708-1189119365=:31808
Content-Type: TEXT/PLAIN; charset=US-ASCII

Sets a bit to power down the Bt87x's internal audio ADC when the ALSA device
isn't open, or when it is in "digital mode" using an external ADC.
--289736052-1740772708-1189119365=:31808
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="bt87x_powerdown.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0709061556050.31808@shell4.speakeasy.net>
Content-Description: 
Content-Disposition: attachment; filename="bt87x_powerdown.patch"

RnJvbTogVHJlbnQgUGllcGhvIDx4eXp6eUBzcGVha2Vhc3kub3JnPg0KDQpz
bmQtYnQ4N3g6IFBvd2VyIGRvd24gYXVkaW8gQURDIHdoZW4gbm90IGluIHVz
ZQ0KDQpTZXRzIGEgYml0IHRvIHBvd2VyIGRvd24gdGhlIEJ0ODd4J3MgaW50
ZXJuYWwgYXVkaW8gQURDIHdoZW4gdGhlIEFMU0EgZGV2aWNlDQppc24ndCBv
cGVuLCBvciB3aGVuIGl0IGlzIGluICJkaWdpdGFsIG1vZGUiIHVzaW5nIGFu
IGV4dGVybmFsIEFEQy4NCg0KU2lnbmVkLW9mZi1ieTogVHJlbnQgUGllcGhv
IDx4eXp6eUBzcGVha2Vhc3kub3JnPg0KDQpkaWZmIC1yIGE1NWRjMGFmZmUy
MSBwY2kvYnQ4N3guYw0KLS0tIGEvcGNpL2J0ODd4LmMJVGh1IFNlcCAwNiAx
NTowNjo0NCAyMDA3ICswMjAwDQorKysgYi9wY2kvYnQ4N3guYwlUaHUgU2Vw
IDA2IDE1OjQ4OjEwIDIwMDcgLTA3MDANCkBAIC0zNzcsNyArMzc3LDcgQEAg
c3RhdGljIHN0cnVjdCBzbmRfcGNtX2hhcmR3YXJlIHNuZF9idDg3eA0KIA0K
IHN0YXRpYyBpbnQgc25kX2J0ODd4X3NldF9kaWdpdGFsX2h3KHN0cnVjdCBz
bmRfYnQ4N3ggKmNoaXAsIHN0cnVjdCBzbmRfcGNtX3J1bnRpbWUgKnJ1bnRp
bWUpDQogew0KLQljaGlwLT5yZWdfY29udHJvbCB8PSBDVExfREFfSU9NX0RB
Ow0KKwljaGlwLT5yZWdfY29udHJvbCB8PSBDVExfREFfSU9NX0RBIHwgQ1RM
X0FfUFdSRE47DQogCXJ1bnRpbWUtPmh3ID0gc25kX2J0ODd4X2RpZ2l0YWxf
aHc7DQogCXJ1bnRpbWUtPmh3LnJhdGVzID0gc25kX3BjbV9yYXRlX3RvX3Jh
dGVfYml0KGNoaXAtPmJvYXJkLmRpZ19yYXRlKTsNCiAJcnVudGltZS0+aHcu
cmF0ZV9taW4gPSBjaGlwLT5ib2FyZC5kaWdfcmF0ZTsNCkBAIC0zOTgsNyAr
Mzk4LDcgQEAgc3RhdGljIGludCBzbmRfYnQ4N3hfc2V0X2FuYWxvZ19odyhz
dHJ1Yw0KIAkJLnJhdHMgPSAmYW5hbG9nX2Nsb2NrDQogCX07DQogDQotCWNo
aXAtPnJlZ19jb250cm9sICY9IH5DVExfREFfSU9NX0RBOw0KKwljaGlwLT5y
ZWdfY29udHJvbCAmPSB+KENUTF9EQV9JT01fREEgfCBDVExfQV9QV1JETik7
DQogCXJ1bnRpbWUtPmh3ID0gc25kX2J0ODd4X2FuYWxvZ19odzsNCiAJcmV0
dXJuIHNuZF9wY21faHdfY29uc3RyYWludF9yYXRudW1zKHJ1bnRpbWUsIDAs
IFNORFJWX1BDTV9IV19QQVJBTV9SQVRFLA0KIAkJCQkJICAgICAmY29uc3Ry
YWludF9yYXRlcyk7DQpAQCAtNDM2LDYgKzQzNiwxMSBAQCBzdGF0aWMgaW50
IHNuZF9idDg3eF9jbG9zZShzdHJ1Y3Qgc25kX3BjDQogc3RhdGljIGludCBz
bmRfYnQ4N3hfY2xvc2Uoc3RydWN0IHNuZF9wY21fc3Vic3RyZWFtICpzdWJz
dHJlYW0pDQogew0KIAlzdHJ1Y3Qgc25kX2J0ODd4ICpjaGlwID0gc25kX3Bj
bV9zdWJzdHJlYW1fY2hpcChzdWJzdHJlYW0pOw0KKw0KKwlzcGluX2xvY2tf
aXJxKCZjaGlwLT5yZWdfbG9jayk7DQorCWNoaXAtPnJlZ19jb250cm9sIHw9
IENUTF9BX1BXUkROOw0KKwlzbmRfYnQ4N3hfd3JpdGVsKGNoaXAsIFJFR19H
UElPX0RNQV9DVEwsIGNoaXAtPnJlZ19jb250cm9sKTsNCisJc3Bpbl91bmxv
Y2tfaXJxKCZjaGlwLT5yZWdfbG9jayk7DQogDQogCWNoaXAtPnN1YnN0cmVh
bSA9IE5VTEw7DQogCWNsZWFyX2JpdCgwLCAmY2hpcC0+b3BlbmVkKTsNCkBA
IC03NTEsNyArNzU2LDggQEAgc3RhdGljIGludCBfX2RldmluaXQgc25kX2J0
ODd4X2NyZWF0ZShzdA0KIAkJZ290byBmYWlsOw0KIAl9DQogDQotCWNoaXAt
PnJlZ19jb250cm9sID0gQ1RMX0RBX0VTMiB8IENUTF9QS1RQXzE2IHwgKDE1
IDw8IENUTF9EQV9TRFJfU0hJRlQpOw0KKwljaGlwLT5yZWdfY29udHJvbCA9
IENUTF9BX1BXUkROIHwgQ1RMX0RBX0VTMiB8DQorCQkJICAgIENUTF9QS1RQ
XzE2IHwgKDE1IDw8IENUTF9EQV9TRFJfU0hJRlQpOw0KIAljaGlwLT5pbnRl
cnJ1cHRfbWFzayA9IE1ZX0lOVEVSUlVQVFM7DQogCXNuZF9idDg3eF93cml0
ZWwoY2hpcCwgUkVHX0dQSU9fRE1BX0NUTCwgY2hpcC0+cmVnX2NvbnRyb2wp
Ow0KIAlzbmRfYnQ4N3hfd3JpdGVsKGNoaXAsIFJFR19JTlRfTUFTSywgMCk7
DQo=

--289736052-1740772708-1189119365=:31808
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--289736052-1740772708-1189119365=:31808--
