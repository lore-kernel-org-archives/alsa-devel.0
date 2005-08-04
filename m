From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: [PATCH] PXA27x AC97 warm reset
Date: Thu, 04 Aug 2005 16:20:06 +0100
Message-ID: <1123168806.15878.6.camel@cearnarfon>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-kceqES+e3E13h2v21IYG"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Nicolas Pitre <nico@cam.org>
List-Id: alsa-devel@alsa-project.org


--=-kceqES+e3E13h2v21IYG
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch extends the period of an AC97 warm reset on the PXA27x from
50uS to 500uS. The shorter reset didn't always guarantee that the codec
would wake up.

Changes:-

  o Change pxa27x warm reset period to 500uS
  o Removed double semi-colon.

Signed-off-by: Liam Girdwood <liam.girdwood@wolfsonmicro.com>

Liam 

--=-kceqES+e3E13h2v21IYG
Content-Disposition: attachment; filename=pxa-warm-reset.diff
Content-Type: text/x-patch; name=pxa-warm-reset.diff; charset=UTF-8
Content-Transfer-Encoding: base64

SW5kZXg6IGFybS9weGEyeHgtYWM5Ny5jDQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpSQ1MgZmlsZTogL2N2c3Jvb3Qv
YWxzYS9hbHNhLWtlcm5lbC9hcm0vcHhhMnh4LWFjOTcuYyx2DQpyZXRyaWV2aW5nIHJldmlzaW9u
IDEuMQ0KZGlmZiAtdSAtcjEuMSBweGEyeHgtYWM5Ny5jDQotLS0gYXJtL3B4YTJ4eC1hYzk3LmMJ
MzAgSnVuIDIwMDUgMTc6NTQ6MDUgLTAwMDAJMS4xDQorKysgYXJtL3B4YTJ4eC1hYzk3LmMJNCBB
dWcgMjAwNSAxNToxMjoxNSAtMDAwMA0KQEAgLTEzMiw5ICsxMzIsOSBAQA0KIAkJdWRlbGF5KDEw
KTsNCiAJCUdDUiB8PSBHQ1JfV0FSTV9SU1Q7DQogCQlweGFfZ3Bpb19tb2RlKDExMyB8IEdQSU9f
QUxUX0ZOXzJfT1VUKTsNCi0JCXVkZWxheSg1MCk7DQorCQl1ZGVsYXkoNTAwKTsNCiAjZWxzZQ0K
LQkJR0NSIHw9IEdDUl9XQVJNX1JTVHxHQ1JfUFJJUkRZX0lFTnxHQ1JfU0VDUkRZX0lFTjs7DQor
CQlHQ1IgfD0gR0NSX1dBUk1fUlNUfEdDUl9QUklSRFlfSUVOfEdDUl9TRUNSRFlfSUVOOw0KIAkJ
d2FpdF9ldmVudF90aW1lb3V0KGdzcl93cSwgZ3NyX2JpdHMgJiAoR1NSX1BDUiB8IEdTUl9TQ1Ip
LCAxKTsNCiAjZW5kaWYJCQkNCiANCg==


--=-kceqES+e3E13h2v21IYG--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
