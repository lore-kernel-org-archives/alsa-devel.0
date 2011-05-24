From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: [PATCH 1/6] ASoC: davinci-pcm: trivial: make ping-pong
	params setup symmetrical
Date: Tue, 24 May 2011 14:50:15 -0400
Message-ID: <b1bc5d0c2a18a913f3c256c5cdb9b63dea3b91f9.1306258759.git.bengardiner@nanometrics.ca>
References: <cover.1306258759.git.bengardiner@nanometrics.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog103.obsmtp.com (na3sys009aog103.obsmtp.com
	[74.125.149.71])
	by alsa0.perex.cz (Postfix) with ESMTP id CC8A910386A
	for <alsa-devel@alsa-project.org>;
	Tue, 24 May 2011 20:50:25 +0200 (CEST)
Received: by mail-vx0-f180.google.com with SMTP id 12so5692082vxk.25
	for <alsa-devel@alsa-project.org>; Tue, 24 May 2011 11:50:23 -0700 (PDT)
In-Reply-To: <cover.1306258759.git.bengardiner@nanometrics.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Sekhar Nori <nsekhar@ti.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
Cc: Steven Faludi <stevenfaludi@nanometrics.ca>, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

The setup of the pong channel uses EDMA_CHAN_SLOT instead of & 0x3f as the
setup of the ping channel does.

Make the setup of ping and pong symmetric. There is no functional change
introduced by this patch.

Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
Reviewed-by: Steven Faludi <stevenfaludi@nanometrics.ca>

---
 sound/soc/davinci/davinci-pcm.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
index 9d35b8c..0d04e0c 100644
--- a/sound/soc/davinci/davinci-pcm.c
+++ b/sound/soc/davinci/davinci-pcm.c
@@ -425,7 +425,8 @@ static int request_ping_pong(struct snd_pcm_substream *substream,
 
 	edma_read_slot(link, &prtd->asp_params);
 	prtd->asp_params.opt &= ~(TCCMODE | EDMA_TCC(0x3f) | TCINTEN);
-	prtd->asp_params.opt |= TCCHEN | EDMA_TCC(prtd->ram_channel & 0x3f);
+	prtd->asp_params.opt |= TCCHEN |
+		EDMA_TCC(prtd->ram_channel & 0x3f);
 	edma_write_slot(link, &prtd->asp_params);
 
 	/* pong */
@@ -439,7 +440,7 @@ static int request_ping_pong(struct snd_pcm_substream *substream,
 	prtd->asp_params.opt &= ~(TCCMODE | EDMA_TCC(0x3f));
 	/* interrupt after every pong completion */
 	prtd->asp_params.opt |= TCINTEN | TCCHEN |
-		EDMA_TCC(EDMA_CHAN_SLOT(prtd->ram_channel));
+		EDMA_TCC(prtd->ram_channel & 0x3f);
 	edma_write_slot(link, &prtd->asp_params);
 
 	/* ram */
-- 
1.7.4.1
