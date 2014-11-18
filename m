From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH 2/2] ALSA: hda - fix the mic mute led problem
	for Latitude E5550
Date: Tue, 18 Nov 2014 17:57:41 +0800
Message-ID: <1416304661-13243-2-git-send-email-hui.wang@canonical.com>
References: <1416304661-13243-1-git-send-email-hui.wang@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f51.google.com (mail-pa0-f51.google.com
 [209.85.220.51])
 by alsa0.perex.cz (Postfix) with ESMTP id D044626508C
 for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2014 10:59:53 +0100 (CET)
Received: by mail-pa0-f51.google.com with SMTP id ey11so7330925pad.24
 for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2014 01:59:52 -0800 (PST)
In-Reply-To: <1416304661-13243-1-git-send-email-hui.wang@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: hui.wang@canonical.com, alsa-devel@alsa-project.org, po-hsu.lin@canonical.com
List-Id: alsa-devel@alsa-project.org

The microphone mute led on the Latitude E5550 can't work. We need to
apply DELL_WMI_MIC_MUTE_LED quirk to this machine.

The machine uses alc293 codec and already applied the quirk
ALC293_FIXUP_DELL1_MIC_NO_PRESENCE through pin_fixup_tbl[].

Here we just let DELL_WMI_MIC_MUTE_LED be chained to
ALC269_FIXUP_HEADSET_MODE, then the machine will have these
quirks ALC293_FIXUP_DELL1_MIC_NO_PRESENCE-->
ALC269_FIXUP_HEADSET_MODE-->ALC255_FIXUP_DELL_WMI_MIC_MUTE_LED.

BugLink: https://bugs.launchpad.net/bugs/1381856
Reported-and-Tested-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 9da5798..8fea1b8 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4520,6 +4520,8 @@ static const struct hda_fixup alc269_fixups[] = {
 	[ALC269_FIXUP_HEADSET_MODE] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc_fixup_headset_mode,
+		.chained = true,
+		.chain_id = ALC255_FIXUP_DELL_WMI_MIC_MUTE_LED
 	},
 	[ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC] = {
 		.type = HDA_FIXUP_FUNC,
-- 
1.9.1
