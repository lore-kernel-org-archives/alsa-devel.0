From: =?UTF-8?B?5a6L5rWp?= <baritono.tux@gmail.com>
Subject: [PATCH] ALSA: hda - Add quirk for Gateway T6834c laptop
Date: Mon, 20 Jul 2009 15:01:16 +0800
Message-ID: <66805f8c0907200001y3406758bxc5e1532596fc01d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636163d19526c53046f1db4f2
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f211.google.com (mail-gx0-f211.google.com
	[209.85.217.211])
	by alsa0.perex.cz (Postfix) with ESMTP id CC105103818
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Jul 2009 09:01:17 +0200 (CEST)
Received: by gxk7 with SMTP id 7so3245734gxk.8
	for <alsa-devel@alsa-project.org>; Mon, 20 Jul 2009 00:01:16 -0700 (PDT)
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

--001636163d19526c53046f1db4f2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Hao Song <baritono.tux@gmail.com>

Gateway T6834c laptops need EAPD always on while the default behavior
for the STAC9205 reference board is to turn it off upon every HP plug.
By using the special "eapd" model, which is first introduced for Gateway
T1616 laptops for this same reason, this peculiarity can be properly
handled.

Signed-off-by: Hao Song <baritono.tux@gmail.com>
---
 sound/pci/hda/patch_sigmatel.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.=
c
index 41b5b3a..d9efe5c 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -2379,6 +2379,7 @@ static struct snd_pci_quirk stac9205_cfg_tbl[] =3D {
               "Dell Vostro 1500", STAC_9205_DELL_M42),
     /* Gateway */
     SND_PCI_QUIRK(0x107b, 0x0565, "Gateway T1616", STAC_9205_EAPD),
+    SND_PCI_QUIRK(0x107b, 0x0560, "Gateway T6834c", STAC_9205_EAPD),
     {} /* terminator */
 };

--=20
1.6.0.4


--=20
=E5=AE=8B=E6=B5=A9
Song, Hao
Institute of Theoretical Computer Science and Communications
Room 117, Ho Sin Hang Engineering Building
Chinese University of Hong Kong, Hong Kong, P.R.China
E-mail: baritono.tux@gmail.com
Office Tel: (+8600852)-31634255

--001636163d19526c53046f1db4f2
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-ALSA-hda-Add-quirk-for-Gateway-T6834c-laptop.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-hda-Add-quirk-for-Gateway-T6834c-laptop.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fxcuklkq0

RnJvbSBjY2EzMGNkZDZmZjE0NGVlZjhmNzBkNDc0MWE3OGRhMTNmNzg1ZWZiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYW8gU29uZyA8YmFyaXRvbm8udHV4QGdtYWlsLmNvbT4KRGF0
ZTogTW9uLCAyMCBKdWwgMjAwOSAxNDozMToyNiArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIEFMU0E6
IGhkYSAtIEFkZCBxdWlyayBmb3IgR2F0ZXdheSBUNjgzNGMgbGFwdG9wClN0YXR1czogTwoKR2F0
ZXdheSBUNjgzNGMgbGFwdG9wcyBuZWVkIEVBUEQgYWx3YXlzIG9uIHdoaWxlIHRoZSBkZWZhdWx0
IGJlaGF2aW9yCmZvciB0aGUgU1RBQzkyMDUgcmVmZXJlbmNlIGJvYXJkIGlzIHRvIHR1cm4gaXQg
b2ZmIHVwb24gZXZlcnkgSFAgcGx1Zy4KQnkgdXNpbmcgdGhlIHNwZWNpYWwgImVhcGQiIG1vZGVs
LCB3aGljaCBpcyBmaXJzdCBpbnRyb2R1Y2VkIGZvciBHYXRld2F5ClQxNjE2IGxhcHRvcHMgZm9y
IHRoaXMgc2FtZSByZWFzb24sIHRoaXMgcGVjdWxpYXJpdHkgY2FuIGJlIHByb3Blcmx5CmhhbmRs
ZWQuCgpTaWduZWQtb2ZmLWJ5OiBIYW8gU29uZyA8YmFyaXRvbm8udHV4QGdtYWlsLmNvbT4KLS0t
CiBzb3VuZC9wY2kvaGRhL3BhdGNoX3NpZ21hdGVsLmMgfCAgICAxICsKIDEgZmlsZXMgY2hhbmdl
ZCwgMSBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3Bj
aS9oZGEvcGF0Y2hfc2lnbWF0ZWwuYyBiL3NvdW5kL3BjaS9oZGEvcGF0Y2hfc2lnbWF0ZWwuYwpp
bmRleCA0MWI1YjNhLi5kOWVmZTVjIDEwMDY0NAotLS0gYS9zb3VuZC9wY2kvaGRhL3BhdGNoX3Np
Z21hdGVsLmMKKysrIGIvc291bmQvcGNpL2hkYS9wYXRjaF9zaWdtYXRlbC5jCkBAIC0yMzc5LDYg
KzIzNzksNyBAQCBzdGF0aWMgc3RydWN0IHNuZF9wY2lfcXVpcmsgc3RhYzkyMDVfY2ZnX3RibFtd
ID0gewogCQkgICAgICAiRGVsbCBWb3N0cm8gMTUwMCIsIFNUQUNfOTIwNV9ERUxMX000MiksCiAJ
LyogR2F0ZXdheSAqLwogCVNORF9QQ0lfUVVJUksoMHgxMDdiLCAweDA1NjUsICJHYXRld2F5IFQx
NjE2IiwgU1RBQ185MjA1X0VBUEQpLAorCVNORF9QQ0lfUVVJUksoMHgxMDdiLCAweDA1NjAsICJH
YXRld2F5IFQ2ODM0YyIsIFNUQUNfOTIwNV9FQVBEKSwKIAl7fSAvKiB0ZXJtaW5hdG9yICovCiB9
OwogCi0tIAoxLjYuMC40Cgo=
--001636163d19526c53046f1db4f2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--001636163d19526c53046f1db4f2--
