From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: Re: [RFC PATCH 00/14] ASoC: qcom: add support to apq8016 audio
Date: Sat, 2 May 2015 16:57:04 -0700
Message-ID: <20150502235704.GA27804@kwestfie-linux.qualcomm.com>
References: <1430414148-10869-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1430414148-10869-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Patrick Lai <plai@codeaurora.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Kenneth Westfield <kwestfie@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 30, 2015 at 06:15:48PM +0100, Srinivas Kandagatla wrote:
> Hi All,
> 
> This patchset adds apq8016 audio support into lpass driver. Existing Lpass
> driver can not be used as-it-is for apq8016 as it contains code specific to
> ipq806x. Also the driver only supports single i2s port, single dma channel and
> single bitclk control.
> 
> APQ8016 has 4 MI2S( Primary, Secondary, Tertiary, Quaternary) which can be routed
> to internal wcd codec or external codecs. This routing is controlled by 2 mux
> registers.
> 
> This patch series firstly re-organizes the lpass driver such that the SOC
> specific bits are moved away from the driver. And secondly the SOC specifics
> are now passed as lpass variant data which would include various register
> offsets, dma channel allocations and SOC specific clock handling.
> 
> Finally the patchset add apq8016 lpass and machine driver.
> 
> This patchset also has two trivial cleanup patches which are to do with
> redundant checks and removing unnecessary header files.
> 
> All these patches are tested for HDMI audio via adv7533 bridge and Analog audio
> on APQ8016-SBC and msm8916-mtp boards. I dont have access to ipq806x boards to
> test these patches.
> 
> This is very first version of the patches which was developed with very
> mimimal/no access to IP documentation. I would like to get your opinon on the
> over all approch.
> 
> 
> Kenneth/Patrick,
> 	Could you please try these patches on storm board?

I will test the patches and let you know by Wednesday.  Also, I posted
some comments, but Patrick should be posting his comments separately
later next week.

-- 
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
