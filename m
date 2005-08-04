From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: [PATCH] WM9713 modem detection
Date: Thu, 04 Aug 2005 18:11:16 +0100
Message-ID: <1123175476.18082.4.camel@cearnarfon>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-4SGW6At4B0mERdX+4auH"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from orlando.wolfsonmicro.main (webmail.wolfsonmicro.com [212.20.225.142])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 871151D2
	for <alsa-devel@alsa-project.org>; Thu,  4 Aug 2005 19:11:17 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
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


--=-4SGW6At4B0mERdX+4auH
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch fixes a problem whereby the WM9713 has modem functionality
incorrectly detected after an AC97 cold reset.

Changes:-

  o Cleared AC97_SCAP_MODEM in wm9713 scaps

Signed-off-by: Liam Girdwood <liam.girdwood@wolfsonmicro.com>

Liam

--=-4SGW6At4B0mERdX+4auH
Content-Disposition: attachment; filename=wm9713-modem.diff
Content-Type: text/x-patch; name=wm9713-modem.diff; charset=UTF-8
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9hYzk3L2FjOTdfcGF0Y2guYyBiL3NvdW5kL3BjaS9hYzk3
L2FjOTdfcGF0Y2guYw0KLS0tIGEvc291bmQvcGNpL2FjOTcvYWM5N19wYXRjaC5jDQorKysgYi9z
b3VuZC9wY2kvYWM5Ny9hYzk3X3BhdGNoLmMNCkBAIC03ODYsNiArNzg2LDcgQEAgaW50IHBhdGNo
X3dvbGZzb24xMyhhYzk3X3QgKiBhYzk3KQ0KIAlhYzk3LT5mbGFncyB8PSBBQzk3X0hBU19OT19S
RUNfR0FJTiB8IEFDOTdfU1RFUkVPX01VVEVTIHwgQUM5N19IQVNfTk9fUEhPTkUgfA0KIAkJQUM5
N19IQVNfTk9fUENfQkVFUCB8IEFDOTdfSEFTX05PX1ZJREVPIHwgQUM5N19IQVNfTk9fQ0QgfCBB
Qzk3X0hBU19OT19UT05FIHwNCiAJCUFDOTdfSEFTX05PX1NURF9QQ007DQorICAgIAlhYzk3LT5z
Y2FwcyAmPSB+QUM5N19TQ0FQX01PREVNOw0KIA0KIAlzbmRfYWM5N193cml0ZV9jYWNoZShhYzk3
LCBBQzk3X0VYVEVOREVEX01JRCwgMHhkYTAwKTsNCiAJc25kX2FjOTdfd3JpdGVfY2FjaGUoYWM5
NywgQUM5N19FWFRFTkRFRF9NU1RBVFVTLCAweDM4MTApOw0K


--=-4SGW6At4B0mERdX+4auH--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
