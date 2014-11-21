From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] ASoC: sigmadsp: Fix endianness conversion
Date: Fri, 21 Nov 2014 18:53:52 +0100
Message-ID: <1416592432-29132-2-git-send-email-lars@metafoo.de>
References: <1416592432-29132-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-173.synserver.de (smtp-out-173.synserver.de
 [212.40.185.173])
 by alsa0.perex.cz (Postfix) with ESMTP id CDDD72606E1
 for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2014 18:54:01 +0100 (CET)
In-Reply-To: <1416592432-29132-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Make sure to always convert the firmware data to local endianness before
using it.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Fixes: a35daac77a03 ("ASoC: sigmadsp: Add support for fw v2")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/sigmadsp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/sigmadsp.c b/sound/soc/codecs/sigmadsp.c
index 55af596..6abefd2 100644
--- a/sound/soc/codecs/sigmadsp.c
+++ b/sound/soc/codecs/sigmadsp.c
@@ -235,7 +235,7 @@ static int sigma_fw_load_control(struct sigmadsp *sigmadsp,
 
 	ctrl->addr = le16_to_cpu(ctrl_chunk->addr);
 	ctrl->num_bytes = num_bytes;
-	ctrl->samplerates = chunk->samplerates;
+	ctrl->samplerates = le32_to_cpu(chunk->samplerates);
 
 	list_add_tail(&ctrl->head, &sigmadsp->ctrl_list);
 
@@ -266,7 +266,7 @@ static int sigma_fw_load_data(struct sigmadsp *sigmadsp,
 
 	data->addr = le16_to_cpu(data_chunk->addr);
 	data->length = length;
-	data->samplerates = chunk->samplerates;
+	data->samplerates = le32_to_cpu(chunk->samplerates);
 	memcpy(data->data, data_chunk->data, length);
 	list_add_tail(&data->head, &sigmadsp->data_list);
 
@@ -329,7 +329,7 @@ static int sigmadsp_fw_load_v2(struct sigmadsp *sigmadsp,
 		if (length > fw->size - pos || length < sizeof(*chunk))
 			return -EINVAL;
 
-		switch (chunk->tag) {
+		switch (le32_to_cpu(chunk->tag)) {
 		case SIGMA_FW_CHUNK_TYPE_DATA:
 			ret = sigma_fw_load_data(sigmadsp, chunk, length);
 			break;
-- 
1.8.0
