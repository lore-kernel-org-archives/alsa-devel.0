From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: [PATCH 4/4] davinci-mcasp: fix _CBM_CFS pin directions
Date: Thu, 21 Apr 2011 14:19:04 -0400
Message-ID: <a3e514e0152efcd95a7b07401889c4f30c3a092c.1303408522.git.bengardiner@nanometrics.ca>
References: <cover.1303408522.git.bengardiner@nanometrics.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog109.obsmtp.com (na3sys009aog109.obsmtp.com
	[74.125.149.201])
	by alsa0.perex.cz (Postfix) with ESMTP id A36EA103997
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Apr 2011 20:19:17 +0200 (CEST)
Received: by mail-yw0-f45.google.com with SMTP id 41so707453ywl.18
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

The current davinci_mcasp_set_dai_fmt() sets bits ACLKX and ACLKR in the PDIR
register for the codec clock-master/frame-slave mode; however, this results in
the ACLKX and ACLKR pins being outputs according to SPRUFM1 [1]  which
conflicts with "codec is clock master."

Similarly to the previous patch in this series, "fix _CBM_CFS hw_params" --
For codec clock-master/frame-slave mode (_CMB_CFS), clear bits ACLKX and ACLKR
in the PDIR register to set the pins as inputs and hence allow externally
sourced bit-clocks.

[1] http://www.ti.com/litv/pdf/sprufm1

Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
Reviewed-by: James Nuss <jamesnuss@nanometrics.ca>
---
 sound/soc/davinci/davinci-mcasp.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 8004643..0a3d891 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -445,8 +445,10 @@ static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		mcasp_clr_bits(base + DAVINCI_MCASP_ACLKRCTL_REG, ACLKRE);
 		mcasp_set_bits(base + DAVINCI_MCASP_RXFMCTL_REG, AFSRE);
 
+		mcasp_clr_bits(base + DAVINCI_MCASP_PDIR_REG,
+				ACLKX | ACLKR);
 		mcasp_set_bits(base + DAVINCI_MCASP_PDIR_REG,
-				ACLKX | AFSX | ACLKR | AFSR);
+				AFSX | AFSR);
 		break;
 	case SND_SOC_DAIFMT_CBM_CFM:
 		/* codec is clock and frame master */
-- 
1.7.1
