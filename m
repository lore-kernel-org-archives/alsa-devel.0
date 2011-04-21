From: Ben Gardiner <bengardiner-ScDXFp4xN3PN+rMO2ozGnw@public.gmane.org>
Subject: [PATCH 1/4] davinci-mcasp: correct tdm_slots limit
Date: Thu, 21 Apr 2011 14:19:01 -0400
Message-ID: <e6aa9fd05c44088ab8446f1c60d2056f92929483.1303408522.git.bengardiner@nanometrics.ca>
References: <cover.1303408522.git.bengardiner@nanometrics.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <cover.1303408522.git.bengardiner-ScDXFp4xN3PN+rMO2ozGnw@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Liam Girdwood <lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

The current check for the number of tdm-slots specified by platform data is
always true (x >= 2 || x <= 32); therefore the else branch that warns of an
incorrect number of slots can never be taken.

Check that the number of tdm slots specified by platform data is between 2
and 32, inclusive.

Signed-off-by: Ben Gardiner <bengardiner-ScDXFp4xN3PN+rMO2ozGnw@public.gmane.org>
Reviewed-by: James Nuss <jamesnuss-ScDXFp4xN3PN+rMO2ozGnw@public.gmane.org>
---
 sound/soc/davinci/davinci-mcasp.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index fb55d2c..e595756 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -644,7 +644,7 @@ static void davinci_hw_param(struct davinci_audio_dev *dev, int stream)
 		mcasp_set_reg(dev->base + DAVINCI_MCASP_TXTDM_REG, mask);
 		mcasp_set_bits(dev->base + DAVINCI_MCASP_TXFMT_REG, TXORD);
 
-		if ((dev->tdm_slots >= 2) || (dev->tdm_slots <= 32))
+		if ((dev->tdm_slots >= 2) && (dev->tdm_slots <= 32))
 			mcasp_mod_bits(dev->base + DAVINCI_MCASP_TXFMCTL_REG,
 					FSXMOD(dev->tdm_slots), FSXMOD(0x1FF));
 		else
@@ -660,7 +660,7 @@ static void davinci_hw_param(struct davinci_audio_dev *dev, int stream)
 				AHCLKRE);
 		mcasp_set_reg(dev->base + DAVINCI_MCASP_RXTDM_REG, mask);
 
-		if ((dev->tdm_slots >= 2) || (dev->tdm_slots <= 32))
+		if ((dev->tdm_slots >= 2) && (dev->tdm_slots <= 32))
 			mcasp_mod_bits(dev->base + DAVINCI_MCASP_RXFMCTL_REG,
 					FSRMOD(dev->tdm_slots), FSRMOD(0x1FF));
 		else
-- 
1.7.1
