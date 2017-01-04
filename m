From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 2/2] ASoC: Intel: bytcr_rt5640: quirks for
	Insyde devices
Date: Wed,  4 Jan 2017 15:44:53 -0600
Message-ID: <1483566293-27911-2-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1483566293-27911-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C0DD2675DC
 for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2017 22:45:16 +0100 (CET)
In-Reply-To: <1483566293-27911-1-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.de
Cc: youling257 <youling257@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: youling257 <youling257@gmail.com>

There are literally dozens of Insyde devices with a different
name but with the same audio routing. Use a generic quirk to
match on vendor name only to avoid recurring edits of the
same thing.

Signed-off-by: youling257 <youling257@gmail.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 8d2fb2d..1bd985f 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -387,6 +387,16 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 						 BYT_RT5640_SSP0_AIF1),
 
 	},
+	{
+		.callback = byt_rt5640_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
+		},
+		.driver_data = (unsigned long *)(BYT_RT5640_IN3_MAP |
+						 BYT_RT5640_MCLK_EN |
+						 BYT_RT5640_SSP0_AIF1),
+
+	},
 	{}
 };
 
-- 
2.7.4
