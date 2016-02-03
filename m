From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: Re: [alsa-devel] [PATCH RFC 00/15] ASoC: qcom: Add capture support.
Date: Tue, 2 Feb 2016 16:33:10 -0800
Message-ID: <20160203003310.GA14436@kwestfie-linux.qualcomm.com>
References: <1454347622-9970-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1454347622-9970-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Patrick Lai <plai@codeaurora.org>, alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 01, 2016 at 09:27:02AM -0800, Srinivas Kandagatla wrote:
> LPASS IP on QCOM SOC supports both Playback and capture
> via I2S, but this feature is missing in existing code. 
> This patchset aims at adding capture support to lpass IP.
> First few patches in this series does cleanup the driver
> to make easy to add capture support.
> 
> These patches are tested on DB410C with Headset Mic.

Thanks for posting this.  I went through the changes, and it mostly
looks good minus some small, easy-to-fix nits.

-- 
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
