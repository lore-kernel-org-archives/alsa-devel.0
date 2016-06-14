From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: Re: [alsa-devel] [PATCH v2 2/2] sound: lpass-platform: Move dma
 channel allocation to pcmops
Date: Tue, 14 Jun 2016 09:33:07 -0700
Message-ID: <20160614163248.GA13496@kwestfie-linux.qualcomm.com>
References: <1465893003-12477-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1465893003-12477-2-git-send-email-srinivas.kandagatla@linaro.org>
 <20160614124908.GA16521@kwestfie-linux.qualcomm.com>
 <576007FA.2050705@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <576007FA.2050705@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 14, 2016 at 06:34:50AM -0700, Srinivas Kandagatla wrote:
> On 14/06/16 13:49, Kenneth Westfield wrote:
> >On Tue, Jun 14, 2016 at 09:30:03AM +0100, Srinivas Kandagatla wrote:

> >>-	data = devm_kzalloc(soc_runtime->dev, sizeof(*data), GFP_KERNEL);
> >>+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> >
> >Is the reason for changing the dev pointer similar to why it was changed
> >for snd_dma_alloc_pages() below?
> Yep, Only reason is that I can fit stuff in single line.

The original line fit in one as well.  If that is the reason, maybe
just leave it unchanged.

-- 
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
