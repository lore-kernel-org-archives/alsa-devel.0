From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: soc-pcm: msbits constraint: Drop 8 and
	16 bit sample sizes
Date: Wed, 25 Jan 2012 10:09:41 +0200
Message-ID: <1327478981-8443-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog116.obsmtp.com (na3sys009aog116.obsmtp.com
	[74.125.149.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 68FB02440D
	for <alsa-devel@alsa-project.org>; Wed, 25 Jan 2012 09:09:57 +0100 (CET)
Received: by lahg1 with SMTP id g1so3942493lah.1
	for <alsa-devel@alsa-project.org>; Wed, 25 Jan 2012 00:09:54 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

As per discussion we can safely ignore the 8 and 16 bit sample
sizes when applying the msbits constraint.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi Mark,

As we discussed [1] let's remove the 8 and 16 bit size from the array.

[1]
http://mailman.alsa-project.org/pipermail/alsa-devel/2012-January/048276.html

Regards,
Peter

 sound/soc/soc-pcm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 3268901..93be95b 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -68,7 +68,7 @@ static int soc_pcm_apply_symmetry(struct snd_pcm_substream *substream,
  * like the DAC/ADC resolution to use but there isn't right now.
  */
 static int sample_sizes[] = {
-	8, 16, 24, 32,
+	24, 32,
 };
 
 static void soc_pcm_apply_msb(struct snd_pcm_substream *substream,
-- 
1.7.8.3
