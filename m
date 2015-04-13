From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: hda - Expose codec type sysfs
Date: Mon, 13 Apr 2015 13:22:36 +0200
Message-ID: <1428924157-6288-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A0D70261AA5
 for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2015 13:22:41 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 7E9C7AD69
 for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2015 11:22:41 +0000 (UTC)
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
List-Id: alsa-devel@alsa-project.org

The type field of HD-audio codec object should be exposed to
user-space so that it can identify which driver type to bind (legacy /
asoc).

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/hda/hdac_sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/hda/hdac_sysfs.c b/sound/hda/hdac_sysfs.c
index 18aea43d230d..0a6ce3b84cc4 100644
--- a/sound/hda/hdac_sysfs.c
+++ b/sound/hda/hdac_sysfs.c
@@ -36,6 +36,7 @@ static ssize_t type##_show(struct device *dev,			\
 } \
 static DEVICE_ATTR_RO(type)
 
+CODEC_ATTR(type);
 CODEC_ATTR(vendor_id);
 CODEC_ATTR(subsystem_id);
 CODEC_ATTR(revision_id);
@@ -45,6 +46,7 @@ CODEC_ATTR_STR(vendor_name);
 CODEC_ATTR_STR(chip_name);
 
 static struct attribute *hdac_dev_attrs[] = {
+	&dev_attr_type.attr,
 	&dev_attr_vendor_id.attr,
 	&dev_attr_subsystem_id.attr,
 	&dev_attr_revision_id.attr,
-- 
2.3.5
