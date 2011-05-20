From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: [PATCH - ALSA - emu10k1] Add dB range to Bass and
 Treble controls for SB Live!
Date: Fri, 20 May 2011 15:04:07 +0800
Message-ID: <BANLkTimx7-3oeL-93Mq=MxjGZXsv9h+t6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0015174769805132ba04a3afbabc
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 9648A103836
	for <alsa-devel@alsa-project.org>;
	Fri, 20 May 2011 09:04:07 +0200 (CEST)
Received: by fxm5 with SMTP id 5so2829116fxm.38
	for <alsa-devel@alsa-project.org>; Fri, 20 May 2011 00:04:07 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

--0015174769805132ba04a3afbabc
Content-Type: text/plain; charset=ISO-8859-1

As the "Wave", "Wave Surround" or "Front" Playback Volume must be
changed to 70% (i.e. -12 dB) so that distortion won't occur when
increase Bass and Treble from 50% to 100%, so the maximum gain in Bass
and Treble are +12 dB

--0015174769805132ba04a3afbabc
Content-Type: application/octet-stream;
	name="0001-Add-dB-range-to-Bass-and-Treble-for-SB-Live.patch"
Content-Disposition: attachment;
	filename="0001-Add-dB-range-to-Bass-and-Treble-for-SB-Live.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gnws8kig0

RnJvbSAwNGU5MzlhOWZhZGRmN2Q2NzAwZGRmNTgxZGMyMDY4YjBjN2M1ZTliIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYXltb25kIFlhdSA8c3VwZXJxdWFkLnZvcnRleDJAZ21haWwu
Y29tPgpEYXRlOiBGcmksIDIwIE1heSAyMDExIDE0OjMyOjA0ICswODAwClN1YmplY3Q6IFtQQVRD
SCAtIEFMU0EgLSBlbXUxMGsxXSBBZGQgZEIgcmFuZ2UgdG8gQmFzcyBhbmQgVHJlYmxlIGZvciBT
QiBMaXZlIQoKQXMgdGhlICJXYXZlIiwgIldhdmUgU3Vycm91bmQiIG9yICJGcm9udCIgUGxheWJh
Y2sgVm9sdW1lIG11c3QgYmUgY2hhbmdlZCB0byA3MCUgKGkuZS4gLTEyIGRCKSBzbyB0aGF0IGRp
c3RvcnRpb24gd29uJ3Qgb2NjdXIgd2hlbiBpbmNyZWFzZSBCYXNzIGFuZCBUcmVibGUgZnJvbSA1
MCUgdG8gMTAwJSwgc28gdGhlIG1heGltdW0gZ2FpbiBpbiBCYXNzIGFuZCBUcmVibGUgYXJlICsx
MiBkQgoKU2lnbmVkLW9mZi1ieTogUmF5bW9uZCBZYXUgPHN1cGVycXVhZC52b3J0ZXgyQGdtYWls
LmNvbT4KCmRpZmYgLS1naXQgYS9zb3VuZC9wY2kvZW11MTBrMS9lbXVmeC5jIGIvc291bmQvcGNp
L2VtdTEwazEvZW11ZnguYwppbmRleCA3YTk0MDE0Li5kYWU0MDUwIDEwMDY0NAotLS0gYS9zb3Vu
ZC9wY2kvZW11MTBrMS9lbXVmeC5jCisrKyBiL3NvdW5kL3BjaS9lbXUxMGsxL2VtdWZ4LmMKQEAg
LTMwMyw2ICszMDMsOSBAQCBzdGF0aWMgY29uc3QgdTMyIGRiX3RhYmxlWzEwMV0gPSB7CiBzdGF0
aWMgY29uc3QgREVDTEFSRV9UTFZfREJfU0NBTEUoc25kX2VtdTEwazFfZGJfc2NhbGUxLCAtNDAw
MCwgNDAsIDEpOwogc3RhdGljIGNvbnN0IERFQ0xBUkVfVExWX0RCX0xJTkVBUihzbmRfZW11MTBr
MV9kYl9saW5lYXIsIFRMVl9EQl9HQUlOX01VVEUsIDApOwogCisvKiBFTVUxMEsxIGJhc3MvdHJl
YmxlIGRiIGdhaW4gKi8KK3N0YXRpYyBjb25zdCBERUNMQVJFX1RMVl9EQl9TQ0FMRShzbmRfZW11
MTBrMV9iYXNzX3RyZWJsZV9kYl9zY2FsZSwgLTEyMDAsIDYwLCAwKTsKKwogc3RhdGljIGNvbnN0
IHUzMiBvbm9mZl90YWJsZVsyXSA9IHsKIAkweDAwMDAwMDAwLCAweDAwMDAwMDAxCiB9OwpAQCAt
MjE2Myw2ICsyMTY2LDcgQEAgc3RhdGljIGludCBfX2RldmluaXQgX3NuZF9lbXUxMGsxX2luaXRf
ZWZ4KHN0cnVjdCBzbmRfZW11MTBrMSAqZW11KQogCWN0bC0+bWluID0gMDsKIAljdGwtPm1heCA9
IDQwOwogCWN0bC0+dmFsdWVbMF0gPSBjdGwtPnZhbHVlWzFdID0gMjA7CisJY3RsLT50bHYgPSBz
bmRfZW11MTBrMV9iYXNzX3RyZWJsZV9kYl9zY2FsZTsKIAljdGwtPnRyYW5zbGF0aW9uID0gRU1V
MTBLMV9HUFJfVFJBTlNMQVRJT05fQkFTUzsKIAljdGwgPSAmY29udHJvbHNbaSArIDFdOwogCWN0
bC0+aWQuaWZhY2UgPSBTTkRSVl9DVExfRUxFTV9JRkFDRV9NSVhFUjsKQEAgLTIxNzIsNiArMjE3
Niw3IEBAIHN0YXRpYyBpbnQgX19kZXZpbml0IF9zbmRfZW11MTBrMV9pbml0X2VmeChzdHJ1Y3Qg
c25kX2VtdTEwazEgKmVtdSkKIAljdGwtPm1pbiA9IDA7CiAJY3RsLT5tYXggPSA0MDsKIAljdGwt
PnZhbHVlWzBdID0gY3RsLT52YWx1ZVsxXSA9IDIwOworCWN0bC0+dGx2ID0gc25kX2VtdTEwazFf
YmFzc190cmVibGVfZGJfc2NhbGU7CiAJY3RsLT50cmFuc2xhdGlvbiA9IEVNVTEwSzFfR1BSX1RS
QU5TTEFUSU9OX1RSRUJMRTsKIAogI2RlZmluZSBCQVNTX0dQUgkweDhjCi0tIAoxLjYuMC42Cgo=
--0015174769805132ba04a3afbabc
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0015174769805132ba04a3afbabc--
