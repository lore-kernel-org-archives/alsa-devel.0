From: "Michalis Pappas" <mepapp@noc.uoa.gr>
Subject: [PATCH] Automatic driver detection for Amilo 3540
Date: Sat, 11 Apr 2009 15:16:08 +0300 (EEST)
Message-ID: <38678d234221cafb5837421906b91762.squirrel@webmail.uoa.gr>
Reply-To: mepapp@noc.uoa.gr
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20090411151608_60604"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from msa.uoa.gr (msa.uoa.gr [195.134.100.72])
	by alsa0.perex.cz (Postfix) with ESMTP id 3FE52243B7
	for <alsa-devel@alsa-project.org>;
	Sat, 11 Apr 2009 14:16:10 +0200 (CEST)
Received: from webmail.noc.uoa.gr (webmail.noc.uoa.gr [195.134.100.73])
	by msa.uoa.gr (8.14.1/8.14.1) with ESMTP id n3BCG84e021126
	for <alsa-devel@alsa-project.org>;
	Sat, 11 Apr 2009 15:16:08 +0300 (EEST)
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

------=_20090411151608_60604
Content-Type: text/plain; charset="iso-8859-7"
Content-Transfer-Encoding: quoted-printable

A patch to fix the issue described in #4344 and #4352.

Signed-off-by: Michalis Pappas <mepapp@noc.uoa.gr>

--- a/alsa-kernel/pci/hda/patch_realtek.c	2009-01-19 13:08:58.000000000 +=
0200
+++ b/alsa-kernel/pci/hda/patch_realtek.c	2009-04-11 14:15:44.000000000 +=
0300
@@ -8516,6 +8516,8 @@
 	SND_PCI_QUIRK(0x1734, 0x1108, "Fujitsu AMILO Pi2515",
ALC883_FUJITSU_PI2515),
 	SND_PCI_QUIRK(0x1734, 0x113d, "Fujitsu AMILO Xa3530",
 		ALC888_FUJITSU_XA3530),
+	SND_PCI_QUIRK(0x1734, 0x1137, "Fujitsu AMILO Xa3540",
+		ALC888_FUJITSU_XA3530),
 	SND_PCI_QUIRK(0x17aa, 0x101e, "Lenovo 101e", ALC883_LENOVO_101E_2ch),
 	SND_PCI_QUIRK(0x17aa, 0x2085, "Lenovo NB0763", ALC883_LENOVO_NB0763),
 	SND_PCI_QUIRK(0x17aa, 0x3bfc, "Lenovo NB0763", ALC883_LENOVO_NB0763),


------=_20090411151608_60604
Content-Type: application/octet-stream; name="amilo3540.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="amilo3540.diff"

LS0tIGEvYWxzYS1rZXJuZWwvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMJMjAwOS0wMS0xOSAxMzow
ODo1OC4wMDAwMDAwMDAgKzAyMDAKKysrIGIvYWxzYS1rZXJuZWwvcGNpL2hkYS9wYXRjaF9yZWFs
dGVrLmMJMjAwOS0wNC0xMSAxNDoxNTo0NC4wMDAwMDAwMDAgKzAzMDAKQEAgLTg1MTYsNiArODUx
Niw4IEBACiAJU05EX1BDSV9RVUlSSygweDE3MzQsIDB4MTEwOCwgIkZ1aml0c3UgQU1JTE8gUGky
NTE1IiwgQUxDODgzX0ZVSklUU1VfUEkyNTE1KSwKIAlTTkRfUENJX1FVSVJLKDB4MTczNCwgMHgx
MTNkLCAiRnVqaXRzdSBBTUlMTyBYYTM1MzAiLAogCQlBTEM4ODhfRlVKSVRTVV9YQTM1MzApLAor
CVNORF9QQ0lfUVVJUksoMHgxNzM0LCAweDExMzcsICJGdWppdHN1IEFNSUxPIFhhMzU0MCIsCisJ
CUFMQzg4OF9GVUpJVFNVX1hBMzUzMCksCiAJU05EX1BDSV9RVUlSSygweDE3YWEsIDB4MTAxZSwg
Ikxlbm92byAxMDFlIiwgQUxDODgzX0xFTk9WT18xMDFFXzJjaCksCiAJU05EX1BDSV9RVUlSSygw
eDE3YWEsIDB4MjA4NSwgIkxlbm92byBOQjA3NjMiLCBBTEM4ODNfTEVOT1ZPX05CMDc2MyksCiAJ
U05EX1BDSV9RVUlSSygweDE3YWEsIDB4M2JmYywgIkxlbm92byBOQjA3NjMiLCBBTEM4ODNfTEVO
T1ZPX05CMDc2MyksCg==
------=_20090411151608_60604
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_20090411151608_60604--
