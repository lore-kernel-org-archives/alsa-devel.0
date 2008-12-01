From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ALSA: Add WM9715 to AC97 IDs
Date: Mon,  1 Dec 2008 14:54:45 +0000
Message-ID: <1228143285-23180-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4ADA6244AB
	for <alsa-devel@alsa-project.org>; Mon,  1 Dec 2008 15:54:47 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The WM9715 is software compatible with the WM9711 and WM9712.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/pci/ac97/ac97_codec.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
index 6704acb..e8375ff 100644
--- a/sound/pci/ac97/ac97_codec.c
+++ b/sound/pci/ac97/ac97_codec.c
@@ -175,7 +175,7 @@ static const struct ac97_codec_id snd_ac97_codec_ids[] = {
 { 0x574d4C04, 0xffffffff, "WM9704M,WM9704Q",	patch_wolfson04, NULL},
 { 0x574d4C05, 0xffffffff, "WM9705,WM9710",	patch_wolfson05, NULL},
 { 0x574d4C09, 0xffffffff, "WM9709",		NULL,		NULL},
-{ 0x574d4C12, 0xffffffff, "WM9711,WM9712",	patch_wolfson11, NULL},
+{ 0x574d4C12, 0xffffffff, "WM9711,WM9712,WM9715",	patch_wolfson11, NULL},
 { 0x574d4c13, 0xffffffff, "WM9713,WM9714",	patch_wolfson13, NULL, AC97_DEFAULT_POWER_OFF},
 { 0x594d4800, 0xffffffff, "YMF743",		patch_yamaha_ymf743,	NULL },
 { 0x594d4802, 0xffffffff, "YMF752",		NULL,		NULL },
-- 
1.5.6.5
