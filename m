From: Mark Brown <broonie@kernel.org>
Subject: Applied "ALSA: hdac: add
	snd_hdac_ext_bus_link_power_up_all" to the asoc tree
Date: Sun, 10 Jan 2016 12:07:41 +0000
Message-ID: <E1aIEmb-0007OQ-O0@debutante>
References: <1449816267-11910-8-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 965902605EF
 for <alsa-devel@alsa-project.org>; Sun, 10 Jan 2016 13:07:47 +0100 (CET)
In-Reply-To: <1449816267-11910-8-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jayachandran B <jayachandran.b@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ALSA: hdac: add snd_hdac_ext_bus_link_power_up_all

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

>From 6706a19747eb693ff35ce140f5cbee66dcfec0c4 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Fri, 18 Dec 2015 15:12:02 +0530
Subject: [PATCH] ALSA: hdac: add snd_hdac_ext_bus_link_power_up_all

We have an API for powering down all links, we need a similar one
for powering up links, so add for power up as well

Signed-off-by: Jayachandran B <jayachandran.b@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/hdaudio_ext.h         |  1 +
 sound/hda/ext/hdac_ext_controller.c | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/sound/hdaudio_ext.h b/include/sound/hdaudio_ext.h
index f3454950ee0b..07fa59237feb 100644
--- a/include/sound/hdaudio_ext.h
+++ b/include/sound/hdaudio_ext.h
@@ -147,6 +147,7 @@ struct hdac_ext_link {
 
 int snd_hdac_ext_bus_link_power_up(struct hdac_ext_link *link);
 int snd_hdac_ext_bus_link_power_down(struct hdac_ext_link *link);
+int snd_hdac_ext_bus_link_power_up_all(struct hdac_ext_bus *ebus);
 int snd_hdac_ext_bus_link_power_down_all(struct hdac_ext_bus *ebus);
 void snd_hdac_ext_link_set_stream_id(struct hdac_ext_link *link,
 				 int stream);
diff --git a/sound/hda/ext/hdac_ext_controller.c b/sound/hda/ext/hdac_ext_controller.c
index 1a55a781270d..548cc1e4114b 100644
--- a/sound/hda/ext/hdac_ext_controller.c
+++ b/sound/hda/ext/hdac_ext_controller.c
@@ -288,6 +288,27 @@ int snd_hdac_ext_bus_link_power_down(struct hdac_ext_link *link)
 EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_link_power_down);
 
 /**
+ * snd_hdac_ext_bus_link_power_up_all -power up all hda link
+ * @ebus: HD-audio extended bus
+ */
+int snd_hdac_ext_bus_link_power_up_all(struct hdac_ext_bus *ebus)
+{
+	struct hdac_ext_link *hlink = NULL;
+	int ret;
+
+	list_for_each_entry(hlink, &ebus->hlink_list, list) {
+		snd_hdac_updatel(hlink->ml_addr,
+				AZX_REG_ML_LCTL, 0, AZX_MLCTL_SPA);
+		ret = check_hdac_link_power_active(hlink, true);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_link_power_up_all);
+
+/**
  * snd_hdac_ext_bus_link_power_down_all -power down all hda link
  * @ebus: HD-audio extended bus
  */
-- 
2.7.0.rc3
