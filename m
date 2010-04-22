From: Daniel Chen <seven.steps@gmail.com>
Subject: [PATCH] ALSA: hda: Use STAC_DELL_M6_BOTH quirk for
	Dell Studio XPS 1645
Date: Wed, 21 Apr 2010 20:48:36 -0400
Message-ID: <j2k604760771004211748o8d9e1340v5d52460c01d62ec6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00504502b4ffc4b7020484c8abd3
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179]) by alsa0.perex.cz (Postfix) with ESMTP id 7D636243E9
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Apr 2010 02:48:38 +0200 (CEST)
Received: by pvh11 with SMTP id 11so215302pvh.38
	for <alsa-devel@alsa-project.org>; Wed, 21 Apr 2010 17:48:37 -0700 (PDT)
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

--00504502b4ffc4b7020484c8abd3
Content-Type: text/plain; charset=UTF-8

Hi,

Attached is a patch against sound-2.6 master HEAD adding a quirk for
the Dell Studio XPS 1645 to make playback and capture work.

Best,
-Dan

--00504502b4ffc4b7020484c8abd3
Content-Type: text/x-diff; charset=US-ASCII;
	name="0001-ALSA-hda-Use-STAC_DELL_M6_BOTH-quirk-for-Dell-Studio.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-hda-Use-STAC_DELL_M6_BOTH-quirk-for-Dell-Studio.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g8auszig0

RnJvbSA2ZDg1NDU4OWEwYmQyMDkwZTA1YjMyNWRhNmYyYzQ4YjlkMWIxMmY4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IFdlZCwgMjEgQXByIDIwMTAgMjA6NDE6NTIgLTA0MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGE6IFVzZSBTVEFDX0RFTExfTTZfQk9USCBxdWlyayBmb3IgRGVsbCBTdHVkaW8gWFBTIDE2
NDUKCkJ1Z0xpbms6IGh0dHBzOi8vbGF1bmNocGFkLm5ldC9idWdzLzU1MzAwMgoKVGhlIE9SIGhh
cyB2ZXJpZmllZCB0aGF0IHRoZSBkZWxsLW02IG1vZGVsIHF1aXJrIGlzIG5lY2Vzc2FyeSBmb3Ig
YXVkaW8KdG8gYmUgYXVkaWJsZSBieSBkZWZhdWx0IG9uIHRoZSBEZWxsIFN0dWRpbyBYUFMgMTY0
NS4KClRoaXMgY2hhbmdlIGlzIG5lY2Vzc2FyeSBmb3IgMi42LjMyLjExIGFuZCAyLjYuMzMuMiBh
bGlrZS4KClJlcG9ydGVkLWJ5OiBSb2JlcnQgQ2hhbWJlcnMKVGVzdGVkLWJ5OiBSb2JlcnQgQ2hh
bWJlcnMKQ2M6IDxzdGFibGVAa2VybmVsLm9yZz4KU2lnbmVkLW9mZi1ieTogRGFuaWVsIFQgQ2hl
biA8Y3JpbXN1bkB1YnVudHUuY29tPgotLS0KIHNvdW5kL3BjaS9oZGEvcGF0Y2hfc2lnbWF0ZWwu
YyB8ICAgIDIgKysKIDEgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hfc2lnbWF0ZWwuYyBiL3NvdW5k
L3BjaS9oZGEvcGF0Y2hfc2lnbWF0ZWwuYwppbmRleCBjNGJlM2ZhLi44MWVjZDkzIDEwMDY0NAot
LS0gYS9zb3VuZC9wY2kvaGRhL3BhdGNoX3NpZ21hdGVsLmMKKysrIGIvc291bmQvcGNpL2hkYS9w
YXRjaF9zaWdtYXRlbC5jCkBAIC0xNjA3LDYgKzE2MDcsOCBAQCBzdGF0aWMgc3RydWN0IHNuZF9w
Y2lfcXVpcmsgc3RhYzkyaGQ3M3h4X2NmZ190YmxbXSA9IHsKIAkJCQkiRGVsbCBTdHVkaW8gMTU1
NSIsIFNUQUNfREVMTF9NNl9ETUlDKSwKIAlTTkRfUENJX1FVSVJLKFBDSV9WRU5ET1JfSURfREVM
TCwgMHgwMmJkLAogCQkJCSJEZWxsIFN0dWRpbyAxNTU3IiwgU1RBQ19ERUxMX002X0RNSUMpLAor
CVNORF9QQ0lfUVVJUksoUENJX1ZFTkRPUl9JRF9ERUxMLCAweDAyZmUsCisJCQkJIkRlbGwgU3R1
ZGlvIFhQUyAxNjQ1IiwgU1RBQ19ERUxMX002X0JPVEgpLAogCXt9IC8qIHRlcm1pbmF0b3IgKi8K
IH07CiAKLS0gCjEuNy4wLjQKCg==
--00504502b4ffc4b7020484c8abd3
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--00504502b4ffc4b7020484c8abd3--
