From: Luke Yelavich <themuso@ubuntu.com>
Subject: [PATCH] ALSA: hda - Refer to macmini3 channel mode
	functions
Date: Tue, 23 Feb 2010 16:25:58 +1100
Message-ID: <1266902758-16160-1-git-send-email-themuso@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ipmail04.adl6.internode.on.net (ipmail04.adl6.internode.on.net
	[150.101.137.141])
	by alsa0.perex.cz (Postfix) with ESMTP id 920B924370
	for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2010 06:26:10 +0100 (CET)
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
Cc: Luke Yelavich <luke.yelavich@canonical.com>
List-Id: alsa-devel@alsa-project.org

From: Luke Yelavich <luke.yelavich@canonical.com>

Refer to alc885_macmini3_{2,6}ch_mode_init functions instead of those for the
mb5 model quirk. While they are the functino contents are the same now, things
may change later. This also gets rid of compiler warnings about initialized,
but unused functions.

Signed-off-by: Luke Yelavich <luke.yelavich@canonical.com>
---
 sound/pci/hda/patch_realtek.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index f8fb260..9e5ea9e 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7033,8 +7033,8 @@ static struct hda_verb alc885_macmini3_ch6_init[] = {
 };
 
 static struct hda_channel_mode alc885_macmini3_6ch_modes[2] = {
-	{ 2, alc885_mb5_ch2_init },
-	{ 6, alc885_mb5_ch6_init },
+	{ 2, alc885_macmini3_ch2_init },
+	{ 6, alc885_macmini3_ch6_init },
 };
 
 
-- 
1.7.0
