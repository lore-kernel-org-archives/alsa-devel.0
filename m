From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 1/2] ALSA: hda/tegra - Probe up to 8 codecs
Date: Mon,  3 Dec 2018 16:53:16 +0100
Message-ID: <20181203155317.16627-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 92A4B267ACE
 for <alsa-devel@alsa-project.org>; Mon,  3 Dec 2018 16:53:19 +0100 (CET)
Received: by mail-ed1-f67.google.com with SMTP id y56so11144081edd.11
 for <alsa-devel@alsa-project.org>; Mon, 03 Dec 2018 07:53:19 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, Sameer Pujar <spujar@nvidia.com>, linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, linux-tegra@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Thierry Reding <treding@nvidia.com>

Recent devices support more than the 4 codecs that the AZX core will
probe by default. Probe up to 8 codecs to make sure all of them are
enumerated.

Suggested-by: Sameer Pujar <spujar@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 sound/pci/hda/hda_tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
index 84ea6069d28b..83befd8d43e8 100644
--- a/sound/pci/hda/hda_tegra.c
+++ b/sound/pci/hda/hda_tegra.c
@@ -531,7 +531,7 @@ static void hda_tegra_probe_work(struct work_struct *work)
 		goto out_free;
 
 	/* create codec instances */
-	err = azx_probe_codecs(chip, 0);
+	err = azx_probe_codecs(chip, 8);
 	if (err < 0)
 		goto out_free;
 
-- 
2.19.1
