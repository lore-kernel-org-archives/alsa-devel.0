From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 2/2 resend] ASoC: nuc900: Fix a loop timeout
	test
Date: Sat, 9 Dec 2017 14:52:28 +0300
Message-ID: <20171209115228.5nbcfoz62xy7thv2@mwanda>
References: <20171209115203.pdtdfnmzwz6zpjqs@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by alsa0.perex.cz (Postfix) with ESMTP id D7B3F266C72
 for <alsa-devel@alsa-project.org>; Sat,  9 Dec 2017 12:59:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20171209115203.pdtdfnmzwz6zpjqs@mwanda>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Wan ZongShun <mcuos.com@gmail.com>
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Arvind Yadav <arvind.yadav.cs@gmail.com>
List-Id: alsa-devel@alsa-project.org

We should be finishing the loop with timeout set to zero but because
this is a post-op we finish with timeout == -1.

Fixes: 1082e2703a2d ("ASoC: NUC900/audio: add nuc900 audio driver support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
I sent this one in July but it was missed somehow.

diff --git a/sound/soc/nuc900/nuc900-ac97.c b/sound/soc/nuc900/nuc900-ac97.c
index 71fce7c85c93..81b09d740ed9 100644
--- a/sound/soc/nuc900/nuc900-ac97.c
+++ b/sound/soc/nuc900/nuc900-ac97.c
@@ -67,7 +67,7 @@ static unsigned short nuc900_ac97_read(struct snd_ac97 *ac97,
 
 	/* polling the AC_R_FINISH */
 	while (!(AUDIO_READ(nuc900_audio->mmio + ACTL_ACCON) & AC_R_FINISH)
-								&& timeout--)
+								&& --timeout)
 		mdelay(1);
 
 	if (!timeout) {
@@ -121,7 +121,7 @@ static void nuc900_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
 
 	/* polling the AC_W_FINISH */
 	while ((AUDIO_READ(nuc900_audio->mmio + ACTL_ACCON) & AC_W_FINISH)
-								&& timeout--)
+								&& --timeout)
 		mdelay(1);
 
 	if (!timeout)
