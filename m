From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: Re: [PATCH v3 2/2] sound: lpass-platform: Move dma
 channel allocation to pcmops
Date: Tue, 5 Jul 2016 15:23:41 -0700
Message-ID: <20160705222341.GA14340@kwestfie-linux.qualcomm.com>
References: <1467624109-24230-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1467624109-24230-2-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E75B265E22
 for <alsa-devel@alsa-project.org>; Wed,  6 Jul 2016 00:23:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1467624109-24230-2-git-send-email-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, linux-kernel@vger.kernel.org, Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.com>, kwestfie@codeaurora.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 04, 2016 at 10:21:49AM +0100, Srinivas Kandagatla wrote:
> Move dma channel allocations to pcmops open and close functions. Reason
> to do this is that, lpass_platform_pcm_free() accesses snd_soc_pcm_runtime
> via substream->private data, However By this time runtimes are already
> freed as part of soc_cleanup_card_resources() sequence.
> 
> This patch moves the channel allocations/deallocations to pcmops open()
> and close() respectively, where the code has valid snd_soc_pcm_runtime.
> 
> Without this patch unloading lpass sound card module would result in below
> crash:

snip...

> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---

LGTM.

Acked-by: Kenneth Westfield <kwestfie@codeaurora.org>

-- 
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
