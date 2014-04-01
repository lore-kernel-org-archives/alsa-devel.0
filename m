From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH bisect 2/2] ASoC: fsl_sai: Separately enable interrupts
 for Tx and Rx streams
Date: Tue, 1 Apr 2014 21:21:57 +0800
Message-ID: <20140401132156.GB27586@MrMyself>
References: <1396322227-482-1-git-send-email-Guangyu.Chen@freescale.com>
 <1396322227-482-3-git-send-email-Guangyu.Chen@freescale.com>
 <20140401120715.GR2269@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140401120715.GR2269@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, timur@tabi.org, Li.Xiubo@freescale.com
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 01, 2014 at 01:07:15PM +0100, Mark Brown wrote:
> On Tue, Apr 01, 2014 at 11:17:07AM +0800, Nicolin Chen wrote:
> > We only enable one side interrupt for each stream since over/underrun
> > on the opposite stream would be resulted from what we previously did,
> > enabling TERE but remaining FRDE disabled, even though the xrun on the
> > opposite direction will not break the current stream.
> 
> This still doesn't apply against fsl-sai (nor for-next).

Sir, I just rebased my for-next branch again and found that it's missing
two applied patches: "ASoC: fsl_sai: Add isr to deal with error flag" and
"ASoC: fsl_sai: Improve fsl_sai_isr()", so that's why this PATCH-2 could
not be applied against it as it needs the macro that's included in the
patch "ASoC: fsl_sai: Add isr to deal with error flag".

What should I do now?

Thank you,
Nicolin
