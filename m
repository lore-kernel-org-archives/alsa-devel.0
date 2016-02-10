From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: Re: [PATCH v1 00/14] ASoC: qcom: Add capture support.
Date: Wed, 10 Feb 2016 12:10:09 -0800
Message-ID: <20160210201008.GA29575@kwestfie-linux.qualcomm.com>
References: <1455099418-311-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1455099418-311-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Patrick Lai <plai@codeaurora.org>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, kwestfie@codeaurora.org
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 10, 2016 at 02:16:58AM -0800, Srinivas Kandagatla wrote:
> LPASS IP on QCOM SOC supports both Playback and capture
> via I2S, but this feature is missing in existing code. 
> This patchset aims at adding capture support to lpass IP.
> First few patches in this series does cleanup the driver
> to make easy to add capture support.
> 
> Most of these patches are acked by Kenneth.
> 
> These patches are tested on DB410C with Headset Mic, secondary mic.

With the exception of patch 13 (ASoC: qcom: add mic support), apply my
ack to all remaining patches:
Acked-by: Kenneth Westfield <kwestfie@codeaurora.org>

Once the comments in patch 13 are addressed, apply my ack to that as
well.

-- 
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
