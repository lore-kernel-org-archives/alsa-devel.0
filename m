From: Daniel Chen <seven.steps@gmail.com>
Subject: [PATCH] ALSA: hda: Use hp-laptop quirk to enable
 headphones automute for Asus A52J
Date: Sun, 21 Nov 2010 14:17:31 -0500
Message-ID: <AANLkTikxPY8fZtgU-PLExi7yEPJ4abmse29K4OM3sJHb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016e657b29ec38912049594fdfd
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 6A7B824431
	for <alsa-devel@alsa-project.org>; Sun, 21 Nov 2010 20:17:33 +0100 (CET)
Received: by wyg36 with SMTP id 36so6280177wyg.38
	for <alsa-devel@alsa-project.org>; Sun, 21 Nov 2010 11:17:33 -0800 (PST)
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

--0016e657b29ec38912049594fdfd
Content-Type: text/plain; charset=UTF-8

Hi,

Please apply this patch against current sound-2.6 master HEAD to
enable headphones automute for the bug reporter's laptop.

Thanks,
-Dan

--0016e657b29ec38912049594fdfd
Content-Type: text/x-diff; charset=US-ASCII;
	name="0002-ALSA-hda-Use-hp-laptop-quirk-to-enable-headphones-au.patch"
Content-Disposition: attachment;
	filename="0002-ALSA-hda-Use-hp-laptop-quirk-to-enable-headphones-au.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ggsb61qq0

RnJvbSA1NGEyZDFkNjMxNjhhMTZlNzczMjYyYTNhN2NhMGRkNWZjZmE5ZmE3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IFN1biwgMjEgTm92IDIwMTAgMTQ6MDE6MTQgLTA1MDAKU3ViamVjdDogW1BBVENIIDIvMl0g
QUxTQTogaGRhOiBVc2UgaHAtbGFwdG9wIHF1aXJrIHRvIGVuYWJsZSBoZWFkcGhvbmVzIGF1dG9t
dXRlIGZvciBBc3VzIEE1MkoKCkJ1Z0xpbms6IGh0dHBzOi8vbGF1bmNocGFkLm5ldC9idWdzLzY3
NzY1MgoKVGhlIG9yaWdpbmFsIHJlcG9ydGVyIHN0YXRlcyB0aGF0LCBpbiAyLjYuMzUsIGhlYWRw
aG9uZXMgZG8gbm90IGFwcGVhcgp0byB3b3JrLCBub3IgZG9lcyBpbnNlcnRpbmcgdGhlbSBtdXRl
IHRoZSBBNTJKJ3Mgb25ib2FyZCBzcGVha2Vycy4gIFVwb24KaW5zcGVjdGluZyB0aGUgY29kZWMg
ZHVtcCwgaXQgYXBwZWFycyB0aGF0IHRoZSBuZXdseSBjb21taXR0ZWQgaHAtbGFwdG9wCnF1aXJr
IHdpbGwgc3VmZmljZSB0byBlbmFibGUgdGhpcyBiYXNpYyBmdW5jdGlvbmFsaXR5LiAgVGVzdGlu
ZyB3YXMgZG9uZQp3aXRoIGFuIGFsc2EtZHJpdmVyIGJ1aWxkIGZyb20gMjAxMC0xMS0yMS4KClJl
cG9ydGVkLWFuZC10ZXN0ZWQtYnk6IEpvYW4gQ3JldXMKQ2M6IDxzdGFibGVAa2VybmVsLm9yZz4g
WzIuNi4zNStdClNpZ25lZC1vZmYtYnk6IERhbmllbCBUIENoZW4gPGNyaW1zdW5AdWJ1bnR1LmNv
bT4KLS0tCiBzb3VuZC9wY2kvaGRhL3BhdGNoX2NvbmV4YW50LmMgfCAgICAxICsKIDEgZmlsZXMg
Y2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Nv
dW5kL3BjaS9oZGEvcGF0Y2hfY29uZXhhbnQuYyBiL3NvdW5kL3BjaS9oZGEvcGF0Y2hfY29uZXhh
bnQuYwppbmRleCA2MzYxZjc1Li4zY2ZiMzFlIDEwMDY0NAotLS0gYS9zb3VuZC9wY2kvaGRhL3Bh
dGNoX2NvbmV4YW50LmMKKysrIGIvc291bmQvcGNpL2hkYS9wYXRjaF9jb25leGFudC5jCkBAIC0z
MTAwLDYgKzMxMDAsNyBAQCBzdGF0aWMgc3RydWN0IHNuZF9wY2lfcXVpcmsgY3h0NTA2Nl9jZmdf
dGJsW10gPSB7CiAJU05EX1BDSV9RVUlSSygweDEwMjgsIDB4MDQwMiwgIkRlbGwgVm9zdHJvIiwg
Q1hUNTA2Nl9ERUxMX1ZPU1RSTyksCiAJU05EX1BDSV9RVUlSSygweDEwMjgsIDB4MDQwOCwgIkRl
bGwgSW5zcGlyb24gT25lIDE5VCIsIENYVDUwNjZfSURFQVBBRCksCiAJU05EX1BDSV9RVUlSSygw
eDEwM2MsIDB4MzYwYiwgIkhQIEc2MCIsIENYVDUwNjZfSFBfTEFQVE9QKSwKKwlTTkRfUENJX1FV
SVJLKDB4MTA0MywgMHgxM2YzLCAiQXN1cyBBNTJKIiwgQ1hUNTA2Nl9IUF9MQVBUT1ApLAogCVNO
RF9QQ0lfUVVJUksoMHgxMTc5LCAweGZmMWUsICJUb3NoaWJhIFNhdGVsbGl0ZSBDNjUwRCIsIENY
VDUwNjZfSURFQVBBRCksCiAJU05EX1BDSV9RVUlSSygweDExNzksIDB4ZmY1MCwgIlRvc2hpYmEg
U2F0ZWxsaXRlIFA1MDAtUFNQR1NDLTAxODAwVCIsIENYVDUwNjZfT0xQQ19YT18xXzUpLAogCVNO
RF9QQ0lfUVVJUksoMHgxMTc5LCAweGZmZTAsICJUb3NoaWJhIFNhdGVsbGl0ZSBQcm8gVDEzMC0x
NUYiLCBDWFQ1MDY2X09MUENfWE9fMV81KSwKLS0gCjEuNy4xCgo=
--0016e657b29ec38912049594fdfd
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0016e657b29ec38912049594fdfd--
