From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: hdac_hdmi: Remove the unused 'timeout'
	variable
Date: Mon, 16 May 2016 09:50:07 -0300
Message-ID: <1463403007-7719-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f65.google.com (mail-qg0-f65.google.com
 [209.85.192.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 8518B265D9E
 for <alsa-devel@alsa-project.org>; Mon, 16 May 2016 14:50:35 +0200 (CEST)
Received: by mail-qg0-f65.google.com with SMTP id 90so13525033qgz.0
 for <alsa-devel@alsa-project.org>; Mon, 16 May 2016 05:50:35 -0700 (PDT)
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
Cc: vinod.koul@intel.com, Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Commit b2047e996cd88d3 ("ASoC: hdac_hdmi: add link management")
introuduced the following build warning:

sound/soc/codecs/hdac_hdmi.c:1721:16: warning: unused variable 'timeout' [-Wunused-variable]

Remove the unused 'timeout' variable.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 sound/soc/codecs/hdac_hdmi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 3733297..181cd3b 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1718,7 +1718,6 @@ static int hdac_hdmi_runtime_suspend(struct device *dev)
 	struct hdac_ext_device *edev = to_hda_ext_device(dev);
 	struct hdac_device *hdac = &edev->hdac;
 	struct hdac_bus *bus = hdac->bus;
-	unsigned long timeout;
 	struct hdac_ext_bus *ebus = hbus_to_ebus(bus);
 	struct hdac_ext_link *hlink = NULL;
 	int err;
-- 
1.9.1
