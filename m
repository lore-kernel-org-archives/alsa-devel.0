From: Dan Chen <seven.steps@gmail.com>
Subject: [PATCH] ALSA: intel8x0: Apply headphones+mute LED
 quirk for Dell Inspiron 9300
Date: Thu, 14 Jul 2011 22:17:04 -0400
Message-ID: <CABJmPLmxZ3QN3=BX61PHK0gPn_YEBWtPXgWBX6JK+a2qK+SpwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf3001b821e6173004a8123e13
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 964C424547
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Jul 2011 04:17:05 +0200 (CEST)
Received: by wyh21 with SMTP id 21so570893wyh.38
	for <alsa-devel@alsa-project.org>; Thu, 14 Jul 2011 19:17:05 -0700 (PDT)
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
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--20cf3001b821e6173004a8123e13
Content-Type: text/plain; charset=UTF-8

Hi,

Attached is a patch against sound-2.6 master HEAD resolving the
original reporter's volume keys issue. Please consider applying.

Cheers,
-Dan

--20cf3001b821e6173004a8123e13
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-ALSA-intel8x0-Apply-headphones-mute-LED-quirk-for-De.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-intel8x0-Apply-headphones-mute-LED-quirk-for-De.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gq4imvsc0

RnJvbSA1ZjcwODQ0MzhjNmIwNTllZWQ2NjIzMWEwZmMxOTI2NDliOGM1NThiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IFRodSwgMTQgSnVsIDIwMTEgMjI6MDY6MDYgLTA0MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBpbnRlbDh4MDogQXBwbHkgaGVhZHBob25lcyttdXRlIExFRCBxdWlyayBmb3IgRGVsbAogSW5z
cGlyb24gOTMwMAoKQnVnTGluazogaHR0cHM6Ly9idWdzLmxhdW5jaHBhZC5uZXQvYnVncy83NzQ4
OTUKClRoZSBvcmlnaW5hbCByZXBvcnRlciBzdGF0ZXMgdGhhdCBoaXMgdm9sdW1lIGtleXMgZG8g
bm90IGNoYW5nZSB0aGUKZGVzaXJlZCBNYXN0ZXIgYW5kIFBDTSBtaXhlciBlbGVtZW50cyB0b2dl
dGhlciwgc28gYXBwbHkgdGhlIGhwK211dGUgbGVkCnF1aXJrIGZvciBoaXMgUENJIFNTSUQuCgpS
ZXBvcnRlZC1ieTogSmVmZnJleSBGaW5rZWxzdGVpbgpTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgVCBD
aGVuIDxjcmltc3VuQHVidW50dS5jb20+Ci0tLQogc291bmQvcGNpL2ludGVsOHgwLmMgfCAgICA2
ICsrKysrKwogMSBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvc291bmQvcGNpL2ludGVsOHgwLmMgYi9zb3VuZC9wY2kvaW50ZWw4eDAu
YwppbmRleCBmOWFjZjBmLi42YTViMzg3IDEwMDY0NAotLS0gYS9zb3VuZC9wY2kvaW50ZWw4eDAu
YworKysgYi9zb3VuZC9wY2kvaW50ZWw4eDAuYwpAQCAtMTg4NCw2ICsxODg0LDEyIEBAIHN0YXRp
YyBzdHJ1Y3QgYWM5N19xdWlyayBhYzk3X3F1aXJrc1tdIF9fZGV2aW5pdGRhdGEgPSB7CiAJfSwK
IAl7CiAJCS5zdWJ2ZW5kb3IgPSAweDEwMjgsCisJCS5zdWJkZXZpY2UgPSAweDAxODksCisJCS5u
YW1lID0gIkRlbGwgSW5zcGlyb24gOTMwMCIsCisJCS50eXBlID0gQUM5N19UVU5FX0hQX01VVEVf
TEVECisJfSwKKwl7CisJCS5zdWJ2ZW5kb3IgPSAweDEwMjgsCiAJCS5zdWJkZXZpY2UgPSAweDAx
OTEsCiAJCS5uYW1lID0gIkRlbGwgSW5zcGlyb24gODYwMCIsCiAJCS50eXBlID0gQUM5N19UVU5F
X0hQX09OTFkKLS0gCjEuNy41LjQKCg==
--20cf3001b821e6173004a8123e13
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--20cf3001b821e6173004a8123e13--
