From: Hugo Villeneuve <hugo-rg2e/+w5TaNBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 3/4] ALSA: ASoC: Davinci: Updated sffsdr_hw_params()
	function to new format
Date: Mon,  9 Mar 2009 23:32:08 -0400
Message-ID: <1236655929-31688-4-git-send-email-hugo@hugovil.com>
References: <1236655929-31688-1-git-send-email-hugo@hugovil.com>
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1236655929-31688-1-git-send-email-hugo-rg2e/+w5TaNBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Hugo Villeneuve <hugo-rg2e/+w5TaNBDgjK7y7TUQ@public.gmane.org>
---
 sound/soc/davinci/davinci-sffsdr.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/sound/soc/davinci/davinci-sffsdr.c b/sound/soc/davinci/davinci-sffsdr.c
index b338c71..7fdfba8 100644
--- a/sound/soc/davinci/davinci-sffsdr.c
+++ b/sound/soc/davinci/davinci-sffsdr.c
@@ -45,8 +45,7 @@
 		      SND_SOC_DAIFMT_IB_NF)
 
 static int sffsdr_hw_params(struct snd_pcm_substream *substream,
-			    struct snd_pcm_hw_params *params,
-			    struct snd_soc_dai *dai)
+			    struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
-- 
1.5.5
