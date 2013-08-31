From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/3] ASoC: Remove unused control_type field
	from snd_soc_codec struct
Date: Sat, 31 Aug 2013 11:02:17 +0200
Message-ID: <1377939739-14246-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-153.synserver.de (smtp-out-153.synserver.de
 [212.40.185.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 320D92608A1
 for <alsa-devel@alsa-project.org>; Sat, 31 Aug 2013 11:00:52 +0200 (CEST)
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

The control_type field was used by the core to track which raw IO methods to
use, but when switching to regmap this was no longer necessary and so the last
user of the field was removed in commit be3ea3b9 ("ASoC: Use new register map
API for ASoC generic physical I/O"). The field is now completely unused and can
be removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 8e2ad52..9d4c2ab 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -705,7 +705,6 @@ struct snd_soc_codec {
 
 	/* codec IO */
 	void *control_data; /* codec control (i2c/3wire) data */
-	enum snd_soc_control_type control_type;
 	hw_write_t hw_write;
 	unsigned int (*hw_read)(struct snd_soc_codec *, unsigned int);
 	unsigned int (*read)(struct snd_soc_codec *, unsigned int);
-- 
1.8.0
