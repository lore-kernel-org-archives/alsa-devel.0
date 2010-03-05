From: Daniel Chen <seven.steps@gmail.com>
Subject: [PATCH] ALSA: hda: Use LPIB for a Biostar Microtech
	board
Date: Fri, 5 Mar 2010 09:08:55 -0500
Message-ID: <604760771003050608m5a82eb20i78ae58a94b7bf55e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636e0a7a88a3e0e04810e413f
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f171.google.com (mail-px0-f171.google.com
	[209.85.216.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 301D22414A
	for <alsa-devel@alsa-project.org>; Fri,  5 Mar 2010 15:08:57 +0100 (CET)
Received: by pxi1 with SMTP id 1so1223165pxi.16
	for <alsa-devel@alsa-project.org>; Fri, 05 Mar 2010 06:08:56 -0800 (PST)
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

--001636e0a7a88a3e0e04810e413f
Content-Type: text/plain; charset=UTF-8

Hi,

Attached is a patch against sound-2.6 master HEAD (applies with
tweaking to 2.6.32.x) working around a hardware issue by using
position_fix=1.

Best,
-Dan

--001636e0a7a88a3e0e04810e413f
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-ALSA-hda-Use-LPIB-for-a-Biostar-Microtech-board.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-hda-Use-LPIB-for-a-Biostar-Microtech-board.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g6f28h290

RnJvbSAzMGMzNjYyZDYyOGZkNTBiYTJkYjc0YmIzMzA0NjVmYTMxMDgxY2NkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IEZyaSwgNSBNYXIgMjAxMCAwOTowNDo0OSAtMDUwMApTdWJqZWN0OiBbUEFUQ0hdIEFMU0E6
IGhkYTogVXNlIExQSUIgZm9yIGEgQmlvc3RhciBNaWNyb3RlY2ggYm9hcmQKCkJ1Z0xpbms6IGh0
dHBzOi8vbGF1bmNocGFkLm5ldC9idWdzLzUyMzk1MwoKVGhlIE9SIGhhcyB2ZXJpZmllZCB0aGF0
IHBvc2l0aW9uX2ZpeD0xIGlzIG5lY2Vzc2FyeSB0byB3b3JrIGFyb3VuZAplcnJvcnMgb24gaGlz
IG1hY2hpbmUuCgpSZXBvcnRlZC1ieTogTU1hcmtpbmcKQ2M6IDxzdGFibGVAa2VybmVsLm9yZz4K
U2lnbmVkLW9mZi1ieTogRGFuaWVsIFQgQ2hlbiA8Y3JpbXN1bkB1YnVudHUuY29tPgotLS0KIHNv
dW5kL3BjaS9oZGEvaGRhX2ludGVsLmMgfCAgICAxICsKIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNl
cnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEvaGRh
X2ludGVsLmMgYi9zb3VuZC9wY2kvaGRhL2hkYV9pbnRlbC5jCmluZGV4IGMwYWRkYTMuLjUyYzFj
ZDIgMTAwNjQ0Ci0tLSBhL3NvdW5kL3BjaS9oZGEvaGRhX2ludGVsLmMKKysrIGIvc291bmQvcGNp
L2hkYS9oZGFfaW50ZWwuYwpAQCAtMjI3MCw2ICsyMjcwLDcgQEAgc3RhdGljIHN0cnVjdCBzbmRf
cGNpX3F1aXJrIHBvc2l0aW9uX2ZpeF9saXN0W10gX19kZXZpbml0ZGF0YSA9IHsKIAlTTkRfUENJ
X1FVSVJLKDB4MTEwNiwgMHgzMjg4LCAiQVNVUyBNMlYtTVggU0UiLCBQT1NfRklYX0xQSUIpLAog
CVNORF9QQ0lfUVVJUksoMHgxMDQzLCAweDgxM2QsICJBU1VTIFA1QUQyIiwgUE9TX0ZJWF9MUElC
KSwKIAlTTkRfUENJX1FVSVJLKDB4MTQ2MiwgMHgxMDAyLCAiTVNJIFdpbmQgVTExNSIsIFBPU19G
SVhfTFBJQiksCisJU05EX1BDSV9RVUlSSygweDE1NjUsIDB4ODIwZiwgIkJpb3N0YXIgTWljcm90
ZWNoIiwgUE9TX0ZJWF9MUElCKSwKIAl7fQogfTsKIAotLSAKMS43LjAKCg==
--001636e0a7a88a3e0e04810e413f
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--001636e0a7a88a3e0e04810e413f--
