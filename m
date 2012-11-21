From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - Cirrus: Correctly clear
	line_out_pins when moving to speaker
Date: Wed, 21 Nov 2012 10:03:10 +0100
Message-ID: <1353488590-4024-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 3769E2625EE
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2012 10:03:14 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de, 1076840@bugs.launchpad.net
Cc: "3.6+" <stable@vger.kernel.org>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

If this array is not cleared, the jack related code later might
fail to create "Internal Speaker Phantom Jack" on Dell Inspiron 3420 and
Dell Vostro 2420.

BugLink: https://bugs.launchpad.net/bugs/1076840
Cc: stable@vger.kernel.org (3.6+)
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_cirrus.c |    1 +
 1 file changed, 1 insertion(+)

Notes:
 1) AlsaInfo at https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1076840/+attachment/3428375/+files/AlsaInfo.txt
 2) The phantom jack feature was added in Linux 3.6, but was backported to Ubuntu's 3.5 kernel, so should be applied there as well.

diff --git a/sound/pci/hda/patch_cirrus.c b/sound/pci/hda/patch_cirrus.c
index f99cbf9..ed98172 100644
--- a/sound/pci/hda/patch_cirrus.c
+++ b/sound/pci/hda/patch_cirrus.c
@@ -473,6 +473,7 @@ static int parse_output(struct hda_codec *codec)
 		memcpy(cfg->speaker_pins, cfg->line_out_pins,
 		       sizeof(cfg->speaker_pins));
 		cfg->line_outs = 0;
+		memset(cfg->line_out_pins, 0, sizeof(cfg->line_out_pins));
 	}
 
 	return 0;
-- 
1.7.9.5
