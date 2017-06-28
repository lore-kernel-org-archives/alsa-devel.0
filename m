From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH] ALSA: hda - set input_path bitmap to zero
	after moving it to new place
Date: Wed, 28 Jun 2017 08:59:16 +0800
Message-ID: <1498611556-11626-1-git-send-email-hui.wang@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 3CFE0266838
 for <alsa-devel@alsa-project.org>; Wed, 28 Jun 2017 02:59:21 +0200 (CEST)
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
Cc: stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Recently we met a problem, the codec has valid adcs and input pins,
and they can form valid input paths, but the driver does not build
valid controls for them like "Mic boost", "Capture Volume" and
"Capture Switch".

Through debugging, I found the driver needs to shrink the invalid
adcs and input paths for this machine, so it will move the whole
column bitmap value to the previous column, after moving it, the
driver forgets to set the original column bitmap value to zero, as a
result, the driver will invalidate the path whose index value is the
original colume bitmap value. After executing this function, all
valid input paths are invalidated by a mistake, there are no any
valid input paths, so the driver won't build controls for them.

Cc: <stable@vger.kernel.org>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
the alsa-info.txt of this machine (without this patch) is pasted here:
http://paste.ubuntu.com/24967758/

 sound/pci/hda/hda_generic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 557ecfc..28e265a 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -3216,6 +3216,7 @@ static int check_dyn_adc_switch(struct hda_codec *codec)
 						spec->input_paths[i][nums]);
 					spec->input_paths[i][nums] =
 						spec->input_paths[i][n];
+					spec->input_paths[i][n] = 0;
 				}
 			}
 			nums++;
-- 
1.9.1
