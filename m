From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 3/3] ALSA: hda - initialize channel counts
	correctly
Date: Wed, 16 Jan 2013 11:45:37 +0100
Message-ID: <1358333137-9415-4-git-send-email-david.henningsson@canonical.com>
References: <1358333137-9415-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 579E0262601
 for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2013 11:45:37 +0100 (CET)
In-Reply-To: <1358333137-9415-1-git-send-email-david.henningsson@canonical.com>
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

Even a single DAC can output two channels, so the channel count
is twice the number of DACs.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_generic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index aac8eb9..3ef38da 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -1399,7 +1399,7 @@ static int fill_and_eval_dacs(struct hda_codec *codec,
 	}
 
 	spec->ext_channel_count = spec->min_channel_count =
-		spec->multiout.num_dacs;
+		spec->multiout.num_dacs * 2;
 
 	if (spec->multi_ios == 2) {
 		for (i = 0; i < 2; i++)
-- 
1.7.9.5
