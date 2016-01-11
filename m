From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: hdac_hdmi: remove unused
	hdac_hdmi_query_pin_connlist
Date: Mon, 11 Jan 2016 13:09:55 +0100
Message-ID: <4242434.H1qiCWaR2p@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 59F75260412
 for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2016 13:10:04 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

A recent rework removed the only user of the hdac_hdmi_query_pin_connlist
function, so we now get a warning when building the hdac_hdmi driver:

hdac_hdmi.c:313:12: warning: 'hdac_hdmi_query_pin_connlist' defined but not used [-Wunused-function]

This removes the function, which makes the file build cleanly again.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 15b914476bf2 ("ASoC: hdac_hdmi: Use list to add pins and converters")
---
I saw this warning the first time on today's linux-next with ARM randconfig builds

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index f5df7232405b..5a1ec0f7a1a6 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -310,28 +310,6 @@ hdac_hdmi_query_cvt_params(struct hdac_device *hdac, struct hdac_hdmi_cvt *cvt)
 	return err;
 }
 
-static int hdac_hdmi_query_pin_connlist(struct hdac_ext_device *hdac,
-					struct hdac_hdmi_pin *pin)
-{
-	if (!(get_wcaps(&hdac->hdac, pin->nid) & AC_WCAP_CONN_LIST)) {
-		dev_warn(&hdac->hdac.dev,
-			"HDMI: pin %d wcaps %#x does not support connection list\n",
-			pin->nid, get_wcaps(&hdac->hdac, pin->nid));
-		return -EINVAL;
-	}
-
-	pin->num_mux_nids = snd_hdac_get_connections(&hdac->hdac, pin->nid,
-			pin->mux_nids, HDA_MAX_CONNECTIONS);
-	if (pin->num_mux_nids == 0)
-		dev_warn(&hdac->hdac.dev, "No connections found for pin: %d\n",
-								pin->nid);
-
-	dev_dbg(&hdac->hdac.dev, "num_mux_nids %d for pin: %d\n",
-			pin->num_mux_nids, pin->nid);
-
-	return pin->num_mux_nids;
-}
-
 static void hdac_hdmi_fill_widget_info(struct snd_soc_dapm_widget *w,
 				enum snd_soc_dapm_type id,
 				const char *wname, const char *stream)
