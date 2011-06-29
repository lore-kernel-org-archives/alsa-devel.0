From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [PATCH 5/5] ASoC: atmel_ssc_dai: PM: actually stopping clock on suspend/resume
Date: Wed, 29 Jun 2011 20:00:19 +0200
Message-ID: <e069cdab370eb5737ef9ff744fde828e6abb4163.1309368631.git.nicolas.ferre@atmel.com>
References: <1309370419-22810-1-git-send-email-nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1309370419-22810-1-git-send-email-nicolas.ferre@atmel.com>
In-Reply-To: <ccd4b125244271af7978948689cf1dcef37bc06b.1309368631.git.nicolas.ferre@atmel.com>
References: <ccd4b125244271af7978948689cf1dcef37bc06b.1309368631.git.nicolas.ferre@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

Stop SSC clock on suspend/resume cycle checking if the controller is ac=
tually
initialized. This will save power while sleeping.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 sound/soc/atmel/atmel_ssc_dai.c |   20 +++++++++++++-------
 1 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ss=
c_dai.c
index 9412fc3..43cce80 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -631,12 +631,10 @@ static int atmel_ssc_prepare(struct snd_pcm_subst=
ream *substream,
 #ifdef CONFIG_PM
 static int atmel_ssc_suspend(struct snd_soc_dai *cpu_dai)
 {
-	struct atmel_ssc_info *ssc_p;
+	struct atmel_ssc_info *ssc_p =3D &ssc_info[cpu_dai->id];
=20
 	if (!cpu_dai->active)
-		return 0;
-
-	ssc_p =3D &ssc_info[cpu_dai->id];
+		goto out;
=20
 	/* Save the status register before disabling transmit and receive */
 	ssc_p->ssc_state.ssc_sr =3D ssc_readl(ssc_p->ssc->regs, SR);
@@ -652,6 +650,11 @@ static int atmel_ssc_suspend(struct snd_soc_dai *c=
pu_dai)
 	ssc_p->ssc_state.ssc_tcmr =3D ssc_readl(ssc_p->ssc->regs, TCMR);
 	ssc_p->ssc_state.ssc_tfmr =3D ssc_readl(ssc_p->ssc->regs, TFMR);
=20
+out:
+	if (ssc_p->initialized) {
+		pr_debug("atmel_ssc_dai: suspend - stop clock\n");
+		clk_disable(ssc_p->ssc->clk);
+	}
 	return 0;
 }
=20
@@ -659,14 +662,17 @@ static int atmel_ssc_suspend(struct snd_soc_dai *=
cpu_dai)
=20
 static int atmel_ssc_resume(struct snd_soc_dai *cpu_dai)
 {
-	struct atmel_ssc_info *ssc_p;
+	struct atmel_ssc_info *ssc_p =3D &ssc_info[cpu_dai->id];
 	u32 cr;
=20
+	if (ssc_p->initialized) {
+		pr_debug("atmel_ssc_dai: resume - restart clock\n");
+		clk_enable(ssc_p->ssc->clk);
+	}
+
 	if (!cpu_dai->active)
 		return 0;
=20
-	ssc_p =3D &ssc_info[cpu_dai->id];
-
 	/* restore SSC register settings */
 	ssc_writel(ssc_p->ssc->regs, TFMR, ssc_p->ssc_state.ssc_tfmr);
 	ssc_writel(ssc_p->ssc->regs, TCMR, ssc_p->ssc_state.ssc_tcmr);
--=20
1.7.3
