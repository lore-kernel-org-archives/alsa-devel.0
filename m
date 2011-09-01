From: Timur Tabi <timur@freescale.com>
Subject: Re: [alsa-devel] [RFC v2 PATCH 1/1] ASoC: soc-core: symmetry checking
	for each DAIs separately
Date: Thu, 1 Sep 2011 15:35:35 -0500
Message-ID: <4E5FEC97.6080608@freescale.com>
References: <1314609314-22162-1-git-send-email-b29396@freescale.com>	<CAOZdJXXzMgET+gDknrRBv_yFENrzJe+oFPN7_o7RisBLUhw0Rw@mail.gmail.com>	<65EE16ACC360FA4D99C96DC085B3F77222AE40@039-SN1MPN1-001.039d.mgd.msft.net>	<4E5E1285.8020508@ti.com>
	<4E5E213A.8040909@freescale.com>	<4E5E264B.8000004@metafoo.de>
	<4E5FD5EB.50009@freescale.com> <4E5FDDCB.9060709@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4E5FDDCB.9060709@metafoo.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "w.sang@pengutronix.de" <w.sang@pengutronix.de>, Dong Aisheng-B29396 <B29396@freescale.com>, Liam Girdwood <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Lars-Peter Clausen wrote:
> Try to add a small delay between the two commands. e.g. 'aplay -r 8000 ... &
> sleep 1; arecrod -r 16000 ...'. And of course the DAIs need to be configured to
> be asynchronous, otherwise you'll of course catch the error in the fsl_ssi driver.

Ok, I'm an idiot.  I just noticed that I don't support different sample rates
for playback and capture in my driver, because the CS4270 doesn't support it.
The P1022DS uses the WM8776, which does support it, but I never updated the driver.

Another oddity is that I have this code:

/* Are the RX and the TX clocks locked? */
if (of_find_property(np, "fsl,ssi-asynchronous", NULL))
	ssi_private->asynchronous = 1;
else
	ssi_private->cpu_dai_drv.symmetric_rates = 1;


and later I do this:

if (!ssi_private->asynchronous) {
	snd_pcm_hw_constraint_minmax(substream->runtime,
		SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
		first_runtime->sample_bits,
		first_runtime->sample_bits);

So it looks like I'm confusing sample rate locking with sample size locking.  Ugh.

Anyway, I'm not in any position at the moment to verify this patch.  I need to
get my driver working with asynchronous sample rates first.

-- 
Timur Tabi
Linux kernel developer at Freescale
