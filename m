From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: [PATCH] - ALSA hda - fix segment fault in patch_realtek
Date: Tue, 3 May 2011 13:49:01 +0800
Message-ID: <BANLkTinvc66zUMMzUns=TLMg6h1-UtDA5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0023541882a070790704a258b235
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 166781037F8
	for <alsa-devel@alsa-project.org>;
	Tue,  3 May 2011 07:49:03 +0200 (CEST)
Received: by fxm5 with SMTP id 5so4666388fxm.38
	for <alsa-devel@alsa-project.org>; Mon, 02 May 2011 22:49:01 -0700 (PDT)
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

--0023541882a070790704a258b235
Content-Type: text/plain; charset=ISO-8859-1

Fix segment fault when try to implement alt_playback since those codecs
which support multistreaming playback usually have more than 1 adc but the
driver should create alt_capture when spec->stream_analog_alt_capture is
also defined

--0023541882a070790704a258b235
Content-Type: application/octet-stream;
	name="0001-Fix-segment-fault-when-try-to-use-alt_playback.patch"
Content-Disposition: attachment;
	filename="0001-Fix-segment-fault-when-try-to-use-alt_playback.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gn8f1geu0

RnJvbSA0OTY3NzM2YWI4ZTk3NzNhNjNkYTJhMzI2ZDJjMTllOWNlZmYzYmRhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYXltb25kIFlhdSA8c3VwZXJxdWFkLnZvcnRleDJAZ21haWwu
Y29tPgpEYXRlOiBUdWUsIDMgTWF5IDIwMTEgMTM6MzM6NTMgKzA4MDAKU3ViamVjdDogW1BBVENI
XSAtIEFMU0EgaGRhIC0gZml4IHNlZ21lbnQgZmF1bHQgaW4gcGF0Y2hfcmVhbHRlayAKCkZpeCBz
ZWdtZW50IGZhdWx0IHdoZW4gdHJ5IHRvIHVzZSBhbHRfcGxheWJhY2sgc2luY2UgdGhvc2UgY29k
ZWNzIHdoaWNoIHN1cHBvcnQgbXVsdGlzdHJlYW1pbmcgcGxheWJhY2sgdXN1YWxseSBoYXZlIG1v
cmUgdGhhbiAxIGFkYyBidXQgdGhlIGRyaXZlciBzaG91bGQgY3JlYXRlIGFsdF9jYXB0dXJlIHdo
ZW4gc3BlYy0+c3RyZWFtX2FuYWxvZ19hbHRfY2FwdHVyZSBpcyBhbHNvIGRlZmluZWQKCgpTaWdu
ZWQtb2ZmLWJ5OiBSYXltb25kIFlhdSA8c3VwZXJxdWFkLnZvcnRleDJAZ21haWwuY29tPgoKZGlm
ZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jIGIvc291bmQvcGNpL2hkYS9w
YXRjaF9yZWFsdGVrLmMKaW5kZXggYzlmNzcxNS4uNGRkMGNjYyAxMDA2NDQKLS0tIGEvc291bmQv
cGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKKysrIGIvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVr
LmMKQEAgLTQ0MjQsNyArNDQyNCw3IEBAIHN0YXRpYyBpbnQgYWxjX2J1aWxkX3BjbXMoc3RydWN0
IGhkYV9jb2RlYyAqY29kZWMpCiAJCQkJYWxjX3BjbV9udWxsX3N0cmVhbTsKIAkJCWluZm8tPnN0
cmVhbVtTTkRSVl9QQ01fU1RSRUFNX1BMQVlCQUNLXS5uaWQgPSAwOwogCQl9Ci0JCWlmIChzcGVj
LT5udW1fYWRjX25pZHMgPiAxKSB7CisJCWlmIChzcGVjLT5udW1fYWRjX25pZHMgPiAxICYmIHNw
ZWMtPnN0cmVhbV9hbmFsb2dfYWx0X2NhcHR1cmUpIHsKIAkJCWluZm8tPnN0cmVhbVtTTkRSVl9Q
Q01fU1RSRUFNX0NBUFRVUkVdID0KIAkJCQkqc3BlYy0+c3RyZWFtX2FuYWxvZ19hbHRfY2FwdHVy
ZTsKIAkJCWluZm8tPnN0cmVhbVtTTkRSVl9QQ01fU1RSRUFNX0NBUFRVUkVdLm5pZCA9Ci0tIAox
LjYuMC42Cgo=
--0023541882a070790704a258b235
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0023541882a070790704a258b235--
