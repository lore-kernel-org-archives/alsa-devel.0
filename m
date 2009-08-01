From: Chengu Wang <wangchengu@gmail.com>
Subject: [PATCH] [ALSA] hda: Correct EAPD for Dell Inspiron 1525
Date: Sat, 1 Aug 2009 19:11:17 +0800
Message-ID: <b86064300908010411k73405bv3fa9cf37239ac630@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636457ed0b1bcc70470129999
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--001636457ed0b1bcc70470129999
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

>From 3dfb54666d0940bff474be9db791603f81c46303 Mon Sep 17 00:00:00 2001
From: Chengu Wang <wangchengu@gmail.com>
Date: Thu, 30 Jul 2009 19:43:55 +0800
Subject: [PATCH] [ALSA] hda: Correct EAPD for Dell Inspiron 1525

The commit 24918b61b55c21e09a3e07cd82e1b3a8154782dc statically changes
the model from dell-bios to dell-3stack to solve the sound decreasing
regression (http://lkml.org/lkml/2008/9/12/203), however it leads to another
problem that the 2nd headphone jack doesn't work
(https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3987). So I think
the commit 249**2dc is just a workaround. I would like to give a true solution
here.

The datasheet for STAC9228 says, GPIO2 is the same pin as VOL DOWN, and
the EAPD pin is GPIO0. This is why the sound decreases if we set EAPD as
GPIO2. This patch changes EAPD to GPIO0 to solve the problem.

Signed-off-by: Chengu Wang <wangchengu@gmail.com>
---
 sound/pci/hda/patch_sigmatel.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 8c48f86..3857add 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -2264,7 +2264,7 @@ static struct snd_pci_quirk stac927x_cfg_tbl[] = {
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL,  0x01f3, "Dell Inspiron 1420",
STAC_DELL_BIOS),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL,  0x0227, "Dell Vostro 1400  ",
STAC_DELL_BIOS),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL,  0x022e, "Dell     ", STAC_DELL_BIOS),
-	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL,  0x022f, "Dell Inspiron 1525",
STAC_DELL_3ST),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL,  0x022f, "Dell Inspiron 1525",
STAC_DELL_BIOS),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL,  0x0242, "Dell     ", STAC_DELL_BIOS),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL,  0x0243, "Dell     ", STAC_DELL_BIOS),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL,  0x02ff, "Dell     ", STAC_DELL_BIOS),
@@ -5659,6 +5659,13 @@ static int patch_stac927x(struct hda_codec *codec)
 		/* GPIO2 High = Enable EAPD */
 		spec->eapd_mask = spec->gpio_mask = spec->gpio_dir = 0x04;
 		spec->gpio_data = 0x04;
+		switch (codec->subsystem_id) {
+		case 0x1028022f:
+			/* correct EAPD to be GPIO0 */
+			spec->eapd_mask = spec->gpio_mask = 0x01;
+			spec->gpio_dir = spec->gpio_data = 0x01;
+			break;
+		};
 		spec->dmic_nids = stac927x_dmic_nids;
 		spec->num_dmics = STAC927X_NUM_DMICS;

-- 
1.6.0.4

--001636457ed0b1bcc70470129999
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001--ALSA-hda-Correct-EAPD-for-Dell-Inspiron-1525.patch"
Content-Disposition: attachment;
	filename="0001--ALSA-hda-Correct-EAPD-for-Dell-Inspiron-1525.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fxu8s8l10

RnJvbSAzZGZiNTQ2NjZkMDk0MGJmZjQ3NGJlOWRiNzkxNjAzZjgxYzQ2MzAzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDaGVuZ3UgV2FuZyA8d2FuZ2NoZW5ndUBnbWFpbC5jb20+CkRh
dGU6IFRodSwgMzAgSnVsIDIwMDkgMTk6NDM6NTUgKzA4MDAKU3ViamVjdDogW1BBVENIXSBbQUxT
QV0gaGRhOiBDb3JyZWN0IEVBUEQgZm9yIERlbGwgSW5zcGlyb24gMTUyNQoKVGhlIGNvbW1pdCAy
NDkxOGI2MWI1NWMyMWUwOWEzZTA3Y2Q4MmUxYjNhODE1NDc4MmRjIHN0YXRpY2FsbHkgY2hhbmdl
cwp0aGUgbW9kZWwgZnJvbSBkZWxsLWJpb3MgdG8gZGVsbC0zc3RhY2sgdG8gc29sdmUgdGhlIHNv
dW5kIGRlY3JlYXNpbmcKcmVncmVzc2lvbiAoaHR0cDovL2xrbWwub3JnL2xrbWwvMjAwOC85LzEy
LzIwMyksIGhvd2V2ZXIgaXQgbGVhZHMgdG8gYW5vdGhlcgpwcm9ibGVtIHRoYXQgdGhlIDJuZCBo
ZWFkcGhvbmUgamFjayBkb2Vzbid0IHdvcmsKKGh0dHBzOi8vYnVndHJhY2suYWxzYS1wcm9qZWN0
Lm9yZy9hbHNhLWJ1Zy92aWV3LnBocD9pZD0zOTg3KS4gU28gSSB0aGluawp0aGUgY29tbWl0IDI0
OSoqMmRjIGlzIGp1c3QgYSB3b3JrYXJvdW5kLiBJIHdvdWxkIGxpa2UgdG8gZ2l2ZSBhIHRydWUg
c29sdXRpb24KaGVyZS4KClRoZSBkYXRhc2hlZXQgZm9yIFNUQUM5MjI4IHNheXMsIEdQSU8yIGlz
IHRoZSBzYW1lIHBpbiBhcyBWT0wgRE9XTiwgYW5kCnRoZSBFQVBEIHBpbiBpcyBHUElPMC4gVGhp
cyBpcyB3aHkgdGhlIHNvdW5kIGRlY3JlYXNlcyBpZiB3ZSBzZXQgRUFQRCBhcwpHUElPMi4gVGhp
cyBwYXRjaCBjaGFuZ2VzIEVBUEQgdG8gR1BJTzAgdG8gc29sdmUgdGhlIHByb2JsZW0uCgpTaWdu
ZWQtb2ZmLWJ5OiBDaGVuZ3UgV2FuZyA8d2FuZ2NoZW5ndUBnbWFpbC5jb20+Ci0tLQogc291bmQv
cGNpL2hkYS9wYXRjaF9zaWdtYXRlbC5jIHwgICAgOSArKysrKysrKy0KIDEgZmlsZXMgY2hhbmdl
ZCwgOCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3Bj
aS9oZGEvcGF0Y2hfc2lnbWF0ZWwuYyBiL3NvdW5kL3BjaS9oZGEvcGF0Y2hfc2lnbWF0ZWwuYwpp
bmRleCA4YzQ4Zjg2Li4zODU3YWRkIDEwMDY0NAotLS0gYS9zb3VuZC9wY2kvaGRhL3BhdGNoX3Np
Z21hdGVsLmMKKysrIGIvc291bmQvcGNpL2hkYS9wYXRjaF9zaWdtYXRlbC5jCkBAIC0yMjY0LDcg
KzIyNjQsNyBAQCBzdGF0aWMgc3RydWN0IHNuZF9wY2lfcXVpcmsgc3RhYzkyN3hfY2ZnX3RibFtd
ID0gewogCVNORF9QQ0lfUVVJUksoUENJX1ZFTkRPUl9JRF9ERUxMLCAgMHgwMWYzLCAiRGVsbCBJ
bnNwaXJvbiAxNDIwIiwgU1RBQ19ERUxMX0JJT1MpLAogCVNORF9QQ0lfUVVJUksoUENJX1ZFTkRP
Ul9JRF9ERUxMLCAgMHgwMjI3LCAiRGVsbCBWb3N0cm8gMTQwMCAgIiwgU1RBQ19ERUxMX0JJT1Mp
LAogCVNORF9QQ0lfUVVJUksoUENJX1ZFTkRPUl9JRF9ERUxMLCAgMHgwMjJlLCAiRGVsbCAgICAg
IiwgU1RBQ19ERUxMX0JJT1MpLAotCVNORF9QQ0lfUVVJUksoUENJX1ZFTkRPUl9JRF9ERUxMLCAg
MHgwMjJmLCAiRGVsbCBJbnNwaXJvbiAxNTI1IiwgU1RBQ19ERUxMXzNTVCksCisJU05EX1BDSV9R
VUlSSyhQQ0lfVkVORE9SX0lEX0RFTEwsICAweDAyMmYsICJEZWxsIEluc3Bpcm9uIDE1MjUiLCBT
VEFDX0RFTExfQklPUyksCiAJU05EX1BDSV9RVUlSSyhQQ0lfVkVORE9SX0lEX0RFTEwsICAweDAy
NDIsICJEZWxsICAgICAiLCBTVEFDX0RFTExfQklPUyksCiAJU05EX1BDSV9RVUlSSyhQQ0lfVkVO
RE9SX0lEX0RFTEwsICAweDAyNDMsICJEZWxsICAgICAiLCBTVEFDX0RFTExfQklPUyksCiAJU05E
X1BDSV9RVUlSSyhQQ0lfVkVORE9SX0lEX0RFTEwsICAweDAyZmYsICJEZWxsICAgICAiLCBTVEFD
X0RFTExfQklPUyksCkBAIC01NjU5LDYgKzU2NTksMTMgQEAgc3RhdGljIGludCBwYXRjaF9zdGFj
OTI3eChzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYykKIAkJLyogR1BJTzIgSGlnaCA9IEVuYWJsZSBF
QVBEICovCiAJCXNwZWMtPmVhcGRfbWFzayA9IHNwZWMtPmdwaW9fbWFzayA9IHNwZWMtPmdwaW9f
ZGlyID0gMHgwNDsKIAkJc3BlYy0+Z3Bpb19kYXRhID0gMHgwNDsKKwkJc3dpdGNoIChjb2RlYy0+
c3Vic3lzdGVtX2lkKSB7CisJCWNhc2UgMHgxMDI4MDIyZjoKKwkJCS8qIGNvcnJlY3QgRUFQRCB0
byBiZSBHUElPMCAqLworCQkJc3BlYy0+ZWFwZF9tYXNrID0gc3BlYy0+Z3Bpb19tYXNrID0gMHgw
MTsKKwkJCXNwZWMtPmdwaW9fZGlyID0gc3BlYy0+Z3Bpb19kYXRhID0gMHgwMTsKKwkJCWJyZWFr
OworCQl9OwogCQlzcGVjLT5kbWljX25pZHMgPSBzdGFjOTI3eF9kbWljX25pZHM7CiAJCXNwZWMt
Pm51bV9kbWljcyA9IFNUQUM5MjdYX05VTV9ETUlDUzsKIAotLSAKMS42LjAuNAoK
--001636457ed0b1bcc70470129999
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--001636457ed0b1bcc70470129999--
