From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdac_hdmi: remove unused
	hdac_hdmi_query_pin_connlist" to the asoc tree
Date: Mon, 11 Jan 2016 13:24:34 +0000
Message-ID: <E1aIcSY-0003ln-Lp@debutante>
References: <4242434.H1qiCWaR2p@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3225D260412
 for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2016 14:24:47 +0100 (CET)
In-Reply-To: <4242434.H1qiCWaR2p@wuerfel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdac_hdmi: remove unused hdac_hdmi_query_pin_connlist

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From fe09dd8eb2310ec658f49a5431df2259f11cbe9e Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 11 Jan 2016 13:09:55 +0100
Subject: [PATCH] ASoC: hdac_hdmi: remove unused hdac_hdmi_query_pin_connlist

A recent rework removed the only user of the hdac_hdmi_query_pin_connlist
function, so we now get a warning when building the hdac_hdmi driver:

hdac_hdmi.c:313:12: warning: 'hdac_hdmi_query_pin_connlist' defined but not used [-Wunused-function]

This removes the function, which makes the file build cleanly again.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 15b914476bf2 ("ASoC: hdac_hdmi: Use list to add pins and converters")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c | 22 ----------------------
 1 file changed, 22 deletions(-)

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
-- 
2.7.0.rc3
