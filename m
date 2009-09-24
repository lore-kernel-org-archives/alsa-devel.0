From: gus.alsa@bourg.net
Subject: Patch for Zotac IONITX model detection
Date: Thu, 24 Sep 2009 21:58:51 +0000
Message-ID: <50361.1253829531@bourg.net>
Reply-To: gus.alsa@bourg.net
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=_da3d67c5d7526f23067d42194fdbf292"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from carrera.bourg.net (carrera.bourg.net [207.229.121.50])
	by alsa0.perex.cz (Postfix) with ESMTP id 03511243CA
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Sep 2009 23:58:53 +0200 (CEST)
Received: from mail.bourg.net (carrera [207.229.121.50])
	by carrera.bourg.net (Postfix) with ESMTP id B2B7996FC
	for <alsa-devel@alsa-project.org>; Thu, 24 Sep 2009 21:58:51 +0000 (UTC)
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

--=_da3d67c5d7526f23067d42194fdbf292
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

=20

	Tested this on my Zotac IONITX motherboard (N330 model).  Dmesg
output:

	[   16.464533] ALSA hda_codec.c:3081: hda_codec: model '3stack-6ch'
is selected for config 174b:437b (Zotac IONITX)
	Patch:

	--- alsa-kernel/pci/hda/patch_realtek.c.orig    2009-09-24
14:50:45.000000000 -0700
+++ alsa-kernel/pci/hda/patch_realtek.c 2009-09-24 14:38:07.000000000
-0700
@@ -16724,6 +16724,7 @@ static struct snd_pci_quirk alc662_cfg_t
                                        ALC662_3ST_6ch_DIG),
        SND_PCI_QUIRK_MASK(0x1854, 0xf000, 0x2000, "ASUS H13-200x",
                           ALC663_ASUS_H13),
+       SND_PCI_QUIRK(0x174b, 0x437b, "Zotac IONITX",
ALC662_3ST_6ch),
        {}
 };
	Thanks,

	Gus

-------------------------
Message sent via Atmail Open - http://atmail.org/
--=_da3d67c5d7526f23067d42194fdbf292
Content-Transfer-Encoding: base64
Content-Type: application/octet-stream;
 name="ionitx.audio.patch";
Content-Disposition: attachment;
 filename="ionitx.audio.patch";

LS0tIGFsc2Eta2VybmVsL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jLm9yaWcJMjAwOS0wOS0yNCAx
NDo1MDo0NS4wMDAwMDAwMDAgLTA3MDAKKysrIGFsc2Eta2VybmVsL3BjaS9oZGEvcGF0Y2hfcmVh
bHRlay5jCTIwMDktMDktMjQgMTQ6Mzg6MDcuMDAwMDAwMDAwIC0wNzAwCkBAIC0xNjcyNCw2ICsx
NjcyNCw3IEBAIHN0YXRpYyBzdHJ1Y3Qgc25kX3BjaV9xdWlyayBhbGM2NjJfY2ZnX3QKIAkJCQkJ
QUxDNjYyXzNTVF82Y2hfRElHKSwKIAlTTkRfUENJX1FVSVJLX01BU0soMHgxODU0LCAweGYwMDAs
IDB4MjAwMCwgIkFTVVMgSDEzLTIwMHgiLAogCQkJICAgQUxDNjYzX0FTVVNfSDEzKSwKKwlTTkRf
UENJX1FVSVJLKDB4MTc0YiwgMHg0MzdiLCAiWm90YWMgSU9OSVRYIiwgQUxDNjYyXzNTVF82Y2gp
LAogCXt9CiB9OwogCg==
--=_da3d67c5d7526f23067d42194fdbf292
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=_da3d67c5d7526f23067d42194fdbf292--
