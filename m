From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ASoC: SOF: topology: Use struct_size() helper
Date: Fri, 24 May 2019 11:10:51 -0500
Message-ID: <20190524161051.GA26061@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes, in particular in the
context in which this code is being used.

So, replace the following form:

sizeof(struct sof_ipc_ctrl_data) + sizeof(struct sof_ipc_ctrl_value_chan) *
	le32_to_cpu(mc->num_channels)

with:

struct_size(scontrol->control_data, chanv, le32_to_cpu(mc->num_channels))

and so on...

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/soc/sof/topology.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index c88afa872a58..745cb875863c 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -442,9 +442,8 @@ static int sof_control_load_volume(struct snd_soc_component *scomp,
 		return -EINVAL;
 
 	/* init the volume get/put data */
-	scontrol->size = sizeof(struct sof_ipc_ctrl_data) +
-			 sizeof(struct sof_ipc_ctrl_value_chan) *
-			 le32_to_cpu(mc->num_channels);
+	scontrol->size = struct_size(scontrol->control_data, chanv,
+				     le32_to_cpu(mc->num_channels));
 	scontrol->control_data = kzalloc(scontrol->size, GFP_KERNEL);
 	if (!scontrol->control_data)
 		return -ENOMEM;
@@ -501,9 +500,8 @@ static int sof_control_load_enum(struct snd_soc_component *scomp,
 		return -EINVAL;
 
 	/* init the enum get/put data */
-	scontrol->size = sizeof(struct sof_ipc_ctrl_data) +
-			 sizeof(struct sof_ipc_ctrl_value_chan) *
-			 le32_to_cpu(ec->num_channels);
+	scontrol->size = struct_size(scontrol->control_data, chanv,
+				     le32_to_cpu(ec->num_channels));
 	scontrol->control_data = kzalloc(scontrol->size, GFP_KERNEL);
 	if (!scontrol->control_data)
 		return -ENOMEM;
-- 
2.21.0
