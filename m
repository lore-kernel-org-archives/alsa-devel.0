From: Bankim Bhavsar <bbhavsar@vmware.com>
Subject: [HDA - Add support for VMware HDA Controller 1/1]
Date: Fri, 14 Jan 2011 18:32:30 -0800
Message-ID: <23CF726D96360F4E881BE326E0A843BE06F50FB6C4@EXCH-MBX-5.vmware.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_23CF726D96360F4E881BE326E0A843BE06F50FB6C4EXCHMBX5vmwar_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-outbound-2.vmware.com (smtp-outbound-2.vmware.com
	[65.115.85.73]) by alsa0.perex.cz (Postfix) with ESMTP id 9759C1037E3
	for <alsa-devel@alsa-project.org>; Sat, 15 Jan 2011 03:32:35 +0100 (CET)
Received: from mailhost3.vmware.com (mailhost3.vmware.com [10.16.27.45])
	by smtp-outbound-2.vmware.com (Postfix) with ESMTP id E6C2B27009
	for <alsa-devel@alsa-project.org>; Fri, 14 Jan 2011 18:32:31 -0800 (PST)
Received: from pa-excaht04.vmware.com (pa-excaht04.vmware.com [10.113.81.155])
	by mailhost3.vmware.com (Postfix) with ESMTP id D9E66CD9DF
	for <alsa-devel@alsa-project.org>; Fri, 14 Jan 2011 18:32:31 -0800 (PST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--_002_23CF726D96360F4E881BE326E0A843BE06F50FB6C4EXCHMBX5vmwar_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[ALSA]: HDA - Add support for VMware controller.
Add the new PCI ID 0x15ad and device ID 0x1977 for VMware HDAudio Controlle=
r.


Signed-off-by: Bankim Bhavsar <bbhavsar@vmware.com>

diff --git a/pci/hda/hda_intel.c b/pci/hda/hda_intel.c
index d3d18be..d9394d8 100644
--- a/pci/hda/hda_intel.c
+++ b/pci/hda/hda_intel.c
@@ -459,6 +459,7 @@ enum {
 	AZX_DRIVER_NVIDIA,
 	AZX_DRIVER_TERA,
 	AZX_DRIVER_CTX,
+	AZX_DRIVER_VMWARE,
 	AZX_DRIVER_GENERIC,
 	AZX_NUM_DRIVERS, /* keep this as last entry */
 };
@@ -475,6 +476,7 @@ static char *driver_short_names[] __devinitdata =3D {
 	[AZX_DRIVER_NVIDIA] =3D "HDA NVidia",
 	[AZX_DRIVER_TERA] =3D "HDA Teradici",=20
 	[AZX_DRIVER_CTX] =3D "HDA Creative",=20
+	[AZX_DRIVER_VMWARE] =3D "HDA VMware",
 	[AZX_DRIVER_GENERIC] =3D "HD-Audio Generic",
 };
=20
@@ -2793,6 +2795,8 @@ static DEFINE_PCI_DEVICE_TABLE(azx_ids) =3D {
 	  .driver_data =3D AZX_DRIVER_NVIDIA },
 	/* Teradici */
 	{ PCI_DEVICE(0x6549, 0x1200), .driver_data =3D AZX_DRIVER_TERA },
+	/* VMware HDAudio */
+	{ PCI_DEVICE(0x15ad, 0x1977), .driver_data =3D AZX_DRIVER_VMWARE },
 	/* Creative X-Fi (CA0110-IBG) */
 #if !defined(CONFIG_SND_CTXFI) && !defined(CONFIG_SND_CTXFI_MODULE)
 	/* the following entry conflicts with snd-ctxfi driver,
--=20
1.7.0.4

--_002_23CF726D96360F4E881BE326E0A843BE06F50FB6C4EXCHMBX5vmwar_
Content-Type: application/octet-stream; name="hdaudio.diff"
Content-Description: hdaudio.diff
Content-Disposition: attachment; filename="hdaudio.diff"; size=1042;
	creation-date="Fri, 14 Jan 2011 18:30:43 GMT";
	modification-date="Wed, 12 Jan 2011 14:25:17 GMT"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEvaGRhX2ludGVsLmMgYi9zb3VuZC9wY2kvaGRhL2hk
YV9pbnRlbC5jCmluZGV4IDA1YTBhNDAuLmZiNTViMTQgMTAwNjQ0Ci0tLSBhL3NvdW5kL3BjaS9o
ZGEvaGRhX2ludGVsLmMKKysrIGIvc291bmQvcGNpL2hkYS9oZGFfaW50ZWwuYwpAQCAtNDU3LDYg
KzQ1Nyw3IEBAIGVudW0gewogCUFaWF9EUklWRVJfVUxJLAogCUFaWF9EUklWRVJfTlZJRElBLAog
CUFaWF9EUklWRVJfVEVSQSwKKwlBWlhfRFJJVkVSX1ZNV0FSRSwKIAlBWlhfRFJJVkVSX0dFTkVS
SUMsCiAJQVpYX05VTV9EUklWRVJTLCAvKiBrZWVwIHRoaXMgYXMgbGFzdCBlbnRyeSAqLwogfTsK
QEAgLTQ3Miw2ICs0NzMsNyBAQCBzdGF0aWMgY2hhciAqZHJpdmVyX3Nob3J0X25hbWVzW10gX19k
ZXZpbml0ZGF0YSA9IHsKIAlbQVpYX0RSSVZFUl9VTEldID0gIkhEQSBVTEkgTTU0NjEiLAogCVtB
WlhfRFJJVkVSX05WSURJQV0gPSAiSERBIE5WaWRpYSIsCiAJW0FaWF9EUklWRVJfVEVSQV0gPSAi
SERBIFRlcmFkaWNpIiwgCisJW0FaWF9EUklWRVJfVk1XQVJFXSA9ICJIREEgVk13YXJlIiwgCiAJ
W0FaWF9EUklWRVJfR0VORVJJQ10gPSAiSEQtQXVkaW8gR2VuZXJpYyIsCiB9OwogCkBAIC0yNzg5
LDYgKzI3OTEsOCBAQCBzdGF0aWMgREVGSU5FX1BDSV9ERVZJQ0VfVEFCTEUoYXp4X2lkcykgPSB7
CiAJeyBQQ0lfREVWSUNFKDB4MTAzOSwgMHg3NTAyKSwgLmRyaXZlcl9kYXRhID0gQVpYX0RSSVZF
Ul9TSVMgfSwKIAkvKiBVTEkgTTU0NjEgKi8KIAl7IFBDSV9ERVZJQ0UoMHgxMGI5LCAweDU0NjEp
LCAuZHJpdmVyX2RhdGEgPSBBWlhfRFJJVkVSX1VMSSB9LAorCS8qIFZNd2FyZSBIREF1ZGlvICov
CisJeyBQQ0lfREVWSUNFKDB4MTVhZCwgMHgxOTc3KSwgLmRyaXZlcl9kYXRhID0gQVpYX0RSSVZF
Ul9WTVdBUkUgfSwKIAkvKiBOVklESUEgTUNQICovCiAJeyBQQ0lfREVWSUNFKFBDSV9WRU5ET1Jf
SURfTlZJRElBLCBQQ0lfQU5ZX0lEKSwKIAkgIC5jbGFzcyA9IFBDSV9DTEFTU19NVUxUSU1FRElB
X0hEX0FVRElPIDw8IDgsCg==

--_002_23CF726D96360F4E881BE326E0A843BE06F50FB6C4EXCHMBX5vmwar_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--_002_23CF726D96360F4E881BE326E0A843BE06F50FB6C4EXCHMBX5vmwar_--
