From: Daniel Chen <seven.steps@gmail.com>
Subject: [PATCH] ALSA: hda: Use LPIB for Dell Latitude 131L
Date: Thu, 4 Mar 2010 09:50:21 -0500
Message-ID: <604760771003040650p5d839833gc5a520ddb4afaef7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00504502b000db56050480fab7ab
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f191.google.com (mail-px0-f191.google.com
	[209.85.216.191])
	by alsa0.perex.cz (Postfix) with ESMTP id 91DA310382A
	for <alsa-devel@alsa-project.org>; Thu,  4 Mar 2010 15:50:23 +0100 (CET)
Received: by pxi29 with SMTP id 29so193132pxi.5
	for <alsa-devel@alsa-project.org>; Thu, 04 Mar 2010 06:50:21 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel <alsa-devel@alsa-project.org>, stable@kernel.org
List-Id: alsa-devel@alsa-project.org

--00504502b000db56050480fab7ab
Content-Type: text/plain; charset=UTF-8

Hi,

Please apply the following patch against sound-2.6 master HEAD
(applies with tweaking against 2.6.32.x) to work around hardware
issues on Dell Latitude 131L.

Best,
-Dan

--00504502b000db56050480fab7ab
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-ALSA-hda-Use-LPIB-for-Dell-Latitude-131L.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-hda-Use-LPIB-for-Dell-Latitude-131L.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g6do8wd90

RnJvbSA2YzE1NTk0YzVhMjk3YWM5ZTk3N2U2ODM5N2FmZmViMGQ5OTYwZGYwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IFdlZCwgMyBNYXIgMjAxMCAxODoyNDoyNiAtMDUwMApTdWJqZWN0OiBbUEFUQ0hdIEFMU0E6
IGhkYTogVXNlIExQSUIgZm9yIERlbGwgTGF0aXR1ZGUgMTMxTAoKQnVnTGluazogaHR0cHM6Ly9s
YXVuY2hwYWQubmV0L2J1Z3MvNTMwMzQ2CgpUaGUgT1IgaGFzIHZlcmlmaWVkIHRoYXQgcG9zaXRp
b25fZml4PTEgaXMgbmVjZXNzYXJ5IHRvIHdvcmsgYXJvdW5kCmVycm9ycyBvbiBoaXMgbWFjaGlu
ZS4KClJlcG9ydGVkLWJ5OiBUb20gTG91d3JpZXIKQ2M6IDxzdGFibGVAa2VybmVsLm9yZz4KU2ln
bmVkLW9mZi1ieTogRGFuaWVsIFQgQ2hlbiA8Y3JpbXN1bkB1YnVudHUuY29tPgotLS0KIHNvdW5k
L3BjaS9oZGEvaGRhX2ludGVsLmMgfCAgICAxICsKIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRp
b25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEvaGRhX2lu
dGVsLmMgYi9zb3VuZC9wY2kvaGRhL2hkYV9pbnRlbC5jCmluZGV4IGQ1YzkzYWQuLjk2YjM0OTAg
MTAwNjQ0Ci0tLSBhL3NvdW5kL3BjaS9oZGEvaGRhX2ludGVsLmMKKysrIGIvc291bmQvcGNpL2hk
YS9oZGFfaW50ZWwuYwpAQCAtMjI2Myw2ICsyMjYzLDcgQEAgc3RhdGljIGludCBhenhfZGV2X2Zy
ZWUoc3RydWN0IHNuZF9kZXZpY2UgKmRldmljZSkKIHN0YXRpYyBzdHJ1Y3Qgc25kX3BjaV9xdWly
ayBwb3NpdGlvbl9maXhfbGlzdFtdIF9fZGV2aW5pdGRhdGEgPSB7CiAJU05EX1BDSV9RVUlSSygw
eDEwMjgsIDB4MDFjYywgIkRlbGwgRDgyMCIsIFBPU19GSVhfTFBJQiksCiAJU05EX1BDSV9RVUlS
SygweDEwMjgsIDB4MDFkZSwgIkRlbGwgUHJlY2lzaW9uIDM5MCIsIFBPU19GSVhfTFBJQiksCisJ
U05EX1BDSV9RVUlSSygweDEwMjgsIDB4MDFmNiwgIkRlbGwgTGF0aXR1ZGUgMTMxTCIsIFBPU19G
SVhfTFBJQiksCiAJU05EX1BDSV9RVUlSSygweDEwM2MsIDB4MzA2ZCwgIkhQIGR2MyIsIFBPU19G
SVhfTFBJQiksCiAJU05EX1BDSV9RVUlSSygweDExMDYsIDB4MzI4OCwgIkFTVVMgTTJWLU1YIFNF
IiwgUE9TX0ZJWF9MUElCKSwKIAlTTkRfUENJX1FVSVJLKDB4MTA0MywgMHg4MTNkLCAiQVNVUyBQ
NUFEMiIsIFBPU19GSVhfTFBJQiksCi0tIAoxLjcuMAoK
--00504502b000db56050480fab7ab
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--00504502b000db56050480fab7ab--
