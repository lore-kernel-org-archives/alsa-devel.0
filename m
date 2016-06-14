From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: Re: [PATCH v1 1/2] sound: lpass-cpu: add module licence and
 description
Date: Tue, 14 Jun 2016 00:02:07 -0700
Message-ID: <20160614070206.GA7762@kwestfie-linux.qualcomm.com>
References: <1465824197-7735-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1465824197-7735-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Patrick Lai <plai@codeaurora.org>, kwestfie@codeaurora.org, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 13, 2016 at 02:23:16PM +0100, Srinivas Kandagatla wrote:
> This patch adds module licence to lpass-cpu driver, without this
> patch lpass-cpu module would taint with below error, while insmod/modprobe.
> 
> snd_soc_lpass_cpu: module license 'unspecified' taints kernel.
> Disabling lock debugging due to kernel taint
> snd_soc_lpass_cpu: Unknown symbol regmap_write (err 0)
> snd_soc_lpass_cpu: Unknown symbol devm_kmalloc (err 0)
> ...
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---

Acked-by: Kenneth Westfield <kwestfie@codeaurora.org>

-- 
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
