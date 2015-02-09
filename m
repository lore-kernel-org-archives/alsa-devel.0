From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: Re: [Patch V4 03/10] ASoC: qcom: Document LPASS CPU
	bindings
Date: Sun, 8 Feb 2015 22:38:23 -0800
Message-ID: <20150209063822.GA19870@kwestfie-linux.qualcomm.com>
References: <1423169626-22166-1-git-send-email-kwestfie@codeaurora.org>
 <1423169626-22166-4-git-send-email-kwestfie@codeaurora.org>
 <20150206221823.GF31311@finisterre.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 by alsa0.perex.cz (Postfix) with ESMTP id 11A392604D1
 for <alsa-devel@alsa-project.org>; Mon,  9 Feb 2015 07:38:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20150206221823.GF31311@finisterre.sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Device Tree Mailing List <devicetree@vger.kernel.org>, ALSA Mailing List <alsa-devel@alsa-project.org>, Banajit Goswami <bgoswami@codeaurora.org>, Takashi Iwai <tiwai@suse.de>, Greg KH <gregkh@linuxfoundation.org>, Patrick Lai <plai@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Bryan Huntsman <bryanh@codeaurora.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, David Brown <davidb@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Feb 07, 2015 at 06:18:23AM +0800, Mark Brown wrote:
> On Thu, Feb 05, 2015 at 12:53:39PM -0800, Kenneth Westfield wrote:
> 
> > +- qcom,system-clock-shift		: Add this bool property if the default
> > +					  frequency of the system clock needs to
> > +					  be reduced.
> > +- qcom,system-clock-shift-compare	: A numerical value used to right-shift
> > +					  the default system clock frequency for
> > +					  comparison with the target bit clock
> > +					  frequency.
> > +- qcom,system-clock-shift-amount	: A numerical value used to right-shift
> > +					  the default system clock frequency.
> > +- qcom,alternate-sysclk			: Add this bool property if the default
> > +					  frequency of the system clock cannot
> > +					  divide down to the target bit clock
> > +					  frequency.
> > +- qcom,alternate-sysclk-bitwidth	: A numerical value representing the
> > +					  sample bitwidth which requires use of
> > +					  the alternate system clock frequency.
> > +- qcom,alternate-sysclk-frequency	: A numerical value representing the new
> > +					  system clock frequency to use.
> 
> None of these seem like they are appropriate for device tree properties,
> they appear to be choosing a specific clocking configuration which is
> something that would normally be done as part of the system integration
> in the machine driver rather than in the DAI driver.  This binding won't
> work in cases where the clocks are being changed at runtime and would
> limit systems where that becomes possible in future.

So I add a machine driver that selects the clocking freq in hw_params
and calls set_sysclk in the DAIs.

The DT node for the machine driver would look something like:
        default_system_clock_frequency = < xxxxxx >;
        alternate_system_clock_frequency = < xxxxxx >;
        cpu_dai = < &cpu >;
        codec_dai = < &codec >;
        pinctrl... ?

Does this sound ok?  Also, would it make sense to move the pinctrl back
to the machine driver?

-- 
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
