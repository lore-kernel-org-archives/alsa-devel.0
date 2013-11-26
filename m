From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: hda/realtek - Set pcbeep amp for
	ALC668
Date: Tue, 26 Nov 2013 09:41:12 +0100
Message-ID: <1385455272-13202-2-git-send-email-tiwai@suse.de>
References: <1385455272-13202-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D4E02610D7
 for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2013 09:41:13 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id CE153A7B6A
 for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2013 09:41:12 +0100 (CET)
In-Reply-To: <1385455272-13202-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Kailang Yang <kailang@realtek.com>

Set the missing pcbeep default amp for ALC668.

Signed-off-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 60973fd6eb82..c4ad9d198068 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5118,6 +5118,7 @@ static int patch_alc662(struct hda_codec *codec)
 		case 0x10ec0272:
 		case 0x10ec0663:
 		case 0x10ec0665:
+		case 0x10ec0668:
 			set_beep_amp(spec, 0x0b, 0x04, HDA_INPUT);
 			break;
 		case 0x10ec0273:
-- 
1.8.4.3
