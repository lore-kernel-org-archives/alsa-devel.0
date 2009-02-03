From: pHilipp Zabel <philipp.zabel@gmail.com>
Subject: Re: [PATCH 2/4] ASoC: pxa-ssp: PXA2xx/3xx SSP ports
	start from 1, not 	0
Date: Tue, 3 Feb 2009 19:49:43 +0100
Message-ID: <74d0deb30902031049g500814baje09f163a9e79805b@mail.gmail.com>
References: <1233677983-23710-1-git-send-email-philipp.zabel@gmail.com>
	<1233677983-23710-3-git-send-email-philipp.zabel@gmail.com>
	<20090203164715.GH23827@sirena.org.uk>
	<74d0deb30902030913u581debd1pa31eda017a49524c@mail.gmail.com>
	<20090203173513.GK23827@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.154])
	by alsa0.perex.cz (Postfix) with ESMTP id D2EDF103861
	for <alsa-devel@alsa-project.org>; Tue,  3 Feb 2009 19:49:44 +0100 (CET)
Received: by yw-out-1718.google.com with SMTP id 9so910703ywk.2
	for <alsa-devel@alsa-project.org>; Tue, 03 Feb 2009 10:49:43 -0800 (PST)
In-Reply-To: <20090203173513.GK23827@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 3, 2009 at 6:35 PM, Mark Brown <broonie@sirena.org.uk> wrote:
> On Tue, Feb 03, 2009 at 06:13:22PM +0100, pHilipp Zabel wrote:
>
>> -       priv->dev.ssp = ssp_request(dai->id, "SoC audio");
>> +       priv->dev.ssp = ssp_request(dai->id + 1, "SoC audio");
>>         if (priv->dev.ssp == NULL) {
>>                 ret = -ENODEV;
>>                 goto err_priv;
>
>> But this isn't right either. Because if we request the correct SSP
>> port here, the subsequent request of the same SSP port in ssp_init
>> (called from ops->startup) fails.
>> How to fix?
>
> Hrm.  ssp_init() does a ssp_request() already.  The request on probe is
> just redundant.  Eric was muttering about refactoring the API some more
> but never got round to it.

Hm, hm.. Ripping ssp_init/exit's innards out of them (minus the
ssp/irq_request parts), like this, seems to work:

--------------------------- sound/soc/pxa/pxa-ssp.c ---------------------------
index 1687e18..c56a07c 100644
@@ -21,6 +21,8 @@
 #include <linux/clk.h>
 #include <linux/io.h>

+#include <asm/irq.h>
+
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/initval.h>
@@ -221,9 +223,9 @@ static int pxa_ssp_startup(struct
snd_pcm_substream *substream,
 	int ret = 0;

 	if (!cpu_dai->active) {
-		ret = ssp_init(&priv->dev, cpu_dai->id + 1, SSP_NO_IRQ);
-		if (ret < 0)
-			return ret;
+		priv->dev.port = cpu_dai->id + 1;
+		priv->dev.irq = NO_IRQ;
+		clk_enable(priv->dev.ssp->clk);
 		ssp_disable(&priv->dev);
 	}
 	return ret;
@@ -238,7 +240,7 @@ static void pxa_ssp_shutdown(struct
snd_pcm_substream *substream,

 	if (!cpu_dai->active) {
 		ssp_disable(&priv->dev);
-		ssp_exit(&priv->dev);
+		clk_disable(priv->dev.ssp->clk);
 	}
 }
