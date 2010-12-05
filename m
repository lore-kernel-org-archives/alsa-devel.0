From: Daniel Chen <seven.steps@gmail.com>
Subject: [PATCH] ALSA: hda: Use position_fix=1 for Acer Aspire
 5538 to enable capture on internal mic
Date: Sun, 5 Dec 2010 08:55:08 -0500
Message-ID: <AANLkTi=FB=+dkBQv=a_9EvRsRdfsVSVzOnw_5GxXQRsC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016e64401ea95aa5c0496aa1ebb
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 832712458E
	for <alsa-devel@alsa-project.org>; Sun,  5 Dec 2010 14:55:09 +0100 (CET)
Received: by wwc33 with SMTP id 33so2929255wwc.20
	for <alsa-devel@alsa-project.org>; Sun, 05 Dec 2010 05:55:08 -0800 (PST)
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

--0016e64401ea95aa5c0496aa1ebb
Content-Type: text/plain; charset=UTF-8

Hi,

Attached is a patch against sound-2.6 master HEAD (c2e685d3) enabling
internal microphone capture on the reporter's Acer Aspire 5538.
Please apply.

Thanks,
-Dan

--0016e64401ea95aa5c0496aa1ebb
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-ALSA-hda-Use-position_fix-1-for-Acer-Aspire-5538-to-.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-hda-Use-position_fix-1-for-Acer-Aspire-5538-to-.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ghbzuwhu0

RnJvbSA4YjJkN2JjNmVhMDVmZjRkNDcwM2IyNjEwNzI5YjQ4ZTUyZDQ2OWRlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IFN1biwgNSBEZWMgMjAxMCAwODo0MzoxNCAtMDUwMApTdWJqZWN0OiBbUEFUQ0hdIEFMU0E6
IGhkYTogVXNlIHBvc2l0aW9uX2ZpeD0xIGZvciBBY2VyIEFzcGlyZSA1NTM4IHRvIGVuYWJsZSBj
YXB0dXJlIG9uIGludGVybmFsIG1pYwoKQnVnTGluazogaHR0cHM6Ly9sYXVuY2hwYWQubmV0L2J1
Z3MvNjg1MTYxCgpUaGUgcmVwb3J0ZXIgb2YgdGhlIGJ1ZyBzdGF0ZXMgdGhhdCBoZSBtdXN0IHVz
ZSBwb3NpdGlvbl9maXg9MSB0byBlbmFibGUKY2FwdHVyZSBmb3IgdGhlIGludGVybmFsIG1pY3Jv
cGhvbmUsIHNvIHNldCBpdCBmb3IgaGlzIG1hY2hpbmUncyBQQ0kKU1NJRC4gIFZlcmlmaWVkIHVz
aW5nIDIuNi4zNSBhbmQgdGhlIDIwMTAtMTItMDQgYWxzYS1kcml2ZXIgYnVpbGQuCgpSZXBvcnRl
ZC1hbmQtdGVzdGVkLWJ5OiBSYWxwaCBXYWJlbCA8cndhYmVsQGdteC5uZXQ+CkNjOiA8c3RhYmxl
QGtlcm5lbC5vcmc+ClNpZ25lZC1vZmYtYnk6IERhbmllbCBUIENoZW4gPGNyaW1zdW5AdWJ1bnR1
LmNvbT4KLS0tCiBzb3VuZC9wY2kvaGRhL2hkYV9pbnRlbC5jIHwgICAgMSArCiAxIGZpbGVzIGNo
YW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zb3Vu
ZC9wY2kvaGRhL2hkYV9pbnRlbC5jIGIvc291bmQvcGNpL2hkYS9oZGFfaW50ZWwuYwppbmRleCBh
NzhlYTM0Li5kOWUxNGYxIDEwMDY0NAotLS0gYS9zb3VuZC9wY2kvaGRhL2hkYV9pbnRlbC5jCisr
KyBiL3NvdW5kL3BjaS9oZGEvaGRhX2ludGVsLmMKQEAgLTIyOTksNiArMjI5OSw3IEBAIHN0YXRp
YyBpbnQgYXp4X2Rldl9mcmVlKHN0cnVjdCBzbmRfZGV2aWNlICpkZXZpY2UpCiAgKi8KIHN0YXRp
YyBzdHJ1Y3Qgc25kX3BjaV9xdWlyayBwb3NpdGlvbl9maXhfbGlzdFtdIF9fZGV2aW5pdGRhdGEg
PSB7CiAJU05EX1BDSV9RVUlSSygweDEwMjUsIDB4MDA5ZiwgIkFjZXIgQXNwaXJlIDUxMTAiLCBQ
T1NfRklYX0xQSUIpLAorCVNORF9QQ0lfUVVJUksoMHgxMDI1LCAweDAyNmYsICJBY2VyIEFzcGly
ZSA1NTM4IiwgUE9TX0ZJWF9MUElCKSwKIAlTTkRfUENJX1FVSVJLKDB4MTAyOCwgMHgwMWNjLCAi
RGVsbCBEODIwIiwgUE9TX0ZJWF9MUElCKSwKIAlTTkRfUENJX1FVSVJLKDB4MTAyOCwgMHgwMWRl
LCAiRGVsbCBQcmVjaXNpb24gMzkwIiwgUE9TX0ZJWF9MUElCKSwKIAlTTkRfUENJX1FVSVJLKDB4
MTAyOCwgMHgwMWY2LCAiRGVsbCBMYXRpdHVkZSAxMzFMIiwgUE9TX0ZJWF9MUElCKSwKLS0gCjEu
Ny4xCgo=
--0016e64401ea95aa5c0496aa1ebb
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0016e64401ea95aa5c0496aa1ebb--
