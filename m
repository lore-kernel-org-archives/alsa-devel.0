From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdac_hdmi: keep DAI driver pointer in
	private data" to the asoc tree
Date: Wed, 20 Dec 2017 15:42:27 +0000
Message-ID: <E1eRgVn-00012S-8f@debutante>
References: <87vah2xjob.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 414E326780B
 for <alsa-devel@alsa-project.org>; Wed, 20 Dec 2017 16:42:30 +0100 (CET)
In-Reply-To: <87vah2xjob.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdac_hdmi: keep DAI driver pointer in private data

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 1e02dac395fadfff1f2c6bd90f1180f64a9cbebe Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 20 Dec 2017 01:48:13 +0000
Subject: [PATCH] ASoC: hdac_hdmi: keep DAI driver pointer in private data

struct snd_soc_component::dai_drv will be removed soon.
hdac_hdmi is only user of it. Let's keep it on private data.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 68a4a6b4e68e..15c3638fe345 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -136,6 +136,7 @@ struct hdac_hdmi_priv {
 	struct mutex pin_mutex;
 	struct hdac_chmap chmap;
 	struct hdac_hdmi_drv_data *drv_data;
+	struct snd_soc_dai_driver *dai_drv;
 };
 
 #define hdev_to_hdmi_priv(_hdev) ((to_ehdac_device(_hdev))->private_data)
@@ -1035,7 +1036,7 @@ static int create_fill_widget_route_map(struct snd_soc_dapm_context *dapm)
 	struct snd_soc_dapm_route *route;
 	struct hdac_ext_device *edev = to_hda_ext_device(dapm->dev);
 	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(&edev->hdev);
-	struct snd_soc_dai_driver *dai_drv = dapm->component->dai_drv;
+	struct snd_soc_dai_driver *dai_drv = hdmi->dai_drv;
 	char widget_name[NAME_SIZE];
 	struct hdac_hdmi_cvt *cvt;
 	struct hdac_hdmi_pin *pin;
@@ -1437,6 +1438,7 @@ static int hdac_hdmi_create_dais(struct hdac_device *hdev,
 	}
 
 	*dais = hdmi_dais;
+	hdmi->dai_drv = hdmi_dais;
 
 	return 0;
 }
-- 
2.15.1
