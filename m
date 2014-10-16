From: David Henningsson <david.henningsson@canonical.com>
Subject: [RFC PATCH 2/2] ALSA: hda - Use "Line Out" name
	instead of "PCM" when there are other outputs
Date: Thu, 16 Oct 2014 15:33:46 +0200
Message-ID: <1413466426-2672-2-git-send-email-david.henningsson@canonical.com>
References: <1413466426-2672-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 2119F2606C6
 for <alsa-devel@alsa-project.org>; Thu, 16 Oct 2014 15:33:51 +0200 (CEST)
In-Reply-To: <1413466426-2672-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

In case there are speakers or headphones as well, anything that only
covers the line out should not be labelled "PCM". Let's name it
"Line Out" instead for clarity.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 1d742ea..c037bab 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -1055,7 +1055,7 @@ static const char *get_line_out_pfx(struct hda_codec *codec, int ch,
 
 	/* for a single channel output, we don't have to name the channel */
 	if (cfg->line_outs == 1 && !spec->multi_ios)
-		return "PCM";
+		return "Line Out";
 
 	if (ch >= ARRAY_SIZE(channel_name)) {
 		snd_BUG();
-- 
1.9.1
