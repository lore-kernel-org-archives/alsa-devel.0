From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 07/12] ASoC: SOF: control: correct the copy
	size for bytes kcontrol put
Date: Wed, 22 May 2019 11:21:37 -0500
Message-ID: <20190522162142.11525-8-pierre-louis.bossart@linux.intel.com>
References: <20190522162142.11525-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8D50DF896E9
 for <alsa-devel@alsa-project.org>; Wed, 22 May 2019 18:21:57 +0200 (CEST)
In-Reply-To: <20190522162142.11525-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, Keyon Jie <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Keyon Jie <yang.jie@linux.intel.com>

The size for the bytes kcontrol should include the abi header, that is,
data->size + sizeof(*data), it is also aligned with get method after
this change.

Fixes: c3078f53970 ("ASoC: SOF: Add Sound Open Firmware KControl support")
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/control.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sof/control.c b/sound/soc/sof/control.c
index 11762c4580f1..84e2cbfbbcbb 100644
--- a/sound/soc/sof/control.c
+++ b/sound/soc/sof/control.c
@@ -349,6 +349,7 @@ int snd_sof_bytes_put(struct snd_kcontrol *kcontrol,
 	struct snd_sof_dev *sdev = scontrol->sdev;
 	struct sof_ipc_ctrl_data *cdata = scontrol->control_data;
 	struct sof_abi_hdr *data = cdata->data;
+	size_t size = data->size + sizeof(*data);
 	int ret, err;
 
 	if (be->max > sizeof(ucontrol->value.bytes.data)) {
@@ -358,10 +359,10 @@ int snd_sof_bytes_put(struct snd_kcontrol *kcontrol,
 		return -EINVAL;
 	}
 
-	if (data->size > be->max) {
+	if (size > be->max) {
 		dev_err_ratelimited(sdev->dev,
-				    "error: size too big %d bytes max is %d\n",
-				    data->size, be->max);
+				    "error: size too big %zu bytes max is %d\n",
+				    size, be->max);
 		return -EINVAL;
 	}
 
@@ -375,7 +376,7 @@ int snd_sof_bytes_put(struct snd_kcontrol *kcontrol,
 	}
 
 	/* copy from kcontrol */
-	memcpy(data, ucontrol->value.bytes.data, data->size);
+	memcpy(data, ucontrol->value.bytes.data, size);
 
 	/* notify DSP of byte control updates */
 	snd_sof_ipc_set_get_comp_data(sdev->ipc, scontrol,
-- 
2.20.1
