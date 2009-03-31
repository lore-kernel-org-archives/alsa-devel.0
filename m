From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: SoC pxa2xx-ac97 + wm9705 + touchscreen
	suspend/resume
Date: Tue, 31 Mar 2009 11:30:48 +0100
Message-ID: <20090331103048.GC11800@sirena.org.uk>
References: <20090330223720.GC31396@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E4A66243C2
	for <alsa-devel@alsa-project.org>;
	Tue, 31 Mar 2009 12:30:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090330223720.GC31396@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org, eric miao <eric.y.miao@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 30, 2009 at 11:37:20PM +0100, Russell King - ARM Linux wrote:

> 1. when suspend occurs, we turn the AC97 link off by setting the
> GCR_ACLINK_OFF bit, and stopping the functional units clock.

> Setting GCR to '2' (to release cold reset) using devmem2 starts things
> moving again, shutting up this warning.

Hrm, I suspect this is a result of the second issue.

> 2. maybe as a result of the above problem, the wm9705 touchscreen
> driver doesn't reinitialize, causing loss of touchscreen.  Unbinding
> and re-binding the driver restores the touchscreen, but with a very
> long lag between touching the screen and it being registered.

> I bring (2) up because I notice that the resume actions in (1) are
> deferred.  Given that codecs have shared functions (such as
> touchscreens) need to access the codec from their own resume
> functions, how can this deferral be safe?

Other multi-function devices shouldn't have this problem since they
will not be relying on ASoC to resume their control interface (most
likely they will be using MFD to share the device).  It's not safe for
AC97 devices, though.

We only really need the deferral for non-AC97 devices - it's there since
some I2C buses are very slow and non-AC97 codecs often have large
numbers of registers to restore and require delays to bring the codec up
cleanly leading to a substantial impact on overall resume time.

Could you let me know if the patch below works, please?  I've not fully
tested it myself yet.

>From 2c7c47109e9cf68154128e5dc96077bdf5d9a15b Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Tue, 31 Mar 2009 11:27:03 +0100
Subject: [PATCH] ASoC: Don't defer resume work for AC97 codecs

AC97 devices may have other drivers hanging off them directly so need to
have resumed when the resume function returns meaning that we can't defer
the resume - complete it immediately for them. Non-AC97 devices should
not have other drivers hanging directly off the ASoC devices.

We only really need the deferral for non-AC97 devices - it's there since
some I2C buses are very slow and non-AC97 codecs often have large numbers
of registers to restore and require delays to bring the codec up cleanly
leading to a substantial impact on overall resume time.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: stable@kernel.org
---
 sound/soc/soc-core.c |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 6e710f7..6c62d4a 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -767,11 +767,21 @@ static int soc_resume(struct platform_device *pdev)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
 	struct snd_soc_card *card = socdev->card;
+	struct snd_soc_dai *cpu_dai = card->dai_link[0].cpu_dai;
 
-	dev_dbg(socdev->dev, "scheduling resume work\n");
-
-	if (!schedule_work(&card->deferred_resume_work))
-		dev_err(socdev->dev, "resume work item may be lost\n");
+	/* AC97 devices might have other drivers hanging off them so
+	 * need to resume immediately.  Other drivers don't have that
+	 * problem and may take a substantial amount of time to resume
+	 * due to I/O costs and anti-pop so handle them out of line.
+	 */
+	if (cpu_dai->ac97_control) {
+		dev_dbg(socdev->dev, "Resuming AC97 immediately\n");
+		soc_resume_deferred(&card->deferred_resume_work);
+	} else {
+		dev_dbg(socdev->dev, "Scheduling resume work\n");
+		if (!schedule_work(&card->deferred_resume_work))
+			dev_err(socdev->dev, "resume work item may be lost\n");
+	}
 
 	return 0;
 }
-- 
1.6.2.1
