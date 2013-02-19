From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH v3 1/5] ALSA: hda - hdmi: ELD shouldn't be
	valid after unplug
Date: Tue, 19 Feb 2013 11:51:10 +0100
Message-ID: <1361271074-17555-2-git-send-email-david.henningsson@canonical.com>
References: <1361271074-17555-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id B61042651DC
 for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2013 11:51:10 +0100 (CET)
In-Reply-To: <1361271074-17555-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: fengguang.wu@intel.com, pierre-louis.bossart@linux.intel.com, David Henningsson <david.henningsson@canonical.com>, stable@kernel.org
List-Id: alsa-devel@alsa-project.org

Currently, eld_valid is never set to false, except at kernel module
load time. This patch makes sure that eld is no longer valid when
the cable is (hot-)unplugged.

Cc: stable@kernel.org
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_hdmi.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index b9af281b..32adaa6 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1176,6 +1176,7 @@ static void hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
 		"HDMI status: Codec=%d Pin=%d Presence_Detect=%d ELD_Valid=%d\n",
 		codec->addr, pin_nid, eld->monitor_present, eld_valid);
 
+	eld->eld_valid = false;
 	if (eld_valid) {
 		if (!snd_hdmi_get_eld(eld, codec, pin_nid))
 			snd_hdmi_show_eld(eld);
-- 
1.7.9.5
