From: Daniel Chen <seven.steps@gmail.com>
Subject: [PATCH] ALSA: hda: Fix 0 dB for Packard Bell models
	using Conexant CX20549 (Venice)
Date: Wed, 28 Apr 2010 18:07:16 -0400
Message-ID: <x2n604760771004281507x5464161frd1f09b6cd4c8a7fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636e909e7a2dfc80485533be1
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f202.google.com (mail-pz0-f202.google.com
	[209.85.222.202])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B7EF24621
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Apr 2010 00:07:18 +0200 (CEST)
Received: by pzk40 with SMTP id 40so802170pzk.23
	for <alsa-devel@alsa-project.org>; Wed, 28 Apr 2010 15:07:16 -0700 (PDT)
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

--001636e909e7a2dfc80485533be1
Content-Type: text/plain; charset=UTF-8

Hi,

Attached is a patch against sound-2.6 master HEAD (also applicable to
2.6.32.12 and 2.6.33.3) that fixes 0 dB for Packard Bell machines
using Conexant CX20549. Without it, sound distorts horribly.

Best,
-Dan

--001636e909e7a2dfc80485533be1
Content-Type: text/x-diff; charset=US-ASCII;
	name="0001-ALSA-hda-Fix-0-dB-for-Packard-Bell-models-using-Cone.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-hda-Fix-0-dB-for-Packard-Bell-models-using-Cone.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g8kp2yhf0

RnJvbSBlMjEwOTkyMmY0NTA1ZmUwOGVmNmUyNDY3M2I0ZTRhOTE2NDhmYTRlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IFdlZCwgMjggQXByIDIwMTAgMTg6MDA6MTEgLTA0MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGE6IEZpeCAwIGRCIGZvciBQYWNrYXJkIEJlbGwgbW9kZWxzIHVzaW5nIENvbmV4YW50IENY
MjA1NDkgKFZlbmljZSkKCkJ1Z0xpbms6IGh0dHBzOi8vbGF1bmNocGFkLm5ldC9idWdzLzU0MTgw
MgoKVGhlIE9SJ3MgaGFyZHdhcmUgZGlzdG9ydHMgYXQgUENNIDEwMCUgYmVjYXVzZSBpdCBkb2Vz
IG5vdCBjb3JyZXNwb25kIHRvCjAgZEIuIEZpeCB0aGlzIGluIHBhdGNoX2N4dDUwNDUoKSBmb3Ig
YWxsIFBhY2thcmQgQmVsbCBtb2RlbHMuCgpSZXBvcnRlZC1ieTogVmFsb21icmUKQ2M6IDxzdGFi
bGVAa2VybmVsLm9yZz4KU2lnbmVkLW9mZi1ieTogRGFuaWVsIFQgQ2hlbiA8Y3JpbXN1bkB1YnVu
dHUuY29tPgotLS0KIHNvdW5kL3BjaS9oZGEvcGF0Y2hfY29uZXhhbnQuYyB8ICAgIDUgKysrLS0K
IDEgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hfY29uZXhhbnQuYyBiL3NvdW5kL3BjaS9oZGEvcGF0
Y2hfY29uZXhhbnQuYwppbmRleCA1MDlhMTA0Li5iOTY0NGU0IDEwMDY0NAotLS0gYS9zb3VuZC9w
Y2kvaGRhL3BhdGNoX2NvbmV4YW50LmMKKysrIGIvc291bmQvcGNpL2hkYS9wYXRjaF9jb25leGFu
dC5jCkBAIC0xMTk2LDkgKzExOTYsMTAgQEAgc3RhdGljIGludCBwYXRjaF9jeHQ1MDQ1KHN0cnVj
dCBoZGFfY29kZWMgKmNvZGVjKQogCiAJc3dpdGNoIChjb2RlYy0+c3Vic3lzdGVtX2lkID4+IDE2
KSB7CiAJY2FzZSAweDEwM2M6CisJY2FzZSAweDE2MzE6CiAJY2FzZSAweDE3MzQ6Ci0JCS8qIEhQ
ICYgRnVqaXRzdS1TaWVtZW5zIGxhcHRvcHMgaGF2ZSByZWFsbHkgYmFkIHNvdW5kIG92ZXIgMGRC
Ci0JCSAqIG9uIE5JRCAweDE3LiBGaXggbWF4IFBDTSBsZXZlbCB0byAwIGRCCisJCS8qIEhQLCBQ
YWNrYXJkIEJlbGwsICYgRnVqaXRzdS1TaWVtZW5zIGxhcHRvcHMgaGF2ZSByZWFsbHkgYmFkCisJ
CSAqIHNvdW5kIG92ZXIgMGRCIG9uIE5JRCAweDE3LiBGaXggbWF4IFBDTSBsZXZlbCB0byAwIGRC
CiAJCSAqIChvcmlnaW5hbGx5IGl0IGhhcyAweDJiIHN0ZXBzIHdpdGggMGRCIG9mZnNldCAweDE0
KQogCQkgKi8KIAkJc25kX2hkYV9vdmVycmlkZV9hbXBfY2Fwcyhjb2RlYywgMHgxNywgSERBX0lO
UFVULAotLSAKMS43LjAuNAoK
--001636e909e7a2dfc80485533be1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--001636e909e7a2dfc80485533be1--
