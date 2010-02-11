From: "Jason A. Donenfeld" <jason@zx2c4.com>
Subject: Realtek ALC275
Date: Wed, 10 Feb 2010 19:07:48 -0500
Message-ID: <f8d7c6611002101607m7701aa8el4c85d84ef1b61f8@mail.gmail.com>
References: <f8d7c6611002101605k4a57581gfc0f36ed64adb1c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636c92d7ff65b13047f47f079
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6511A2432C
	for <alsa-devel@alsa-project.org>; Thu, 11 Feb 2010 01:07:51 +0100 (CET)
Received: by yxe9 with SMTP id 9so488897yxe.23
	for <alsa-devel@alsa-project.org>; Wed, 10 Feb 2010 16:07:50 -0800 (PST)
Received: by ywh15 with SMTP id 15so640865ywh.5
	for <alsa-devel@alsa-project.org>; Wed, 10 Feb 2010 16:07:49 -0800 (PST)
In-Reply-To: <f8d7c6611002101605k4a57581gfc0f36ed64adb1c7@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--001636c92d7ff65b13047f47f079
Content-Type: text/plain; charset=ISO-8859-1

Hello All,

The new Vaio F series has a Realtek ALC 275, which is currently setup
in patch_realtek.c to use the 269 configuration. Unfortunately this
does not correctly enable the internal microphone, and the line-in is
not tied to any mixer control. The attached file will enable the
internal microphone, but will do so at the expense of the line-in.

According to Takashi, "The problem is that the digital-mic of pin 0x12
has the exclusive connection to the selector 0x22, followed to ADC
0x11, while other analog input pins are connected to 0x23/0x24, to ADC
0x08/0x09. Thus, the driver requires the dynamic switching of ADCs,
which isn't fully guaranteed to work. A similar situation is found for
Conexant codecs, and a same style hack would be needed for the realtek
codec."

This bug is being tracked here:
http://code.google.com/p/vaio-f11-linux/issues/detail?id=2 and here:
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4909 .

I'm wondering if anyone has any advice on how to implement the
necessary dynamic ADC switching.

Thanks,
Jason Donenfeld

--001636c92d7ff65b13047f47f079
Content-Type: text/x-patch; charset=US-ASCII; name="enable-internal-microphone.patch"
Content-Disposition: attachment; filename="enable-internal-microphone.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g5ise81n0

RnJvbSAxOThkNzkxNzkyYTE1YzgxMjhkZWU3Y2MwMmMwM2ViODEwNzkyMWVlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKYXNvbiBBLiBEb25lbmZlbGQgPEphc29uQHp4MmM0LmNvbT4K
RGF0ZTogV2VkLCAxMCBGZWIgMjAxMCAxODo0OToxNiAtMDUwMApTdWJqZWN0OiBbUEFUQ0hdIEZv
cmNlIEFMQzI2OSB0byB1c2UgaW50ZXJuYWwgbWljcm9waG9uZSBvbiBWUENGMTEuCgoKU2lnbmVk
LW9mZi1ieTogSmFzb24gQS4gRG9uZW5mZWxkIDxKYXNvbkB6eDJjNC5jb20+Ci0tLQogc291bmQv
cGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMgfCAgICA0ICsrLS0KIDEgZmlsZXMgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEv
cGF0Y2hfcmVhbHRlay5jIGIvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKaW5kZXggZGEz
NDA5NS4uZTYyYzVhNyAxMDA2NDQKLS0tIGEvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMK
KysrIGIvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKQEAgLTEzMTE5LDExICsxMzExOSwx
MSBAQCBzdGF0aWMgaW50IHBhdGNoX2FsYzI2OChzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYykKIAog
c3RhdGljIGhkYV9uaWRfdCBhbGMyNjlfYWRjX25pZHNbMV0gPSB7CiAJLyogQURDMSAqLwotCTB4
MDgsCisJMHgxMSwKIH07CiAKIHN0YXRpYyBoZGFfbmlkX3QgYWxjMjY5X2NhcHNyY19uaWRzWzFd
ID0gewotCTB4MjMsCisJMHgyMiwKIH07CiAKIC8qIE5PVEU6IEFEQzIgKDB4MDcpIGlzIGNvbm5l
Y3RlZCBmcm9tIGEgcmVjb3JkaW5nICpNSVhFUiogKDB4MjQpLAotLSAKMS42LjYuMQoK
--001636c92d7ff65b13047f47f079
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--001636c92d7ff65b13047f47f079--
