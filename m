From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: intel: initialize return value properly
Date: Mon,  6 Nov 2017 14:30:36 +0100
Message-ID: <20171106133114.339667-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C1FD26716A
 for <alsa-devel@alsa-project.org>; Mon,  6 Nov 2017 14:31:37 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Vinod Koul <vinod.koul@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Harsha Priya N <harshapriya.n@intel.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Naveen Manohar <naveen.m@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

When CONFIG_SND_SOC_HDAC_HDMI is disabled, we can run into an
uninitialized variable:

sound/soc/intel/skylake/skl.c: In function 'skl_resume':
sound/soc/intel/skylake/skl.c:326:6: error: 'ret' may be used uninitialized in this function [-Werror=maybe-uninitialized]

I have run into this on today's linux-next kernel, but it appears
that this is an older problem that was just hard to trigger
with randconfig builds as CONFIG_SND_SOC_HDAC_HDMI would in
effect be impossible to disable when having SND_SOC_INTEL_SKYLAKE
enabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/intel/skylake/skl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 31d8634e8aa1..acb0ab470ca6 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -355,6 +355,7 @@ static int skl_resume(struct device *dev)
 
 		if (ebus->cmd_dma_state)
 			snd_hdac_bus_init_cmd_io(&ebus->bus);
+		ret = 0;
 	} else {
 		ret = _skl_resume(ebus);
 
-- 
2.9.0
