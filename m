From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: [PATCH] hda-emu - Check channels count for
 playback/capture when using PCM command
Date: Sun, 24 Apr 2011 20:19:30 +0800
Message-ID: <BANLkTiktQKU+1nBZWMenwJYq73U3JR8UNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001517447b3e592b1204a1a91a5b
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 2F86E1037EA
	for <alsa-devel@alsa-project.org>;
	Sun, 24 Apr 2011 14:19:31 +0200 (CEST)
Received: by fxm5 with SMTP id 5so1181433fxm.38
	for <alsa-devel@alsa-project.org>; Sun, 24 Apr 2011 05:19:30 -0700 (PDT)
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

--001517447b3e592b1204a1a91a5b
Content-Type: text/plain; charset=ISO-8859-1

Check channels count for playback/capture when using PCM command

--001517447b3e592b1204a1a91a5b
Content-Type: application/octet-stream;
	name="0001-Check-channels-count-for-playback-capture-using-PCM.patch"
Content-Disposition: attachment;
	filename="0001-Check-channels-count-for-playback-capture-using-PCM.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gmvxzyma0

RnJvbSAxMGRmMTE0M2JjMjIzOGU5ZWQzM2U4N2Q0ZTU3MDFjZDQ5NGYwMjUxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYXltb25kIFlhdSA8c3VwZXJxdWFkLnZvcnRleDJAZ21haWwu
Y29tPgpEYXRlOiBTdW4sIDI0IEFwciAyMDExIDE3OjQ3OjQ1ICswODAwClN1YmplY3Q6IFtQQVRD
SF0gaGRhLWVtdSAtIENoZWNrIGNoYW5uZWxzIGNvdW50IGZvciBwbGF5YmFjay9jYXB0dXJlIHVz
aW5nIFBDTSBjb21tYW5kCgoKU2lnbmVkLW9mZi1ieTogUmF5bW9uZCBZYXUgPHN1cGVycXVhZC52
b3J0ZXgyQGdtYWlsLmNvbT4KCmRpZmYgLS1naXQgYS9oZGEtZW11LmMgYi9oZGEtZW11LmMKaW5k
ZXggMmIxNGIwZi4uZmY3ZjJmNiAxMDA2NDQKLS0tIGEvaGRhLWVtdS5jCisrKyBiL2hkYS1lbXUu
YwpAQCAtNTYzLDYgKzU2MywxMCBAQCB2b2lkIGhkYV90ZXN0X3BjbShpbnQgaWQsIGludCBzdWJp
ZCwKIAkJCWhkYV9sb2coSERBX0xPR19JTkZPLCAiICVkIiwgcmF0ZV9jb25zdHNbaV0pOwogCX0K
IAloZGFfbG9nKEhEQV9MT0dfSU5GTywgIlxuIik7CisJaWYgKChjaGFubmVscyA8IHJ1bnRpbWUt
Pmh3LmNoYW5uZWxzX21pbikgfHwKKwkgICAgKGNoYW5uZWxzID4gcnVudGltZS0+aHcuY2hhbm5l
bHNfbWF4KSkKKwkJaGRhX2xvZyhIREFfTE9HX0VSUiwgIkNoYW5uZWxzIGNvdW50ICglZCkgbm90
IGF2YWlsYWJsZSBmb3IgJXNcbiIsIAorCQkJY2hhbm5lbHMsIChkaXIgPyAiY2FwdHVyZSIgOiAi
cGxheWJhY2siKSk7CQogCWhkYV9sb2coSERBX0xPR19JTkZPLCAiUHJlcGFyZSBQQ00sIHJhdGU9
JWQsIGNoYW5uZWxzPSVkLCAiCiAJCSJmb3JtYXQ9JWQgYml0c1xuIiwKIAkJcmF0ZSwgY2hhbm5l
bHMsIGZvcm1hdCk7Ci0tIAoxLjYuMC42Cgo=
--001517447b3e592b1204a1a91a5b
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--001517447b3e592b1204a1a91a5b--
