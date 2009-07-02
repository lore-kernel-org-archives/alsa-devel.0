From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 1/2] ASoC: Fix mpc5200-psc-ac97 to ensure the
	data ready bit	is cleared
Date: Thu, 02 Jul 2009 11:57:19 -0600
Message-ID: <20090702175719.15773.58956.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f177.google.com (mail-px0-f177.google.com
	[209.85.216.177])
	by alsa0.perex.cz (Postfix) with ESMTP id 710E4244C0
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Jul 2009 19:57:23 +0200 (CEST)
Received: by pxi7 with SMTP id 7so201522pxi.16
	for <alsa-devel@alsa-project.org>; Thu, 02 Jul 2009 10:57:22 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk
Cc: w.sang@pengutronix.de
List-Id: alsa-devel@alsa-project.org

From: Grant Likely <grant.likely@secretlab.ca>

When doing register reads, it is possible for there to be a stale
data ready bit set which will cause subsequent reads to return
prematurely with incorrect data.  This patch fixes the issues by
ensuring stale data is cleared before starting another transaction.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 sound/soc/fsl/mpc5200_psc_ac97.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)


diff --git a/sound/soc/fsl/mpc5200_psc_ac97.c b/sound/soc/fsl/mpc5200_psc_ac97.c
index 794a247..9b8503f 100644
--- a/sound/soc/fsl/mpc5200_psc_ac97.c
+++ b/sound/soc/fsl/mpc5200_psc_ac97.c
@@ -41,6 +41,10 @@ static unsigned short psc_ac97_read(struct snd_ac97 *ac97, unsigned short reg)
 		pr_err("timeout on ac97 bus (rdy)\n");
 		return -ENODEV;
 	}
+
+	/* Force clear the data valid bit */
+	in_be32(&psc_dma->psc_regs->ac97_data);
+
 	/* Send the read */
 	out_be32(&psc_dma->psc_regs->ac97_cmd, (1<<31) | ((reg & 0x7f) << 24));
