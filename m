From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 2/2] ASoC: au1x: psc-ac97: reorganize timeouts
Date: Mon, 19 Oct 2009 16:10:59 +0200
Message-ID: <1255961459-11483-2-git-send-email-manuel.lauss@gmail.com>
References: <1255961459-11483-1-git-send-email-manuel.lauss@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f212.google.com (mail-fx0-f212.google.com
	[209.85.220.212])
	by alsa0.perex.cz (Postfix) with ESMTP id C420F2435F
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Oct 2009 16:10:25 +0200 (CEST)
Received: by mail-fx0-f212.google.com with SMTP id 8so1994494fxm.45
	for <alsa-devel@alsa-project.org>; Mon, 19 Oct 2009 07:10:25 -0700 (PDT)
In-Reply-To: <1255961459-11483-1-git-send-email-manuel.lauss@gmail.com>
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

Codec read/write functions: wait 21us between the pokings of hardware.
Add timeouts to unbounded loops waiting for bits to change.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 sound/soc/au1x/psc-ac97.c |   38 +++++++++++++++++++++++++-------------
 1 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/sound/soc/au1x/psc-ac97.c b/sound/soc/au1x/psc-ac97.c
index efe2afd..2a06a9c 100644
--- a/sound/soc/au1x/psc-ac97.c
+++ b/sound/soc/au1x/psc-ac97.c
@@ -75,10 +75,12 @@ static unsigned short au1xpsc_ac97_read(struct snd_ac97 *ac97,
 			  AC97_CDC(pscdata));
 		au_sync();
 
-		tmo = 2000;
-		while ((!(au_readl(AC97_EVNT(pscdata)) & PSC_AC97EVNT_CD))
-			&& --tmo)
-			udelay(2);
+		tmo = 20;
+		do {
+			udelay(21);
+			if (au_readl(AC97_EVNT(pscdata)) & PSC_AC97EVNT_CD)
+				break;
+		} while (--tmo);
 
 		data = au_readl(AC97_CDC(pscdata));
 
@@ -114,10 +116,12 @@ static void au1xpsc_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
 			  AC97_CDC(pscdata));
 		au_sync();
 
-		tmo = 2000;
-		while ((!(au_readl(AC97_EVNT(pscdata)) & PSC_AC97EVNT_CD))
-		       && --tmo)
-			udelay(2);
+		tmo = 20;
+		do {
+			udelay(21);
+			if (au_readl(AC97_EVNT(pscdata)) & PSC_AC97EVNT_CD)
+				break;
+		} while (--tmo);
 
 		au_writel(PSC_AC97EVNT_CD, AC97_EVNT(pscdata));
 		au_sync();
@@ -200,7 +204,7 @@ static int au1xpsc_ac97_hw_params(struct snd_pcm_substream *substream,
 	/* FIXME */
 	struct au1xpsc_audio_data *pscdata = au1xpsc_ac97_workdata;
 	unsigned long r, ro, stat;
-	int chans, stype = SUBSTREAM_TYPE(substream);
+	int chans, t, stype = SUBSTREAM_TYPE(substream);
 
 	chans = params_channels(params);
 
@@ -242,8 +246,12 @@ static int au1xpsc_ac97_hw_params(struct snd_pcm_substream *substream,
 		au_sync();
 
 		/* ...wait for it... */
-		while (au_readl(AC97_STAT(pscdata)) & PSC_AC97STAT_DR)
-			asm volatile ("nop");
+		t = 100;
+		while ((au_readl(AC97_STAT(pscdata)) & PSC_AC97STAT_DR) && --t)
+			msleep(1);
+
+		if (!t)
+			printk(KERN_ERR "PSC-AC97: can't disable!\n");
 
 		/* ...write config... */
 		au_writel(r, AC97_CFG(pscdata));
@@ -254,8 +262,12 @@ static int au1xpsc_ac97_hw_params(struct snd_pcm_substream *substream,
 		au_sync();
 
 		/* ...and wait for ready bit */
-		while (!(au_readl(AC97_STAT(pscdata)) & PSC_AC97STAT_DR))
-			asm volatile ("nop");
+		t = 100;
+		while ((!(au_readl(AC97_STAT(pscdata)) & PSC_AC97STAT_DR)) && --t)
+			msleep(1);
+
+		if (!t)
+			printk(KERN_ERR "PSC-AC97: can't enable!\n");
 
 		mutex_unlock(&pscdata->lock);
 
-- 
1.6.5
