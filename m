From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/2] ASoC: soc-io: Fix
	snd_soc_component_update_bits_legacy
Date: Mon, 12 Mar 2018 16:24:23 +0200
Message-ID: <20180312142423.13177-3-peter.ujfalusi@ti.com>
References: <20180312142423.13177-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllnx210.ext.ti.com (fllnx210.ext.ti.com [198.47.19.17])
 by alsa0.perex.cz (Postfix) with ESMTP id 81BE8266E60
 for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2018 15:24:28 +0100 (CET)
In-Reply-To: <20180312142423.13177-1-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

After the codec to component conversion codecs with custom read/write
function will no longer able to use update_bits as their io callbacks are
registered at component->driver level and not in component level.

To not complicate the code further, lets just use the
snd_soc_component_read/snd_soc_component_write function and let them sort
out the correct io function to call.

Fixes: e2c330b9b5665 ("ASoC: Move IO abstraction to the component level")

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/soc-io.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-io.c b/sound/soc/soc-io.c
index 2bc1c4c17896..d36a192fbece 100644
--- a/sound/soc/soc-io.c
+++ b/sound/soc/soc-io.c
@@ -88,19 +88,16 @@ static int snd_soc_component_update_bits_legacy(
 	unsigned int old, new;
 	int ret;
 
-	if (!component->read || !component->write)
-		return -EIO;
-
 	mutex_lock(&component->io_mutex);
 
-	ret = component->read(component, reg, &old);
+	ret = snd_soc_component_read(component, reg, &old);
 	if (ret < 0)
 		goto out_unlock;
 
 	new = (old & ~mask) | (val & mask);
 	*change = old != new;
 	if (*change)
-		ret = component->write(component, reg, new);
+		ret = snd_soc_component_write(component, reg, new);
 out_unlock:
 	mutex_unlock(&component->io_mutex);
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
