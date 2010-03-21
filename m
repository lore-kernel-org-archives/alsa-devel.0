From: Daniel Chen <seven.steps@gmail.com>
Subject: [PATCH] ALSA: hda: Fix 0 dB offset for HP laptops
	using CX20551 (Waikiki)
Date: Sun, 21 Mar 2010 19:01:18 -0400
Message-ID: <604760771003211601n3457e1d5jcff90aacefdcd112@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=000e0cd309fce773870482578e0d
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179]) by alsa0.perex.cz (Postfix) with ESMTP id 4228824458
	for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2010 00:01:19 +0100 (CET)
Received: by pvg12 with SMTP id 12so2244083pvg.38
	for <alsa-devel@alsa-project.org>; Sun, 21 Mar 2010 16:01:18 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Mike Pontillo <pontillo@gmail.com>, stable@kernel.org
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--000e0cd309fce773870482578e0d
Content-Type: text/plain; charset=UTF-8

Hi,

Attached is a patch to fix distortion at max PCM setting for HP
laptops using CX20551 (Waikiki).

Best,
-Dan

--000e0cd309fce773870482578e0d
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-ALSA-hda-Fix-0-dB-offset-for-HP-laptops-using-CX2055.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-hda-Fix-0-dB-offset-for-HP-laptops-using-CX2055.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g72g4igs0

RnJvbSA4NDQyYmQ2N2YyNWFiNWRmNDNjOTk1NDk0ODBkNTAxMWZhM2NiOWMxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IFN1biwgMjEgTWFyIDIwMTAgMTg6MzQ6NDMgLTA0MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGE6IEZpeCAwIGRCIG9mZnNldCBmb3IgSFAgbGFwdG9wcyB1c2luZyBDWDIwNTUxIChXYWlr
aWtpKQoKQnVnTGluazogaHR0cHM6Ly9sYXVuY2hwYWQubmV0L2J1Z3MvNDIwNTc4CgpUaGUgT1Ig
aGFzIHZlcmlmaWVkIHRoYXQgaGlzIGhhcmR3YXJlIGRpc3RvcnRzIGJlY2F1c2Ugb2YgdGhlIDAg
ZEIKb2Zmc2V0IG5vdCBjb3JyZXNwb25kaW5nIHRvIHRoZSBoaWdoZXN0IFBDTSBsZXZlbC4gRml4
IHRoaXMgYnkgY2FwcGluZwpzYWlkIFBDTSBsZXZlbCB0byAwIGRCIHNpbWlsYXJseSB0byB3aGF0
IHdlIGRvIGZvciBDWDIwNTQ5IChWZW5pY2UpLgoKUmVwb3J0ZWQtYnk6IE1pa2UgUG9udGlsbG8g
PHBvbnRpbGxvQGdtYWlsLmNvbT4KVGVzdGVkLWJ5OiBNaWtlIFBvbnRpbGxvIDxwb250aWxsb0Bn
bWFpbC5jb20+CkNjOiA8c3RhYmxlQGtlcm5lbC5vcmc+ClNpZ25lZC1vZmYtYnk6IERhbmllbCBU
IENoZW4gPGNyaW1zdW5AdWJ1bnR1LmNvbT4KLS0tCiBzb3VuZC9wY2kvaGRhL3BhdGNoX2NvbmV4
YW50LmMgfCAgIDE1ICsrKysrKysrKysrKysrKwogMSBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRp
b25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hf
Y29uZXhhbnQuYyBiL3NvdW5kL3BjaS9oZGEvcGF0Y2hfY29uZXhhbnQuYwppbmRleCAxOTRhMjhj
Li42MTY4MmUxIDEwMDY0NAotLS0gYS9zb3VuZC9wY2kvaGRhL3BhdGNoX2NvbmV4YW50LmMKKysr
IGIvc291bmQvcGNpL2hkYS9wYXRjaF9jb25leGFudC5jCkBAIC0xNTkxLDYgKzE1OTEsMjEgQEAg
c3RhdGljIGludCBwYXRjaF9jeHQ1MDQ3KHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjKQogI2VuZGlm
CQogCX0KIAlzcGVjLT52bWFzdGVyX25pZCA9IDB4MTM7CisKKwlzd2l0Y2ggKGNvZGVjLT5zdWJz
eXN0ZW1faWQgPj4gMTYpIHsKKwljYXNlIDB4MTAzYzoKKwkJLyogSFAgbGFwdG9wcyBoYXZlIHJl
YWxseSBiYWQgc291bmQgb3ZlciAwIGRCIG9uIE5JRCAweDEwLgorCQkgKiBGaXggbWF4IFBDTSBs
ZXZlbCB0byAwIGRCIChvcmlnaW5hbGx5IGl0IGhhcyAweDFlIHN0ZXBzCisJCSAqIHdpdGggMCBk
QiBvZmZzZXQgMHgxNykKKwkJICovCisJCXNuZF9oZGFfb3ZlcnJpZGVfYW1wX2NhcHMoY29kZWMs
IDB4MTAsIEhEQV9JTlBVVCwKKwkJCQkJICAoMHgxNyA8PCBBQ19BTVBDQVBfT0ZGU0VUX1NISUZU
KSB8CisJCQkJCSAgKDB4MTcgPDwgQUNfQU1QQ0FQX05VTV9TVEVQU19TSElGVCkgfAorCQkJCQkg
ICgweDA1IDw8IEFDX0FNUENBUF9TVEVQX1NJWkVfU0hJRlQpIHwKKwkJCQkJICAoMSA8PCBBQ19B
TVBDQVBfTVVURV9TSElGVCkpOworCQlicmVhazsKKwl9CisKIAlyZXR1cm4gMDsKIH0KIAotLSAK
MS43LjAKCg==
--000e0cd309fce773870482578e0d
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--000e0cd309fce773870482578e0d--
