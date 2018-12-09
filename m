From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6/7] ASoC: hdac_hdmi: Add missing display
	power-off at driver removal
Date: Sun,  9 Dec 2018 10:33:17 +0100
Message-ID: <20181209093318.27829-7-tiwai@suse.de>
References: <20181209093318.27829-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DE471267AB4
 for <alsa-devel@alsa-project.org>; Sun,  9 Dec 2018 10:33:29 +0100 (CET)
In-Reply-To: <20181209093318.27829-1-tiwai@suse.de>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The display power is in unbalance at removing the driver since it
misses the snd_hdac_display_power(OFF) call.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/hdac_hdmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index adce94a3b289..6549adcf857f 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -2059,6 +2059,8 @@ static int hdac_hdmi_dev_remove(struct hdac_device *hdev)
 	struct hdac_hdmi_port *port, *port_next;
 	int i;
 
+	snd_hdac_display_power(hdev->bus, hdev->addr, false);
+
 	list_for_each_entry_safe(pcm, pcm_next, &hdmi->pcm_list, head) {
 		pcm->cvt = NULL;
 		if (list_empty(&pcm->port_list))
-- 
2.19.2
