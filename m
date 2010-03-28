From: Daniel Chen <seven.steps@gmail.com>
Subject: [PATCH] ALSA: hda: Use LPIB for ga-ma770-ud3 board
Date: Sat, 27 Mar 2010 23:41:51 -0700
Message-ID: <604760771003272341t7c352859sd8a4a6f7b2264ba1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636e0a8f00d3ffa0482d6b18f
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179]) by alsa0.perex.cz (Postfix) with ESMTP id B3DB82435F
	for <alsa-devel@alsa-project.org>;
	Sun, 28 Mar 2010 08:41:53 +0200 (CEST)
Received: by pvg12 with SMTP id 12so4997141pvg.38
	for <alsa-devel@alsa-project.org>; Sat, 27 Mar 2010 23:41:51 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, 575669-submitter@bugs.debian.org, stable@kernel.org
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--001636e0a8f00d3ffa0482d6b18f
Content-Type: text/plain; charset=UTF-8

Hi,

Attached is a patch against current sound-2.6 master HEAD (also
applicable to 2.6.32.y and 2.6.33.y) that makes the OR's audio more
tolerable with PulseAudio.

Best,
-Dan

--001636e0a8f00d3ffa0482d6b18f
Content-Type: text/x-diff; charset=US-ASCII;
	name="0001-ALSA-hda-Use-LPIB-for-ga-ma770-ud3-board.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-hda-Use-LPIB-for-ga-ma770-ud3-board.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g7bhc9z70

RnJvbSAzODgxMTMzNGU4NGZlZjUxZGYxNmU0NTBkNjU3YzlmYWVmNzcxNWVmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IFN1biwgMjggTWFyIDIwMTAgMDI6MzQ6NDAgLTA0MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGE6IFVzZSBMUElCIGZvciBnYS1tYTc3MC11ZDMgYm9hcmQKCkJ1Z0xpbms6IGh0dHA6Ly9i
dWdzLmRlYmlhbi5vcmcvY2dpLWJpbi9idWdyZXBvcnQuY2dpP2J1Zz01NzU2NjkKClRoZSBPUiBz
dGF0ZXMgdGhhdCBwb3NpdGlvbl9maXg9MSBpcyBuZWNlc3NhcnkgdG8gd29yayBhcm91bmQgZ2xp
dGNoaW5nCmR1cmluZyB2b2x1bWUgYWRqdXN0bWVudHMgdXNpbmcgUHVsc2VBdWRpby4KClJlcG9y
dGVkLWJ5OiBDYXJsb3MgTGF2aW9sYSA8Y2xhdmlvbGFAZGViaWFuLm9yZz4KVGVzdGVkLWJ5OiBD
YXJsb3MgTGF2aW9sYSA8Y2xhdmlvbGFAZGViaWFuLm9yZz4KQ2M6IDxzdGFibGVAa2VybmVsLm9y
Zz4KU2lnbmVkLW9mZi1ieTogRGFuaWVsIFQgQ2hlbiA8Y3JpbXN1bkB1YnVudHUuY29tPgotLS0K
IHNvdW5kL3BjaS9oZGEvaGRhX2ludGVsLmMgfCAgICAxICsKIDEgZmlsZXMgY2hhbmdlZCwgMSBp
bnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEv
aGRhX2ludGVsLmMgYi9zb3VuZC9wY2kvaGRhL2hkYV9pbnRlbC5jCmluZGV4IGEzM2MxYzUuLmIx
ODVhZmQgMTAwNjQ0Ci0tLSBhL3NvdW5kL3BjaS9oZGEvaGRhX2ludGVsLmMKKysrIGIvc291bmQv
cGNpL2hkYS9oZGFfaW50ZWwuYwpAQCAtMjI3Myw2ICsyMjczLDcgQEAgc3RhdGljIHN0cnVjdCBz
bmRfcGNpX3F1aXJrIHBvc2l0aW9uX2ZpeF9saXN0W10gX19kZXZpbml0ZGF0YSA9IHsKIAlTTkRf
UENJX1FVSVJLKDB4MTAzYywgMHgzMDZkLCAiSFAgZHYzIiwgUE9TX0ZJWF9MUElCKSwKIAlTTkRf
UENJX1FVSVJLKDB4MTEwNiwgMHgzMjg4LCAiQVNVUyBNMlYtTVggU0UiLCBQT1NfRklYX0xQSUIp
LAogCVNORF9QQ0lfUVVJUksoMHgxMDQzLCAweDgxM2QsICJBU1VTIFA1QUQyIiwgUE9TX0ZJWF9M
UElCKSwKKwlTTkRfUENJX1FVSVJLKDB4MTQ1OCwgMHhhMDIyLCAiZ2EtbWE3NzAtdWQzIiwgUE9T
X0ZJWF9MUElCKSwKIAlTTkRfUENJX1FVSVJLKDB4MTQ2MiwgMHgxMDAyLCAiTVNJIFdpbmQgVTEx
NSIsIFBPU19GSVhfTFBJQiksCiAJU05EX1BDSV9RVUlSSygweDE1NjUsIDB4ODIwZiwgIkJpb3N0
YXIgTWljcm90ZWNoIiwgUE9TX0ZJWF9MUElCKSwKIAlTTkRfUENJX1FVSVJLKDB4ODA4NiwgMHhk
NjAxLCAiZU1hY2hpbmVzIFQ1MjEyIiwgUE9TX0ZJWF9MUElCKSwKLS0gCjEuNy4wCgo=
--001636e0a8f00d3ffa0482d6b18f
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--001636e0a8f00d3ffa0482d6b18f--
