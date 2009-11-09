From: Dan Chen <crimsunkg@yahoo.com>
Subject: [PATCH] ALSA: hda: Use model=auto quirk for Sony VAIO
	VGN-FW170J using ALC262
Date: Sun, 8 Nov 2009 16:11:18 -0800 (PST)
Message-ID: <483819.30924.qm@web112613.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1808343879-1257725478=:30924"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web112613.mail.gq1.yahoo.com (web112613.mail.gq1.yahoo.com
	[98.137.27.193]) by alsa0.perex.cz (Postfix) with SMTP id 77D2D10382A
	for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2009 01:11:20 +0100 (CET)
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

--0-1808343879-1257725478=:30924
Content-Type: text/plain; charset=us-ascii

Hi,

Attached please find a patch against sound-2.6 HEAD using ALC262_AUTO
for the Sony VAIO VGN-FW170J. Without using model=auto, the internal mic
does not function.

Thanks,
Dan



      
--0-1808343879-1257725478=:30924
Content-Type: application/octet-stream; name="0001-ALSA-hda-Use-model-auto-quirk-for-Sony-VAIO-VGN-FW17.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0001-ALSA-hda-Use-model-auto-quirk-for-Sony-VAIO-VGN-FW17.patch"

RnJvbSBiMzVlMjNkZTQ5Mjc2MTkxZjhiODZmMGEwOTgyMDA3NTY1NzBmMGNi
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVu
IDxjcmltc3VuQHVidW50dS5jb20+CkRhdGU6IFN1biwgOCBOb3YgMjAwOSAx
OTowMzo1NSAtMDUwMApTdWJqZWN0OiBbUEFUQ0hdIEFMU0E6IGhkYTogVXNl
IG1vZGVsPWF1dG8gcXVpcmsgZm9yIFNvbnkgVkFJTyBWR04tRlcxNzBKIHVz
aW5nIEFMQzI2MgoKQnVnTGluazogaHR0cHM6Ly9idWdzLmxhdW5jaHBhZC5u
ZXQvYnVncy80NzgzMDkKClRoZSBpbnRlcm5hbCBtaWNyb3Bob25lIG9uIHRo
aXMgVkFJTyBtb2RlbCBkb2VzIG5vdCB3b3JrIHVubGVzcyB0aGUKImF1dG8i
IHF1aXJrIGlzIHVzZWQuCgpTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgVCBDaGVu
IDxjcmltc3VuQHVidW50dS5jb20+Ci0tLQogc291bmQvcGNpL2hkYS9wYXRj
aF9yZWFsdGVrLmMgfCAgICAxICsKIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNl
cnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NvdW5k
L3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jIGIvc291bmQvcGNpL2hkYS9wYXRj
aF9yZWFsdGVrLmMKaW5kZXggM2JlZTZhMi4uYzRmMGFjYiAxMDA2NDQKLS0t
IGEvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKKysrIGIvc291bmQv
cGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKQEAgLTExNDU3LDYgKzExNDU3LDcg
QEAgc3RhdGljIHN0cnVjdCBzbmRfcGNpX3F1aXJrIGFsYzI2Ml9jZmdfdGJs
W10gPSB7CiAJU05EX1BDSV9RVUlSSygweDEwNGQsIDB4ODIwZiwgIlNvbnkg
QVNTQU1EIiwgQUxDMjYyX1NPTllfQVNTQU1EKSwKIAlTTkRfUENJX1FVSVJL
KDB4MTA0ZCwgMHg5MDE2LCAiU29ueSBWQUlPIiwgQUxDMjYyX0FVVE8pLCAv
KiBkaWctb25seSAqLwogCVNORF9QQ0lfUVVJUksoMHgxMDRkLCAweDkwMjUs
ICJTb255IFZBSU8gWjIxTU4iLCBBTEMyNjJfVE9TSElCQV9TMDYpLAorCVNO
RF9QQ0lfUVVJUksoMHgxMDRkLCAweDkwMzUsICJTb255IFZBSU8gVkdOLUZX
MTcwSiIsIEFMQzI2Ml9BVVRPKSwKIAlTTkRfUENJX1FVSVJLX01BU0soMHgx
MDRkLCAweGZmMDAsIDB4OTAwMCwgIlNvbnkgVkFJTyIsCiAJCQkgICBBTEMy
NjJfU09OWV9BU1NBTUQpLAogCVNORF9QQ0lfUVVJUksoMHgxMTc5LCAweDAw
MDEsICJUb3NoaWJhIGR5bmFib29rIFNTIFJYMSIsCi0tIAoxLjYuMy4zCgo=


--0-1808343879-1257725478=:30924
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0-1808343879-1257725478=:30924--
