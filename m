From: Andreas Herrmann <herrmann.der.user@googlemail.com>
Subject: [PATCH] ALSA,
 hda: Add support for another Lenovo ThinkPad Edge in conexant codec
Date: Fri, 28 May 2010 09:57:12 +0200
Message-ID: <20100528075712.GH10254@alberich.amd.com>
References: <20100527160656.GE10254@alberich.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 0C3A92436C
	for <alsa-devel@alsa-project.org>;
	Fri, 28 May 2010 09:57:16 +0200 (CEST)
Received: by fxm18 with SMTP id 18so674767fxm.38
	for <alsa-devel@alsa-project.org>; Fri, 28 May 2010 00:57:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100527160656.GE10254@alberich.amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Cc: Jerone Young <jerone.young@canonical.com>, alsa-devel@alsa-project.org, Borislav Petkov <borislav.petkov@amd.com>
List-Id: alsa-devel@alsa-project.org

From: Andreas Herrmann <andreas.herrmann3@amd.com>

On a Thinkpad Edge 13 "01972NG" I had the problem that speakers played
sound although headphones were plugged in. Using model=ideapad with
latest alsa-git kernel fixed this. So adding this quirk to use ideapad
for another Thinkpad Edge variant seems sensible.

Cc: Jerone Young <jerone.young@canonical.com>
Signed-off-by: Andreas Herrmann <andreas.herrmann3@amd.com>
---
 sound/pci/hda/patch_conexant.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

Patch is against today's sound-2.6 git tree.
Please apply.

Thanks,
Andreas


diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index f4a2bd6..2bf2cb5 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -2975,6 +2975,7 @@ static struct snd_pci_quirk cxt5066_cfg_tbl[] = {
 	SND_PCI_QUIRK(0x1179, 0xff50, "Toshiba Satellite P500-PSPGSC-01800T", CXT5066_OLPC_XO_1_5),
 	SND_PCI_QUIRK(0x1179, 0xffe0, "Toshiba Satellite Pro T130-15F", CXT5066_OLPC_XO_1_5),
 	SND_PCI_QUIRK(0x17aa, 0x21b2, "Thinkpad X100e", CXT5066_IDEAPAD),
+	SND_PCI_QUIRK(0x17aa, 0x21b3, "Thinkpad Edge 13 (197)", CXT5066_IDEAPAD),
 	SND_PCI_QUIRK(0x17aa, 0x21b4, "Thinkpad Edge", CXT5066_IDEAPAD),
 	SND_PCI_QUIRK(0x17aa, 0x3a0d, "ideapad", CXT5066_IDEAPAD),
 	SND_PCI_QUIRK(0x17aa, 0x215e, "Lenovo Thinkpad", CXT5066_THINKPAD),
-- 
1.7.1
