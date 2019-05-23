From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ASoC: SOF: Use struct_size() in kmemdup()
Date: Thu, 23 May 2019 10:58:00 -0500
Message-ID: <20190523155800.GA2428@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes, in particular in the
context in which this code is being used.

So, replace code of the following form:

sizeof(*w) + sizeof(struct sof_ipc_window_elem) * w->num_windows

with:

struct_size(w, window, w->num_windows)

Notice that variable size is unnecessary, hence it is removed.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/soc/sof/loader.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sof/loader.c b/sound/soc/sof/loader.c
index 628fae552442..16b016b76fd8 100644
--- a/sound/soc/sof/loader.c
+++ b/sound/soc/sof/loader.c
@@ -19,15 +19,13 @@ static int get_ext_windows(struct snd_sof_dev *sdev,
 {
 	struct sof_ipc_window *w =
 		container_of(ext_hdr, struct sof_ipc_window, ext_hdr);
-	size_t size;
 
 	if (w->num_windows == 0 || w->num_windows > SOF_IPC_MAX_ELEMS)
 		return -EINVAL;
 
-	size = sizeof(*w) + sizeof(struct sof_ipc_window_elem) * w->num_windows;
-
 	/* keep a local copy of the data */
-	sdev->info_window = kmemdup(w, size, GFP_KERNEL);
+	sdev->info_window = kmemdup(w, struct_size(w, window, w->num_windows),
+				    GFP_KERNEL);
 	if (!sdev->info_window)
 		return -ENOMEM;
 
-- 
2.21.0
