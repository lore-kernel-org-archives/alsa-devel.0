From: Daniel Chen <seven.steps@gmail.com>
Subject: [PATCH] ALSA: hda: Use model=lg quirk for LG P1
 Express to enable playback and capture
Date: Thu, 2 Dec 2010 22:55:38 -0500
Message-ID: <AANLkTikZ91CvaV_ww4+Nizpv6313oq4aEtTdqkRbQZ4x@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00221597499ef2e3fd049679825f
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 96FDA103AFA
	for <alsa-devel@alsa-project.org>; Fri,  3 Dec 2010 04:55:39 +0100 (CET)
Received: by wwc33 with SMTP id 33so774550wwc.20
	for <alsa-devel@alsa-project.org>; Thu, 02 Dec 2010 19:55:39 -0800 (PST)
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, stable@kernel.org
List-Id: alsa-devel@alsa-project.org

--00221597499ef2e3fd049679825f
Content-Type: text/plain; charset=UTF-8

Hi,

Attached is a patch against current sound-2.6 master HEAD enabling
audible playback from the LG P1 Express's internal speakers.  Capture
and jack sense were also verified working.  This patch is also
applicable to all stable, supported kernels.  Please apply.

Best,
-Dan

--00221597499ef2e3fd049679825f
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-ALSA-hda-Use-model-lg-quirk-for-LG-P1-Express-to-ena.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-hda-Use-model-lg-quirk-for-LG-P1-Express-to-ena.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gh8jioj90

RnJvbSA0YzcxZGYyZGJjYzcyYzA2MDk2MzQ4ZTAwNTMwYTljODgxOGIwOWI2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IFRodSwgMiBEZWMgMjAxMCAyMjo0NTo0NSAtMDUwMApTdWJqZWN0OiBbUEFUQ0hdIEFMU0E6
IGhkYTogVXNlIG1vZGVsPWxnIHF1aXJrIGZvciBMRyBQMSBFeHByZXNzIHRvIGVuYWJsZSBwbGF5
YmFjayBhbmQgY2FwdHVyZQoKQnVnTGluazogaHR0cHM6Ly9sYXVuY2hwYWQubmV0L2J1Z3MvNTk1
NDgyCgpUaGUgb3JpZ2luYWwgcmVwb3J0ZXIgc3RhdGVzIHRoYXQgYXVkaWJsZSBwbGF5YmFjayBm
cm9tIHRoZSBpbnRlcm5hbApzcGVha2VyIGlzIGluYXVkaWJsZSBkZXNwaXRlIHRoZSBoYXJkd2Fy
ZSBiZWluZyBwcm9wZXJseSBkZXRlY3RlZC4gIFRvCndvcmsgYXJvdW5kIHRoaXMgc3ltcHRvbSwg
aGUgdXNlcyB0aGUgbW9kZWw9bGcgcXVpcmsgdG8gcHJvcGVybHkgZW5hYmxlCmJvdGggcGxheWJh
Y2ssIGNhcHR1cmUsIGFuZCBqYWNrIHNlbnNlLiAgQW5vdGhlciB1c2VyIGNvcnJvYm9yYXRlcyB0
aGlzCndvcmthcm91bmQgb24gc2VwYXJhdGUgaGFyZHdhcmUuICBBZGQgdGhpcyBQQ0kgU1NJRCB0
byB0aGUgcXVpcmsgdGFibGUKdG8gZW5hYmxlIGl0IGZvciBmdXJ0aGVyIExHIFAxIEV4cHJlc3Nl
cy4KClJlcG9ydGVkLWFuZC10ZXN0ZWQtYnk6IFBoaWxpcCBQZWl0c2NoIDxwaGlsaXAucGVpdHNj
aEBnbWFpbC5jb20+ClRlc3RlZC1ieTogbmlraG92CkNjOiA8c3RhYmxlQGtlcm5lbC5vcmc+IFsy
LjYuMzIrXQpTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+
Ci0tLQogc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMgfCAgICAxICsKIDEgZmlsZXMgY2hh
bmdlZCwgMSBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NvdW5k
L3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jIGIvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMK
aW5kZXggNjVhOWVkZS4uMGJhZGVkYSAxMDA2NDQKLS0tIGEvc291bmQvcGNpL2hkYS9wYXRjaF9y
ZWFsdGVrLmMKKysrIGIvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKQEAgLTQ2MDMsNiAr
NDYwMyw3IEBAIHN0YXRpYyBzdHJ1Y3Qgc25kX3BjaV9xdWlyayBhbGM4ODBfY2ZnX3RibFtdID0g
ewogCVNORF9QQ0lfUVVJUksoMHgxNzM0LCAweDEwYjAsICJGdWppdHN1IiwgQUxDODgwX0ZVSklU
U1UpLAogCVNORF9QQ0lfUVVJUksoMHgxODU0LCAweDAwMTgsICJMRyBMVzIwIiwgQUxDODgwX0xH
X0xXKSwKIAlTTkRfUENJX1FVSVJLKDB4MTg1NCwgMHgwMDNiLCAiTEciLCBBTEM4ODBfTEcpLAor
CVNORF9QQ0lfUVVJUksoMHgxODU0LCAweDAwNWYsICJMRyBQMSBFeHByZXNzIiwgQUxDODgwX0xH
KSwKIAlTTkRfUENJX1FVSVJLKDB4MTg1NCwgMHgwMDY4LCAiTEcgdzEiLCBBTEM4ODBfTEcpLAog
CVNORF9QQ0lfUVVJUksoMHgxODU0LCAweDAwNzcsICJMRyBMVzI1IiwgQUxDODgwX0xHX0xXKSwK
IAlTTkRfUENJX1FVSVJLKDB4MTlkYiwgMHg0MTg4LCAiVENMIFM3MDAiLCBBTEM4ODBfVENMX1M3
MDApLAotLSAKMS43LjEKCg==
--00221597499ef2e3fd049679825f
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--00221597499ef2e3fd049679825f--
