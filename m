From: John Hsu <supercraig0719@gmail.com>
Subject: [PATCH] ASoC: nau8825: debug message of crosstalk
	bypass
Date: Mon, 26 Jun 2017 15:35:16 +0800
Message-ID: <1498462517-13197-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f195.google.com (mail-pf0-f195.google.com
 [209.85.192.195])
 by alsa0.perex.cz (Postfix) with ESMTP id CFE96266B13
 for <alsa-devel@alsa-project.org>; Mon, 26 Jun 2017 09:35:29 +0200 (CEST)
Received: by mail-pf0-f195.google.com with SMTP id z6so8342915pfk.3
 for <alsa-devel@alsa-project.org>; Mon, 26 Jun 2017 00:35:29 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, benzh@chromium.org, mac.chiang@intel.com, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, John Hsu <supercraig0719@gmail.com>, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org

Add debug message for crosstalk function bypass.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Signed-off-by: John Hsu <supercraig0719@gmail.com>
---
 sound/soc/codecs/nau8825.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index a8c7a55..80bae48 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -2440,6 +2440,8 @@ static void nau8825_print_device_properties(struct nau8825 *nau8825)
 			nau8825->jack_insert_debounce);
 	dev_dbg(dev, "jack-eject-debounce:  %d\n",
 			nau8825->jack_eject_debounce);
+	dev_dbg(dev, "crosstalk-bypass:     %d\n",
+			nau8825->xtalk_bypass);
 }
 
 static int nau8825_read_device_properties(struct device *dev,
-- 
2.6.4
