From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v3 08/11] ASoC: fsl: make fsl_ssi driver
 compilable on ARM/IMX
Date: Fri, 9 Mar 2012 09:26:55 +0800
Message-ID: <20120309012653.GG2499@S2101-09.ap.freescale.net>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
	<1331225990-27308-9-git-send-email-shawn.guo@linaro.org>
	<4F5912D0.2090800@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-tul01m020-f179.google.com (mail-tul01m020-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 7BE4910BBCB
	for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2012 02:27:04 +0100 (CET)
Received: by obbup3 with SMTP id up3so1474052obb.38
	for <alsa-devel@alsa-project.org>; Thu, 08 Mar 2012 17:27:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4F5912D0.2090800@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 08, 2012 at 02:13:04PM -0600, Timur Tabi wrote:
> Shawn Guo wrote:
> > +static DEFINE_SPINLOCK(ssi_reg_lock);
> > +static inline void write_ssi_mask(u32 __iomem *addr, u32 clear, u32 set)
> > +{
> > +	u32 val;
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&ssi_reg_lock, flags);
> > +	val = readl(addr);
> > +	val = (val & ~clear) | set;
> > +	writel(val, addr);
> > +	spin_unlock_irqrestore(&ssi_reg_lock, flags);
> > +}
> > +#endif
> 
> I think this spinlock is the wrong approach.  The problem with
> read-modify-write is on the function level, not the register level.
> 
Something like this:

@@ -496,6 +494,10 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
        struct snd_soc_pcm_runtime *rtd = substream->private_data;
        struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(rtd->cpu_dai);
        struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
+       unsigned long flags;
+       int ret = 0;
+
+       spin_lock_irqsave(&ssi_lock, flags);

        switch (cmd) {
        case SNDRV_PCM_TRIGGER_START:
@@ -517,10 +519,12 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
                break;

        default:
-               return -EINVAL;
+               ret = -EINVAL;
        }

-       return 0;
+       spin_unlock_irqrestore(&ssi_lock, flags);
+
+       return ret;
 }

-- 
Regards,
Shawn
