From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/6] ALSA: hda - Add api_version to
	hda_device_id struct
Date: Fri, 16 Oct 2015 18:20:53 +0200
Message-ID: <1445012458-3337-2-git-send-email-tiwai@suse.de>
References: <1445012458-3337-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 7CBF2266716
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

For distinguishing the difference between HDA legacy and ext codec
driver entries, we need to expose the value corresponding to type
field.  This patch adds a new field, api_version, to hda_device_id
struct, so that this information is embedded in modalias string.

Although the information is basically redundant (struct hdac_device
already has type field), the helper that extracts from
MODULE_DEVICE_TABLE() won't take it account except for the exported
table entries themselves.  So we need to put the same information in
the table, too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/hdaudio.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index 49df61c7afdc..b35bf59a1ecc 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -33,6 +33,7 @@ extern struct bus_type snd_hda_bus_type;
 struct hda_device_id {
 	__u32 vendor_id;
 	__u32 rev_id;
+	__u8 api_version;
 	const char *name;
 	unsigned long driver_data;
 };
-- 
2.6.1
