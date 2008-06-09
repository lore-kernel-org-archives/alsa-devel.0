From: "Akio Idehara" <zbe64533@gmail.com>
Subject: [PATCH] Add Toshiba dynabook SS RX1 support
Date: Mon, 9 Jun 2008 22:57:40 +0900
Message-ID: <aeb93b2b0806090657r3b49e942g235104059e1484c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.168])
	by alsa0.perex.cz (Postfix) with ESMTP id BB0CB249D1
	for <alsa-devel@alsa-project.org>;
	Mon,  9 Jun 2008 15:57:42 +0200 (CEST)
Received: by wf-out-1314.google.com with SMTP id 24so3061057wfg.23
	for <alsa-devel@alsa-project.org>; Mon, 09 Jun 2008 06:57:41 -0700 (PDT)
Content-Disposition: inline
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

I have Toshiba dynabook SS RX1 and this patch adds that support.

Signed-off-by: Akio Idehara <zbe64533@gmail.com>
---
 sound/pci/hda/patch_realtek.c |    2 ++
 1 file changed, 2 insertions(+)
--- a/sound/pci/hda/patch_realtek.c	2008-06-08 19:23:57.000000000 +0900
+++ b/sound/pci/hda/patch_realtek.c	2008-06-08 20:55:34.000000000 +0900
@@ -9718,6 +9718,8 @@ static struct snd_pci_quirk alc262_cfg_t
 	SND_PCI_QUIRK(0x104d, 0x820f, "Sony ASSAMD", ALC262_SONY_ASSAMD),
 	SND_PCI_QUIRK(0x104d, 0x900e, "Sony ASSAMD", ALC262_SONY_ASSAMD),
 	SND_PCI_QUIRK(0x104d, 0x9015, "Sony 0x9015", ALC262_SONY_ASSAMD),
+	SND_PCI_QUIRK(0x1179, 0x0001, "Toshiba dynabook SS RX1",
+		      ALC262_SONY_ASSAMD),
 	SND_PCI_QUIRK(0x10cf, 0x1397, "Fujitsu", ALC262_FUJITSU),
 	SND_PCI_QUIRK(0x10cf, 0x142d, "Fujitsu Lifebook E8410", ALC262_FUJITSU),
 	SND_PCI_QUIRK(0x144d, 0xc032, "Samsung Q1 Ultra", ALC262_ULTRA),
