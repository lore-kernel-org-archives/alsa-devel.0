From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/6] ALSA: hda - Add hdaudio bus modalias
	support
Date: Fri, 16 Oct 2015 18:20:56 +0200
Message-ID: <1445012458-3337-5-git-send-email-tiwai@suse.de>
References: <1445012458-3337-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B0253266728
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

From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>

This patch just adds modalias sysfs entry to each hdaudio bus entry.

[rewritten to call the common helper function by tiwai]

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/hda/hdac_sysfs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/hda/hdac_sysfs.c b/sound/hda/hdac_sysfs.c
index c71142dea98a..42d61bf41969 100644
--- a/sound/hda/hdac_sysfs.c
+++ b/sound/hda/hdac_sysfs.c
@@ -45,6 +45,13 @@ CODEC_ATTR(mfg);
 CODEC_ATTR_STR(vendor_name);
 CODEC_ATTR_STR(chip_name);
 
+static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	return snd_hdac_codec_modalias(dev_to_hdac_dev(dev), buf, 256);
+}
+static DEVICE_ATTR_RO(modalias);
+
 static struct attribute *hdac_dev_attrs[] = {
 	&dev_attr_type.attr,
 	&dev_attr_vendor_id.attr,
@@ -54,6 +61,7 @@ static struct attribute *hdac_dev_attrs[] = {
 	&dev_attr_mfg.attr,
 	&dev_attr_vendor_name.attr,
 	&dev_attr_chip_name.attr,
+	&dev_attr_modalias.attr,
 	NULL
 };
 
-- 
2.6.1
