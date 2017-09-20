From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH RESEND 3/3] ASoC: Intel: cht_bsw_rt5672: fix
	card name
Date: Tue, 19 Sep 2017 19:34:53 -0500
Message-ID: <20170920003453.16209-4-pierre-louis.bossart@linux.intel.com>
References: <20170920003453.16209-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id C288D267400
 for <alsa-devel@alsa-project.org>; Wed, 20 Sep 2017 02:35:04 +0200 (CEST)
In-Reply-To: <20170920003453.16209-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, vinod.koul@intel.com, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

For now reason the current card name is a ridiculous
'cherrytrailcraudio'. This isn't very useful or self-explanatory,
change to driver name cht-bsw-rt5672.

[Additional comment from Takashi: One bonus by this change would be to
avoid inconsistent names by the driver's name string size.  Since it's
16 bytes including \0, the name is shortened as cherrytrailcrau or
such in some fields.  With the new name this shouldn't happen ]

Reviewed-by: Takashi Iwai <tiwai@suse.de>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/cht_bsw_rt5672.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/cht_bsw_rt5672.c b/sound/soc/intel/boards/cht_bsw_rt5672.c
index 5b1e3ee965a7..f799b76fdedf 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5672.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5672.c
@@ -383,7 +383,7 @@ static int cht_resume_post(struct snd_soc_card *card)
 
 /* SoC card */
 static struct snd_soc_card snd_soc_card_cht = {
-	.name = "cherrytrailcraudio",
+	.name = "cht-bsw-rt5672",
 	.owner = THIS_MODULE,
 	.dai_link = cht_dailink,
 	.num_links = ARRAY_SIZE(cht_dailink),
-- 
2.11.0
