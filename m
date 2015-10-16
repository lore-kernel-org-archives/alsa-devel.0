From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6/6] ALSA: hda - Advertise MODALIAS in uevent
Date: Fri, 16 Oct 2015 18:20:58 +0200
Message-ID: <1445012458-3337-7-git-send-email-tiwai@suse.de>
References: <1445012458-3337-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B5A3266723
 for <alsa-devel@alsa-project.org>; Fri, 16 Oct 2015 18:21:07 +0200 (CEST)
In-Reply-To: <1445012458-3337-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Vinod Koul <vinod.koul@intel.com>, Jeeja Kp <jeeja.kp@intel.com>, Subhransu S Prusty <subhransu.s.prusty@intel.com>, Liam Girdwood <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Thierry Reding <treding@nvidia.com>

By setting the MODALIAS variable in uevents, userspace helpers will be
enabled to load modules via the module alias associated with a device.

This information is required to automatically load HDA codec drivers
instead of having to explicitly request the various modules in the HDA
core code.

[Note that currently the legacy HDA controller driver tries to bind
 codec modules manually.  It's for supporting the fallback generic
 drivers.  This new udev modalias support was added rather for ASoC
 HDA ext drivers, since this addition itself won't hurt the legacy HDA
 -- tiwai]

[Use the common helper function to generate the modalias -- tiwai]

Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/hda/hda_bus_type.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/hda/hda_bus_type.c b/sound/hda/hda_bus_type.c
index bcb1a79eec38..3060e2aee36f 100644
--- a/sound/hda/hda_bus_type.c
+++ b/sound/hda/hda_bus_type.c
@@ -64,9 +64,21 @@ static int hda_bus_match(struct device *dev, struct device_driver *drv)
 	return 1;
 }
 
+static int hda_uevent(struct device *dev, struct kobj_uevent_env *env)
+{
+	char modalias[32];
+
+	snd_hdac_codec_modalias(dev_to_hdac_dev(dev), modalias,
+				sizeof(modalias));
+	if (add_uevent_var(env, "MODALIAS=%s", modalias))
+		return -ENOMEM;
+	return 0;
+}
+
 struct bus_type snd_hda_bus_type = {
 	.name = "hdaudio",
 	.match = hda_bus_match,
+	.uevent = hda_uevent,
 };
 EXPORT_SYMBOL_GPL(snd_hda_bus_type);
 
-- 
2.6.1
