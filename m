From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: [PATCH 1/3] ASoC: hdac_hdmi: report codec link up/down
	status to bus
Date: Wed, 12 Jun 2019 15:22:56 +0300
Message-ID: <20190612122258.4363-2-kai.vehmanen@linux.intel.com>
References: <20190612122258.4363-1-kai.vehmanen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A697DF80791
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 14:22:12 +0200 (CEST)
In-Reply-To: <20190612122258.4363-1-kai.vehmanen@linux.intel.com>
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
Cc: kai.vehmanen@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Report codec power status to the HDA codec bus from runtime pm
suspend and resume callbacks. This is required to implement
runtime idle logic that relies on 'codec_powered' field of hdac_bus
to be maintained for all codecs.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 660e0587f3999..01ab7aed315cb 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -2090,6 +2090,7 @@ static int hdac_hdmi_runtime_suspend(struct device *dev)
 		return -EIO;
 	}
 
+	snd_hdac_codec_link_down(hdev);
 	snd_hdac_ext_bus_link_put(bus, hlink);
 
 	snd_hdac_display_power(bus, hdev->addr, false);
@@ -2116,6 +2117,7 @@ static int hdac_hdmi_runtime_resume(struct device *dev)
 	}
 
 	snd_hdac_ext_bus_link_get(bus, hlink);
+	snd_hdac_codec_link_up(hdev);
 
 	snd_hdac_display_power(bus, hdev->addr, true);
 
-- 
2.17.1
