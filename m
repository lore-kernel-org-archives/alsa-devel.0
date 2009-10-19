From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 1/2] ASoC: au1x: psc-ac97: verify correct codec
	register was read
Date: Mon, 19 Oct 2009 16:10:58 +0200
Message-ID: <1255961459-11483-1-git-send-email-manuel.lauss@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f212.google.com (mail-fx0-f212.google.com
	[209.85.220.212])
	by alsa0.perex.cz (Postfix) with ESMTP id 452392435F
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Oct 2009 16:10:24 +0200 (CEST)
Received: by fxm8 with SMTP id 8so1994494fxm.45
	for <alsa-devel@alsa-project.org>; Mon, 19 Oct 2009 07:10:23 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Manuel Lauss <manuel.lauss@gmail.com>
List-Id: alsa-devel@alsa-project.org

Verify that the correct register has been received from the codec.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 sound/soc/au1x/psc-ac97.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/soc/au1x/psc-ac97.c b/sound/soc/au1x/psc-ac97.c
index a521aa9..efe2afd 100644
--- a/sound/soc/au1x/psc-ac97.c
+++ b/sound/soc/au1x/psc-ac97.c
@@ -61,7 +61,8 @@ static unsigned short au1xpsc_ac97_read(struct snd_ac97 *ac97,
 {
 	/* FIXME */
 	struct au1xpsc_audio_data *pscdata = au1xpsc_ac97_workdata;
-	unsigned short data, retry, tmo;
+	unsigned short retry, tmo;
+	unsigned long data;
 
 	au_writel(PSC_AC97EVNT_CD, AC97_EVNT(pscdata));
 	au_sync();
@@ -79,15 +80,19 @@ static unsigned short au1xpsc_ac97_read(struct snd_ac97 *ac97,
 			&& --tmo)
 			udelay(2);
 
-		data = au_readl(AC97_CDC(pscdata)) & 0xffff;
+		data = au_readl(AC97_CDC(pscdata));
 
 		au_writel(PSC_AC97EVNT_CD, AC97_EVNT(pscdata));
 		au_sync();
 
 		mutex_unlock(&pscdata->lock);
+
+		if (reg != ((data >> 16) & 0x7f))
+			tmo = 1;	/* wrong register, try again */
+
 	} while (--retry && !tmo);
 
-	return retry ? data : 0xffff;
+	return retry ? data & 0xffff : 0xffff;
 }
 
 /* AC97 controller writes to codec register */
-- 
1.6.5
