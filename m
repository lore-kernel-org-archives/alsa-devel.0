From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: [PATCH ALSA HDA 1/1] Fix alc662_dac_nid and change
	6stack-dig to 5stack-dig
Date: Tue, 5 Apr 2011 22:59:29 +0800
Message-ID: <BANLkTim-aFLPMDOsoBG+ifynovDgT8LO3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00151743f8847ea02a04a02d1f52
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id ED17E1037F3
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Apr 2011 16:59:43 +0200 (CEST)
Received: by fxm5 with SMTP id 5so356401fxm.38
	for <alsa-devel@alsa-project.org>; Tue, 05 Apr 2011 07:59:43 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--00151743f8847ea02a04a02d1f52
Content-Type: text/plain; charset=ISO-8859-1

Fix alc662_dac_nid and change "6stack-dig" to "5stack-dig"

alc662 series only have 3 stereo DAC , so it can only support 5stack-dig
instead of 6stack-dig

--00151743f8847ea02a04a02d1f52
Content-Type: application/octet-stream;
	name="0001-Fix-alc662_dac_nid-and-change-6stack-dig-to-5stac.patch"
Content-Disposition: attachment;
	filename="0001-Fix-alc662_dac_nid-and-change-6stack-dig-to-5stac.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gm4ybv4k0

RnJvbSBiMGRiOTU4YTBhOTNmN2EwZWFkMzMyZTgyNjVhNjAxNDk0ZGExZjRlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYXltb25kIFlhdSA8c3VwZXJxdWFkLnZvcnRleDJAZ21haWwu
Y29tPgpEYXRlOiBUdWUsIDUgQXByIDIwMTEgMjI6NDc6MTUgKzA4MDAKU3ViamVjdDogW1BBVENI
IEFMU0EgSERBIDEvMV0gRml4IGFsYzY2Ml9kYWNfbmlkIGFuZCBjaGFuZ2UgIjZzdGFjay1kaWci
IHRvICI1c3RhY2stZGlnIgoKYWxjNjYyIHNlcmllcyBvbmx5IGhhdmUgMyBEQUMgLCBzbyBpdCBj
YW4gb25seSBzdXBwb3J0IDVzdGFjay1kaWcgaW5zdGVhZCBvZiA2c3RhY2stZGlnCgpTaWduZWQt
b2ZmLWJ5OiBSYXltb25kIFlhdSA8c3VwZXJxdWFkLnZvcnRleDJAZ21haWwuY29tPgoKZGlmZiAt
LWdpdCBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jIGIvc291bmQvcGNpL2hkYS9wYXRj
aF9yZWFsdGVrLmMKaW5kZXggNTA4NTVjZi4uNTU0MjBkNyAxMDA2NDQKLS0tIGEvc291bmQvcGNp
L2hkYS9wYXRjaF9yZWFsdGVrLmMKKysrIGIvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMK
QEAgLTE3NDExLDggKzE3NDExLDggQEAgc3RhdGljIGludCBwYXRjaF9hbGM4NjF2ZChzdHJ1Y3Qg
aGRhX2NvZGVjICpjb2RlYykKICNkZWZpbmUgQUxDNjYyX0RJR09VVF9OSUQJMHgwNgogI2RlZmlu
ZSBBTEM2NjJfRElHSU5fTklECTB4MGEKIAotc3RhdGljIGhkYV9uaWRfdCBhbGM2NjJfZGFjX25p
ZHNbNF0gPSB7Ci0JLyogZnJvbnQsIHJlYXIsIGNsZmUsIHJlYXJfc3VyciAqLworc3RhdGljIGhk
YV9uaWRfdCBhbGM2NjJfZGFjX25pZHNbM10gPSB7CisJLyogZnJvbnQsIHJlYXIsIGNsZmUgKi8K
IAkweDAyLCAweDAzLCAweDA0CiB9OwogCkBAIC0xODY3MCw3ICsxODY3MCw3IEBAIHN0YXRpYyBj
b25zdCBjaGFyICogY29uc3QgYWxjNjYyX21vZGVsc1tBTEM2NjJfTU9ERUxfTEFTVF0gPSB7CiAJ
W0FMQzY2Ml8zU1RfMmNoX0RJR10JPSAiM3N0YWNrLWRpZyIsCiAJW0FMQzY2Ml8zU1RfNmNoX0RJ
R10JPSAiM3N0YWNrLTZjaC1kaWciLAogCVtBTEM2NjJfM1NUXzZjaF0JPSAiM3N0YWNrLTZjaCIs
Ci0JW0FMQzY2Ml81U1RfRElHXQk9ICI2c3RhY2stZGlnIiwKKwlbQUxDNjYyXzVTVF9ESUddCT0g
IjVzdGFjay1kaWciLAogCVtBTEM2NjJfTEVOT1ZPXzEwMUVdCT0gImxlbm92by0xMDFlIiwKIAlb
QUxDNjYyX0FTVVNfRUVFUENfUDcwMV0gPSAiZWVlcGMtcDcwMSIsCiAJW0FMQzY2Ml9BU1VTX0VF
RVBDX0VQMjBdID0gImVlZXBjLWVwMjAiLAotLSAKMS42LjAuNgoK
--00151743f8847ea02a04a02d1f52
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--00151743f8847ea02a04a02d1f52--
