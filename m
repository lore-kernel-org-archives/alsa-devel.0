From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: [PATCH 3/4] davinci-mcasp: fix _CBM_CFS hw_params
Date: Thu, 21 Apr 2011 14:19:03 -0400
Message-ID: <831ad13442c7bca120d24d8679da614b20a0090d.1303408522.git.bengardiner@nanometrics.ca>
References: <cover.1303408522.git.bengardiner@nanometrics.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog113.obsmtp.com (na3sys009aog113.obsmtp.com
	[74.125.149.209])
	by alsa0.perex.cz (Postfix) with ESMTP id 8803F103976
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Apr 2011 20:19:14 +0200 (CEST)
Received: by mail-yi0-f54.google.com with SMTP id 12so835291yie.27
	for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2011 11:19:13 -0700 (PDT)
In-Reply-To: <cover.1303408522.git.bengardiner@nanometrics.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>, alsa-devel@alsa-project.org
Cc: davinci-linux-open-source@linux.davincidsp.com, Takashi Iwai <tiwai@suse.de>, James Nuss <jamesnuss@nanometrics.ca>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The current davinci_mcasp_set_dai_fmt() sets bits ACLKXE and ACLKRE (CLKXM
and CLKRM as they are reffered to in SPRUFM1 [1]) for codec clock-slave/
frame-slave mode (_CBS_CFS) which selects internally generated bit-clock and
frame-sync signals; however, it does the same thing again for codec
clock-master/frame-slave mode (_CBM_CFS) in the very next case statement which
is incorrectly selecting internally generated bit-clocks in this mode.

For codec clock-master/frame-slave mode (_CBM_CFS), clear bits ACLKXE and
ACLKRE to select externally-generated bit-clocks.

[1] http://www.ti.com/litv/pdf/sprufm1

Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
Reviewed-by: James Nuss <jamesnuss@nanometrics.ca>
---
 sound/soc/davinci/davinci-mcasp.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 1aa24a1..8004643 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -439,10 +439,10 @@ static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		break;
 	case SND_SOC_DAIFMT_CBM_CFS:
 		/* codec is clock master and frame slave */
-		mcasp_set_bits(base + DAVINCI_MCASP_ACLKXCTL_REG, ACLKXE);
+		mcasp_clr_bits(base + DAVINCI_MCASP_ACLKXCTL_REG, ACLKXE);
 		mcasp_set_bits(base + DAVINCI_MCASP_TXFMCTL_REG, AFSXE);
 
-		mcasp_set_bits(base + DAVINCI_MCASP_ACLKRCTL_REG, ACLKRE);
+		mcasp_clr_bits(base + DAVINCI_MCASP_ACLKRCTL_REG, ACLKRE);
 		mcasp_set_bits(base + DAVINCI_MCASP_RXFMCTL_REG, AFSRE);
 
 		mcasp_set_bits(base + DAVINCI_MCASP_PDIR_REG,
-- 
1.7.1
