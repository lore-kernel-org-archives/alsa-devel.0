From: Huacai Chen <chenhc@lemote.com>
Subject: [PATCH] ALSA: hda - Add fixup model name lookup for
	Lemote A1205
Date: Fri, 19 Sep 2014 14:57:02 +0800
Message-ID: <1411109822-1918-1-git-send-email-chenhc@lemote.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
 [209.85.220.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 8647C260815
 for <alsa-devel@alsa-project.org>; Fri, 19 Sep 2014 08:57:39 +0200 (CEST)
Received: by mail-pa0-f52.google.com with SMTP id kq14so3207644pab.25
 for <alsa-devel@alsa-project.org>; Thu, 18 Sep 2014 23:57:37 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, 3.15+@alsa-project.org, #@alsa-project.org, stable@vger.kernel.org, Fuxin Zhang <zhangfx@lemote.com>, Huacai Chen <chenhc@lemote.com>
List-Id: alsa-devel@alsa-project.org

Lemote A1004 is already added in commit a2dd933d01f (ALSA: hda - Add
fixup name lookup for CX5051 and 5066 codecs), but Lemote A1205 has
missing.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Cc: <stable@vger.kernel.org> # 3.15+
---
 sound/pci/hda/patch_conexant.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 5f214f1..726b7c6 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -798,6 +798,7 @@ static const struct hda_model_fixup cxt5066_fixup_models[] = {
 	{ .id = CXT_PINCFG_LENOVO_TP410, .name = "tp410" },
 	{ .id = CXT_FIXUP_THINKPAD_ACPI, .name = "thinkpad" },
 	{ .id = CXT_PINCFG_LEMOTE_A1004, .name = "lemote-a1004" },
+	{ .id = CXT_PINCFG_LEMOTE_A1205, .name = "lemote-a1205" },
 	{ .id = CXT_FIXUP_OLPC_XO, .name = "olpc-xo" },
 	{}
 };
-- 
1.7.7.3
