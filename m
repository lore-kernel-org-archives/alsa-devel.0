From: Daniel Chen <seven.steps@gmail.com>
Subject: [PATCH] ALSA: ac97: Add IBM ThinkPad R40e to
	Headphone/Line Jack Sense blacklist
Date: Thu, 25 Mar 2010 22:45:36 -0700
Message-ID: <604760771003252245h284c289y22815c2f791abdb1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=000e0cd514042e63f30482adace1
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 9E1601037F9
	for <alsa-devel@alsa-project.org>; Fri, 26 Mar 2010 06:45:37 +0100 (CET)
Received: by pwj7 with SMTP id 7so5673750pwj.38
	for <alsa-devel@alsa-project.org>; Thu, 25 Mar 2010 22:45:36 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, stable@kernel.org
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--000e0cd514042e63f30482adace1
Content-Type: text/plain; charset=UTF-8

Hi,

Attached is a patch against current sound-2.6 master HEAD (also
applicable to 2.6.32.y and 2.6.33.y) that adds the IBM ThinkPad R40e
to the Headphone/Line Jack Sense blacklist, which is required for
audible audio.

Best,
-Dan

--000e0cd514042e63f30482adace1
Content-Type: text/x-diff; charset=US-ASCII;
	name="0001-ALSA-ac97-Add-IBM-ThinkPad-R40e-to-Headphone-Line-Ja.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-ac97-Add-IBM-ThinkPad-R40e-to-Headphone-Line-Ja.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g78khe8l0

RnJvbSBkZmNiNzk0YjQwNTllZDNmNmNkODhiYWJiOGZhNjUxZmE2NzQxM2M1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IFRodSwgMjUgTWFyIDIwMTAgMjI6Mzg6MTUgLTA3MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBhYzk3OiBBZGQgSUJNIFRoaW5rUGFkIFI0MGUgdG8gSGVhZHBob25lL0xpbmUgSmFjayBTZW5z
ZSBibGFja2xpc3QKCkJ1Z0xpbms6IGh0dHBzOi8vbGF1bmNocGFkLm5ldC9idWdzLzMwMzc4OQoK
VGhpcyBtb2RlbCBuZWVkcyBib3RoICdIZWFkcGhvbmUgSmFjayBTZW5zZScgYW5kICdMaW5lIEph
Y2sgU2Vuc2UnCm11dGVkIGZvciBhdWRpYmxlIGF1ZGlvLCBzbyBqdXN0IGFkZCBpdHMgU1NJRCB0
byB0aGUgYmxhY2tsaXN0IGFuZApkb24ndCBlbnVtZXJhdGUgdGhlIGNvbnRyb2xzLgoKQ2M6IDxz
dGFibGVAa2VybmVsLm9yZz4KU2lnbmVkLW9mZi1ieTogRGFuaWVsIFQgQ2hlbiA8Y3JpbXN1bkB1
YnVudHUuY29tPgotLS0KIHNvdW5kL3BjaS9hYzk3L2FjOTdfcGF0Y2guYyB8ICAgIDEgKwogMSBm
aWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvc291bmQvcGNpL2FjOTcvYWM5N19wYXRjaC5jIGIvc291bmQvcGNpL2FjOTcvYWM5N19wYXRj
aC5jCmluZGV4IDFjYWY1ZTMuLjFhNTliNzEgMTAwNjQ0Ci0tLSBhL3NvdW5kL3BjaS9hYzk3L2Fj
OTdfcGF0Y2guYworKysgYi9zb3VuZC9wY2kvYWM5Ny9hYzk3X3BhdGNoLmMKQEAgLTE4NTIsNiAr
MTg1Miw3IEBAIHN0YXRpYyB1bnNpZ25lZCBpbnQgYWQxOTgxX2phY2tzX2JsYWNrbGlzdFtdID0g
ewogCTB4MTAxNDA1MjMsIC8qIFRoaW5rcGFkIFI0MCAqLwogCTB4MTAxNDA1MzQsIC8qIFRoaW5r
cGFkIFgzMSAqLwogCTB4MTAxNDA1MzcsIC8qIFRoaW5rcGFkIFQ0MXAgKi8KKwkweDEwMTQwNTNl
LCAvKiBUaGlua3BhZCBSNDBlICovCiAJMHgxMDE0MDU1NCwgLyogVGhpbmtwYWQgVDQycC9SNTBw
ICovCiAJMHgxMDE0MDU2NywgLyogVGhpbmtwYWQgVDQzcCAyNjY4LUc3VSAqLwogCTB4MTAxNDA1
ODEsIC8qIFRoaW5rcGFkIFg0MS0yNTI3ICovCi0tIAoxLjcuMAoK
--000e0cd514042e63f30482adace1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--000e0cd514042e63f30482adace1--
